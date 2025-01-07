module 0x9d04502f43d3d1b8d7381f8fc62d07005e1fb9fcb86f407e3b8b6e158776b838::memek_rfeasr {
    struct MEMEK_RFEASR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASR>(arg0, 6, b"MEMEKRFEASR", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASR>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASR>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASR>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

