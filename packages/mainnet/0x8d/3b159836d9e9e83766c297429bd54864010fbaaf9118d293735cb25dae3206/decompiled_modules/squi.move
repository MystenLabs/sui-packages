module 0x8d3b159836d9e9e83766c297429bd54864010fbaaf9118d293735cb25dae3206::squi {
    struct SQUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUI>(arg0, 6, b"SQUI", b"SQUI", b"SQUI is the cutest mollusc to ever grace the depths of the Sui ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.hop.ag/ipfs/QmQzzAfNYtgLQbGEaGruS5dQnAFqGmioht1WEFVfz3rQgW")), arg1);
        0x2::transfer::public_transfer<0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::Connector<SQUI>>(0x5c8657a6009556804585cd667be3b43487062195422ff586333721de0f8baeae::connector::new<SQUI>(15151226967539727828, v0, v1, 0x1::string::utf8(b"https://x.com/SquiSUI"), 0x1::string::utf8(b"https://squi.ink/"), 0x1::string::utf8(b"https://t.me/squisui"), 0x2::tx_context::sender(arg1), arg1), @0xfa6d14378e545d7da62d15f7f1b5ac26ed9b2d7ffa6b232b245ffe7645591e91);
    }

    // decompiled from Move bytecode v6
}

