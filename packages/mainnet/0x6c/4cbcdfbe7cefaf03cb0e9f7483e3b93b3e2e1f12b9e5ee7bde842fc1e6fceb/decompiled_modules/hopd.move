module 0x6c4cbcdfbe7cefaf03cb0e9f7483e3b93b3e2e1f12b9e5ee7bde842fc1e6fceb::hopd {
    struct HOPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPD>(arg0, 6, b"HOPD", b"hop.dead", b"Hop is dead! Phase 2 is when sui hits 10$", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_53_6393bca4ae.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPD>>(v1);
    }

    // decompiled from Move bytecode v6
}

