module 0x764d187e34e66bd622e292f97ff58b1c3be74287f67df9081e083d0d50d8cacd::chatzu {
    struct CHATZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHATZU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<CHATZU>(arg0, 6, b"CHATZU", b"Chatzu AI by SuiAI", b"Chatzu is a Chrome extension that turns coin pages on platforms like Dexscreener and Photon into real-time chat rooms, enabling instant communication and collaboration directly on the charts.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2108_9d829c2429.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CHATZU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHATZU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

