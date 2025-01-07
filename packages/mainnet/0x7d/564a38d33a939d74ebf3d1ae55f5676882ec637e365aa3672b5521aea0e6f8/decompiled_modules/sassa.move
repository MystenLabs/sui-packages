module 0x7d564a38d33a939d74ebf3d1ae55f5676882ec637e365aa3672b5521aea0e6f8::sassa {
    struct SASSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASSA>(arg0, 6, b"SASSA", b"The Real Satoshi", x"5265616c20666f756e646572206f6620426974636f696e20746f2062652072657665616c65642062792048424f20746f6d6f72726f772e205374726f6e672074686573697320746f20627579207468697320636f696e2e204920616d206e6f7420676f696e6720686f6c6420616e7920534153534120746f6b656e732c20796f752062757920697420616e64206d616b65206974206269672e0a0a4a6f696e20746865207265766f6c7574696f6e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_06_18_38_48_ff0e66fffa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

