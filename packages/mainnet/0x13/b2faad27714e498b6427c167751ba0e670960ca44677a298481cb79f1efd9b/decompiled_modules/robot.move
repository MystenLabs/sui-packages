module 0x13b2faad27714e498b6427c167751ba0e670960ca44677a298481cb79f1efd9b::robot {
    struct ROBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOT>(arg0, 6, b"ROBOT", b"ROBOT MUSK", x"546865206675747572652077696c6c206c6f6f6b206c696b6520746865206675747572650a20202020202020202020202020202020202020202020202020202020202020202020202020202d2d2d456c6f6e204d75736b0a0a68747470733a2f2f782e636f6d2f656c6f6e6d75736b2f7374617475732f31383434363132393737393637383930373036", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Yeb_OREXEAARVN_7_3b9ff02372.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

