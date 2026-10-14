module 0x6181e2aabffb4fe6f495a53167591e526a18efa458b6b94c7922a899366877ea::fthm {
    struct FTHM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FTHM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FTHM>(arg0, 9, b"FTHM", b"Fathom", b"Fathom (FTHM), bridged from Arc by LayerZero", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FTHM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FTHM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

