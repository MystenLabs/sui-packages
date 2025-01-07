module 0x75cab45b9cba2d0b06a91d1f5fa51a4569da07374cf42c1bd2802846a61efe33::uris {
    public(friend) fun get_chestpiece(arg0: vector<u8>, arg1: vector<u8>) : (vector<u8>, vector<u8>, vector<u8>) {
        if (arg0 == b"Fang MK IV" && arg1 == b"Vesper") {
            (b"QmPUiVDsuvN9VLkhCpiL5u7qk7UQrgxUbBhScJXMvEDkMD", b"QmQiQtAXNVM9E627Nuug2S7eE4p3gJLpaJ7XZu9sHRzMze", b"Qma7qxAH1p2SBbJdnDJUyhTABqHuFyu6pf5wRykM47vtid")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Hikari") {
            (b"QmbBhF7sJKpWmkqQE1qSax6cG8tXkMB4NYGyNDdD86C7cf", b"QmQiQtAXNVM9E627Nuug2S7eE4p3gJLpaJ7XZu9sHRzMze", b"QmR7k6YEUj8VTk8dSdvYFZWsvYNqUKo6PQjMND94iV8oQQ")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Volt") {
            (b"QmUQ3Cq4VZYmSdewiu5KgR5drHKR8ucGcUh8tefKz6zaqF", b"QmQiQtAXNVM9E627Nuug2S7eE4p3gJLpaJ7XZu9sHRzMze", b"Qma7tkYqJ83eXnvWi37CjhrYJYnVvfFPB1axW5miR344Ct")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Blood Ivory") {
            (b"QmWQfxxQzrzSbAHrjP2wekNqnbjbrT6doDWVi7NkY1Q9TR", b"QmQiQtAXNVM9E627Nuug2S7eE4p3gJLpaJ7XZu9sHRzMze", b"QmbHGB2Vs2eZFa1R8mUGinb9uN5prnQJy1cZ8Nwaj4RxjD")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Red Damascus") {
            (b"QmSmtTdQzEgusRnZNkqGavrQqFNpnYE6S9KHX8yseeZz75", b"QmQiQtAXNVM9E627Nuug2S7eE4p3gJLpaJ7XZu9sHRzMze", b"QmQn9rdTaRSPBQqivo32gv36BtZKURjxnTEMEtLkw2Nkia")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Digital Winter") {
            (b"QmPTQocDPbmbaZfTMLEss3Z2qu2757H7pQR2sZbS8ThWzK", b"QmQiQtAXNVM9E627Nuug2S7eE4p3gJLpaJ7XZu9sHRzMze", b"QmRBPQhmC1H1tJQ223Cu2549LjJgLHb7PPURExc1S7pBTn")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Dusk") {
            (b"QmRBM9YWiedpRuYqMDY3bmPHBa18c2KsK4GpyAQ8cLDWhv", b"QmQiQtAXNVM9E627Nuug2S7eE4p3gJLpaJ7XZu9sHRzMze", b"QmUyAYrRQqG2TPmFp2uHnmUiaw6bkKATDyYMystTxVZW9u")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Viceroy") {
            (b"QmNeJr5mvK79YUbPoWQEV6siSna7GQWp3oKGkxQbQ1Rqq4", b"QmQiQtAXNVM9E627Nuug2S7eE4p3gJLpaJ7XZu9sHRzMze", b"QmVZ7bvZ8aDVBD2rp5jF2unsjoiroHyPiEnjTXubnBcakr")
        } else if (arg0 == b"Helios" && arg1 == b"Vesper") {
            (b"Qmd9jLeVmxJ5VF8GWwXJQEBsJVGNoNS6ka4XDerTXMdd5E", b"QmVBrMNDhQDDxgSomvjqX3oQWYKLDyZKcYRqFCJp9jvBwe", b"QmR4xrDEerAgDhx9pQqkVUj3SBs5uJuTUKXmF6Tkf3CC8w")
        } else if (arg0 == b"Helios" && arg1 == b"Hikari") {
            (b"QmQR6F8AFjWXeQy61158FgMEKadLj9pVTeUtTRwQPabuSX", b"QmVBrMNDhQDDxgSomvjqX3oQWYKLDyZKcYRqFCJp9jvBwe", b"QmUH6DxA6GJxsPaoM3T9eWwAES4S2evxHrhwuuzmn7HoNP")
        } else if (arg0 == b"Helios" && arg1 == b"Volt") {
            (b"QmXZgdnsguMNCfVVJ5n9iPDAdo1Cz65aQC2Q1egbCEW8Z8", b"QmVBrMNDhQDDxgSomvjqX3oQWYKLDyZKcYRqFCJp9jvBwe", b"Qmc4WPLJKSr7kY6rubfRDwfvBUaJCapBzZxjqSnPXHSJCj")
        } else if (arg0 == b"Helios" && arg1 == b"Blood Ivory") {
            (b"Qma4xBXRwZBux5vqbMUL5wDXJFQtTnX4hZiENabm6hw9ec", b"QmVBrMNDhQDDxgSomvjqX3oQWYKLDyZKcYRqFCJp9jvBwe", b"QmTfwm1CRdJCexvC5HLtzrTfknRomdwrkfc1gLrwmi8zKG")
        } else if (arg0 == b"Helios" && arg1 == b"Red Damascus") {
            (b"QmRP6qXr1VRRX1kPUrbkLMXZiFZ8Q2mW7bjhzmcsRoAbho", b"QmVBrMNDhQDDxgSomvjqX3oQWYKLDyZKcYRqFCJp9jvBwe", b"QmcGUoJRqRJXUx1X1bynYmJo5YPmyrUare5BrtRQ53nb48")
        } else if (arg0 == b"Helios" && arg1 == b"Digital Winter") {
            (b"QmTmGbG5kLBaVVS8no2sausjd6NmUaHuMy1NkFvXDFUYiG", b"QmVBrMNDhQDDxgSomvjqX3oQWYKLDyZKcYRqFCJp9jvBwe", b"QmVs1dwDtEzPtnmpm4a99MS2e6AFatkihfLvyUc9pSf6KJ")
        } else if (arg0 == b"Helios" && arg1 == b"Dusk") {
            (b"QmWZoTrJrMsfwNz9wcCcjixZACnsDKxBYVHbz3Re9RLWoE", b"QmVBrMNDhQDDxgSomvjqX3oQWYKLDyZKcYRqFCJp9jvBwe", b"QmXy5dzvh6cs4drGa8Fdmj1cpDgFPiECCBQBhSVjwejH7U")
        } else if (arg0 == b"Helios" && arg1 == b"Viceroy") {
            (b"QmYdCmPzVL9NeS8taQtR4RdZJb7ahJTzAttMv5ebndCYD5", b"QmVBrMNDhQDDxgSomvjqX3oQWYKLDyZKcYRqFCJp9jvBwe", b"QmUCsYDcdHt7nuYXN8FwSLNn4QjWJozkpg8hxR88tYB2KQ")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Vesper") {
            (b"QmXaTtvFE3hwAUvJZ1ZVqYF6REwuYgEzyPRKbvSbgSLe8P", b"QmbZpkUbqxpyGbgD5JNkzGmDoqMjvgjZDjy9PTGGg9XX7Q", b"QmQfZi8WgtBZVP5ym14xm71x3Q89CxmdA2XqwWDxVnSMzU")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Hikari") {
            (b"QmU33qSizfnHzQqYYM4WXdRjygYcDrmSqtmJMLrFBmR81n", b"QmbZpkUbqxpyGbgD5JNkzGmDoqMjvgjZDjy9PTGGg9XX7Q", b"QmXczx7rwTt8sFd4SQHYkr6EAs9Ne1184ifNa1cHiWCcpR")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Volt") {
            (b"QmfGoU2P3ADsnLybV1fzFn8VT86KeRJE6hpW4Gfvw1PfZj", b"QmbZpkUbqxpyGbgD5JNkzGmDoqMjvgjZDjy9PTGGg9XX7Q", b"QmRcopFjm83WvCAQLcQHP5JiQUyw2wWyse6XQ2ffZWXRxS")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Blood Ivory") {
            (b"QmdDQ5VicdPX5Pu3vj1WvQApisHaC8xnB4uquCb1LhdM8k", b"QmbZpkUbqxpyGbgD5JNkzGmDoqMjvgjZDjy9PTGGg9XX7Q", b"QmbM1Himh9mWhtYc2F6dB5pVbUKVRuP9dTCbYwPGhQw1cw")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Red Damascus") {
            (b"QmedfU3BPyzf9rTWtXfYm3oMiGaSy8YyFgsB78Z6CLBjP9", b"QmbZpkUbqxpyGbgD5JNkzGmDoqMjvgjZDjy9PTGGg9XX7Q", b"QmdQTJpZtFSkhcYZiAAaAvtvtG6fqY5xyCqiNzdu3s28hK")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Digital Winter") {
            (b"QmSYudMSkZsFoKvi4NZToTdyPyFuootChbMYdP33chvxB3", b"QmbZpkUbqxpyGbgD5JNkzGmDoqMjvgjZDjy9PTGGg9XX7Q", b"QmfH34y7r2QWNs8pbP4R4frZ2Bim5DypNop1U7XLFmysFj")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Dusk") {
            (b"QmS5BbDqDsYnQarZA8S3AFdL2R7B1W7u7mRdWD1rKTMNvW", b"QmbZpkUbqxpyGbgD5JNkzGmDoqMjvgjZDjy9PTGGg9XX7Q", b"Qma2nZKqwURqamqptVnUE8YuAvCb5Zh3b6ppJxjgwTymiE")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Viceroy") {
            (b"QmXrgVrWn7MRaKDGT1Wyo6hdxieajYr88TMF43h7tV31vj", b"QmbZpkUbqxpyGbgD5JNkzGmDoqMjvgjZDjy9PTGGg9XX7Q", b"QmNSY8VKv6ijsr9xb1Spq9pyqzvga1Q88td7oL29kc189E")
        } else {
            (b"", b"", b"")
        }
    }

    public(friend) fun get_helm(arg0: vector<u8>, arg1: vector<u8>) : (vector<u8>, vector<u8>, vector<u8>) {
        if (arg0 == b"SK-Viper" && arg1 == b"Vesper") {
            (b"QmUKit1spLEV4XbTwe9Gq7VfUekQG3ecUzp9nW8PgmqASq", b"QmTZam75o41LtAjsnDiWcWvtE1ovky45fs47z8bqxFcQiG", b"QmaKdSMdsB2ztf7VwqaAfmEWN6uiKKe6mGX9qamJka4mgW")
        } else if (arg0 == b"SK-Viper" && arg1 == b"Hikari") {
            (b"QmdqUhNe5M5H1j5TJBpGHsoWKFXL8sTa6xEeA4jcAdzkh9", b"QmTZam75o41LtAjsnDiWcWvtE1ovky45fs47z8bqxFcQiG", b"Qmdx6hHzGwS9fUXaFo88te8UAhnZqcRhnHV2R3oZHogTdQ")
        } else if (arg0 == b"SK-Viper" && arg1 == b"Volt") {
            (b"QmPUDBHzDT5Siig8YqVoiyyKQWNRZE9Ea14ynvinVxJP7k", b"QmTZam75o41LtAjsnDiWcWvtE1ovky45fs47z8bqxFcQiG", b"QmT3Nfsoq1B99Gcrm3gbeawm3oRGHoJctWsbdGYD247qZP")
        } else if (arg0 == b"SK-Viper" && arg1 == b"Blood Ivory") {
            (b"QmXLy8ZGEeBmABPgfeNTUCe8NGtHdv6d1MyjK1AZR63XmX", b"QmTZam75o41LtAjsnDiWcWvtE1ovky45fs47z8bqxFcQiG", b"QmRE7Lu2ikQ4qoH8ko3NMHLiZ3V7afSJfyKyDuMN1KUaNA")
        } else if (arg0 == b"SK-Viper" && arg1 == b"Red Damascus") {
            (b"QmSyYKtzhuNvg6qcAGEGZegfkHaj9Efhns36ojm1Djo8Cg", b"QmTZam75o41LtAjsnDiWcWvtE1ovky45fs47z8bqxFcQiG", b"QmSuk6a5wBP1gygYtmBSARUodig9g3yq6Lsk4hcVvdaubT")
        } else if (arg0 == b"SK-Viper" && arg1 == b"Digital Winter") {
            (b"QmYs9dmQrCTbm4ZuSEBS6Nhs4ocfur7tvxjSVXxpEWkYBa", b"QmTZam75o41LtAjsnDiWcWvtE1ovky45fs47z8bqxFcQiG", b"QmatcStvhsSybyjHX5B7BYrGfgP8x28TBqzvKrFDK56ckn")
        } else if (arg0 == b"SK-Viper" && arg1 == b"Dusk") {
            (b"QmNmsGwqZDcnYBko8DazYFPX4QZwSNoQGAXJdgLhzKR1tq", b"QmTZam75o41LtAjsnDiWcWvtE1ovky45fs47z8bqxFcQiG", b"QmWwmZpj8hJrVKLGXeWyrj7H6A6zxZf3xtricjraXCQoWt")
        } else if (arg0 == b"SK-Viper" && arg1 == b"Viceroy") {
            (b"QmUF54qrRKb58vVNtqJXJR1tHQV8zAAYccdCLEN1B16mYB", b"QmTZam75o41LtAjsnDiWcWvtE1ovky45fs47z8bqxFcQiG", b"QmVNqqhdvRddHZpn7utvvrM5ZAwvr7Tfjmb8k3AZZN6Yjx")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Vesper") {
            (b"QmXmp8NnZbYJpRLkmSoGPgkmzhPhTeLEQB7F8KBjj6Ndjc", b"QmaZuoAcXp4M7WFFb1SaNAxYYrSqGtvebtcfAapdxjLanD", b"QmPtQqxP2r3QLLi2bB8sERuKcFNhQTqsk1GiYeu7em4ewm")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Hikari") {
            (b"QmU9Mxo4pPizgBdkhEiwA9ysK5KE9qYR5HQg92p17uXFWE", b"QmaZuoAcXp4M7WFFb1SaNAxYYrSqGtvebtcfAapdxjLanD", b"QmWK15XaJJa7z8QyQvqyQUCqHJX5nLAjpG6ig1BcwusCTW")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Volt") {
            (b"QmcXJVkKyKrEqJ2Umy1tv2gu6ffJaHU3VBNtamMrNQpAti", b"QmaZuoAcXp4M7WFFb1SaNAxYYrSqGtvebtcfAapdxjLanD", b"QmYKmdrn7vjwL5wnKe3gdz3HjmX6AzZnYsg6b2NymmyGWo")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Blood Ivory") {
            (b"QmSq8nEs1aHtXzGVKMdD8GFQJsEdvxSDkQCo5nTKupKH53", b"QmaZuoAcXp4M7WFFb1SaNAxYYrSqGtvebtcfAapdxjLanD", b"QmUnvPxMPir8jGDTZZUuvTUSocmnK6qZxHxSaCkASyv3sZ")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Red Damascus") {
            (b"QmXUQQ2kCKCNy7fUpmAezhYoPtFApr7Mzs1qbqsCme5fM7", b"QmaZuoAcXp4M7WFFb1SaNAxYYrSqGtvebtcfAapdxjLanD", b"QmRZw94yyA3su5geSeFYqKemBXh5amgd92qyN5BnDx2yr5")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Digital Winter") {
            (b"QmUtVqMkAh5rnMy1KWXNjaq8Mw2GT7N29a3H1ctTomyPzF", b"QmaZuoAcXp4M7WFFb1SaNAxYYrSqGtvebtcfAapdxjLanD", b"QmZYE4iwXKoyGpyNz6NNhHALeC8FiQzezc1Sde8jVTYXds")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Dusk") {
            (b"QmXaxKeLbRpKnRRo7tRGg7bARA719WdCsyEhvbR4LNCP5E", b"QmaZuoAcXp4M7WFFb1SaNAxYYrSqGtvebtcfAapdxjLanD", b"Qme7BCwUzULNDDfg6YoNqoPi97b3L1pYSrD3As4EhAAR5C")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Viceroy") {
            (b"QmWS91ry4ptKVyvqCgGzWBVsQma7R75tM8heYFqDptqxKE", b"QmaZuoAcXp4M7WFFb1SaNAxYYrSqGtvebtcfAapdxjLanD", b"QmNqdiFhttwNjEEGHJPeVzwvg6U9ozSfzhViqyLFp6iaAX")
        } else if (arg0 == b"Spectre-09" && arg1 == b"Vesper") {
            (b"QmVKPDyjHfgzKA3bttQPMwnW1DkW9cjzTMiJCkT43mz4ur", b"QmV3SLcH7AHqkUen998v5VsdhtAu7tUxdb2z6cUia2Y8e6", b"QmVMXEEBUfJvQmrRTakyg75LeDays7oHzb6YwNiRoBXnZB")
        } else if (arg0 == b"Spectre-09" && arg1 == b"Hikari") {
            (b"QmRFnrZsyNwQAoDVjbwYG6ZKu5v6bdSdEfvEacea2JAg3q", b"QmV3SLcH7AHqkUen998v5VsdhtAu7tUxdb2z6cUia2Y8e7", b"QmUzKkhv7apQGXpcRMUFCZsJg1UT4N6AMJkRsJmrWXrWeK")
        } else if (arg0 == b"Spectre-09" && arg1 == b"Volt") {
            (b"QmNo7ui1qW6HbixTMcrnABFyZPhf93DCeNEDyM1CexzeqD", b"QmV3SLcH7AHqkUen998v5VsdhtAu7tUxdb2z6cUia2Y8e8", b"Qma3sSZjac9VX4ByTQGpFk3A8f6DbsuvaUdJUmHGDHx3sW")
        } else if (arg0 == b"Spectre-09" && arg1 == b"Blood Ivory") {
            (b"QmX2W4YWtRVHfLQTLKXzBcZxkpmJE1f9Cu17ewLJ7v6FtB", b"QmV3SLcH7AHqkUen998v5VsdhtAu7tUxdb2z6cUia2Y8e9", b"QmfN5psUVGjakavQD2tPCZXsxR3gnXk6xHCCqswUaMT8rL")
        } else {
            let (v3, v4, v5) = if (arg0 == b"Spectre-09" && arg1 == b"Red Damascus") {
                (b"QmXv3h8r8TAxRyRjxQcxVCybJpfeRno5i9rhpWWE21q5oa", b"QmZsF7bPiEnBSm2KDihqhzoa7td1oMzJts9PAFtaTji5PQ", b"QmV3SLcH7AHqkUen998v5VsdhtAu7tUxdb2z6cUia2Y8e10")
            } else {
                let (v6, v7, v8) = if (arg0 == b"Spectre-09" && arg1 == b"Digital Winter") {
                    (b"QmeH3rK7n59ZwmNc9fuBdBrEQtcp3GrKR6MQDYJdYjE5j5", b"QmV3SLcH7AHqkUen998v5VsdhtAu7tUxdb2z6cUia2Y8e11", b"QmdqtF4y3EkPBNA4T5QrSq4H1GkrQq9DxCzNeB6NQfUD6p")
                } else if (arg0 == b"Spectre-09" && arg1 == b"Dusk") {
                    (b"QmcFL7LQ2wcfCBp4PVPwjLcmn7VCy7gPqXg276n2sZrVNn", b"QmV3SLcH7AHqkUen998v5VsdhtAu7tUxdb2z6cUia2Y8e12", b"QmYbSYN3F1BuvkzdaB5ahFrAszBEgvY9LQW1fJgYfTKu7f")
                } else if (arg0 == b"Spectre-09" && arg1 == b"Viceroy") {
                    (b"QmXRyAno8GX3snAaTP7zT5QA1tzk2iVJ5RHAyqBifyWJog", b"QmV3SLcH7AHqkUen998v5VsdhtAu7tUxdb2z6cUia2Y8e13", b"QmavjLzxCpqmiUALLYi1uxksTuSyn3R9EU1XkX175J86wF")
                } else if (arg0 == b"Helios" && arg1 == b"Vesper") {
                    (b"QmVZoAyTabK21ZLpEbaBrrfpWYXNX9G7kJT94AZt9PA3Zb", b"QmXrBZdKXHzvk7UARzt6f22f5SnRSa65Hkp5jjAhKEMs2w", b"QmeFpNssFP5KSdtmAw8vS8PXx5Hx5c7QozAWBAVv5Dy6Bg")
                } else if (arg0 == b"Helios" && arg1 == b"Hikari") {
                    (b"Qmer2YBR2PfNK4UNrq5krN9LD2N2FuMx8DSCcBVXnDLWca", b"QmXrBZdKXHzvk7UARzt6f22f5SnRSa65Hkp5jjAhKEMs2w", b"QmS1Ue9n89wmPn9yAsKwMHUNU4rhRKcF1hgpgiBnG1WVei")
                } else if (arg0 == b"Helios" && arg1 == b"Volt") {
                    (b"QmVVexu8yEQxLYPNJo9rQgvEaxHfc1KbRxYLjmXDmHqcfN", b"QmXrBZdKXHzvk7UARzt6f22f5SnRSa65Hkp5jjAhKEMs2w", b"QmWipdrZYKUvgSBtzcWSM1S743gyqFiCiTXdBvmMCpKqXm")
                } else if (arg0 == b"Helios" && arg1 == b"Blood Ivory") {
                    (b"QmPrMKxbMfrziKaTqYm6R3V1BowaK43xWYA5KwfqydLeaW", b"QmXrBZdKXHzvk7UARzt6f22f5SnRSa65Hkp5jjAhKEMs2w", b"Qma5pzVjzjcYPhJx56NN5p3g1FCJvH6GPEuJPamZgSwgki")
                } else if (arg0 == b"Helios" && arg1 == b"Red Damascus") {
                    (b"Qmdfbiyc6WruYu8wqSKSkqWWLXMpa8sPZB28nDWaWSKDLr", b"QmXrBZdKXHzvk7UARzt6f22f5SnRSa65Hkp5jjAhKEMs2w", b"QmcTjj47dWBQkWY4z5j6xG6BLzj4rnaFjsFQy5M7qzq9TJ")
                } else if (arg0 == b"Helios" && arg1 == b"Digital Winter") {
                    (b"QmQzof7F8yZEUnGLCdT3dYqsqdTn6hVWcq4371Un5eB88W", b"QmXrBZdKXHzvk7UARzt6f22f5SnRSa65Hkp5jjAhKEMs2w", b"QmeQw6wZ8sfm5MNtfs9DJBXAYEN8HwQRPPqqERGjMBzXsU")
                } else if (arg0 == b"Helios" && arg1 == b"Dusk") {
                    (b"QmTRZuFzdKwrdDNi8oFuvG61DJptYDJ5mwfcRbdPCuV4Wg", b"QmXrBZdKXHzvk7UARzt6f22f5SnRSa65Hkp5jjAhKEMs2w", b"QmZh8LwNf5CzgAF6q7k2sSGA4m4r2H2jk9SefBsf7AR2rx")
                } else if (arg0 == b"Helios" && arg1 == b"Viceroy") {
                    (b"QmUBb5BY9PMRGNaiJaGAGVNBS8bLWVxoJRU2emBcHgJ7qw", b"QmXrBZdKXHzvk7UARzt6f22f5SnRSa65Hkp5jjAhKEMs2w", b"QmX86mAxwozBgreYk95EVLh5R1LL6uBsvapkaSLLC5DuCm")
                } else if (arg0 == b"Baha-2000" && arg1 == b"Vesper") {
                    (b"QmZ4rzYhRn7nXDSZ746GTSPvKRMz93PxtNbarQvZw9ngZS", b"QmeKnCv2rnaZTc2FqAyz4ED1FWZDLo1dUGPMTAhuVUvror", b"QmYDcuwSzaUNWKbDthLCRKVSvmqMj4fu3DBBZBFvTNTb5z")
                } else if (arg0 == b"Baha-2000" && arg1 == b"Hikari") {
                    (b"QmQBeYQS8UE1zgW5LboHJUYYHsSaxy1H2Afo2qznDwiZrW", b"QmeKnCv2rnaZTc2FqAyz4ED1FWZDLo1dUGPMTAhuVUvror", b"QmVh6yeK2TWk4E4RagASao23pKoShFpJHpdomzXHzWPtyY")
                } else if (arg0 == b"Baha-2000" && arg1 == b"Volt") {
                    (b"QmV574L9pmm8djh4owwTKTwviCDuLto1LkWgKGgAVBSPNX", b"QmeKnCv2rnaZTc2FqAyz4ED1FWZDLo1dUGPMTAhuVUvror", b"QmZdL8HJfBReRKd7F675gbPT7nVgmbgarCSvzkzfhdJTDo")
                } else if (arg0 == b"Baha-2000" && arg1 == b"Blood Ivory") {
                    (b"QmRNWC1qK2wXfVvPAyyTsQqtjiKVvr138jWTCERvWy2tDd", b"QmeKnCv2rnaZTc2FqAyz4ED1FWZDLo1dUGPMTAhuVUvror", b"QmVsVh4DWCirkcSZtdyWK3f4jrJGvFS7ZUTb4gfGJ6Rm66")
                } else if (arg0 == b"Baha-2000" && arg1 == b"Red Damascus") {
                    (b"QmeaeujWvV79Ut9XqfTmGZ4FDjDFjCCPGHSs5XpcbEsYL6", b"QmeKnCv2rnaZTc2FqAyz4ED1FWZDLo1dUGPMTAhuVUvror", b"QmThCL6a3BbYKjZCWqvwgHtgwoPykJ35gVzJG7qvff5zeV")
                } else if (arg0 == b"Baha-2000" && arg1 == b"Digital Winter") {
                    (b"QmXApBE2HwbXD4byk7zdyW1fGKoS1pjrQLZkSboLqkxgb6", b"QmeKnCv2rnaZTc2FqAyz4ED1FWZDLo1dUGPMTAhuVUvror", b"QmTt6aNKNVyWSDwYdZNaXfwUDZgTmzGCxG14VzCcfkE4w8")
                } else if (arg0 == b"Baha-2000" && arg1 == b"Dusk") {
                    (b"QmVoE5sAz5dnxFouLCXSyo8NtNTaMVJ18bERSm2aqfTaJc", b"QmeKnCv2rnaZTc2FqAyz4ED1FWZDLo1dUGPMTAhuVUvror", b"QmS8Myc6RQXzBpVtphAmwkyjtxwtyxNLXn6hJxpLrV3CeN")
                } else if (arg0 == b"Baha-2000" && arg1 == b"Viceroy") {
                    (b"QmUSMpADfFkSVkXAMqrxJYxssuXFhRNvQdFtuxsJSGV5By", b"QmeKnCv2rnaZTc2FqAyz4ED1FWZDLo1dUGPMTAhuVUvror", b"QmWmaoe9DPKVSgkD6D3aruHAugTDzCbgdpELEu7gQi2raH")
                } else {
                    (b"", b"", b"")
                };
                (v8, v6, v7)
            };
            (v4, v5, v3)
        }
    }

    public(friend) fun get_left_bracer(arg0: vector<u8>, arg1: vector<u8>) : (vector<u8>, vector<u8>, vector<u8>) {
        if (arg0 == b"Fang MK IV" && arg1 == b"Vesper") {
            (b"QmXqWBynqUrfRhdhaxSq7o8VeeDnYE22s3duc3yYQaKwNY", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"Qma7qxAH1p2SBbJdnDJUyhTABqHuFyu6pf5wRykM47vtid")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Hikari") {
            (b"QmdDyDpGZHnhK389ESC8XHNVE6wj5SkBsPjDXfewh6vaSY", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"QmR7k6YEUj8VTk8dSdvYFZWsvYNqUKo6PQjMND94iV8oQQ")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Volt") {
            (b"QmedxC4QSmHd6g9WYraPnf3yxZnjaKPgMnmB4RfWDLhPUj", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"Qma7tkYqJ83eXnvWi37CjhrYJYnVvfFPB1axW5miR344Ct")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Blood Ivory") {
            (b"QmSUK6nKkoMm1va8xWmxE23uYxf9KAWYC1tCTjchz1wABX", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"QmbHGB2Vs2eZFa1R8mUGinb9uN5prnQJy1cZ8Nwaj4RxjD")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Red Damascus") {
            (b"QmYthENCKywsDKzFEVVZ1hxNR9pShwrmo1k8oJxHVgYUqX", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"QmQn9rdTaRSPBQqivo32gv36BtZKURjxnTEMEtLkw2Nkia")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Digital Winter") {
            (b"QmYqMjTor3k8vU7HpQFWzHqyAtUV6yQHUhrAGzxc1kqxVK", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"QmRBPQhmC1H1tJQ223Cu2549LjJgLHb7PPURExc1S7pBTn")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Dusk") {
            (b"QmStrNTzKLgV74imiTzvecfyxrUh3KJwYsV3KGcPFvsVhN", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"QmUyAYrRQqG2TPmFp2uHnmUiaw6bkKATDyYMystTxVZW9u")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Viceroy") {
            (b"QmTSFgFg5mRSx42GZwjzUugD5Uhfpi8wxmn7KKGQhDZZVn", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"QmVZ7bvZ8aDVBD2rp5jF2unsjoiroHyPiEnjTXubnBcakr")
        } else if (arg0 == b"Helios" && arg1 == b"Vesper") {
            (b"QmcKXwiFFabMh2dRsp8Kq7eac5mR6qRiXaEY8zRrHrp6mf", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmR4xrDEerAgDhx9pQqkVUj3SBs5uJuTUKXmF6Tkf3CC8w")
        } else if (arg0 == b"Helios" && arg1 == b"Hikari") {
            (b"QmNnwtztfjSSeEeQG1fZXXLu28ZaSJRqHWzzNhZJMuqUKq", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmUH6DxA6GJxsPaoM3T9eWwAES4S2evxHrhwuuzmn7HoNP")
        } else if (arg0 == b"Helios" && arg1 == b"Volt") {
            (b"QmVPd3dEqB4VZpUwX5m5u1RQDzh7CJr4jL1uxDSfiT21vY", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"Qmc4WPLJKSr7kY6rubfRDwfvBUaJCapBzZxjqSnPXHSJCj")
        } else if (arg0 == b"Helios" && arg1 == b"Blood Ivory") {
            (b"QmaWeNhKJapYex6ttHWwA1UsgM8t8LHe45kmeAaApcX1DE", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmTfwm1CRdJCexvC5HLtzrTfknRomdwrkfc1gLrwmi8zKG")
        } else if (arg0 == b"Helios" && arg1 == b"Red Damascus") {
            (b"QmTdE3gCw6g9k5bVqi6ejpFe8Q9WmNUAhuM6V24u4zKkuC", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmcGUoJRqRJXUx1X1bynYmJo5YPmyrUare5BrtRQ53nb48")
        } else if (arg0 == b"Helios" && arg1 == b"Digital Winter") {
            (b"QmY6usWXLFQjJTPCiw9pErxn2349y4ZSn7q5Xp9kas9xt3", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmVs1dwDtEzPtnmpm4a99MS2e6AFatkihfLvyUc9pSf6KJ")
        } else if (arg0 == b"Helios" && arg1 == b"Dusk") {
            (b"QmQUjmT13Kqx4QepjHqiZSBmA4H4CBAiLdmPFo5Pgy9SJZ", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmXy5dzvh6cs4drGa8Fdmj1cpDgFPiECCBQBhSVjwejH7U")
        } else if (arg0 == b"Helios" && arg1 == b"Viceroy") {
            (b"QmNt2i5TajmcNGHqTyUpXKpdZWe8rU7E4CXKNaPMeFLXJQ", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmUCsYDcdHt7nuYXN8FwSLNn4QjWJozkpg8hxR88tYB2KQ")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Vesper") {
            (b"QmRfy2rP9qjgA41jZqshjxghWnuqMjuX8Ma8smGv9htHtF", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmQfZi8WgtBZVP5ym14xm71x3Q89CxmdA2XqwWDxVnSMzU")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Hikari") {
            (b"QmY1fwbKbh84qF4x8N9riRWc5Qerf3EjRjYthWDCJpEapG", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmXczx7rwTt8sFd4SQHYkr6EAs9Ne1184ifNa1cHiWCcpR")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Volt") {
            (b"Qmd3LLkg4oCe25bj8hsAgVv12RVAf8NQFExgJXsnvVJ14M", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmRcopFjm83WvCAQLcQHP5JiQUyw2wWyse6XQ2ffZWXRxS")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Blood Ivory") {
            (b"QmayU6nsZsrYRAXEZiCABaqz3KsVHU65bJtWqacZm4gu9o", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmbM1Himh9mWhtYc2F6dB5pVbUKVRuP9dTCbYwPGhQw1cw")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Red Damascus") {
            (b"QmVH1a2LGQzWwz8ixtGSFRZdqRkxdoiwi6Fifh26vH1AT6", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmdQTJpZtFSkhcYZiAAaAvtvtG6fqY5xyCqiNzdu3s28hK")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Digital Winter") {
            (b"QmWdSfy1BdSfEnQ7GGNUaJDZZWkFnGMr9PPL1fKgVQSUNR", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmfH34y7r2QWNs8pbP4R4frZ2Bim5DypNop1U7XLFmysFj")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Dusk") {
            (b"QmaPwLvmjzhWRVFtSTnGP4aLz4sCFkBidbRdPqVUb4rnsS", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"Qma2nZKqwURqamqptVnUE8YuAvCb5Zh3b6ppJxjgwTymiE")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Viceroy") {
            (b"QmTAaQfPVdUxBxAHgiUjH1D8iswkMBu6sr8ofhZuBKpPwM", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmNSY8VKv6ijsr9xb1Spq9pyqzvga1Q88td7oL29kc189E")
        } else {
            (b"", b"", b"")
        }
    }

    public(friend) fun get_left_pauldron(arg0: vector<u8>, arg1: vector<u8>) : (vector<u8>, vector<u8>, vector<u8>) {
        if (arg0 == b"Fang MK IV" && arg1 == b"Vesper") {
            (b"QmZGG2NML9LwAZdyAWXHtpzS2PHaCh1kbqiKcw2mQR2dHT", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"Qma7qxAH1p2SBbJdnDJUyhTABqHuFyu6pf5wRykM47vtid")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Hikari") {
            (b"QmVytpnN9upw3zWisAowATG3pr43XtNuuLJjvYJcD64REk", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"QmR7k6YEUj8VTk8dSdvYFZWsvYNqUKo6PQjMND94iV8oQQ")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Volt") {
            (b"Qmc9aVWctf6MFm3zmUkNCWRpJ3itzyPhs1uqCYX471PXLb", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"Qma7tkYqJ83eXnvWi37CjhrYJYnVvfFPB1axW5miR344Ct")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Blood Ivory") {
            (b"QmTVhZKqth1fWCi8KYRAZ2jCaxjtc7fBr7cNe95f9JYdsw", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"QmbHGB2Vs2eZFa1R8mUGinb9uN5prnQJy1cZ8Nwaj4RxjD")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Red Damascus") {
            (b"QmUJgHr1pfzgchWv8xXefxwsjcCWoiy333k4HgWwrWWEB7", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"QmQn9rdTaRSPBQqivo32gv36BtZKURjxnTEMEtLkw2Nkia")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Digital Winter") {
            (b"QmNjF39qDhs2bUgLqyesX7J3MPXEw1cqb2zpA8qWrQbRJf", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"QmRBPQhmC1H1tJQ223Cu2549LjJgLHb7PPURExc1S7pBTn")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Dusk") {
            (b"QmXN5rvnqmQGjbDhMQAYHTiwiBwoPxDkmUYXVgtxQCaRth", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"QmUyAYrRQqG2TPmFp2uHnmUiaw6bkKATDyYMystTxVZW9u")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Viceroy") {
            (b"Qmc9MdgX1VhEHi2dKWHqJPmeeHUJQ3oae7anY6nRe1iof3", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"QmVZ7bvZ8aDVBD2rp5jF2unsjoiroHyPiEnjTXubnBcakr")
        } else if (arg0 == b"Helios" && arg1 == b"Vesper") {
            (b"QmXQTQLTTNU8p1jimPrrMmhkhcAQbPw6SC3ZZEcbYajPSK", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs1", b"QmR4xrDEerAgDhx9pQqkVUj3SBs5uJuTUKXmF6Tkf3CC8w")
        } else if (arg0 == b"Helios" && arg1 == b"Hikari") {
            (b"QmPUeUSbXBx4QjFyGjgHeC9bhkuvQQLxq3dUohB5rngoL3", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs2", b"QmUH6DxA6GJxsPaoM3T9eWwAES4S2evxHrhwuuzmn7HoNP")
        } else if (arg0 == b"Helios" && arg1 == b"Volt") {
            (b"QmWHE2QSp2557rYuMTUCof2XZWgDkoe5zBGGQW3K6S53kQ", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs3", b"Qmc4WPLJKSr7kY6rubfRDwfvBUaJCapBzZxjqSnPXHSJCj")
        } else if (arg0 == b"Helios" && arg1 == b"Blood Ivory") {
            (b"QmXP5FM3odwvTR3HbX7tHypFgRh35XjiKBrphVpE4BDfvK", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs4", b"QmTfwm1CRdJCexvC5HLtzrTfknRomdwrkfc1gLrwmi8zKG")
        } else if (arg0 == b"Helios" && arg1 == b"Red Damascus") {
            (b"QmVmEmHGQMU4Y18psUXK4Q5W5dNWhmYZQVnbCX3uBU1FUG", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs5", b"QmcGUoJRqRJXUx1X1bynYmJo5YPmyrUare5BrtRQ53nb48")
        } else if (arg0 == b"Helios" && arg1 == b"Digital Winter") {
            (b"QmPu2mjLhHNCfoPxZ9u1Bma1bDm9qwUXNwCcijEVd9rbue", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs6", b"QmVs1dwDtEzPtnmpm4a99MS2e6AFatkihfLvyUc9pSf6KJ")
        } else if (arg0 == b"Helios" && arg1 == b"Dusk") {
            (b"QmVbSTWm79Ya9CPken8qjrYrNYETg7FkWntiyShzCGCyHy", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs7", b"QmXy5dzvh6cs4drGa8Fdmj1cpDgFPiECCBQBhSVjwejH7U")
        } else if (arg0 == b"Helios" && arg1 == b"Viceroy") {
            (b"QmPkxR7Q6W8TnGQwWyrGGJxpH2h81frGYABCMGrbCHpVVv", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs8", b"QmUCsYDcdHt7nuYXN8FwSLNn4QjWJozkpg8hxR88tYB2KQ")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Vesper") {
            (b"QmZBu8pFAwy9WafdtL1JEMAusZU1EZf4F5MNr8niBqkMVY", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmQfZi8WgtBZVP5ym14xm71x3Q89CxmdA2XqwWDxVnSMzU")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Hikari") {
            (b"QmYz7VDgitqZ7wnS2bvQ8wxYe8wpLBwZEAfnrHTcKJA2Kn", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmXczx7rwTt8sFd4SQHYkr6EAs9Ne1184ifNa1cHiWCcpR")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Volt") {
            (b"QmTiuzHuXypKnigyaZmdPjgCSZesibU7U31PkgqCK1wYPw", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmRcopFjm83WvCAQLcQHP5JiQUyw2wWyse6XQ2ffZWXRxS")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Blood Ivory") {
            (b"QmdenS3WfAeUCLcBVm2KPmsgrzYuRvAariJeqfZWQq1vEq", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmbM1Himh9mWhtYc2F6dB5pVbUKVRuP9dTCbYwPGhQw1cw")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Red Damascus") {
            (b"QmbjUR7HoTXnmRRswyuohqxzZ1wPyB5cK8yopBCSvVyFYX", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmdQTJpZtFSkhcYZiAAaAvtvtG6fqY5xyCqiNzdu3s28hK")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Digital Winter") {
            (b"QmZLzrQuJ91cyTCe5wA31x2oUNAts93vid1YgaRbPpVkka", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmfH34y7r2QWNs8pbP4R4frZ2Bim5DypNop1U7XLFmysFj")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Dusk") {
            (b"QmdY2pzeUuHVKYV1rbVFKx4XGe2xmYwD3ynXCQHMyv6keg", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"Qma2nZKqwURqamqptVnUE8YuAvCb5Zh3b6ppJxjgwTymiE")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Viceroy") {
            (b"QmRJgKqZKLuyyKy1bVzoGrTcuqFXGXiG2WEx3pgtgcHcsP", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmNSY8VKv6ijsr9xb1Spq9pyqzvga1Q88td7oL29kc189E")
        } else {
            (b"", b"", b"")
        }
    }

    public(friend) fun get_other(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : (vector<u8>, vector<u8>, vector<u8>) {
        if (arg0 == b"Fang MK IV" && arg1 == b"Right Arm" && arg2 == b"Obsidian") {
            (b"Qmf5XuQHbBzaGkbmawgPTo6pQbjEYDPFwtGYsxqDv29W6Y", b"QmPKgzaUHgiVaejnVhmKYe8ySvN9QoPejBfGmAvV8EDTAk", b"Qme91xCktjvK2ohEe5Z1m7fqrW9zhmwXEqvcR9tUsQxmxQ")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Left Arm" && arg2 == b"Obsidian") {
            (b"QmPoRhkiGPfV36FPuH5eNmJzhN5jjoE4rZKjGfVPA3JPTH", b"QmUpMGFHtrbGtWVF4UY3ALkN7144osEyc3agie27xUsDst", b"Qme91xCktjvK2ohEe5Z1m7fqrW9zhmwXEqvcR9tUsQxmxQ")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Right Glove" && arg2 == b"Obsidian") {
            (b"QmSFTFWX5x8b3yHu9DhBdAf7oQ3FpK3z4X5sDur3YcAuBZ", b"QmQREkRpofc9k6AdSr7jjqfakc7v8iUnCbDm9tR7wTq633", b"Qme91xCktjvK2ohEe5Z1m7fqrW9zhmwXEqvcR9tUsQxmxQ")
        } else {
            let (v3, v4, v5) = if (arg0 == b"Fang MK IV" && arg1 == b"Left Glove" && arg2 == b"Obsidian") {
                (b"QmeAge99jdeV2ZGAhRADA8tbg6yv9hUgpQSZGPuzJfYL91", b"Qme91xCktjvK2ohEe5Z1m7fqrW9zhmwXEqvcR9tUsQxmxQ", b"QmVyHepwDoojjFe97qQNYhdm5o2y5Wht6hx8KjJdtXcy4j")
            } else {
                let (v6, v7, v8) = if (arg0 == b"Fang MK IV" && arg1 == b"Belt" && arg2 == b"Obsidian") {
                    (b"QmZTCcB1h6EhAuDdkrBSURvoJDSbQaBkryEjYFYqkLsjJU", b"QmXELes9dLWJqTvmQ472tiXJ6jh9w7Gzjtmqcib4xS4JBr", b"Qme91xCktjvK2ohEe5Z1m7fqrW9zhmwXEqvcR9tUsQxmxQ")
                } else if (arg0 == b"Fang MK IV" && arg1 == b"Upper Torso" && arg2 == b"Obsidian") {
                    (b"QmNPzNFsPXpy21NfrKAdt7UYTzcjAw3p9jCszUGPkhMmY2", b"QmdZVgV4kkY2SEXQhK9Tj1Yc4fbx1CMzNgXaspxfrCpkxH", b"Qme91xCktjvK2ohEe5Z1m7fqrW9zhmwXEqvcR9tUsQxmxQ")
                } else if (arg0 == b"Fang MK IV" && arg1 == b"Shins" && arg2 == b"Obsidian") {
                    (b"QmeqJLFKPnW9GF9aFUpFMLteKnJVhPbTwxLCiADunx1rcH", b"QmcfJ5fiDpw5Mo8VitGmJxYy9dopbjKrNQqkuq245hetyR", b"Qme91xCktjvK2ohEe5Z1m7fqrW9zhmwXEqvcR9tUsQxmxQ")
                } else if (arg0 == b"Helios" && arg1 == b"Legs" && arg2 == b"Hikari") {
                    (b"QmXA84fkpJYnj8uND8aBFpXWTX9a9iBSPDsTizD7mJetYb", b"QmWgBfhzkjp4xhfW6mu2K8pwo8BB22RK7AtMcUvKKnMbkx", b"QmVj2yJUsLZSYFhT5B4bg7BVMR7ZBQ8dgPGADPVLdsaTUp")
                } else if (arg0 == b"Helios" && arg1 == b"Legs" && arg2 == b"Volt") {
                    (b"QmW1Zne5wDGkYhu6uJ94UBcdgTgy8kbMyN4XDpHTPVYuCi", b"QmWgBfhzkjp4xhfW6mu2K8pwo8BB22RK7AtMcUvKKnMbkx", b"QmQxwtRVy9rDrAcWEowqZUP65kBEGqfi4dD4EA7UnSAymk")
                } else if (arg0 == b"Helios" && arg1 == b"Legs" && arg2 == b"Blood Ivory") {
                    (b"QmSs2nDMbTFEAyxBFo7h9mAQuVZ4cWBTDQpbyr5CDwymZp", b"QmWgBfhzkjp4xhfW6mu2K8pwo8BB22RK7AtMcUvKKnMbkx", b"QmX75QqqntYe5QaCG2EoxWw9uAXoPkJGMcaJSYtqjKfShs")
                } else if (arg0 == b"Helios" && arg1 == b"Legs" && arg2 == b"Dusk") {
                    (b"QmeYmoSJud4ZhmrU2FctvMGaSdggibybEjj33rVphYFEJC", b"QmWgBfhzkjp4xhfW6mu2K8pwo8BB22RK7AtMcUvKKnMbkx", b"QmYVjU45qhhvrcnZUq7fpjmhDHajRh1inqbPgJg3KX3NHQ")
                } else if (arg0 == b"Helios" && arg1 == b"Legs" && arg2 == b"Digital Winter") {
                    (b"QmYiVJkyUmkQzNbzFJvwdjnqq8vVGfW6dC56vvim1K6tvV", b"QmWgBfhzkjp4xhfW6mu2K8pwo8BB22RK7AtMcUvKKnMbkx", b"Qmb1VM5ouXbdvhWRTcG1o62ziJooHUx9netQqQHri3kVwU")
                } else if (arg0 == b"Fang MK IV" && arg1 == b"Legs" && arg2 == b"Volt") {
                    (b"QmPR2pG4BV5jxRpSyJrka79GBCnVwpaD4h5MYhAjPm7LPQ", b"QmfT6udrYTsdAAFQoLTJnseex2e5SWjJLEzYNsRZuFR4Na", b"QmZeHnF1hfnLFoQY4CzWFNWEngqD4xubpv3oY3t6s4B9Ec")
                } else if (arg0 == b"Fang MK IV" && arg1 == b"Legs" && arg2 == b"Blood Ivory") {
                    (b"QmRAJGMjbB1UYtjvHWiPfEgAgJcFHUx1Ls87wc9NW86moz", b"QmfT6udrYTsdAAFQoLTJnseex2e5SWjJLEzYNsRZuFR4Na", b"QmW8BexqjN1eeAtJm3PMJoKZn5C8nHLyaaSKHF3NzNjiNW")
                } else if (arg0 == b"Fang MK IV" && arg1 == b"Legs" && arg2 == b"Digital Winter") {
                    (b"QmYRL4Ws5DjjFywLzibgqLa3NSNDZinKNxn3xQZUywVrv3", b"QmfT6udrYTsdAAFQoLTJnseex2e5SWjJLEzYNsRZuFR4Na", b"QmPj1N162KPjsvfvW23L21J5fiMgS1ddi8TCTa3kZFRZU9")
                } else if (arg0 == b"Fang MK IV" && arg1 == b"Legs" && arg2 == b"Dusk") {
                    (b"QmT249WMmnCRHmctNykUEaN3L7soyVweP7TxoQe1J3DrfV", b"QmfT6udrYTsdAAFQoLTJnseex2e5SWjJLEzYNsRZuFR4Na", b"QmZCsLAMDiQHj4pqRC9uxnXoUiUj2LuxEC6Tfooa9PwxGi")
                } else if (arg0 == b"Fang MK IV" && arg1 == b"Boots" && arg2 == b"Vesper") {
                    (b"QmVhMNkjTcQA4r7bkkmVnWB848ZByUJJKxhEfUC59YZWwR", b"QmYZF7mxfYX3hFdk6eeGr5zq3XN2umvyC311xtxQV731an", b"QmfL4Ny444s5bZkY6RPvVk3ueRew5pidXcxsGzZywxaX7Q")
                } else if (arg0 == b"Fang MK IV" && arg1 == b"Boots" && arg2 == b"Hikari") {
                    (b"QmUcPUp3c8kvAAdoXRNJyHtNHVMvXKPsyQoZLtmB62FgDC", b"QmYZF7mxfYX3hFdk6eeGr5zq3XN2umvyC311xtxQV731an", b"Qme5VfGdBxJkbhNQpZuMkVDs62JVqBrFHZyuR3McNWWwbN")
                } else if (arg0 == b"Fang MK IV" && arg1 == b"Boots" && arg2 == b"Volt") {
                    (b"Qmbx5yrZbGxCmwBQLBNtcFifuCe7SRCUtikcniR5hzTdEG", b"QmYZF7mxfYX3hFdk6eeGr5zq3XN2umvyC311xtxQV731an", b"QmZKxvQmfAdqrvV9tJXNDbUuhyjhHqq6fB1nztAUKfzvBV")
                } else if (arg0 == b"Fang MK IV" && arg1 == b"Boots" && arg2 == b"Blood Ivory") {
                    (b"QmQiifUDqs3i8tirEX3ip3MSYxZ4TyFmeWmeVXu9aKWP1y", b"QmYZF7mxfYX3hFdk6eeGr5zq3XN2umvyC311xtxQV731an", b"QmUzF23GjLHUW6ZDFur7h4VB4nJKqUYNFP9oL3MXdi8Eyh")
                } else if (arg0 == b"Fang MK IV" && arg1 == b"Boots" && arg2 == b"Red Damascus") {
                    (b"QmXKQdQ1LJRNnXtkkVs7S3tV3sqY46XGdbyc2BRFpmupDt", b"QmYZF7mxfYX3hFdk6eeGr5zq3XN2umvyC311xtxQV731an", b"QmYVq1CwkMRDT1PEbUEQVZXkMDrBdZ2JMhxVoreCxTAhMV")
                } else if (arg0 == b"Fang MK IV" && arg1 == b"Boots" && arg2 == b"Dusk") {
                    (b"QmUt6coyQCM6D9m73gpgeTnYYCb9yZtAQKvn44nU4A17Qr", b"QmYZF7mxfYX3hFdk6eeGr5zq3XN2umvyC311xtxQV731an", b"QmZLLqH257RysDghRPN9QDMsGER1b4SQAFU2jjbjcWYen5")
                } else {
                    (b"", b"", b"")
                };
                (v7, v8, v6)
            };
            (v5, v3, v4)
        }
    }

    public(friend) fun get_right_bracer(arg0: vector<u8>, arg1: vector<u8>) : (vector<u8>, vector<u8>, vector<u8>) {
        if (arg0 == b"Fang MK IV" && arg1 == b"Vesper") {
            (b"QmSiGmYpj6TxQ6J6ZJmXsjDJ3eew1qCDDeguARVcj1CZgP", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"Qma7qxAH1p2SBbJdnDJUyhTABqHuFyu6pf5wRykM47vtid")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Hikari") {
            (b"QmaWRjDzNYUcdwvLHXacxFfPktbop7Pz1UQ1xp8ytKVvkP", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"QmR7k6YEUj8VTk8dSdvYFZWsvYNqUKo6PQjMND94iV8oQQ")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Volt") {
            (b"QmUjKRxCaoa7jj9wPtLVP99535cuZstKw61DSKHZomgzuC", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"Qma7tkYqJ83eXnvWi37CjhrYJYnVvfFPB1axW5miR344Ct")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Blood Ivory") {
            (b"QmSw7gPpmvQkYpokyn5ixrBEkoXnckjpFndEyHSdAUw3ei", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"QmbHGB2Vs2eZFa1R8mUGinb9uN5prnQJy1cZ8Nwaj4RxjD")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Red Damascus") {
            (b"QmRdzgXZFArajw1CHxkv65m2JUhVbPi4L6vPtvs1gkzRhx", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"QmQn9rdTaRSPBQqivo32gv36BtZKURjxnTEMEtLkw2Nkia")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Digital Winter") {
            (b"QmcmjafeZaCLWL5hQ4esTYtFgzuhEDZ6SGE6RBzsn8B3ed", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"QmRBPQhmC1H1tJQ223Cu2549LjJgLHb7PPURExc1S7pBTn")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Dusk") {
            (b"QmUMjqKx5DUHpPaA36ur4R3TEh9M8WkHMuCv1K8PGtiacY", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"QmUyAYrRQqG2TPmFp2uHnmUiaw6bkKATDyYMystTxVZW9u")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Viceroy") {
            (b"Qmb5A7MoJY2teBivNsDkNHrQRaDoxNJw6RNcSr9PNi8MWy", b"QmfBZ5aYwQWzArLR7jEUR1g7UDLNykRzyW8s3QyqjErH6A", b"QmVZ7bvZ8aDVBD2rp5jF2unsjoiroHyPiEnjTXubnBcakr")
        } else if (arg0 == b"Helios" && arg1 == b"Vesper") {
            (b"Qmf4nAHZEYaEPU5WFuvFo6ErEyChyPwqj4zo4TQpzxWf28", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmR4xrDEerAgDhx9pQqkVUj3SBs5uJuTUKXmF6Tkf3CC8w")
        } else if (arg0 == b"Helios" && arg1 == b"Hikari") {
            (b"QmfJp5cucxU5ouA9dtcyutujFTMs1d47JjZdBtU9LV9kDu", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmUH6DxA6GJxsPaoM3T9eWwAES4S2evxHrhwuuzmn7HoNP")
        } else if (arg0 == b"Helios" && arg1 == b"Volt") {
            (b"QmUS3vBjXT6v9N5ahu2snR3UAmm2BnvgoCdRdgrjYCjiH2", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"Qmc4WPLJKSr7kY6rubfRDwfvBUaJCapBzZxjqSnPXHSJCj")
        } else if (arg0 == b"Helios" && arg1 == b"Blood Ivory") {
            (b"QmYSApXrFKDBaPSqraEjpvnew36KMBrDGEYB1naEKN2kmG", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmTfwm1CRdJCexvC5HLtzrTfknRomdwrkfc1gLrwmi8zKG")
        } else if (arg0 == b"Helios" && arg1 == b"Red Damascus") {
            (b"QmVwgr2ukAavDuuCMQ9itd4qQFYq7J2YoGD8qLeDVcWoBT", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmcGUoJRqRJXUx1X1bynYmJo5YPmyrUare5BrtRQ53nb48")
        } else if (arg0 == b"Helios" && arg1 == b"Digital Winter") {
            (b"QmQdgmR9GVVymCxxoKijYxSBERgF6znXLBGZvdaLYUvbPK", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmVs1dwDtEzPtnmpm4a99MS2e6AFatkihfLvyUc9pSf6KJ")
        } else if (arg0 == b"Helios" && arg1 == b"Dusk") {
            (b"QmWWQsmCMosfrv4zd4iSEPG6QKPEkAxrJReKavm75LDezC", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmXy5dzvh6cs4drGa8Fdmj1cpDgFPiECCBQBhSVjwejH7U")
        } else if (arg0 == b"Helios" && arg1 == b"Viceroy") {
            (b"QmWoCKD1ErC2hba9J9HVJQX4dKJA5upykRq3vk3ZN2xHRZ", b"QmNuDJZb3LM1opC712Q18AjPqaAaFYWGjF6FRN5V6HbEKY", b"QmUCsYDcdHt7nuYXN8FwSLNn4QjWJozkpg8hxR88tYB2KQ")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Vesper") {
            (b"QmaVSVa7M3TbdumjaiDBPg5UneD84CdCJdo4bnR4DHvR3F", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmQfZi8WgtBZVP5ym14xm71x3Q89CxmdA2XqwWDxVnSMzU")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Hikari") {
            (b"QmYGonKLmwqKDsc7gcLPWF8bADFHGdwsMSZQeuS2M1nvY1", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmXczx7rwTt8sFd4SQHYkr6EAs9Ne1184ifNa1cHiWCcpR")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Volt") {
            (b"QmPRMKzz8auBeVJ6v2ZRk8oVSsSy8B8f67DaYjMGBnQnvs", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmRcopFjm83WvCAQLcQHP5JiQUyw2wWyse6XQ2ffZWXRxS")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Blood Ivory") {
            (b"QmXYJS3UmLgXpr1A4TgNkPR4Tp8hzEBEQEQxSpem3dEePL", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmbM1Himh9mWhtYc2F6dB5pVbUKVRuP9dTCbYwPGhQw1cw")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Red Damascus") {
            (b"QmPZ9n3yAgpgx8HaNfZEs98kwn7VXbxLphGNRu4BHiCFWf", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmdQTJpZtFSkhcYZiAAaAvtvtG6fqY5xyCqiNzdu3s28hK")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Digital Winter") {
            (b"QmW7hVFmZB5dkShChjpgtZjQe6CpqCCj82ZuxUu3tmvYRH", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmfH34y7r2QWNs8pbP4R4frZ2Bim5DypNop1U7XLFmysFj")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Dusk") {
            (b"QmQNeUnEYpfNtg3uFTG4d2UmMVGPT9P36yx2gvaZJnvUGX", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"Qma2nZKqwURqamqptVnUE8YuAvCb5Zh3b6ppJxjgwTymiE")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Viceroy") {
            (b"Qmdj74RuvnQoDjYcRDw7YkwhQQeZDcEo9LW4jdX7s8BiHx", b"Qmev1vqHEHun5yujgVfpB6d98dx9AmXpSme1Q8fm1uz3Yr", b"QmNSY8VKv6ijsr9xb1Spq9pyqzvga1Q88td7oL29kc189E")
        } else {
            (b"", b"", b"")
        }
    }

    public(friend) fun get_right_pauldron(arg0: vector<u8>, arg1: vector<u8>) : (vector<u8>, vector<u8>, vector<u8>) {
        if (arg0 == b"Fang MK IV" && arg1 == b"Vesper") {
            (b"Qmf4Sjhbtk7ou1epHrB4uWNJhXZ42HAPgkM2EujdjQ2K8J", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"Qma7qxAH1p2SBbJdnDJUyhTABqHuFyu6pf5wRykM47vtid")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Hikari") {
            (b"QmaFwkN2NQBw6v3PAqUv9fN9Z3DP3CeznY6j71ZUWRBdaz", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"QmR7k6YEUj8VTk8dSdvYFZWsvYNqUKo6PQjMND94iV8oQQ")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Volt") {
            (b"QmZWQLPu1FKYMoXNxjLwFqDrgJ29sUX5XRM7r8cPFoyoZh", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"Qma7tkYqJ83eXnvWi37CjhrYJYnVvfFPB1axW5miR344Ct")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Blood Ivory") {
            (b"QmdwP4UNr6Vtuh1G9bUesFnmhYnbBzbMoZsVEk99gsu1ky", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"QmbHGB2Vs2eZFa1R8mUGinb9uN5prnQJy1cZ8Nwaj4RxjD")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Red Damascus") {
            (b"QmQZttjmekzBKgHA1ojXBUWrKSfjeNwx8k28Xhdw6zPMY6", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"QmQn9rdTaRSPBQqivo32gv36BtZKURjxnTEMEtLkw2Nkia")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Digital Winter") {
            (b"QmRjQU3dRJq6h83S3xDngnAuSJ77AYCbvVRczBmjQ56GGZ", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"QmRBPQhmC1H1tJQ223Cu2549LjJgLHb7PPURExc1S7pBTn")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Dusk") {
            (b"QmRJga25EchbFKYSNayS8Ei45Q5MHyaU7Mb8uA9mxezgiD", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"QmUyAYrRQqG2TPmFp2uHnmUiaw6bkKATDyYMystTxVZW9u")
        } else if (arg0 == b"Fang MK IV" && arg1 == b"Viceroy") {
            (b"QmbTZQTY3pW2Hjajg7Z2Fjs3pkd6aC1EMJAyJy56TpTQqs", b"QmdGRF8PHaY5vgh3kt92HJudc7KKLMYCMYHNw1dT3hyuMR", b"QmVZ7bvZ8aDVBD2rp5jF2unsjoiroHyPiEnjTXubnBcakr")
        } else if (arg0 == b"Helios" && arg1 == b"Vesper") {
            (b"QmdUB89UbdiZVfhj5B9BiF2KKNNaTpoNzgKpfHetKUNVQ9", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs1", b"QmR4xrDEerAgDhx9pQqkVUj3SBs5uJuTUKXmF6Tkf3CC8w")
        } else if (arg0 == b"Helios" && arg1 == b"Hikari") {
            (b"QmWiiFgt6UjQAvDVo9JwucHRAgYj5VgXg3p3r9aLsb1hSr", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs2", b"QmUH6DxA6GJxsPaoM3T9eWwAES4S2evxHrhwuuzmn7HoNP")
        } else if (arg0 == b"Helios" && arg1 == b"Volt") {
            (b"QmXKceKgqdXCADyBp9tmVm3uzQg2n88tNYs8beUe48Wumf", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs3", b"Qmc4WPLJKSr7kY6rubfRDwfvBUaJCapBzZxjqSnPXHSJCj")
        } else if (arg0 == b"Helios" && arg1 == b"Blood Ivory") {
            (b"QmQTLSSVd1yvaEbDzD8QK2h94vGKeiqwwjwmyKbwWjyXrQ", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs4", b"QmTfwm1CRdJCexvC5HLtzrTfknRomdwrkfc1gLrwmi8zKG")
        } else if (arg0 == b"Helios" && arg1 == b"Red Damascus") {
            (b"QmdL6ec66vrasTLZy7838VgmUiBBs6ho965ifHdoHFyRut", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs5", b"QmcGUoJRqRJXUx1X1bynYmJo5YPmyrUare5BrtRQ53nb48")
        } else if (arg0 == b"Helios" && arg1 == b"Digital Winter") {
            (b"QmRkKNU51isEvfwLm6YUrXS5vsVceK2AZTAm45GBH6wwVu", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs6", b"QmVs1dwDtEzPtnmpm4a99MS2e6AFatkihfLvyUc9pSf6KJ")
        } else if (arg0 == b"Helios" && arg1 == b"Dusk") {
            (b"QmYZdMxUFQ92PYtBMd7uoWCRLxPb3C9vNhSZYDMMUyBo7y", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs7", b"QmXy5dzvh6cs4drGa8Fdmj1cpDgFPiECCBQBhSVjwejH7U")
        } else if (arg0 == b"Helios" && arg1 == b"Viceroy") {
            (b"Qmcz2xSDSENbohBVSZ8KCvs6Vw4vHCwrWGc5yNG1WHQG9y", b"QmUyEaCtTvWJofoh9X2xLZ1XqLXM2kAijoNhCikA4FXEs8", b"QmUCsYDcdHt7nuYXN8FwSLNn4QjWJozkpg8hxR88tYB2KQ")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Vesper") {
            (b"QmUsRbdVssWsGCvbKJzTVeSYBdrCc62vJoLakYeryGeXot", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmQfZi8WgtBZVP5ym14xm71x3Q89CxmdA2XqwWDxVnSMzU")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Hikari") {
            (b"Qmay9VwA2dXHPhiZbrbHRUrT9QqqLTC1WTHysB7DJesaeU", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmXczx7rwTt8sFd4SQHYkr6EAs9Ne1184ifNa1cHiWCcpR")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Volt") {
            (b"QmaJGCLULTVgPEecoQjSVibuXxVUU7hm9nBbGAKZyzLSPM", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmRcopFjm83WvCAQLcQHP5JiQUyw2wWyse6XQ2ffZWXRxS")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Blood Ivory") {
            (b"QmW2pkqnMFV3RYcsdGGbcd81G9jVHtTEpnxLhpHf7pptNf", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmbM1Himh9mWhtYc2F6dB5pVbUKVRuP9dTCbYwPGhQw1cw")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Red Damascus") {
            (b"Qmc95s6tryBWZFaekJ8hS6Dha8qzvYcWRoorJ5kEu3aiyF", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmdQTJpZtFSkhcYZiAAaAvtvtG6fqY5xyCqiNzdu3s28hK")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Digital Winter") {
            (b"Qmdge5jvvSZyPk5ytAJMwNi9wysGz4WfcnQmsBdcXAYZAH", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmfH34y7r2QWNs8pbP4R4frZ2Bim5DypNop1U7XLFmysFj")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Dusk") {
            (b"QmUG3QZY9N1g6JwYKXyFC1pqzjNLvvJ4sbdmySufxeQuXj", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"Qma2nZKqwURqamqptVnUE8YuAvCb5Zh3b6ppJxjgwTymiE")
        } else if (arg0 == b"Neo-Shogunate" && arg1 == b"Viceroy") {
            (b"QmY7Dj4hJcUXk6zzAoHS1c6UK7xjSe49SJXYakN17TkpoK", b"QmRqFH9qG1HNdrZu2DcKPCD4ZMaqE3R41vmdNBfhzB2BJY", b"QmNSY8VKv6ijsr9xb1Spq9pyqzvga1Q88td7oL29kc189E")
        } else {
            (b"", b"", b"")
        }
    }

    public(friend) fun get_weapon(arg0: vector<u8>) : (vector<u8>, vector<u8>, vector<u8>) {
        if (arg0 == b"Talon") {
            (b"QmZJsZjQUDw4p9kdW5iJVMvAW1Kq1rZmkR5R3MTXHw8yLC", b"QmWevevsHSTACBdR339Vm37pHuzqCszmh2n5mKw6pKsAxk", b"Qmc1c6nfpGaE5L5GJpzf9frMrfFwyNPn4K8ANuBoVH6526")
        } else if (arg0 == b"Renegade") {
            (b"QmVcRFLdZVQCVx7CnR5wUZaBfhQvK8vEDPJJWv6zYLddNU", b"QmPM7UQqdDNyo8Y6XGwnAofJwRAqLUoShb7V5kdp6uLrmX", b"QmYvCYnYpgv1a5wvtnDU5yJ3VFTXES21A2WGUv4iV2zqi9")
        } else if (arg0 == b"Raptor") {
            (b"QmXSU8KtxG6sfrtWxHYHp3fBdy9MLqVusz3s7BRYVkotUD", b"QmfVixneV9iNhKnFc8LNuMwxB46cPwpcZoYuKEtGsuBWVn", b"QmPuhiTscBhBkDZePiVoPS3hcoMQ2vZb56pEo3pmxBWQW6")
        } else if (arg0 == b"Valenti 12") {
            (b"Qmd1XZodJRcWc19YkcFYSk3mXTEFnFudGpvkXBjKJWKrnq", b"QmaDtnPD94AYFKBq9SPas58wENb7GSJvU7sBkwYo2VRZVV", b"QmVbjiENLixsfY6bgjrL9xhh1RRqpnbxGVffZ2QMyjSJzb")
        } else if (arg0 == b"Enforcer") {
            (b"QmbUr1K3n7uzVcBre764k2FXUKRbYnK9YxgmvrQkyPkV8S", b"QmTNZ65j4pZCQjEd4yPk8pJXLQJoE26iyqqqEmbXosrguk", b"QmWLUjRvprjQay4uEdAJxfdWshhd7Ee7CGuagRp5YbAZfX")
        } else if (arg0 == b"Whisper 9mm") {
            (b"Qmd5bukgXb8k2hk9tBoiFmumHnymCjEkMjtZTisaNAvgds", b"QmTFC2VbGN5azjEgLh3smZrXtWZPsve58i71QKG8uso3Jf", b"QmTJ6bbWZsjBYbKjFajKwtHqqAjXFjYN8bEDGqqVzqUJyR")
        } else if (arg0 == b"Wakizashi") {
            (b"QmXE6Zu5cJCTgUCakAiZ8tyyZnwVFeV8HVAAtF6GECi6Q2", b"QmeCfprhnh9SA2ZAJxRrUMB2tdJUk75uap5ftzA3uzGMFu", b"QmVsF3nLeXn8ZDyWW4faeRg9JGNyQ8FFyyicnFpm6ocHHB")
        } else if (arg0 == b"Scalper") {
            (b"QmZff5Fa1bARuNfZFzw5fwG1owDcmhzRxdu41LNPMjSTju", b"QmQpvT7TzoiWT3iGabMofyKttGU4Eh1JNfQfnQvsG7yZj9", b"QmcW2myEAobNXegmDo9PLsDxePuRNkxrwtyQEwWVaD5vEU")
        } else if (arg0 == b"Neo-Katana") {
            (b"QmZxG1GsZUwQeoRTZexdyyCMzCMDC7JGNnnaz5RfbTDKW4", b"QmZqJVwqBusJU1RsgHnMm7SqPfnCxvg33wTt6uot9vkYbB", b"QmVsF3nLeXn8ZDyWW4faeRg9JGNyQ8FFyyicnFpm6ocHHB")
        } else {
            (b"", b"", b"")
        }
    }

    // decompiled from Move bytecode v6
}

