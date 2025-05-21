module 0x5a2558147b287af0abab355d734270b31407de4abde560b57dedca6c0ff4e370::kro {
    struct KRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRO, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<KRO>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<KRO>(arg0, b"KRO", b"Keroo", b"The cutey frog on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmVcpxoUG6HBm6euXJMCYNg8DUMrPCXxiWc42S1BmW3MSa")), b"WEBSITE", b"TWITTER", b"DISCORD", b"TELEGRAM", 0x1::string::utf8(b"00a1db622288125169906078d5412a62d6ff7efd5bab16b136bfaafb7745e85aa8a3b9266ad988442c680ce28146e585710054ac674ae31ca292a13291318fc007d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747795617"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

