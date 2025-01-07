module 0x8a560a6084da249da9e8e2a888c565255482479549f701da6faa560a36cf5ff3::ccat {
    struct CCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::BondingCurveStartCap<CCAT>>(0x2a20d4c2d103816de4bbc8a56d627834e591fcf70f284279e77586a4a32a570b::bonding_curve::create_bonding_curve<CCAT>(arg0, b"CCAT", b"Crazy Cats", b"Crazy Cats  is a cryptocurrency created for development and testing purposes. It allows developers to experiment with smart contracts, blockchain applications, and crypto transactions without involving real funds or economic risk.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pump-static.cetus.zone/icon/e8358c35-3ec4-4d81-8a44-7470fd71ca8a")), b"https://docs.sui.io/paper/sui.pdf", b"https://x.com/SuiNetwork", b"https://discord.com/invite/sui", b"https://t.me/Sui_Blockchain_Chinese", 0x1::string::utf8(b"007aeff37016faf554de9f40c880accbd474cea222e7b2331fbd7117e420b52064c2e0ead738a8e5eff8df66dfe99d891bdfedc57244987a5a8451c032d092d7022b29e6d9d2f97b81d63bdea83da70b8c1ba172cabaeef1786acbe6c04a2125da"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

