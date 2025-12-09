module 0x9d704470e45873e35b2e3cdda8833e94b4d9daa3c87dada82714332a78651dca::ALPHA {
    struct ALPHA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ALPHA>(arg0, 9, 0x1::string::utf8(b"ALPHA"), 0x1::string::utf8(b"Alphanumero"), 0x1::string::utf8(x"416c7068616e756d65726f202d207768657265206e756d62657273206d65657420616c706861206761696e7320f09f94a2f09f9a80"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ALPHA>>(0x2::coin_registry::finalize<ALPHA>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ALPHA>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHA>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

