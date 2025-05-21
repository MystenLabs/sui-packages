module 0x890efbc5e622bb0e27425c48806c2e35d3e62df265a81cdabf7289dd4605581e::panda {
    struct PANDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<PANDA>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<PANDA>(arg0, b"PANDA", b"Panda", b"PANDA to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQ3b2dvqHVrbCAizuZiRjx3fwZBCSq5wJ2mPoEaY5B3az")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"002f9a2224167ef6c756d99b17b5e360a8e136ca8ad8f34c187ed8acd8f7cd31a3c5f1e807e2ed3f8214e7cdb0a08584c00583e9616b7866a0d41ee362ad06b702d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747815583"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

