module 0xb42335b9133e0a574dac5678cb55a546edd08e58f22eef08b564d0f2862154d7::beg {
    struct BEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEG, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BEG>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BEG>(arg0, b"BEG", b"monkey", b"kjojokp0'kpkjoj[ojpo;", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZcGb6LwHZhx9irgqHJsLUQUge1WhS2GbL7xSt8psh8pM")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"003d2b60cb7d47e5ca1878c5b035372d4a2a748b9faa1db8a2d4b2db202aae1bd3a9f80cbc0eef381c48e0e746bde2f1765290a7180c2c339e7c56d5d2acec9f05d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748268602"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

