module 0x1db6444494d126eb78a6a8fb29fb29b0c8e765c8c01ab2fa9e70920589648473::kui {
    struct KUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUI, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<KUI>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<KUI>(arg0, b"KUI", b"SharKui on SUI", x"4b5549206973206e6f74206a75737420612063727970746f2c206e6f74206a7573742061206d656d65e280a60a0a6974e28099732061205245564f4c5554494f4e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZdbFHZWyH2yqqmqjBcYNLU58EZu34WWjSRd3w6a44H9t")), b"https://sharkui.io/", b"https://x.com/KUI_on_SUI/", b"DISCORD", b"https://t.me/KUIONSUI", 0x1::string::utf8(b"008b88a2a662dfbb635ff5c7d89834d05c13a3d71c2be72e6d6322955c56f940b3b7b8dc98f02fedf77d7663f444f924c1b6bbefa08ffebd04d23e5fd710dd7a0fd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747844351"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

