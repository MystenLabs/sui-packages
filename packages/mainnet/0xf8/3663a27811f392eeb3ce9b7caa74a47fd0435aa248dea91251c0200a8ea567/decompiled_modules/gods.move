module 0xf83663a27811f392eeb3ce9b7caa74a47fd0435aa248dea91251c0200a8ea567::gods {
    struct GODS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODS>(arg0, 7, b"GODS", b"GODFATHER", b"only the gods can change the game", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GODS>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODS>>(v1);
    }

    // decompiled from Move bytecode v6
}

