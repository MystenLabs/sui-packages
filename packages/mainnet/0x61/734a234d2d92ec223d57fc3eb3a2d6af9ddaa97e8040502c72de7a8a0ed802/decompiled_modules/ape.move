module 0x61734a234d2d92ec223d57fc3eb3a2d6af9ddaa97e8040502c72de7a8a0ed802::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<APE>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<APE>(arg0, b"APE", b"Ape Club", b"APE.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUaz8cn45WSKbDGAsCE8NrryyLxS6Rz1zsyjEtRBVod4r")), b"https://docs.sui.io/paper/sui.pdf", b"https://x.com/SuiNetwork", b"https://discord.com/invite/sui", b"https://t.me/Sui_Blockchain_Chinese", 0x1::string::utf8(b"00c11d1ca545a1624b57c43d6849d88049ada86eba9871b521cb5ca8d78f58ae822acc38f105e95063c60f1177775b3dfb18f88e7e261580ea77c12aaee537fe0ff5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739329561"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

