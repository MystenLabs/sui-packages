module 0xac422eccd9df69e87611be4fc126f31eb3f80204a285d177591db93fd1fbffb4::bot {
    struct BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOT>(arg0, 6, b"BOT", b"SuiAstroBot", x"224269702d626f702d7765652c2077686972722d636c69636b2c20627a7a7a2d776f6f6f21220a0a24424f542054484520535549424f54", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GIF_pfp_0b4bdf070b.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

