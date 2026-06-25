module 0x734d1d7ccb9e2d91c55c3c7a170677af3cc212c5a972aa5df73ff5475d0c4da2::sniff {
    struct SNIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIFF>(arg0, 9, b"SNIFF", b"SNIFF", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SNIFF>>(0x2::coin::mint<SNIFF>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIFF>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIFF>>(v1);
    }

    // decompiled from Move bytecode v7
}

