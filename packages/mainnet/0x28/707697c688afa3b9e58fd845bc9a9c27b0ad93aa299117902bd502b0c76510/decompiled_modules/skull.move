module 0x28707697c688afa3b9e58fd845bc9a9c27b0ad93aa299117902bd502b0c76510::skull {
    struct SKULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKULL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SKULL>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SKULL>(arg0, b"SKULL", b"Skull", b"The nasal cavity is formed by the vomer and the nasal, lachrymal, and turbinate bones.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQ7WQ72jrhep2nfNdezbYPpX3jqeAUnjYYTU2mnZvjNDZ")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0021d916c2072f8b1198ad7bca909a0106c733ed7cb5fbdf84e5a447205f8d803a1807b3b1125ad1db397213e7b2b89883e7fd9960f130353783b8eaf88ab9fe0cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747323874"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

