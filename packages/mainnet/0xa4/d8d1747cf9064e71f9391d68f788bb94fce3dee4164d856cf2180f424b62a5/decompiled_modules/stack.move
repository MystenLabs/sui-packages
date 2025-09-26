module 0xa4d8d1747cf9064e71f9391d68f788bb94fce3dee4164d856cf2180f424b62a5::stack {
    struct STACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve_v2<STACK>(arg0, b"STACK", b"SUI STACK", b"Welcome to SUI Stack how can I develop your order?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRrJaCnsHPdpqZqsbNsdUu5GRUXiQwgaipmzcZcLyZgVw")), b"WEBSITE", b"https://x.com/suinetwork", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00534894c36687f5b62ad5b832f0a052c5d5cb2737641269d15a1ebb175b2cea2fa8ad0b62285227a7240728e35a1e8ae387bc87c78934f4643d7bb98b11ad740ad598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1758908561"), arg1);
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCapV2>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STACK>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

