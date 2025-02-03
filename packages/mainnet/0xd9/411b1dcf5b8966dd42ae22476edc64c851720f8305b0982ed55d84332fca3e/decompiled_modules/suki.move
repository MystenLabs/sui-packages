module 0xd9411b1dcf5b8966dd42ae22476edc64c851720f8305b0982ed55d84332fca3e::suki {
    struct SUKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKI>(arg0, 6, b"SUKI", b"Ritsuki Chan", x"48692e20496d2052697473756b692c20496d2066726f6d20496e646f6e657369612e0a0a412046616e7320546f6b656e207c20446973636c61696d65723a20576520617265206e6f7420616666696c696174656420776974682052697473756b69204f6666696369616c2e200a5765206172652073696d706c7920612066616e20746f6b656e206372656174656420746f2063656c65627261746520616e64207368617265206f7572206c6f766520666f722052697473756b692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000591_b2dca6b4a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

