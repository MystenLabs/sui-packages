module 0x15e74c49b8dd310d2073a5400cd32669931643f30ac23ef2b341c0b0c312362e::sui_wolf {
    struct SUI_WOLF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_WOLF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_WOLF>(arg0, 9, b"WOLF", b"Sui Wolf", b"The sui WOLF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://photos.pinksale.finance/file/pinksale-logo-upload/1775521315261-8df14eb122a94c14e5a422b271ebc831.gif"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUI_WOLF>>(0x2::coin::mint<SUI_WOLF>(&mut v2, 50000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI_WOLF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_WOLF>>(v2, @0x0);
    }

    // decompiled from Move bytecode v7
}

