module 0xf43f20aa8afe55e2b6c00c67f00148c7a2394cece2cd884c696b35d43284c833::cstars {
    struct CSTARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSTARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSTARS>(arg0, 6, b"CSTARS", b"CORN STARS", x"434f524e20535441525320464f5220594f5520414c4c200a0a434f4d45204a4f494e20555320594f5520484f524e59204d4653200a0a504f524e20494e2054454c454752414d20564944454f204348415420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CSTARS_3308db1ce2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSTARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSTARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

