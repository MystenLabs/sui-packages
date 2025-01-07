module 0xc4389723b8a5fd75810470aa21d1558cda50132a10cb82c62489ce4e82be8f2d::rachop {
    struct RACHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RACHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RACHOP>(arg0, 6, b"Rachop", b"RacHop", x"53554973202331205261636f6f6e210a57697468206d792062756e6e79206279206d7920736964652c20526163686f7020616e6420492074616b652074686520726964652e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSGQUYn4MkWnYhmmQCaf7rWtNrd4zcsRt1UWr9HFZ1Mgp")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<RACHOP>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<RACHOP>(16778644283913256322, v0, v1, 0x1::string::utf8(b"https://x.com/RachopSui"), 0x1::string::utf8(b"https://rachop.com"), 0x1::string::utf8(b"https://t.me/RachopSUI"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

