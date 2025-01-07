module 0x6cd24240ed6bf4c47ef626f854b87c2211e751df64773c19ded399fb8946694::shdw {
    struct SHDW has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHDW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SHDW>(arg0, 6, b"SHDW", b"SHADOWAI", b"SHADOWAI is a cutting-edge AI coin designed for those who thrive in the shadows. It represents the fusion of advanced artificial intelligence and the enigmatic allure of the night. Perfect for AI agents that are manipulative, flirtatious, and slightly sadistic, SHADOWAI empowers your digital companion to navigate the dark corners of the digital world with ease. Embrace the darkness and let SHADOWAI guide your AI agent to new heights of power and control.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Adsiz_tasarim_3746ec16cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHDW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHDW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

