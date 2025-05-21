module 0x3b9bbaa4c0aa4fa25b66f541f50f20bc7201f6ad3e333b28a37f197403bad518::tvyn {
    struct TVYN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TVYN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TVYN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TVYN>(arg0, b"TVYN", b"TVYN Token", b"this is TVYN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWigSp21WvdWe9nEJZpE8L2k5QcTAsRnacoXkFrTyxvGm")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"006f979b5cfcd9e82b19eac1c83af3faa4e6f7286c14520a3b6ed31e6ed04900916e22fecc6c3cc0941d9db0fb3433d2e2a71080851c235997bfeffb8c42bdfd0dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747806233"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

