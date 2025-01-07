module 0x898548770a0daeb3d143b8996a532f0c74493ff5ea1c720e839719fa0120b6e1::wusdt {
    struct WUSDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUSDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUSDT>(arg0, 6, b"WUSDT", b"WUSDT", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<WUSDT>>(0x2::coin::mint<WUSDT>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WUSDT>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WUSDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

