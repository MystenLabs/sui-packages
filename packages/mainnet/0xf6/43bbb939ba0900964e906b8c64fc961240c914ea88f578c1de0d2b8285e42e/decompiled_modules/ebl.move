module 0xf643bbb939ba0900964e906b8c64fc961240c914ea88f578c1de0d2b8285e42e::ebl {
    struct EBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EBL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<EBL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<EBL>(arg0, b"EBL", b"Eblis", b"he was in love with ....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUyAdwwSKsngMwBYWCN4A3nCgUGMr5CBbUx2bstEaD8ch")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"005a1286c4be51ca254d8c532ea2bf18bc94e5f997cf30a18db3fa667a7995aae27410451de80cb1df261f67ed18145e096e6c8da23a010b2b8181f48db2ba6a08d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748151985"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

