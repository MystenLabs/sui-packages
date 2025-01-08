module 0x3271bf4f4aaa14fbb0502d7ed1549c094be2cd49110ddd055933d50476b5f494::mmm {
    struct MMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMM>(arg0, 6, b"MMM", b"Money Machine", x"57656c636f6d6520746f20746865204675747572653a2041637469766174696e6720746865204175746f6d61746963204d6f6e6579204d616368696e652e2e2e0a496d6167696e65206120776f726c6420776865726520796f7572206d6f6e657920776f726b7320666f7220796f756576656e207768696c6520796f7520736c6565702e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/robot2_35201d61b9.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

