module 0x15923feb08beba3c83c6062a47fa0b5523bde0795a008e3fe79899aed9c0c9ce::dvs_mwp6fsao {
    struct DVS_MWP6FSAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MWP6FSAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<DVS_MWP6FSAO>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mwp6fsao"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DVS_MWP6FSAO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MWP6FSAO>>(0x2::coin_registry::finalize<DVS_MWP6FSAO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

