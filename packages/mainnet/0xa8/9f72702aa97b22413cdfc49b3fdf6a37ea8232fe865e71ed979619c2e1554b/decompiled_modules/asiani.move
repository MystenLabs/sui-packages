module 0xa89f72702aa97b22413cdfc49b3fdf6a37ea8232fe865e71ed979619c2e1554b::asiani {
    struct ASIANI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASIANI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASIANI>(arg0, 6, b"ASIANI", b"ASIANI PENIS", x"546865206c656164696e67206d656d65636f696e206469676974616c206173736574206275696c74206f6e207468652053756920626c6f636b636861696e2065636f73797374656d0a24415349414e492050454e4953207374616e64732061732074686520666f72656d6f73742065636f6e6f6d696320706f776572686f75736520676c6f62616c6c792c2073686170696e672074686520667574757265206f6620696e7465726e6174696f6e616c20636f6d6d6572636520616e6420676f7665726e616e63652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d1900d0a0s0d0_bed44c9c65.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASIANI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASIANI>>(v1);
    }

    // decompiled from Move bytecode v6
}

