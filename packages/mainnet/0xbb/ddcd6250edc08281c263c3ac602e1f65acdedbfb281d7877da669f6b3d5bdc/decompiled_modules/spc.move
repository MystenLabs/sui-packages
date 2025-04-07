module 0xbbddcd6250edc08281c263c3ac602e1f65acdedbfb281d7877da669f6b3d5bdc::spc {
    struct SPC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<SPC>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<SPC>(arg0, b"SPC", b"SPAACE", b"Anyot SPAACE SPAACESPAACE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQyjB52DRDeemCs1zW3prgse49ixzgsBDCZTT928yRRe1")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007ba29b7a9a961fa9b1263dfde6d5a9b27550eb33cd73eb19225615596b51fe668fd308531b39da922eb8b7fe9900e7b1632efa1c2431af0552375d3701fc8006f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631744014511"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

