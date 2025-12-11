module 0xf336ebf48304b5b45dd268e9fbf8864c6b2fb02b0beaf47a6ca6f56c6d1de66d::BRN983509 {
    struct BRN983509 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRN983509, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BRN983509>(arg0, 9, 0x1::string::utf8(b"BRN983509"), 0x1::string::utf8(b"Burn Test Token 1765472983509"), 0x1::string::utf8(b"Token for testing burn operations"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BRN983509>>(0x2::coin_registry::finalize<BRN983509>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BRN983509>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRN983509>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRN983509>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

