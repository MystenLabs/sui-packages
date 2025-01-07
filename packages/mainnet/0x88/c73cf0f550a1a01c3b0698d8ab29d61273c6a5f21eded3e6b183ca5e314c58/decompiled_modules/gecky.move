module 0x88c73cf0f550a1a01c3b0698d8ab29d61273c6a5f21eded3e6b183ca5e314c58::gecky {
    struct GECKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GECKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GECKY>(arg0, 6, b"GECKY", b"Gecky on sui", x"4d656574204765636b792c2061206c6169642d6261636b2c20667269656e646c792c206269672d647265616d696e67206765636b6f2066726f6d20746865206d696e64206f662070657065207468652066726f67732063726561746f72204d6174742046757269652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_4237_0dd0492f85.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GECKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GECKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

