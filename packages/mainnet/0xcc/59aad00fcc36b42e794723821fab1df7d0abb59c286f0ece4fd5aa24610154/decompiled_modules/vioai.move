module 0xcc59aad00fcc36b42e794723821fab1df7d0abb59c286f0ece4fd5aa24610154::vioai {
    struct VIOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VIOAI>(arg0, 6, b"VioAi", b"VioAI", b"Advanced computer vision capabilities powered by cutting-edge neural networks. Our system can analyze and understand visual data in real-time, enabling unprecedented applications in robotics, autonomous systems, and augmented reality.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2141_217a06c5b6.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIOAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VIOAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

