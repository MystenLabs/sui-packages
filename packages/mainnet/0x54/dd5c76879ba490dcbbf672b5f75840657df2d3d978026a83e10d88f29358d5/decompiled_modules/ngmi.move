module 0x54dd5c76879ba490dcbbf672b5f75840657df2d3d978026a83e10d88f29358d5::ngmi {
    struct NGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGMI>(arg0, 6, b"NGMI", b"NOT GUNNA MAKE IT", x"54696d6520746f20656e7465722061206e65772067656e65726174696f6e2e0a54696d6520746f20656e6420776f7274686c657373204b4f4c532e0a54696d6520746f2073656e6420746865204e6967657269616e73206261636b20746f206d75642068757473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2448_df16ee22a6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

