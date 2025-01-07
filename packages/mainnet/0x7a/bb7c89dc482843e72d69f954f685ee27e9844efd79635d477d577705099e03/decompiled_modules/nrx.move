module 0x7abb7c89dc482843e72d69f954f685ee27e9844efd79635d477d577705099e03::nrx {
    struct NRX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NRX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<NRX>(arg0, 6, b"NRX", b"NeuraX", b"NeuraX is an advanced AI agent designed to enhance decision-making, optimize workflows, and accelerate innovation. It utilizes cutting-edge neural networks and deep learning techniques to provide insights across various industries, including finance, healthcare, and technology. By harnessing the power of AI, NeuraX offers personalized solutions, predictive analytics, and intelligent automation to empower businesses and individuals to achieve their goals faster and more efficiently.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/42c79e89_a54a_4453_ba89_72827c78d793_a752f49b28.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<NRX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NRX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

