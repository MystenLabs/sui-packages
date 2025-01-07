module 0x3be5026764430950449094c880d971f0298e4fd04e322c6f3b82a99e71d22faa::memek_rfaae {
    struct MEMEK_RFAAE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEK_RFAAE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEK_RFAAE>(arg0, 6, b"MEMEKRFAae", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEK_RFAAE>>(v1);
        0x2::coin::mint_and_transfer<MEMEK_RFAAE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEK_RFAAE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

