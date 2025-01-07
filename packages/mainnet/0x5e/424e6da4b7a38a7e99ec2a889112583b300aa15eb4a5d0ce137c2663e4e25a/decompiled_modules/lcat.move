module 0x5e424e6da4b7a38a7e99ec2a889112583b300aa15eb4a5d0ce137c2663e4e25a::lcat {
    struct LCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LCAT>(arg0, 6, b"LCAT", x"6c696c434154f09f9088e2808de2ac9b", x"74686520736d616c6c6573742f2063757465737420f09f9088e2808de2ac9b206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734259605396.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LCAT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LCAT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

