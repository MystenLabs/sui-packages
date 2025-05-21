module 0xbb4106c98c39af5b5ee78df9e0f4502663918adea30e9c0086107ff55ba2e87a::tank {
    struct TANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TANK, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TANK>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TANK>(arg0, b"TANK", b"SuiTank", x"546865206d656d6574616e6b206f6620405375694e6574776f726b20f09f90a2f09f92a70a4f6e2d636861696e2e2048656176792e20556e73746f707061626c652e202454414e4b20697320726f6c6c696e6720e280942067657420696e206f722067657420666c617474656e65642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmd6ZQg5o4fprXiBTWsHDMStio2BY1QhxXU62RSiyFtWUb")), b"WEBSITE", b"https://x.com/suitankcoin", b"DISCORD", b"https://t.me/suitankcoin", 0x1::string::utf8(b"00e5ac9623653284b3e18bc8b41102e571c49cc32dd633f902cf9b874f66f0de36c2aa1ee7db2cb44c1fe2c4abb69d269f522d4905e635dbdc1c8aa44dec24ea07d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747830072"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

