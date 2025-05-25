module 0x960e4618bd6c0116ad35ff8e1e60ed0a51b7300958148677c503a04b58184760::hko {
    struct HKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HKO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<HKO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<HKO>(arg0, b"HKO", b"HIKO THE MEO", x"546f20737570706f727420686f757365206361747320e2809420666f72207468652062656175746966756c206665656c696e672074686569722070726573656e6365206272696e677320746f206f7572206c69766573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmU6QGJkhqEia2xRARA29V8fZaDSecoBs8YBouAagRSBij")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"001fa2cf53cd56ce9fbdcc081e14e8131ae24bdce712bdef59dc19f86b72bd88e487011cf372066efcbb161e1046021aead83be29a1d3cbe9ea0436b4c98806502d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748188569"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

