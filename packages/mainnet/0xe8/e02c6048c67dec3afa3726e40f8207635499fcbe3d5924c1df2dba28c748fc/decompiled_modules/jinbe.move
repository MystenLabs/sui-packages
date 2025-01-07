module 0xe8e02c6048c67dec3afa3726e40f8207635499fcbe3d5924c1df2dba28c748fc::jinbe {
    struct JINBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JINBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JINBE>(arg0, 6, b"JINBE", b"$JINBE", x"244a494e424520666972737420736f6e206f6620746865205355492e0a0a5768656e20697420636f6d657320746f20746865205375692065636f73797374656d2c20244a696e6265e280997320676f74207468652063757272656e7473206f6e2068697320736964652e20546865206f6365616ee280997320646565702c20627574206869732077616c6c657427732064656570657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmSChK2Nui2F9DjuDQASU1XAcgkcqoJ933zgbejrhohEpk")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<JINBE>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<JINBE>(8404029632594473699, v0, v1, 0x1::string::utf8(b"https://x.com/JinbeSui?t=IrfIu_JkDy5_rArQYLpSWA&s=09"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"no telegram"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

