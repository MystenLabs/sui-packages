module 0xf0686de8171af427fea1f6effc0b1e7ecc4d27041e78c765f99526a0a8ffe7be::splashy {
    struct SPLASHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHY, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASHY>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASHY>(arg0, b"SPLASHY", b"Splashy The Ghost", x"53706c61736879207468652067686f737420726f616d732061726f756e642074686520537569206e6574776f726b2e200a0a53706c617368792073636172657320746865206a65657473206177617920616e642072616973657320746f2074686520746f702e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmbC8n18HKACikGzV4emML72JzQusqsMvVNAhvnRHUQ5SU")), b"splashyonsui.xyz", b"https://x.com/SplashyOnSui", b"DISCORD", b"t.me/splashyonsui", 0x1::string::utf8(b"007d9a45fb1fcba576e84c73139ee58711568d45e7286dd323272ecf46870b9a67aa80f59182f0fb3ba39d918e0d4c6306b36d48e6d7cf53bc550f80d0190b0a05d598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747757613"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

