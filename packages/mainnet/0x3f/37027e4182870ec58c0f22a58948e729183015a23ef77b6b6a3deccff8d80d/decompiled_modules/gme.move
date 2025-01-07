module 0x3f37027e4182870ec58c0f22a58948e729183015a23ef77b6b6a3deccff8d80d::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GME>(arg0, 6, b"GME", b"GameStopSui", x"0a57656c636f6d6520746f2024474d45206f6e205355492e200a576861742069732024474d45206f6e20245355493f0a24474d452069732074686520707572722d6665637420626c656e64206f66206d656d65206d6167696320616e642063727970746f20706f74656e7469616c2120426f726e2066726f6d20746865206c6567656e646172792024474d4520736167612c20746869732066656c696e652d7468656d656420636f696e206973206865726520746f2074616b6520796f75722063727970746f20706f7274666f6c696f206f6e2061206d6f6f6e2d626f756e6420616476656e747572652e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241004_000804_abe252ab52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GME>>(v1);
    }

    // decompiled from Move bytecode v6
}

