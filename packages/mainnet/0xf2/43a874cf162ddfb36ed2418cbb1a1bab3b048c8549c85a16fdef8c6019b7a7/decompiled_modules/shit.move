module 0xf243a874cf162ddfb36ed2418cbb1a1bab3b048c8549c85a16fdef8c6019b7a7::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 8, b"SHIT", b"shit", b"PoW-mined token on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suicommunityx.github.io/shit-icon.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIT>>(v1);
        0xf243a874cf162ddfb36ed2418cbb1a1bab3b048c8549c85a16fdef8c6019b7a7::mining::create_and_share<SHIT>(v0, arg1);
    }

    // decompiled from Move bytecode v7
}

