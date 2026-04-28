module 0x5890bfbd740f1546a9bb255e48d6f01007fc68eb2590f19fd88f2208f14ebb5f::frkin {
    struct FRKIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRKIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FRKIN>(arg0, 9, b"FRKIN", b"FREEKIN", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v3 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<FRKIN>>(0x2::coin::mint<FRKIN>(&mut v3, 10000000000000, arg1), v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRKIN>>(v3, v0);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FRKIN>>(v2);
    }

    // decompiled from Move bytecode v6
}

