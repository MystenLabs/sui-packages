module 0x7447c4c115d66d189d6d2df32590471a19d6467edb2f682db7b3fe1b994ed10f::dvs_mvhne6l1 {
    struct DVS_MVHNE6L1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVHNE6L1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVHNE6L1>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvhne6l1"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVHNE6L1>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVHNE6L1>>(0x2::coin_registry::finalize<DVS_MVHNE6L1>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

