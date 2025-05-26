module 0x4ba590cdce89c268c3b1b2a681fc15ceb564aeca8eb2ba9203be7e1417320050::chr {
    struct CHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHR, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<CHR>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<CHR>(arg0, b"Chr", b"Charity", b"Lets save the world together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmTVyD7NPCwTzCCjDFmepThMK9qasFWLJCYGhrNNS9yc9K")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00d9cef61634b09c59c4118514a9702a9b5861290f13eab57e8757820cf184bfd33d671dd3902f3b1bbd6aaa8591e9cc7db22369926f9474fa6bb12b1763f04304d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1748275235"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

