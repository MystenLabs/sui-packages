module 0x8052639aed0c89300defcdfbfc8da00271444c1f76febaac9a3947b5e4b92f22::splash {
    struct SPLASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASH, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASH>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASH>(arg0, b"SPLASH", b"SPLASH SUI", b"this token og", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWYtG5dHg8dDxmxUJtqApyevGNVfJbgt2CyyqxqQbnktp")), b"https://app.splash.xyz", b"https://x.com/splash_xyz", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0028d1881139e542fed1227476e5d0f069f6be7fdb3c90e57bfc3fd932a2d12ff675a1a2e30cf4c98fddd7d6007cf27433b70f1cd9e0baa8d044303e86ecba610ed598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758480"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

