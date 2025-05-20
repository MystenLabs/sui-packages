module 0x43a4d9ed4214beaeb2496d19206da55accfb6bf6d752400f510dc82d53f1488d::blinky {
    struct BLINKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLINKY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BLINKY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BLINKY>(arg0, b"BLINKY", b"Blinky the coin", b"$BLINKY, first SUI fish full of splashes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUAqS5R6dgUp1bgbC7Q2pHJ941GxaPjcva6C8bfnhSVee")), b"https://suiblockchain.net/blinky", b"https://x.com/SuiBlinky_", b"DISCORD", b"https://t.me/suiblinky", 0x1::string::utf8(b"00bf0c9dcb607b54702c6cbaac78e78b0c19f9d607d9be5b2d1d166fdc811756e6e22444a63a2b18f06f1bf28a4954ca5bb8c78561178dab8cf4f63dc7436d1000d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747766940"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

