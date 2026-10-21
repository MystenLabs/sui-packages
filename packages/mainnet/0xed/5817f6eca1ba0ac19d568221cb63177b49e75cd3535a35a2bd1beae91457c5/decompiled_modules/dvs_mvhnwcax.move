module 0xed5817f6eca1ba0ac19d568221cb63177b49e75cd3535a35a2bd1beae91457c5::dvs_mvhnwcax {
    struct DVS_MVHNWCAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVHNWCAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVHNWCAX>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvhnwcax"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVHNWCAX>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVHNWCAX>>(0x2::coin_registry::finalize<DVS_MVHNWCAX>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

