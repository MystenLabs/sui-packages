module 0xc1bbee154997b8986f5cc67650f4861cc1aebc5b1881f7dbfe81c6e5ab6b23ea::test {
    struct TEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEST, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TEST>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TEST>(arg0, b"TEST", b"test", b"just test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeH3NZBTMKY6EbAPi6niD6SeXHgg49viARaUk5bL1V3tP")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"007ff36f57c1a04c7a70a0c60845f039cc594d4c3908299ae5317a9e0c09722d77fbcd1fe7a4fb5019395fc8fb924bf9383d2cfd1d368601735819f2342ed99601d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747764702"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

