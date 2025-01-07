module 0x1e4ff8cfab9652c2c47d4781c06fdee676615485b48c99c8fefeffe705ddf905::babydoge {
    struct BABYDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYDOGE>(arg0, 6, b"BabyDoge", b"Babydoge", b"babydoge in the sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732081566364.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYDOGE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYDOGE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

