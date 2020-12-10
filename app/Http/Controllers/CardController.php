<?php

namespace App\Http\Controllers;

use App\Models\Card;
use App\Models\Column;
use Illuminate\Http\Request;

class CardController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $cards = new Card();
        return response()->json([
            'status' => 'success',
            'cards' =>  $cards->select(['id', 'title', 'description'])->get()
        ]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $validated = (object) $request->validate([
            'title' => 'bail|required|max:50',
            'description' => 'bail|required|max:200',
            'label' => 'bail|required|alpha_num|max:36',
            'id' => 'bail|required|numeric',
        ]);
        try {
            $column = Column::findOrFail($validated->id);

            $card = $column->cards()->create([
                'title' => $validated->title,
                'description' => $validated->description,
                'label' => $validated->label,
            ]);
            return response()->json([
                'status' => 'success',
                'card' => $card
            ]);
        } catch( \ErrorException $e ) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ]);
        } catch( \BadMethodCallException $e ) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ]);
        } catch( \Exception $e ) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ]);
        } catch( \Error $e ) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ]);
        }
    }

    /**
     * Display the specified resource.
     *
     * @param  \App\Models\Card  $card
     * @return \Illuminate\Http\Response
     */
    public function show(Card $card)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Card  $card
     * @return \Illuminate\Http\Response
     */
    public function edit(Card $card)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Card  $card
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Card $card)
    {
        try {
            $validated = (object) $request->validate([
                'title' => 'bail|required|string|max:50',
                'description' => 'bail|required|string|max:200',
            ]);
            $card = tap($card)->update([
                'title' => $validated->title,
                'description' => $validated->description,
            ]);
            return response()->json([
                'status' => 'success',
                'card' => $card
            ]);

        } catch( \Exception $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ]);
        } catch( \Error $e) {
            return response()->json([
                'status' => 'error',
                'message' => $e->getMessage()
            ]);
        }
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Card  $card
     * @return \Illuminate\Http\Response
     */
    public function destroy(Card $card)
    {
        //
    }
}
