module 0xa56a94f8f16b481ec491072ef04fbd87481e25a8f837cac1d62a1162fe444cf2::reborn {
    struct REBORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: REBORN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<REBORN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<REBORN>(arg0, b"REBORN", b"Token", b"We have risen up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYDjCAoUAqhgvVW4UExGgMdzPFtHJ6HW61NkjWz7UXeSg")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00116b5fd0c1ca21d446a78986f3a5381543e59fbe39e74bfc4d831c117fbddd2241f4d3e13411bbcde090f0169281ab1833ea78c20f5e705cbf123e4bfb8a5704d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1749632651"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

