module 0xe5949b5632e95e16e78f278ae5a31b0cf038f2e6285b28b84ed486f85ac101b7::solanasiu {
    struct SOLANASIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOLANASIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOLANASIU>(arg0, 6, b"SOLANASIU", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOLANASIU>>(v1);
        0x2::coin::mint_and_transfer<SOLANASIU>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOLANASIU>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

