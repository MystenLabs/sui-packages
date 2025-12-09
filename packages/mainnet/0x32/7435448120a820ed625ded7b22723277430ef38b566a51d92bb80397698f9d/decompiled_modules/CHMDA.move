module 0x327435448120a820ed625ded7b22723277430ef38b566a51d92bb80397698f9d::CHMDA {
    struct CHMDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHMDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHMDA>(arg0, 9, 0x1::string::utf8(b"CHMDA"), 0x1::string::utf8(b"chammmanda"), 0x1::string::utf8(b"The legendary chammmanda - a mystical fire-breathing creature of the Sui blockchain"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHMDA>>(0x2::coin_registry::finalize<CHMDA>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHMDA>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMDA>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMDA>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

