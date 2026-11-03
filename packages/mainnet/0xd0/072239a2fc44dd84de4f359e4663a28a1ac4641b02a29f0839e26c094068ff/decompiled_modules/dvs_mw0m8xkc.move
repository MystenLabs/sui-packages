module 0xd0072239a2fc44dd84de4f359e4663a28a1ac4641b02a29f0839e26c094068ff::dvs_mw0m8xkc {
    struct DVS_MW0M8XKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MW0M8XKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DVS_MW0M8XKC>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mw0m8xkc"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DVS_MW0M8XKC>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MW0M8XKC>>(0x2::coin_registry::finalize<DVS_MW0M8XKC>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

