module 0x7f1320fd77e3a5a58d11d7307a4642c0420e20a75aa10bb68bc02f2073ab6ccc::dollar {
    struct DOLLAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLLAR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DOLLAR>(arg0, 6, b"DOLLAR", b"DOLLAR BANKNOTE", b"SuiEmoji Dollar Banknote", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.suiemoji.fun/emojis/dollar.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOLLAR>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLLAR>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

