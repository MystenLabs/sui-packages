module 0xb1251b6cbe798d6dbf7b02d1c67eaa80de3ac40d8e0c276bbfbc763dabf60bfb::suileon {
    struct SUILEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEON, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUILEON>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUILEON>(arg0, b"SUILEON", b"Interleon Pokemon", b"Build the first pokemon battle game on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYVE6BXYJ2E5ryyDQ9uFnYUh88SEvcwazYNN5nGtRQUB8")), b"https://www.notion.so/SUILEO-Interleon-Pokemon-Battle-Whitepaper-1faff48cdd24808c920ecea00fff2214", b"https://x.com/Suileonmeme", b"DISCORD", b"https://t.me/Suileon", 0x1::string::utf8(b"00fc06821d9b7283e0cc1e89bdc37169725685af40e2844bc337f90c0a7f524334b28033db1b52cac00de34b83a5f338ac5631a22f9e0ee71e4fa4a9a85f7bc90cd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747835917"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

