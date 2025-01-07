module 0x5c4ac54a4c5cc5dd387547ec78911f0078045ded229261149a4574196cf84cee::memek_rfae {
    struct MEMEK_RFAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFAE>(arg0, 6, b"MEMEKRFae", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFAE>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFAE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFAE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

