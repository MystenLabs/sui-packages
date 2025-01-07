module 0x6a30f117c2dd34b0587c0818b9ba549b1ff138d0980ce6e4ad3f6aeb6cfe5225::dk {
    struct DK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<DK>(arg0, v0, b"DK", b"DK", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DK>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<DK>>(0x2::coin::mint<DK>(&mut v4, 1000000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

