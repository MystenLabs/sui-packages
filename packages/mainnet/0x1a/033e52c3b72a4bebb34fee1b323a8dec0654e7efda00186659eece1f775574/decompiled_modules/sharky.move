module 0x1a033e52c3b72a4bebb34fee1b323a8dec0654e7efda00186659eece1f775574::sharky {
    struct SHARKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARKY>(arg0, 6, b"SHARKY", b"Sui Sharky", x"536861726b792077696c6c2065617420746865206a65657473206f6620535549210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_02_21_53_30_b51f3b0bfe.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

