module 0x3aeee18c2cb21264b8c53ba4904c80fcf66bb6302b923a7130b675920f23033b::stSUI {
    struct STSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STSUI>(arg0, 9, b"systSUI", b"SY stSUI", b"SY AlphaFi Staked SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

