module 0x65f511b18d028bacd8aa754d823c93b5559cc0a21093987d227629e4a21760af::magat {
    struct MAGAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGAT>(arg0, 6, b"MAGAT", b"Donald Trump MAGA", x"446f6e616c64205472756d70204d4147415420746f6b656e202d204d4147415420776173206372656174656420746f20666f7374657220746865207072696e6369706c6573206f662073656c662d72656c69616e63652c20696e6e6f766174696f6e2c20616e6420676c6f62616c2061776172656e6573732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_26_002908_583a7394f8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAGAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

