module 0xecb16c00d53e431b8d8b8f76c61540bac08191c7eded0a4d1af6a8a48c861d7f::pho {
    struct PHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PHO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::BondingCurveStartCap<PHO>>(0xd8eca1042cad0b9657d93fd462c9f0437bbd387a83765dbb4c4956b5872ced18::bonding_curve::create_bonding_curve<PHO>(arg0, b"PHO", b"Photo", b"photo token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXWwVYov7ey6TstegGG5baaBptxBd8rq5phbyM3f9MYKv")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d2d2f2b0fbd38efdd7c6ad351a77032f6ffdf64f82726ca38d5efd265b4ab6366e202176e11b67cc4624950a6149deca2f2ab2d6065a252e333d8da88767e806f5e689b46a3c79677b7e9b0dfffd989cb2ebbaf787a48e68232da391253111631739524562"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

