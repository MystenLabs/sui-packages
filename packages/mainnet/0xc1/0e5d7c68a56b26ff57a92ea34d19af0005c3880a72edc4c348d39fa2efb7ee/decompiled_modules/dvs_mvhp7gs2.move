module 0xc10e5d7c68a56b26ff57a92ea34d19af0005c3880a72edc4c348d39fa2efb7ee::dvs_mvhp7gs2 {
    struct DVS_MVHP7GS2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVHP7GS2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVHP7GS2>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvhp7gs2"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVHP7GS2>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVHP7GS2>>(0x2::coin_registry::finalize<DVS_MVHP7GS2>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

