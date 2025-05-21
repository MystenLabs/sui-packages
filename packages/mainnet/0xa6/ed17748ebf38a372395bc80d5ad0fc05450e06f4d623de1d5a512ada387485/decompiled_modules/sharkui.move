module 0xa6ed17748ebf38a372395bc80d5ad0fc05450e06f4d623de1d5a512ada387485::sharkui {
    struct SHARKUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SHARKUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SHARKUI>(arg0, b"SharKUI", b"SharKui", b"SharKui half-man and half-shark.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTmELgixkjE9uBAfVvwXWUkN8Bx3JyzVftstScwXuoKQr")), b"https://sharkui.io/", b"https://x.com/KUI_on_SUI", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00bc0909616950a0ad2374b23283a631f0fc090eeb68f43a8fc3bad0465775e1a5ed5d2e372dbd03962f961c42aabce23452b2cbdb145b83980288e23837d9c90cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747839716"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

