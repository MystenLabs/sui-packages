module 0xb794aa81bca65c1eda9855633f758820e6d1c3995c6c85b6df4967fb221ece6d::MNTIL {
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

