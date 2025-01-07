module 0x675f1cd0e34057e4de0727c8a3b6147721407d0b50182cccff5075346a3f2671::wild {
    struct WILD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILD>(arg0, 6, b"WILD", b"Wild N Nasty", b"Raw. Wild. Unleashed.  Exclusive content for my bold followers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2beb52fb_f0d3_4df8_b405_2c9001b46095_6f0f141053.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILD>>(v1);
    }

    // decompiled from Move bytecode v6
}

