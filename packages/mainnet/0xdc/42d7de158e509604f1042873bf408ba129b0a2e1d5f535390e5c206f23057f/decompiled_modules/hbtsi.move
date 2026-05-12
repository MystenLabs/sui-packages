module 0xdc42d7de158e509604f1042873bf408ba129b0a2e1d5f535390e5c206f23057f::hbtsi {
    struct HBTSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HBTSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HBTSI>(arg0, 6, b"HBTSI", b"Heartbeat Sui Testnet", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HBTSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HBTSI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

