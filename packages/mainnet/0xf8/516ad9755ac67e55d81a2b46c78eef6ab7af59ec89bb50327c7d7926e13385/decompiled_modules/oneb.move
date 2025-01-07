module 0xf8516ad9755ac67e55d81a2b46c78eef6ab7af59ec89bb50327c7d7926e13385::oneb {
    struct ONEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONEB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<ONEB>(arg0, v0, b"ONEB", b"TESTONEBILLION", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONEB>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONEB>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<ONEB>>(0x2::coin::mint<ONEB>(&mut v4, 1000000000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

