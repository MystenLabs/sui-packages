module 0x16d462bc5c5a08701f1df3c9bfc30a1024f51537f3e4eab179c9ed535762c8e::shwa {
    struct SHWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHWA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SHWA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SHWA>(arg0, b"SHWA", b"Sheetless Water", x"416e20496e6469616e206d616e206472696e6b696e6720636c65616e2c207368c4b1746c65737320776174657220666f72207468652066697273742074696d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmU57b8HpjLY1Vbg8z62fXgQ3daLKPJkUbJcDj3ennWuwD")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"000f4bafaa0d45b979b6c4ee55b5abb757699d09f6a664a6954169722a1e404d99612cee399617684db2c38efe6d19c3909ce71619f68ede60f6ea55ecdc2fff07d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747793397"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

