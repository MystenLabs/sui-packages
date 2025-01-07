module 0x4249e4f438aacc6d69ff58c1508dafe24d42e3c57c475dba6cd264f97af926d8::ponyo {
    struct PONYO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONYO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONYO>(arg0, 6, b"PONYO", b"PONYO SUI", x"506f6e796f20496d706163742069732074686520776f726c647320666972737420616e696d652d696e737069726564206175746f2d696d7061637420696e76657374696e6720746f6b656e2e20496e73706972656420627920746865207365612d62617365642032303038204a6170616e6573652066696c6d2061626f75742061207265736375656420676f6c64666973682c206f757220666f756e6465727320617265206f6e2061206d697373696f6e20746f2070726f766520746861742057656220332e302063616e206d616b652074686520776f726c6420612062657474657220706c6163652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5637_3092829277.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONYO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PONYO>>(v1);
    }

    // decompiled from Move bytecode v6
}

