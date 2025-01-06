module 0xa55bd06893328f8b75823e25e2c0c672943e3507b3ac99deb7d41ec38c83fab5::lgbt {
    struct LGBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LGBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LGBT>(arg0, 6, b"LGBT", b"LGBTQIAPN+ by SuiAI", b"LGBTQIAPN+", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Designer_4_6282d05292.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LGBT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LGBT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

