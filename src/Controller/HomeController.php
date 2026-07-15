<?php

namespace App\Controller;

use App\Enum\DownloadStatusEnum;
use App\Repository\DownloadRepository;
use App\Repository\UserRepository;
use App\Service\TmDbApiService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Attribute\Route;

final class HomeController extends AbstractController
{


    public function __construct(
    )
    {
    }

    #[Route('/', name: 'app_home')]
    public function index(): Response
    {
        return $this->render('home/index.html.twig', [
        ]);
    }
}
