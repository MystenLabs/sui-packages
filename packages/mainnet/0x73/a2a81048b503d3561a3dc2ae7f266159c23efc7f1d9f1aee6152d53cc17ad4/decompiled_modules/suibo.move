module 0x73a2a81048b503d3561a3dc2ae7f266159c23efc7f1d9f1aee6152d53cc17ad4::suibo {
    struct SUIBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIBO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIBO>(arg0, b"SUIBO", b"Suibo on SUI", b"SUIBO is not money game.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbHFavizefgKu761mHTR3958bKwsCHmb9Lk7ZTB357WxN")), b"https://linktr.ee/suibo", b"https://x.com/SuiboSui", b"https://discord.com/invite/suibo", b"https://t.me/SuiboSuiVIP", 0x1::string::utf8(b"002f14958c517f7bf5304b20801c84f53097d4e520e3afd674f4647f1ebcbeeb0f8331fc59864c22ca32f6781fdec61c13b453cb5a75750e0f88ae41d2890cf705d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749485058"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

