module 0x41286015c57968fc09cba1afdf46ab05e4197652e23af1c83a582772a445e8ca::lofiSui {
    struct LOFISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOFISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOFISUI>(arg0, 9, b"sylofiSUI", b"SY lofiSUI", b"SY LOFI Staked SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOFISUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOFISUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

