module 0x797181ae6f7409b839606f4d53c7d8ad352a137df656a2130f9b29ac5c1195a1::adais {
    struct ADAIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAIS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ADAIS>(arg0, 6, b"ADAIS", b"AgentDocAI by SuiAI", b"Agent Doc AI is a revolutionary decentralized AI healthcare assistant that blends cutting-edge artificial intelligence, blockchain technology, and decentralized science. It empowers users to input symptoms, receive real-time diagnoses, and access tailored healthcare recommendations while contributing to a community-driven healthcare ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1fe27e6e_a4cd_4cc8_9d16_1564d4131a6a_6d0267f29a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ADAIS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAIS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

