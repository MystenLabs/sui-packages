module 0xd0210c1b32d8cc4b36d99a2a728e04982662e959e1124137d31383def450d891::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GOAT>(arg0, 6, b"GOAT", b"Goatseus Maximus by SuiAI", b"First meme on SUI created by @truth_terminal. Goatseus Maximus will fulfill the prophecies of the ancient memeers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/GOAT_71fc574ab6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GOAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

