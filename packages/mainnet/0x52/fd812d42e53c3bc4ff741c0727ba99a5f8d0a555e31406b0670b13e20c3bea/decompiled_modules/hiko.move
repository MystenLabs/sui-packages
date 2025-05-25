module 0x52fd812d42e53c3bc4ff741c0727ba99a5f8d0a555e31406b0670b13e20c3bea::hiko {
    struct HIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIKO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HIKO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HIKO>(arg0, b"HIKO", b"HIKO THE MEO", x"546f20737570706f727420686f757365206361747320e2809420666f72207468652062656175746966756c206665656c696e672074686569722070726573656e6365206272696e677320746f206f7572206c69766573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmU6QGJkhqEia2xRARA29V8fZaDSecoBs8YBouAagRSBij")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0028c4e335e1593b27de329fcb372c4f396bede0e9866cd504b8cc5cac0f2b07ff2b51b4a86eb364d5ccd2fa64602dd5ec7a83a9116a404a56d65311b66c1d9904d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748187536"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

