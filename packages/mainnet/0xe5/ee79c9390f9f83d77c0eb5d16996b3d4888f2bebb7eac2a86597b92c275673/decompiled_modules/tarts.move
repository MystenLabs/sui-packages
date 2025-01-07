module 0xe5ee79c9390f9f83d77c0eb5d16996b3d4888f2bebb7eac2a86597b92c275673::tarts {
    struct TARTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TARTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TARTS>(arg0, 6, b"TARTS", b"SUI TARTS", x"5468652063616e64792065766572796f6e65206b6e6f7773206e6f77206973206e6f77206f6e20535549200a6c65747320676574207468697320626f6e6465642c2049276d20747279696e6720746f206d616b65206d696c6c696f6e616972657320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_4_51365e4c68.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TARTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TARTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

