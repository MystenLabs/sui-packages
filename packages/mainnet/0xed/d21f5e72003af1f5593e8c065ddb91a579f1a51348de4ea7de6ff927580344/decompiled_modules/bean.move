module 0xedd21f5e72003af1f5593e8c065ddb91a579f1a51348de4ea7de6ff927580344::bean {
    struct BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BEAN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BEAN>(arg0, b"BEAN", b"BEAN2", b"let's toast to this marvelous mempad", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmXNnCjj3YJzSZB2PqrQTXJAv8g1PdpUUvzuMvfow15bZj")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00061fde7a3c43930e4cc379b6c6e2c26f122fea5b153f2d393669cd86aefbc7389c27a37c106a66bccd91b2758e41a0f16344e9a081b85fc620da2a0ac749fa01d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758983"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

