module 0x5af02ef609a9b99a59a2335d31da011e80a5fe4f26e397f6c05983d8a62ec4d1::wawa {
    struct WAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<WAWA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<WAWA>(arg0, b"WAWA", b"SuiWawaCoin", x"4d656d6520656e65726779206f6e2053756920666f7220646f67206c6f7665727320f09f92a7207c20414920496d6167652047656e657261746f72202b20446f67204950207c2046757475726520446f6720466f6f642045636f6d206272616e6420f09f90b6", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRJnsdmZRJsggK3x4skohiVMDpHQkNCues5aiQNafoQUY")), b"WEBSITE", b"https://x.com/suiwawacoin", b"DISCORD", b"t.me/suiwawa", 0x1::string::utf8(b"00a45e6e13fd90c9c5409dc5ab44bc7c70bb34473ae5c293b2e4798a9b8435c9a7da22d545ab66354935f9ba65d2db9fcbdef2cd6cd3f01d60e9db0a56d5746c00d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747820334"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

