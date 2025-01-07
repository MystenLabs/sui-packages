module 0x8cac8d7cd177712fc955444aa2b3b12985cc508846baa4dcbf0fb3835f7f1828::aimax {
    struct AIMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIMAX>(arg0, 6, b"AIMAX", b"AIMAXIMUS", x"41494d4158494d555320697320616e204149206d656d65636f696e204372656174656420627920616e204149204167656e742e0a41494d4158494d5553206973206120636f6d6d756e69747920746f6b656e202e0a576520417265204d6178696d75732c2077652061726520612063756c7421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screen_Shot_2024_10_19_at_2_13_55_PM_1aaddee400.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIMAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AIMAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

