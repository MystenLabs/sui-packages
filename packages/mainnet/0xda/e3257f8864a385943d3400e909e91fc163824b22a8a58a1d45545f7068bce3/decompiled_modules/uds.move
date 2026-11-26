module 0xdae3257f8864a385943d3400e909e91fc163824b22a8a58a1d45545f7068bce3::uds {
    struct UDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: UDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UDS>(arg0, 9, b"UDS", b"UDS Test Token", b"Sui chain test token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<UDS>>(0x2::coin::mint<UDS>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UDS>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

