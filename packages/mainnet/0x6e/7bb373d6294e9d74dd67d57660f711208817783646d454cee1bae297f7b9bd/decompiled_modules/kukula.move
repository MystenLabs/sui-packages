module 0x6e7bb373d6294e9d74dd67d57660f711208817783646d454cee1bae297f7b9bd::kukula {
    struct KUKULA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUKULA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUKULA>(arg0, 6, b"KUKULA", b"", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUKULA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUKULA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

