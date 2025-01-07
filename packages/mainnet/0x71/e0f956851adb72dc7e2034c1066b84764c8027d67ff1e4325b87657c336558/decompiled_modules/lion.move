module 0x71e0f956851adb72dc7e2034c1066b84764c8027d67ff1e4325b87657c336558::lion {
    struct LION has drop {
        dummy_field: bool,
    }

    fun init(arg0: LION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LION>(arg0, 6, b"LION", b"SUILION", x"436f6c6f6e79206f66207375696c696f6e732074616b696e67206f766572207375690a54686973206d666b6572206c696b657320626f64792073686f747320776974682074657175696c6120616e64206c6174696e61732e2057616e6e61206b6e6f7720686973207765616b6e6573733f3f206475646520736169642066636b696e206e65636b206b697373657321", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HWA_Au_XA_2_400x400_94808412fe.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LION>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LION>>(v1);
    }

    // decompiled from Move bytecode v6
}

