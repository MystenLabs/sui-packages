module 0x3bf56472bb3138f27403ad0186d1c0de28bdd9e567c1228fa4ffffd52d47d3cf::snake {
    struct SNAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNAKE>(arg0, 6, b"Snake", b"SnakeToken", b"Welcome to the next generation of meme coins, The cutest little snake ever", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_E484_B7_D_8_F00_4_FFE_B6_A1_32656296_FF_8_F_6f735e4de5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

