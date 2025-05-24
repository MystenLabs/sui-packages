module 0x82baa774cf4a56efd28d6912fd31bd24285cd90fb5de8e6a2943bddc06b2c995::cct {
    struct CCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CCT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CCT>(arg0, b"CCT", b"caticoin", b"fast and smooth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmWJ3nuwujfS8EMXSiZ32hcp9jXXL1pyQ85TTZ8YjzDaHw")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00e5053b05c005522e54c5d1de96ec4cfce25b16cfe1cbd7574484491b764bb7e8ca8f181656619bb66b48f4c5eac01d147cc69caa478b1e1d5444f7d79b21f707d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748068008"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

