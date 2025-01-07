module 0x4675c070847886153ddb1640f09f1b8218cfdf373bb992c86325372512cb32b9::sxl {
    struct SXL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SXL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SXL>(arg0, 6, b"SXL", b"SUI AXOL", b"Meet AXOL, the cutest amphibian on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/axol_14eb2f3a73.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SXL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SXL>>(v1);
    }

    // decompiled from Move bytecode v6
}

