module 0xbf92936420917efc7133e492f95ba83614a33794a3723701109a36b430816350::CHDX {
    struct CHDX has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHDX>(arg0, 9, 0x1::string::utf8(b"CHDX"), 0x1::string::utf8(b"Charmandrix"), 0x1::string::utf8(b"A fiery, Pokemon-inspired token with burn-only mechanics for deflationary fun on the Sui blockchain."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHDX>>(0x2::coin_registry::finalize<CHDX>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CHDX>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHDX>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHDX>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

