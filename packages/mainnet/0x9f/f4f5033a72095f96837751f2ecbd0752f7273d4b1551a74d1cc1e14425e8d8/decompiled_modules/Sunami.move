module 0x9ff4f5033a72095f96837751f2ecbd0752f7273d4b1551a74d1cc1e14425e8d8::Sunami {
    struct SUNAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNAMI>(arg0, 6, b"Sunami", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUNAMI>(&mut v2, 10, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUNAMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNAMI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

