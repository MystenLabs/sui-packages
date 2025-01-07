module 0x75348b7a617866dbeb80e32dca23b6d6585eefdb6a74c3632f7418834b651fd6::ult {
    struct ULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ULT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<ULT>(arg0, v0, b"ULT", b"ULT", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ULT>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ULT>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<ULT>>(0x2::coin::mint<ULT>(&mut v4, 100000000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

