<?php
declare(strict_types=1);

namespace App\Tests;

use Symfony\Bundle\FrameworkBundle\Test\WebTestCase;

final class ApplicationAvailabilityFunctionalTest extends WebTestCase
{
    /**
     * @test
     * @dataProvider urlProvider
     */
    public function pageIsSuccessful($url)
    {
        $client = self::createClient();
        $client->request('GET', $url);

        $this->assertResponseIsSuccessful();
    }

    public function urlProvider()
    {
        yield ['/'];
    }
}
