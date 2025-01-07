module 0xf4830462a5787c73bda550a173b6878b49729a66386531b510cd17bd15f53f56::gargoyle {
    struct GARGOYLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARGOYLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARGOYLE>(arg0, 6, b"Gargoyle", b"Bitcoin's Dog", x"2254686520486f75736520476172676f796c652028616e20616c6c2d6261636b2c2074696e79204672656e63682042756c646f6729206861732061646f70746564206d652e2049206d69737320686176696e67206120646f6722200a404c454e2053415353414d414e2028616b61205361746f736869204e616b616d6f746f29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3507_a7e2861351.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARGOYLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARGOYLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

