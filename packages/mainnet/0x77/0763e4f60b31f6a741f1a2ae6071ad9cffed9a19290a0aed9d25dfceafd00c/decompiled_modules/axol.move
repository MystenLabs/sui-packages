module 0x770763e4f60b31f6a741f1a2ae6071ad9cffed9a19290a0aed9d25dfceafd00c::axol {
    struct AXOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOL>(arg0, 6, b"AXOL", b"Axol On Sui", b"Smiling Ear to Ear", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Axol_f2f952adf2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

