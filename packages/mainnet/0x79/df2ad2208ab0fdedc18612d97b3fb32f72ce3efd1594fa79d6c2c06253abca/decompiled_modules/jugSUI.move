module 0x79df2ad2208ab0fdedc18612d97b3fb32f72ce3efd1594fa79d6c2c06253abca::jugSUI {
    struct JUGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUGSUI>(arg0, 9, b"syjugSUI", b"SY jugSUI", b"SY Jugemu Sui", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JUGSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUGSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

