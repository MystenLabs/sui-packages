module 0x24b89f2948d3af5ba89716dcdd3056272f7b8e0a07b8d906e8748d4c10f7c54f::siva {
    struct SIVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIVA>(arg0, 6, b"Siva", b"Lord Siva", x"4c6f72642073697661206f6e20537569206e6574776f726b0a0a496e20746865207374696c6c6e657373206f6620746865206d696e642c204920616d20666f756e642e2042652073696c656e742c20616e64206b6e6f772074686174204920616d2077697468696e20796f752e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/7_B309526_D2_A1_4039_B75_A_9_B28268_B0_B40_ccbe85a90c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIVA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIVA>>(v1);
    }

    // decompiled from Move bytecode v6
}

