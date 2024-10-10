<?php

namespace App\Controllers;

use App\Models\Exercises;

class ExercisesController extends Controller
{
    public static function create()
    {
        $name = $_POST["title"];

        $exerciseData = Exercises::addExercise($name)[0];

        header("Location: /exercises/" . $exerciseData['id'] . "/fields");
    }

    public static function showAnswering()
    {
        $exercises = Exercises::findAllByStatus("answering");

        include_once VIEW_DIR . "/TakeExercise.php";
    }
}
