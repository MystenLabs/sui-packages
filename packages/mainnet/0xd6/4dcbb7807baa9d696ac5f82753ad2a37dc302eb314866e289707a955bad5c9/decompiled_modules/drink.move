module 0xd64dcbb7807baa9d696ac5f82753ad2a37dc302eb314866e289707a955bad5c9::drink {
    struct DRINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRINK>(arg0, 6, b"DRINK", b"Drink Milk", x"546865204472696e6b204d696c6b20776173206372656174656420666f722074686520707572706f7365206f66206120736f6369616c206578706572696d656e742e0a446f2063617473206272696e672070656f706c6520746f6765746865723f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ik_Avii_Q_061c0859bb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

