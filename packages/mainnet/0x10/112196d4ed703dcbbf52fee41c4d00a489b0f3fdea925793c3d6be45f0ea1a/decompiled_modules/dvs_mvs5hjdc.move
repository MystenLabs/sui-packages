module 0x10112196d4ed703dcbbf52fee41c4d00a489b0f3fdea925793c3d6be45f0ea1a::dvs_mvs5hjdc {
    struct DVS_MVS5HJDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVS5HJDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVS5HJDC>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvs5hjdc"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVS5HJDC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVS5HJDC>>(0x2::coin_registry::finalize<DVS_MVS5HJDC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

