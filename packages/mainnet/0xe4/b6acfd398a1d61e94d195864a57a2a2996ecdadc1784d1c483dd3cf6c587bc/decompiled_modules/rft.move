module 0xe4b6acfd398a1d61e94d195864a57a2a2996ecdadc1784d1c483dd3cf6c587bc::rft {
    struct RFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<RFT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<RFT>(arg0, b"RFT", b"Rich Forum Token", b"Just for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTyFhrNwCJvvHcmQTg8TQxEiXPJSA1F8seBeQyxBjzSJx")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0081cc59b5a3f6b221a6f5cd3bfe9c9944d80a0c7f8b73f75cf77b22eda76f9affd803cbb981a72cfe0c953170785fdab46b5002ade43f83e574bded69934a3e02d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748097594"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

