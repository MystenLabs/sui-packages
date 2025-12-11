module 0x88a6388ae20a7586b98e0dd7b60318e1d2353924e689ba3d2227baa3242d06e5::FLX333813 {
    struct FLX333813 has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLX333813, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<FLX333813>(arg0, 9, 0x1::string::utf8(b"FLX333813"), 0x1::string::utf8(b"Flexible Test 1765474333813"), 0x1::string::utf8(b"A flexible supply test token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<FLX333813>>(0x2::coin_registry::finalize<FLX333813>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FLX333813>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLX333813>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLX333813>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

