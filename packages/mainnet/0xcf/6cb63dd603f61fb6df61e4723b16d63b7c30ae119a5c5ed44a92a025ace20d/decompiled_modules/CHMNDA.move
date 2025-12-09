module 0xcf6cb63dd603f61fb6df61e4723b16d63b7c30ae119a5c5ed44a92a025ace20d::CHMNDA {
    struct CHMNDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHMNDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHMNDA>(arg0, 9, 0x1::string::utf8(b"CHMNDA"), 0x1::string::utf8(b"chammmanda"), 0x1::string::utf8(b"The legendary chammmanda - a mystical fire-breathing creature of the Sui blockchain"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHMNDA>>(0x2::coin_registry::finalize<CHMNDA>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHMNDA>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMNDA>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMNDA>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

