module 0x56a457262ace1f899aa78ea2e077802779e2b421f874b1e89cbc1ac57946754a::kSUI {
    struct KSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSUI>(arg0, 9, b"sykSUI", b"SY kSUI", b"SY Kriya Staked SUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

