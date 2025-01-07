module 0x3db9a151862c85e85476d4112b6b1b29d8d43e16af2bea94b269302c76c52222::memek_rfeasrdba {
    struct MEMEK_RFEASRDBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRDBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRDBA>(arg0, 6, b"MEMEKRFEASRDBA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRDBA>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRDBA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRDBA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

