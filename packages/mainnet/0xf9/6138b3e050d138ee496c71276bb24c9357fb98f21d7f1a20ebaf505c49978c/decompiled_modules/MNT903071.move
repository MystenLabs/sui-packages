module 0xf96138b3e050d138ee496c71276bb24c9357fb98f21d7f1a20ebaf505c49978c::MNT903071 {
    struct MNT903071 has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNT903071, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MNT903071>(arg0, 9, 0x1::string::utf8(b"MNT903071"), 0x1::string::utf8(b"Mint Test Token 1765472903071"), 0x1::string::utf8(b"Token for testing mint operations"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MNT903071>>(0x2::coin_registry::finalize<MNT903071>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MNT903071>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNT903071>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNT903071>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

