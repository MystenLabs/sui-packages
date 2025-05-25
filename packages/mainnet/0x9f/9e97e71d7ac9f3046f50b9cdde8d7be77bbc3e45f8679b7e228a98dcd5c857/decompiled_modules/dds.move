module 0x9f9e97e71d7ac9f3046f50b9cdde8d7be77bbc3e45f8679b7e228a98dcd5c857::dds {
    struct DDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<DDS>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<DDS>(arg0, b"DDS", b"DUTERTE", b"DUTERTE MEME", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQE8sK9WSUTN5z8jwFPT5vjpkMJwxYQnFdKZ2jGT7vRJz")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"004dac9e4c7d7371089f9b58e7d8901cdf6ec1f26a85185bb1c30b1f3a699a044e1a7fedddd628417b0df5aa030891d5e93de9d08adb1b60f925412c0d725cd204d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748198598"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

