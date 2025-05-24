module 0x7cb99fe5d96f52891d6cb435567d050aec9cb18d4bb96045ca5d7e179bc5cd57::ac {
    struct AC has drop {
        dummy_field: bool,
    }

    fun init(arg0: AC, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<AC>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<AC>(arg0, b"AC", b"Creed", b"Cult Creed Community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTjxEimWXo79YP3iMVm9N1GdgMacN8kDQE8NGzDy9Seox")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"0065101e611631c0636b4bf6992afad372150ec666f0cb86b80644336eaeec8e610070c17ea4feea60f4e2dd768040c95897ca06b0f09c244abaa0fa0203663e04d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748099396"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

