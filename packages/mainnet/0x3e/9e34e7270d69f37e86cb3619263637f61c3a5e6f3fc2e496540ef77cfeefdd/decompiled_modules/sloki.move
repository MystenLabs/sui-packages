module 0x3e9e34e7270d69f37e86cb3619263637f61c3a5e6f3fc2e496540ef77cfeefdd::sloki {
    struct SLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SLOKI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SLOKI>(arg0, b"SLOKI", b"SloKing", b"SloKing! The Pokemon meme king on SUI. Stake, vault NFTs, and rule the chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmSB6aG9jaHtavbLkZgRJhjVnhuaqmJDpxMpY73dy6t6Tz")), b"WEBSITE", b"https://x.com/slokingonsui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003c03953426b08e437a77fb50e86dcb69ee82071e77f5a3109626a5158b4c3c7807dfd7b76d9ee47ecb8469d7d2fd5d32b7af7b38a5bfdc0b6d8952cd14f7ef05d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748249285"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

