module 0x8b292f45f303fa3bf215ab95bc0a43d2e38cdb3a830aa3875a53f1d2cac18b9a::ccs {
    struct CCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCS>(arg0, 6, b"CCS", b"cell cat sui", b"CELL IN COMING FOR SUI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_88d639a38b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

