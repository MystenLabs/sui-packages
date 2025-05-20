module 0x6180e2952aca6b84aa435e1c5513515cfebf2bb6511e1a0bee729b47c3775c04::spepe {
    struct SPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPEPE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPEPE>(arg0, b"SPEPE", b"SplashPEPE", b"Splash PEPE created by Matt Furie", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmabJt9gzakcyMy1iTXyY9msNeUtxE4MGU3nYUE4zzFWzk")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008abef4d0462590a0647d51e04ff0b74652b1535d7bc4f3d441bb5c92db223287d774246d495924b6fb169fa8d7cce0e26db44a9fbd8e68a1d0e2c8f5c86c6c0fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747756552"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

