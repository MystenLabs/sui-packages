module 0xe3345e1befcc13d27e79fd4748c21ee8a259f5fed4f72a5506af417c8d58d13e::hiko {
    struct HIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIKO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HIKO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HIKO>(arg0, b"HIKO", b"HIKO THE MEO", x"546f20737570706f727420686f757365206361747320e2809420666f72207468652062656175746966756c206665656c696e672074686569722070726573656e6365206272696e677320746f206f7572206c69766573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmU6QGJkhqEia2xRARA29V8fZaDSecoBs8YBouAagRSBij")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001a8426455107722c642c7bbfc04a62a914771320d7620e7e8e69ab74b605547a5b712b03e47e7a8fd85ae4bf93f6e32c68775cef5c0953d6a3fe0fbc58915e0ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748187813"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

