module 0xca18ad487a2e529634e440feff3980015efdce81a837d536a209ca6ce2143868::peera {
    struct PEERA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEERA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PEERA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PEERA>(arg0, b"PEERA", b"Peera", b"AI-powered forums", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUTGAkC6a9gRuWEFKk2qp7QnwZ8V8fnxi8CRZwwebLv8v")), b"https://www.peera.ai/", b"https://x.com/peera_ai", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008867ebc00ddc68f25e313b7ffbc02c2fb9efbfc04cb6271ee8df1d43fa994fcc3f7d7b17030ca75654516a3c65329f891cfe9ea9118a5b07d7e00f45477b5100d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747918658"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

