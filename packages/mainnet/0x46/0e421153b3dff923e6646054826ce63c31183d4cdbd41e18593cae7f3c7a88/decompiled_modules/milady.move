module 0x460e421153b3dff923e6646054826ce63c31183d4cdbd41e18593cae7f3c7a88::milady {
    struct MILADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILADY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<MILADY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<MILADY>(arg0, b"MILADY", b"MILADY BEAR", b"gen/acc https://x.com/emogenacc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmeouoAfEfcrx8v9Zd4uyVcaemDfE8dhgachosFeQ57sVd")), b"WEBSITE", b"https://x.com/emogenacc", b"DISCORD", b"https://t.me/UniGemAlpha", 0x1::string::utf8(b"00edee8ba7c2cf94893a290a806a6efb802824614425bc030cf0c4f2714181fc5a4f978db5e09707cf3c934bd21ecf107500f5c4debf7757eb18ddc8adf827fb01d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758428"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

