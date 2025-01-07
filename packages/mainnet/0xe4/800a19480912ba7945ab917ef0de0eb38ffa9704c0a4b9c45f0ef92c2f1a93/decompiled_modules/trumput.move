module 0xe4800a19480912ba7945ab917ef0de0eb38ffa9704c0a4b9c45f0ef92c2f1a93::trumput {
    struct TRUMPUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPUT>(arg0, 6, b"TRUMPUT", b"TRUMP VS PUTIN", b"Who wins?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pixlr_image_generator_4911c0cc_5a6a_4c3a_b61d_8835612c19b4_0e568bdcef.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

