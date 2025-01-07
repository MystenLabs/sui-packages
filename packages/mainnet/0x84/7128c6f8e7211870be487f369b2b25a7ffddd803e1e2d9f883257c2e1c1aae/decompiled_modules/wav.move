module 0x847128c6f8e7211870be487f369b2b25a7ffddd803e1e2d9f883257c2e1c1aae::wav {
    struct WAV has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAV>(arg0, 6, b"Wav", b"Catwavflag", b"When you're ready to conquer the sofa  #PurrfectVictory", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/openart_image_Zj8x_Q3w_1727359224163_raw_92ed3e3a52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAV>>(v1);
    }

    // decompiled from Move bytecode v6
}

