module 0xcbb4097dbc7bf93b3ff0f8ac55ce328ff43e9b763278ee1e5e96c2abddacbfdd::nugget {
    struct NUGGET has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUGGET, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/IMG_6591-xVluEJxHco0baDP2cGcZA1lSKDahvU.jpeg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/IMG_6591-xVluEJxHco0baDP2cGcZA1lSKDahvU.jpeg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<NUGGET>(arg0, 9, b"NUGGET", b"nugget", b"Gold nugget", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NUGGET>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUGGET>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<NUGGET>>(0x2::coin::mint<NUGGET>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

