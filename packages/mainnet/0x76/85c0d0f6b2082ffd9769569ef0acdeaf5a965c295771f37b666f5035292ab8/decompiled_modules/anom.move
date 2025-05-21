module 0x7685c0d0f6b2082ffd9769569ef0acdeaf5a965c295771f37b666f5035292ab8::anom {
    struct ANOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANOM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<ANOM>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<ANOM>(arg0, b"ANOM", b"Anomemely on Sui", x"557365202177686174696620e28094207765206d696e7420746865206d61646e6573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmcF4xoC6Q2uvhtKWp6LG48vudHR1bbxv53E9zfoqcdQtC")), b"https://anomemely.xyz/", b"https://x.com/anomemelyonsui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b3d240348b848e480d4a9bc6c687587ceb31eec88d767a53e37c88233627df10845e5f529d30f6fed7819f8a12be226a52dd302748bf242244fa941f6892110fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747850388"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

