module 0xba2daa055453b55356833254d92a065f06d233740c9a89508114ec4f648de970::plonk {
    struct PLONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLONK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PLONK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PLONK>(arg0, b"PLONK", b"Plonk", b"Plonk is the first Sui dog coin for the people, by the people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmPRfcs8hcRdrup93xAJTj8Q44rTs1XHNxdJPFCo43neYh")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0016fa1cc4a26714931f3c1d3984d25a80994fae2aba4c2829f3a2e8239b17621760fc23e6bd774049d4bae9ac456a2f4dff0c157ff865bac7d860f94a7277a304d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747761123"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

