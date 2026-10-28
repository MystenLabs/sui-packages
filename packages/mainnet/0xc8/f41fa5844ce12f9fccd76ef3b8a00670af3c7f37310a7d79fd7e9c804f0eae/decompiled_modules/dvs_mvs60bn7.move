module 0xc8f41fa5844ce12f9fccd76ef3b8a00670af3c7f37310a7d79fd7e9c804f0eae::dvs_mvs60bn7 {
    struct DVS_MVS60BN7 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MVS60BN7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MVS60BN7>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mvs60bn7"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MVS60BN7>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MVS60BN7>>(0x2::coin_registry::finalize<DVS_MVS60BN7>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

