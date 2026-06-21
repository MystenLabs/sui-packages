module 0xc8ee73edf5c8f559561f1dd6553f709802788b46546043f5f2a39dbda970c21b::aether {
    struct AETHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: AETHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AETHER>(arg0, 9, b"AETHER", b"Aether", b"Utility token", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AETHER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AETHER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

