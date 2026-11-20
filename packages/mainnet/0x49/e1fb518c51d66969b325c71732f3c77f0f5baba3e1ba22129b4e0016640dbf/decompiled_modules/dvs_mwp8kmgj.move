module 0x49e1fb518c51d66969b325c71732f3c77f0f5baba3e1ba22129b4e0016640dbf::dvs_mwp8kmgj {
    struct DVS_MWP8KMGJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MWP8KMGJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<DVS_MWP8KMGJ>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mwp8kmgj"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DVS_MWP8KMGJ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MWP8KMGJ>>(0x2::coin_registry::finalize<DVS_MWP8KMGJ>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

