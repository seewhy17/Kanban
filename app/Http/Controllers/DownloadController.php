<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class DownloadController extends Controller
{
    public function download()
    {

        $name = 'dump.sql';
        return response()->download(storage_path('downloads/kanban.sql'), $name);
    }
}
