module 0x3f84c432631bcd27d8801d38d1eeb7e79bd07ed564fa7723b9bb3e621cbb7f67::whog {
    struct WHOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHOG>(arg0, 6, b"WHOG", b"WARTHHOG", x"5761727468686f6720202d20466173742c2077696c642c20616e6420756e73746f707061626c6565786163746c7920686f77207765206c696b65206f7572206761696e732e2042652072656164792c2062656361757365206f6e6365207468697320636f696e207374617274732072756e6e696e672c206e6f7468696e672063616e2073746f702069742e0a47657420796f7572207475736b7320696e206e6f772c206f722077617463682066726f6d2074686520736964656c696e65732061732057484f47206368617267652e0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241015_175159_0e7e087092.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

