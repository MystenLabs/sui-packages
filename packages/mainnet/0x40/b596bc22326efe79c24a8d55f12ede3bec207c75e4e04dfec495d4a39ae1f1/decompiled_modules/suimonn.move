module 0x40b596bc22326efe79c24a8d55f12ede3bec207c75e4e04dfec495d4a39ae1f1::suimonn {
    struct SUIMONN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMONN, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SUIMONN>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SUIMONN>(arg0, b"Suimonn", b"Suimon", x"245355494d4f4e2c206469652d6861726420506f6bc3a96d6f6e2066616e73206272696e67696e672073617469726520746f20746865202453554920626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmR7xUQ3zbUd7NrawwBR7jQKSeAVdZ29j8KXuEnFZykm8x")), b"suimons.com", b"https://x.com/Suimon_at_Sui", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"008c8c3b01c57b3d186510d1044f90ccf772c84b82a0b59bff6f79bb22028e476023094e70492afccc530c779a9b63f1f51ea090472a4ca34b7988aa2fac9df508d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758089"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

