module 0x9388575979c317005cfef9138085842b2b0136a32048936255b6a89f28e8ef33::vsui {
    struct VSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VSUI>(arg0, 9, b"VSUI", b"VSUI", b"VSUI", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

