module 0x39005ce09acdc0913c99011119f1fd56e4e7898391058ad263071575525f21b9::fire_dog {
    struct FIRE_DOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRE_DOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://photos.pinksale.finance/file/pinksale-logo-upload/1777921471759-fffb4599bd0653dbb9abf1faf3f775da.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) > 0) {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1777921471759-fffb4599bd0653dbb9abf1faf3f775da.jpg"))
        } else {
            0x1::option::none<0x2::url::Url>()
        };
        let (v2, v3) = 0x2::coin::create_currency<FIRE_DOG>(arg0, 9, b"FIRE DOG", b"FIRE DOG", b"Fire Dog Coin", v1, arg1);
        let v4 = v2;
        if (1000000000000000000 > 0) {
            0x2::coin::mint_and_transfer<FIRE_DOG>(&mut v4, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRE_DOG>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIRE_DOG>>(v3, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

