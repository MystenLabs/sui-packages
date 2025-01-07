module 0x7e2d99db4b2e0715cdb5e61131067866e70ff649e4ce28927c1c87ece09b812e::five {
    struct FIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIVE>(arg0, 6, b"FIVE", b"Five Dollars", b"$5.00 is coming $SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2025_01_03_T233429_000_2f3651884b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

