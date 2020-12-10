<?php

namespace App\Http\Controllers;

use App\Models\card;
use App\Models\Column;
use Illuminate\Http\Request;

class ColumnController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {
        $columns = new Column();
        return response()->json([
            'status' => 'success',
            'columns' =>  $columns->with('cards')->select(['id', 'column_id', 'title'])->get()
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
        $validated = $request->validate([
            'title' => 'bail|required|max:50',
            'column_id' => 'bail|required|alpha_num|max:36',
        ]);
        try {

            $column = Column::create($validated);
            return response()->json([
                'status' => 'success',
                'column' => $column
            ]);

        } catch( \ErrorException $e ) {
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
     * @param  \App\Models\Column  $column
     * @return \Illuminate\Http\Response
     */
    public function show(Column $column)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  \App\Models\Column  $column
     * @return \Illuminate\Http\Response
     */
    public function edit(Column $column)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \App\Models\Column  $column
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, Column $column)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  \App\Models\Column  $column
     * @return \Illuminate\Http\Response
     */
    public function destroy(Column $column)
    {
        try {
            $column->delete();
            return response()->json([
                'status' => 'success',
            ]);

        } catch ( \ErrorException $e ){
            return response()->json([
                'status' => 'deletion failed',
                'message' => $e->getMessage()
            ]);
        }
    }
}
