module 0xd6cc0c6064be4b3f53d17b1988633fdeecc0b556dfc42c7522ae29322abdd09::suiloong {
    struct SUILOONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILOONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SUILOONG>(arg0, 6, 0x1::string::utf8(b"SUILOONG"), 0x1::string::utf8(b"SUILOONG"), 0x1::string::utf8(b"$SUILOONG launched at popularsui.xyz  High-fashion character entering the Sui ecosystem. SUILOONG is a couture figure on the Sui network: a character first, a token by design. Find him on INSTAGRAM, TIKTOK, SUILOONG.COM and X."), 0x1::string::utf8(b"https://popularsui.xyz/media/e299619ed4ccc72b34b2fe22ed2bb6ff69ad9e09230747a88a24dfc3364b16ec.webp"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILOONG>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SUILOONG>>(0x2::coin_registry::finalize<SUILOONG>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

