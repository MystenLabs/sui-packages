module 0x7830690e33e3abb3bb798acf74f85fefcfa968bf05cc1ed9a7244ed37f30d88f::squirtle {
    struct SQUIRTLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIRTLE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SQUIRTLE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SQUIRTLE>(arg0, b"Squirtle", b"SQUI", x"5371756972746c65206f6e2053756920f09f94ab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeNiKPCWULg4DC5nEZxCWWaMUUTabWgavCEfv95kn6EPF")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"009173cf35d521f796a2ffff17838349db783a093f3c733e03d46ed55517d47da200f0144e84f52dceefe270fed2980f01e1553bd7178f62e58c9e3f599eebd60ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747759235"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

