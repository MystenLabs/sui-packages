module 0x5c4bd569617f9f63440a2ee23a9162c172ad057f5191ae22947571f73274bd0a::CHMMDA3 {
    struct CHMMDA3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHMMDA3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHMMDA3>(arg0, 9, 0x1::string::utf8(b"CHMMDA3"), 0x1::string::utf8(b"chammmanda"), 0x1::string::utf8(b"The legendary chammmanda - a mystical fire-breathing creature of the Sui blockchain"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHMMDA3>>(0x2::coin_registry::finalize<CHMMDA3>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHMMDA3>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMMDA3>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHMMDA3>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

