module 0xc9a08dc57d4372ff9ac545e41a35d04205f8ae1601a83b39bd124189a6133338::tuzki {
    struct TUZKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUZKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUZKI>(arg0, 6, b"TUZKI", b"Tuzki", b"$TUZKI is a simple meme, cartoonish white rabbit with large, expressive eyes and a minimalist design.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0675_c501959afd.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUZKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUZKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

