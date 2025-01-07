module 0xf18b4cd513149ca936d785ea550e1c5423acfd6804b5aefd741cb3afeadb192d::visualai {
    struct VISUALAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VISUALAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VISUALAI>(arg0, 6, b"VISUALAI", b"Visual.Ai", b"Visual AI refers to artificial intelligence designed to understand, analyze, and process images and videos. This technology uses machine learning algorithms and pattern recognition to identify objects, text, or other features within images. Visual AI is applied in various fields, such as facial recognition, autonomous vehicles, medical image analysis, and many other applications...By utilizing techniques like image processing and deep learning, Visual AI can train models to recognize complex visual patterns and make decisions or predictions based on visual data. This technology is continuously evolving, with applications expanding across industries such as security, entertainment, retail, and healthcare...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000268039_dbd5c724f4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VISUALAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VISUALAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

