module 0x8dfe22b7f08f216ddcc645c9adf535c4b685657f949714d3da27d57d74b7a6e9::blupe {
    struct BLUPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUPE, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<BLUPE>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<BLUPE>(arg0, b"BLUPE", b"Blue Pepe", x"424c55504520697320746865206f6666696369616c207065706520666f72205375692065636f73797374656d2e2041206d656d6520636f696e206275696c74206f6e207468652053756920426c6f636b636861696e2e20506f7765726564206279206120646564696361746564207465616d20616e64206d6f7469766174656420636f6d6d756e6974792e0a24424c55504520697320746865207469636b65720a42656c6965766520696e20424c5550452e2042656c6965766520696e207468652050726f7068656379", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmdyTcRDYhdxkzmFQZhhEUMadS19pzy8Y6nST3ABrqhhgG")), b"https://blupe.xyz", b"https://x.com/splash_xyz", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00b5d4fded6503a5811db5ca3c3a46e79194c7dedab05d8f1b2260f1d36df74f606c052364a05342aede9b046e9320f6b88c47d0f0ec7b032415d6e65bc05c5800d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747770156"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

