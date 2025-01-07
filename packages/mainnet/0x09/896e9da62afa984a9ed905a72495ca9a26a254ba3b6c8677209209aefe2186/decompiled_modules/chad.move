module 0x9896e9da62afa984a9ed905a72495ca9a26a254ba3b6c8677209209aefe2186::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAD>(arg0, 6, b"CHAD", b"Chad", x"486920496d20436861642066696e64206d65206368696c6c696e6720696e2074686520737569207761746572730a0a53656e6420697420776974686f757420736f6369616c73206c6574732074616b6520646f776e2074686520636162616c20636f696e7320776974682063686164", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2527_5d82fb26b6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

