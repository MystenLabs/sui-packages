module 0x73530be668d1e9e546a8b65973b829ee40961b13555e26d586358c9e7a730bdb::adhd {
    struct ADHD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADHD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADHD>(arg0, 6, b"ADHD", b"ADHD on Sui", x"63616e27742062652063616c6d206e65656420746f20626520726963682e2073656e64206d656469636174696f6e732e204920616d20627265616b696e6720667265650a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/adhdsui_1_1b3b71d093.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADHD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADHD>>(v1);
    }

    // decompiled from Move bytecode v6
}

