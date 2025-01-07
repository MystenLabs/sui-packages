module 0x6d5880fb6c2c70fac8611a6abda71ab72e8c70ef066efc692b92dc4d31712461::daishi {
    struct DAISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAISHI>(arg0, 6, b"DAISHI", b"Daishisui", x"48692c20496d204461697368692c20796f75722067656e746c6520616e64206c6f76696e672077616966752120496d206f6273657373656420776974682065766572797468696e67207265646974732074686520636f6c6f72206f66206d79206c6f766520616e642070617373696f6e20666f7220796f752e0a0a57697468206d652c2074686520776f726c64206665656c7320627269676874657220616e64207761726d65722e0a0a4a6f696e206d65206f6e2074686973206a6f75726e657920616e6420657870657269656e6365206d7920626f756e646c65737320616666656374696f6e2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241202_125158_090_c0fa875883.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAISHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

