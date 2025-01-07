module 0x35a6fbf26a7f90a86e9b37160cbbdea26c5f5c3c6ca9f97c035ebe624a44d313::memek_rfeasrd {
    struct MEMEK_RFEASRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRD>(arg0, 6, b"MEMEKRFEASRD", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRD>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

