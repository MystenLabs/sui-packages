module 0x7895eb81f5f82a19fb7858187580acba620159dd5506f138d13868484143b136::wdk {
    struct WDK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WDK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 9;
        let v1 = b"undefined";
        if (0x1::vector::length<u8>(&v1) > 0) {
            0x1::option::some<vector<u8>>(v1);
        };
        let (v2, v3) = 0x2::coin::create_currency<WDK>(arg0, v0, b"WDK", b"WDK", b"undefined", 0x1::option::none<0x2::url::Url>(), arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WDK>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WDK>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<WDK>>(0x2::coin::mint<WDK>(&mut v4, 10000000 * 0x2::math::pow(10, v0), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

