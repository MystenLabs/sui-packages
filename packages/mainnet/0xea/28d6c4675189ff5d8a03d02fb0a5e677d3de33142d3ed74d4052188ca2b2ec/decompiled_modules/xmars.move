module 0xea28d6c4675189ff5d8a03d02fb0a5e677d3de33142d3ed74d4052188ca2b2ec::xmars {
    struct XMARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMARS>(arg0, 6, b"Xmars", b"X-mars", b"Xmars is the ultimate meme coin that rockets humor and hype into orbit!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_01_00_49_31_7f5ce786d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

