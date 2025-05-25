module 0xef2ee55ac5e43bc4b6e2ea0274e473ff5209a5e4bf2a7146e61856181aecd576::hiko {
    struct HIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIKO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HIKO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HIKO>(arg0, b"HIKO", b"HIKO THE MEO", x"546f20737570706f727420686f757365206361747320e2809420666f72207468652062656175746966756c206665656c696e672074686569722070726573656e6365206272696e677320746f206f7572206c69766573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmU6QGJkhqEia2xRARA29V8fZaDSecoBs8YBouAagRSBij")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00ac9dc6cfb8f2a0da2e8c87630ce594722d17f31d230fc7803d28ebb38a4ede4976d120e618bc82ac02d8d692ffa9f1507a18f8be7578fbe855630adf2e301d0fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748187975"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

