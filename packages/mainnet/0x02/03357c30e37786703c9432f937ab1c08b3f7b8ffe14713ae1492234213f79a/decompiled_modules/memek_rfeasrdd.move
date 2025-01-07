module 0x203357c30e37786703c9432f937ab1c08b3f7b8ffe14713ae1492234213f79a::memek_rfeasrdd {
    struct MEMEK_RFEASRDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFEASRDD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFEASRDD>(arg0, 6, b"MEMEKRFEASRDD", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFEASRDD>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFEASRDD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFEASRDD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

