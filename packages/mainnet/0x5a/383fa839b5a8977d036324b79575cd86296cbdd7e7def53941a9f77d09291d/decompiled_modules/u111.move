module 0x5a383fa839b5a8977d036324b79575cd86296cbdd7e7def53941a9f77d09291d::u111 {
    struct U111 has drop {
        dummy_field: bool,
    }

    fun init(arg0: U111, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<U111>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<U111>(arg0, b"U111", b"111", b"1111", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmUrMJrHZD2DEzCEK3wtDsENEVecEvudESTtxYCudMSGzB")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006bf674bb7c29118c5be8bb26370ffde8356b117deb5c54fd9daf542224e1c90ef5c2126421c87b6151f7d4c3cc32d71d7a84e63c43ef1d46e664eb241799cd0fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747298398"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

