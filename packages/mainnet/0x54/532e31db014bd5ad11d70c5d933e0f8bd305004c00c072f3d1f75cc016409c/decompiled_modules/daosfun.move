module 0x54532e31db014bd5ad11d70c5d933e0f8bd305004c00c072f3d1f75cc016409c::daosfun {
    struct DAOSFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAOSFUN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DAOSFUN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DAOSFUN>(arg0, b"DAOSFUN", b"Suidaosfun", b"Enabling a new era for DAOs on SUI, investing in both tech coins & memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbTwUZT3jRfAepo95whZGA4eznizNZkkuFvFWWJtatH3M")), b"https://suidaos.fun/", b"https://x.com/SuiDAOs_fun", b"DISCORD", b"https://t.me/suidaosfun", 0x1::string::utf8(b"00e7f1242b1a3284d1827932f04d2573f5c8fe5e92ac684b9d73f2e04eae37b3b52e19946b6cea63e970eb6382bfb53e3e4741e225d297407728b9eb90391e5007d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758600"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

