module 0xaa0e36c32c459e19b02d38ac806c1a2a95decc8e9dc777043c23904a0e520ee5::player {
    struct PLAYER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLAYER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PLAYER>(arg0, 6, b"PLAYER", b"PLAYER 456", b"PLAYER 456 ON SUIAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/logo_e4bd43dc62.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PLAYER>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLAYER>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

