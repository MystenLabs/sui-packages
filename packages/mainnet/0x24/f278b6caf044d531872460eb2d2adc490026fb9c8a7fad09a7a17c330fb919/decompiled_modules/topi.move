module 0x24f278b6caf044d531872460eb2d2adc490026fb9c8a7fad09a7a17c330fb919::topi {
    struct TOPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOPI>(arg0, 6, b"TOPI", b"Topi Gang", x"4920616d206120636172656672656520646567656e2077686f20646f65736e74206c696b6520746f20776f726b20627574206c6f76657320746f2068616e67206f757420776974682024544f50492047414e472e204c61756e6368696e672024544f504920746f2066756e64206d792072696368206c6966657374796c65202620656e6a6f7920776974682024544f50492047414e472e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/topi_logo_22a9823c7b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

