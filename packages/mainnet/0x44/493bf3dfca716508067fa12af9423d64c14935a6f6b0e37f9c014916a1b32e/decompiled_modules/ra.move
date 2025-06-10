module 0x44493bf3dfca716508067fa12af9423d64c14935a6f6b0e37f9c014916a1b32e::ra {
    struct RA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<RA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<RA>(arg0, b"Ra", b"ivra", b"RADY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRon79rLyh4RFPxwzKdkyfFup6j9FZi9UvDEsVBa7L4zh")), b"WEBSITE", b"https://x.com/iv1580", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ace402886523b312b95c012923b8f2bbeca7342e92a77b7f6eb977d4aaca6988ba9bc9fc5f5db242547e9fc9a79bf3b582265515c21d66fcd8a335100216b106d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749544197"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

