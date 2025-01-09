module 0x1a6f9ef31d74b7af50df098f92171700137dc1f2669974386e004f2a2015efe6::antsui {
    struct ANTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ANTSUI>(arg0, 6, b"ANTSUI", b"Antarcticsui agent  by SuiAI", b"Antarctic Token is a cutting-edge utility token powering an AI-driven ecosystem. Designed for interoperability and innovation, it enables seamless access to AI services, rewards user engagement, and supports decentralized governance. With a focus on sustainability and collaboration, Antarctic Token bridges technology and purpose to create a smarter, more connected future.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_3960_2b5203d288.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ANTSUI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANTSUI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

