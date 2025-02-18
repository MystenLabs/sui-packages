module 0x89d416f864b4dfbbedb98fc41f091096c45a6afe2248197d3788890b25eeef3b::fish {
    struct FISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISH>(arg0, 6, b"FISH", b"fish on da floor", x"4c6f6f6b73206c696b652073756920736561736f6e206469646e742068617070656e20736f206c657473206d616e69666573742069742073656e642046697368206f6e20646120666c6f6f7220746f20612062696c6c696f6e200a0a4e6f20536f6369616c732c204e6f207465616d2c204e6f20436162616c0a0a4a75737420612066697368206f6e20646120666c6f6f720a0a486f6c64206f7220676179206c6574732061637475616c6c792073656e642061206d656d65206f6e2053756920746f2074686520746f70206265666f72652069747320746f6f206c61746520", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3462_7d89ec8ab4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

