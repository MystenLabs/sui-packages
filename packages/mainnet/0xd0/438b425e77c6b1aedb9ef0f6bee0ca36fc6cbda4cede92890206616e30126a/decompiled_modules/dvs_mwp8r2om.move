module 0xd0438b425e77c6b1aedb9ef0f6bee0ca36fc6cbda4cede92890206616e30126a::dvs_mwp8r2om {
    struct DVS_MWP8R2OM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DVS_MWP8R2OM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1f44a8e9fab4380228fe9c1bcc27d99b7f6ea76a8e18b5c178ca18cd46fb33c4::sale_token::new<DVS_MWP8R2OM>(arg0, 9, 0x1::string::utf8(b"DVS"), 0x1::string::utf8(b"DevSim mwp8r2om"), 0x1::string::utf8(b"BlastFun devsim token"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0xd70a8d11582fd1997380bc59bfd56a2f9028ebe11da74514ea3d386258d932fc::sealed_treasury_cap::SealedTreasuryCap<DVS_MWP8R2OM>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DVS_MWP8R2OM>>(0x2::coin_registry::finalize<DVS_MWP8R2OM>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

