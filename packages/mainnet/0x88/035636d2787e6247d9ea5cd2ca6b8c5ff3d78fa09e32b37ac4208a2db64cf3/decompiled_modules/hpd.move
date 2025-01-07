module 0x88035636d2787e6247d9ea5cd2ca6b8c5ff3d78fa09e32b37ac4208a2db64cf3::hpd {
    struct HPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPD>(arg0, 6, b"HPD", b"HOPDOG", b"WOOF WOOF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmRKatJ6xRmwJ3NaK24UT4WwU7YqCXTWQbTf4AZGnHPn8R")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<HPD>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<HPD>(9018372391107950220, v0, v1, 0x1::string::utf8(b"https://x.com/hopdog_sui"), 0x1::string::utf8(b"https://hopdogsui.fun/"), 0x1::string::utf8(b"http://t.me/hopdogsui hop.fun"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

