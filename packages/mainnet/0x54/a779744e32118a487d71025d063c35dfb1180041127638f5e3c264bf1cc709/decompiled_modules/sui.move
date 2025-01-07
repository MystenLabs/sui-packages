module 0x54a779744e32118a487d71025d063c35dfb1180041127638f5e3c264bf1cc709::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"Soviet Union International", x"536f7669657420556e696f6e20496e7465726e6174696f6e616c20282453554929206973206865726520666f72207468652070656f706c6520616e6420706f7765726564206279206d656d65732120f09f92bc20546865206d6f746865726c616e64206e6565647320594f5521205374657020666f727761726420616e6420736861706520686973746f72792120f09f8c8d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmbsLdRdxRWrMhrxebDqbasS4pDppP3u1THrfoEroVk6wQ")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SUI>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SUI>(2304456552395619881, v0, v1, 0x1::string::utf8(b"https://x.com/SovietSui"), 0x1::string::utf8(b"no website"), 0x1::string::utf8(b"https://t.me/SovietSUIchannel"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

