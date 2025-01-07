module 0xbcd773f25d0b2ff1d4602449e32c49db543a076108a795425c408695097d5405::senta {
    struct SENTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENTA>(arg0, 6, b"SENTA", b"Senta Klaws", b"Senta Klaws isn't your typical meme coin-it's a celebration of the holiday spirit infused with cutting-edge creativity. With $SENTA.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LFWEG_43_P_400x400_3315db4aba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

