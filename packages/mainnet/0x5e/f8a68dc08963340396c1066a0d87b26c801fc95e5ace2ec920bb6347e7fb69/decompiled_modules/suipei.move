module 0x5ef8a68dc08963340396c1066a0d87b26c801fc95e5ace2ec920bb6347e7fb69::suipei {
    struct SUIPEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPEI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIPEI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIPEI>(arg0, b"SUIPEI", b"Sui Pei", b"Meet SUIPEI the feline warrior raised in a small ancient village in China by his elderly master PeiPei, an expert in the ancient art of \"Feline Krypto Fu\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZjQzUVZtJohpS7UX46EJpiVeBcc1Sbse4mvTh3KcQP9d")), b"https://www.suipei.xyz/", b"https://x.com/SuiPeionSui", b"DISCORD", b"https://t.me/Sui_pei", 0x1::string::utf8(b"003b8313d01c55703671eb59b1220192c104ad1a869c3b147b78de572f51a7072026e5f767dde638f8ac8b39444fa3cee5b54c16b99011ab4b65e39c715c6ac800d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747768380"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

