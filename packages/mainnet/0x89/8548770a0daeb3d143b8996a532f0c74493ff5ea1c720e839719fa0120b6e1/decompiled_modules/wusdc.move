module 0x898548770a0daeb3d143b8996a532f0c74493ff5ea1c720e839719fa0120b6e1::wusdc {
    struct WUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUSDC>(arg0, 6, b"WUSDC", b"WUSDC", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<WUSDC>>(0x2::coin::mint<WUSDC>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WUSDC>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

