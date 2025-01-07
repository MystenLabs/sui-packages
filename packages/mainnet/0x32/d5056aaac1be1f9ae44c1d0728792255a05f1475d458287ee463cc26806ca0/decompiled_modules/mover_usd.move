module 0x32d5056aaac1be1f9ae44c1d0728792255a05f1475d458287ee463cc26806ca0::mover_usd {
    struct MOVER_USD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVER_USD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVER_USD>(arg0, 6, b"moverUSD", b"MOVER USD", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://mov3r.xyz/moverUSD.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOVER_USD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVER_USD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

