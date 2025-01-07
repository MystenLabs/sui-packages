module 0x23e8231e71e1bdcea94a2576839f224a1478277a39d3642e0c8b551744eee90a::dad {
    struct DAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAD>(arg0, 9, b"DAD", b"Are ya winning son?", b".Are ya winning son?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0xe0bddd8b0d180d7493f614d26931450e5ba1a199.png?size=xl&key=973233")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DAD>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAD>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

