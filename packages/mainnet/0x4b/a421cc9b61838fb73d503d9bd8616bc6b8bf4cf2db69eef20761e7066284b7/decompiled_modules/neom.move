module 0x4ba421cc9b61838fb73d503d9bd8616bc6b8bf4cf2db69eef20761e7066284b7::neom {
    struct NEOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEOM>(arg0, 6, b"neom", b"NEOM", b"Nemo debt token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

