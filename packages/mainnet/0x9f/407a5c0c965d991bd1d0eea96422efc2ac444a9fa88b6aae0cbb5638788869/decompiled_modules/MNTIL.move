module 0x9f407a5c0c965d991bd1d0eea96422efc2ac444a9fa88b6aae0cbb5638788869::MNTIL {
    struct MNTIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MNTIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MNTIL>(arg0, 9, 0x1::string::utf8(b"MNTIL"), 0x1::string::utf8(b"myntil"), 0x1::string::utf8(b"A custom utility token for decentralized applications"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MNTIL>>(0x2::coin_registry::finalize<MNTIL>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MNTIL>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNTIL>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MNTIL>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

