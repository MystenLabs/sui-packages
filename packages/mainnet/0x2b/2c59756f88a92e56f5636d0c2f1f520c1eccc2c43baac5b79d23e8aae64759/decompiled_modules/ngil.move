module 0x2b2c59756f88a92e56f5636d0c2f1f520c1eccc2c43baac5b79d23e8aae64759::ngil {
    struct NGIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGIL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<NGIL>(arg0, v0, b"NGIL", b"NEWGIL", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGIL>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGIL>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<NGIL>>(0x2::coin::mint<NGIL>(&mut v4, 20000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

