module 0xe695af1a13473aec9df7235bb081c8aba6a12bb465a57f1471dba605eccf3b7e::toilet {
    struct TOILET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOILET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOILET>(arg0, 6, b"Toilet", b"Skibidi Toilet", x"f09f9abd24546f696c657420f09f9abd456e6a6f7920746865207669676f726f75732066756e206f662074686520776172206265747765656e20746f696c657420686561647320616e642074686569722068756d616e6f696420656e656d79e28099732e20546f696c65744865616473206c69766520696e206120776f726c642066726f746820776974682064616e676572206275742066656172206e6f742120f09f9abd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731020847661.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TOILET>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOILET>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

