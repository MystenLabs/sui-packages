module 0xb882b45245e8dfcce659c141b6155e731400ea50ebded01136872362914e8d9f::MNT589598 {
    struct MNT589598 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNT589598, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MNT589598>(arg0, 9, 0x1::string::utf8(b"MNT589598"), 0x1::string::utf8(b"Mint Test Token 1765474589598"), 0x1::string::utf8(b"Token for testing mint operations"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MNT589598>>(0x2::coin_registry::finalize<MNT589598>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MNT589598>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNT589598>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNT589598>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

