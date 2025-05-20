module 0xd86005993fb91f622c5b18675d3ed817102eb28ce7d8bb838662737496447216::tism {
    struct TISM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TISM, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<TISM>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<TISM>(arg0, b"TISM", b"TISM on SUI", x"4920676f74205449534d2c2049276d2074726164696e6720696e746f20535549206d656d65636f696e7320f09f9fa0206669727374206172742070726f6a656374206f662073706c617368f09f9fa0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmaPuw1huoFgrdor1nNpNLKGWuws7odL16Uz1sEb3rF5Z4")), b"https://tismishere.com/", b"https://x.com/tismishere", b"DISCORD", b"https://t.me/tismishere", 0x1::string::utf8(b"00ef189848e65340a4015c7599705749fe018e8aef71fdd7f75dd3e01c663380643752ccfb87ea1cab5d2272709f6b6eaafacfa049606bea301b1f111cd92bf509d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747758976"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

