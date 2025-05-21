module 0xf0a50b6575ac5a084a0b5c84fa7421432f9862b750499c7fe02173034060865b::dogy {
    struct DOGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DOGY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DOGY>(arg0, b"DOGY", b"DOGGY", b"DOGY DOGY DOGY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcoY1W8sowvMKBXcP1dLFufSR6u5aBmtRkPqyzwz2EN2N")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0017be73a8e3b1c8198be3a18cc992208e6ad71493249c5191d7d277884d1c2a8ac1af536cd6ecf2c45109b0b4f32b148f5242efe6edf5028232bd81ac33f77202d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747843539"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

