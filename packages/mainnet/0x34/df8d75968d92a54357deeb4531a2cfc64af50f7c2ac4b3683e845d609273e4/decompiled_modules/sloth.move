module 0x34df8d75968d92a54357deeb4531a2cfc64af50f7c2ac4b3683e845d609273e4::sloth {
    struct SLOTH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLOTH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLOTH>(arg0, 6, b"SLOTH", b"Sloth", x"536c6f746820697320746865206375746573742024534c4f5448206f6e205355492c206272696e67696e672024534c4f544820746f2074686520776f726c64206f66206d656d65732e0a0a4e6f20636174732c206e6f20646f67732e204f6e6c792024534c4f54482e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_91e0ce3fdb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLOTH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLOTH>>(v1);
    }

    // decompiled from Move bytecode v6
}

