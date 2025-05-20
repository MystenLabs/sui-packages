module 0xf3c67068785d6ed741e2a34652f40003e8b51c58599eaf76d9872c2458adfdb1::splashy {
    struct SPLASHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASHY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASHY>(arg0, b"SPLASHY", b"Splashy", b"Splashy the ghost roams around the Sui network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWYtG5dHg8dDxmxUJtqApyevGNVfJbgt2CyyqxqQbnktp")), b"WEBSITE", b"https://x.com/SplashyOnSui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00f982e72d2ceccdc7c436600bb31f87a3a9906aa1f6bc315a0b387b1902674b08d67c72940680195f439b7b766063670f4dbdfba9d4fea37dbcee866a75e09601d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756817"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

