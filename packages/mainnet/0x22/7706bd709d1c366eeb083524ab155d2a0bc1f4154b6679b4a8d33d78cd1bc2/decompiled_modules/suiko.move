module 0x227706bd709d1c366eeb083524ab155d2a0bc1f4154b6679b4a8d33d78cd1bc2::suiko {
    struct SUIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKO>(arg0, 6, b"Suiko", b"SUIKODEN", x"546865204669727374205375696b6f64656e20696e205375690a4954532043524541544520464f5220434f4d4d554e4954590a4e4f20424f4459204f574e204954530a534f204954532043544f200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suikoden_03f713512d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

