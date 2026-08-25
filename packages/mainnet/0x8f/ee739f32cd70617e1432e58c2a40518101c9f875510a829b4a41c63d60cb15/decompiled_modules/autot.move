module 0x8fee739f32cd70617e1432e58c2a40518101c9f875510a829b4a41c63d60cb15::autot {
    struct AUTOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AUTOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AUTOT>(arg0, 6, b"AUTOT", b"Auto Test", x"6b6565706572206175746f2d6d6967726174696f6e207465737420e28094206e6f742061207265616c20746f6b656e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://192.168.1.107:4000/api/images/4ac202ab4dca7a23bc889c8024f834f33f6c82abec45b3b5b97f0941b9a45bfd.png")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AUTOT>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AUTOT>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

