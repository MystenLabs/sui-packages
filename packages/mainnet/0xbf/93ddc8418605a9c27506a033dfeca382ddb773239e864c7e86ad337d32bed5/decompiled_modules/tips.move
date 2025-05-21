module 0xbf93ddc8418605a9c27506a033dfeca382ddb773239e864c7e86ad337d32bed5::tips {
    struct TIPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIPS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TIPS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TIPS>(arg0, b"TIPS", b"DevTips", x"5765206275696c742053706c6173682077697468206c6f76652e20537570706f727420746865206465767320627920686f6c64696e6720244465765469707320e2809420776520776f6ee28099742073656c6c20756e74696c20444558206c697374696e672e0a54697020757321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRraHD8PhLpVRHWfnCLXUoGNevrDaF2q2LtVjPWFo31Gs")), b"WEBSITE", b"TWITTER", b"DISCORD", b"https://t.me/splash_DevTips", 0x1::string::utf8(b"0018368db7757bdf297efb47d23bf782b13ce2c8a92f97a6ad21d3e7267b4fb7ab941e0e47bab23129c49c69f8bbd215a0e2913bee9bd15480472cfb8ebce5f400d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747864545"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

