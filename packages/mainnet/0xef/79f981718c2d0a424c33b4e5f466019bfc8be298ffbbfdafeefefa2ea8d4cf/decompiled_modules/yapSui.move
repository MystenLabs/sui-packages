module 0xef79f981718c2d0a424c33b4e5f466019bfc8be298ffbbfdafeefefa2ea8d4cf::yapSui {
    struct YAPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAPSUI>(arg0, 9, b"syyapSUI", b"SY yapSUI", b"SY Yap Staked SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YAPSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAPSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

