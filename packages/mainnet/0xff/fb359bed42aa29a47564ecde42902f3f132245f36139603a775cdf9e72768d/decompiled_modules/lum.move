module 0xfffb359bed42aa29a47564ecde42902f3f132245f36139603a775cdf9e72768d::lum {
    struct LUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LUM>(arg0, 6, b"LUM", b"lumina by SuiAI", x"556e6c6f636b206e6577206c6576656c73206f6620696e746572616374696f6e207769746820646174612c20746563686e6f6c6f67792c20616e6420636f6d6d756e6974792077697468204c756d696e612e20f09f8cb8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000004586_68bf214bfc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LUM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

