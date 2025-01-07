module 0xa975de376c9b5da3aad81f99152a209122b440fc46d157c81727e7b39ac4bc50::squidpnut {
    struct SQUIDPNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDPNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDPNUT>(arg0, 6, b"SQUIDPNUT", b"SQUID PNUT", b"Risk it all, go nuts$SQUIDPNUT takes the game to the next level.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ocz_Rovbu_400x400_51a5b4b9cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDPNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDPNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

