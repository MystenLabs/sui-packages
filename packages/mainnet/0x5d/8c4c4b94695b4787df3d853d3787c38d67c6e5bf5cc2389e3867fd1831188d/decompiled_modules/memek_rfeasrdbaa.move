module 0x5d8c4c4b94695b4787df3d853d3787c38d67c6e5bf5cc2389e3867fd1831188d::memek_rfeasrdbaa {
    struct MEMEK_RFEASRDBAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRDBAA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRDBAA>(arg0, 6, b"MEMEKRFEASRDBAA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRDBAA>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRDBAA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRDBAA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

