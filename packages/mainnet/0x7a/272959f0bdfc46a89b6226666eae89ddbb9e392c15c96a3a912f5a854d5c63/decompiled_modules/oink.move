module 0x7a272959f0bdfc46a89b6226666eae89ddbb9e392c15c96a3a912f5a854d5c63::oink {
    struct OINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<OINK>(arg0, 6, b"OINK", b"Oink", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRuAEAABXRUJQVlA4INQEAABQHQCdASqAAIAAPm0ylUekIqIhJ5IrQIANiWMAejpBd8HAK8RjpfeYD9h/WZ6QD+wdST6AHSm/ud6R2qy+YumB9Rlnh/e/xx/LfUQf4PfhOP/1r/R90d+IHuT2vfJRx6+ivoV+ovYP/Vj/eF08o2OF1PPVDmQU8NcHfDUUmKgLB7pXW6ADoZxWANX2YnIMUDwwVcDw1nryZjk8TWjHh+6pfKus6wKAzoiBpSFKf5DA5HjMbYF3wGGHl9Dy4CneRd5QzYKkrlAMjdkmfbbbTX2LnhkGRRGaf6yJeNlAXu/4MgOPsYa1SOMCFR1W0+zwahBSV7AA/vz4QB78HwO0bhQcQIJdeU4g1YmPdW+IKDfx6X99uBJExfB9lReH9wYt57/Y9QqH9rz5np7le0fOpWxuBexqX/mc5e3CvPKxqJgsSFUpq9fsfuFT1qcf74PKklA5/fZ35WwpmQfKw1+QE5JILdYWro56gQTq9zlKqT1pywjYeiEdRyXC9Gfb7mOsIId2AYtrPydcsjdj8Yw5xIf/9I2hNSyp72Wi8UkAIsZXjX9vOZ8gujoxfSOQfxqdz7lCaTZr10TG36fIIFi+m++F2foOpmgjCaZ2yYMeITxh15eppN4VX+JYjC3MQU3QD5JJHnohiWOB9TADNgeK9TOktOzTtK+prgTZhTG1oODJncnaudf8QDCwf5KWa+3q9tNS50a0ES8t+lrEaNgvo1LcB6/B3MtXLdHz/l1fiSWq8hReJG4Vmv0X/JR0TU4vfkdQkmVSHG/x51a4k5eEyNlWebPqKMkicSTwmcBE4GRW0pw2mJ5pZcqbgwuUA13tG+IlLE3Vi1HBFMF8Cpx4/6lJ/BhXXp74p3z0vmIDxNlKU4AhodZGd3iZNGaEtp4xsYVOV+v+SejrZMcFkugJWuMrij7FqjCYsE03YILmcYi4Q+uqpPyXpWheubqHucc3Hk7r5hnD8dH0YQfCpOTz/yDbtnNO9L/vQLrsd9W1DVZ7iE+rU0oGo/6AHY9vnW/tPTQN/Bfk83PlCaBSaOkk//4NarVSsTfI1gBJeEiViAtWiFhuoFuEXDN90Q1cETD/wc3qa6eWtbAkagQISK3bNxFjeo3628z5400UARiEF1FcfncuO8T5KElNC3DonnH8ZuEoriaFUzPgBnuoR7jj/cTwx9CwGb9Mv8ctRKf3GAkTbnz8XkfMXvtBe3fa6x8TEyAd9Y+kZmJ1gnXQfytuXl/hWH85UDBBMPG2cPvbs49ViB1UglSnpbptmcmksIxN38EpTUfphKf2Bb2C31q4JPGvMkpcWQFqXU+9b3jAQJ3nYJ9YeYCLKNCrGnhxmRRlgrgarcQCDsdgVhghJacncTV+/5hvbP0XhPO0w/srEJaGXKtxjKXfYQmG1wYVqn2nuXxUf3uWZciuCVrGSOmPyn+f6Mf7rA+MW/FO38jByH4JZyVtvFiRSbExjOq4+EhvBX4fi/SjsWoaoypL1vH1t8ZWT02uSKDu/6/GSlJD+WvSd521j+uovL/qAI6DJED79+GeMBxG+oVR2jcqul4HbltdrDUvqROuVU4styHr96iTwVWCvJ1tMNyJ+0D/kXX+3+BDrIkTtzQpe5Lf9MUjajwcMbz/OUH8GpDm9IgNIweogAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

