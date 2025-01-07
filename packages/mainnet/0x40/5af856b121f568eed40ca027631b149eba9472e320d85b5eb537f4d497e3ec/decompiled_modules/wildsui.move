module 0x405af856b121f568eed40ca027631b149eba9472e320d85b5eb537f4d497e3ec::wildsui {
    struct WILDSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILDSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILDSUI>(arg0, 6, b"WILDSUI", b"Wild Sui", x"57696c6453756920f09f9085f09f8d83202d205468652057696c64657374204d656d6520546f6b656e206f6e207468652053756920426c6f636b636861696e2120f09f9a80f09fa4a3f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731121284147.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WILDSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILDSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

