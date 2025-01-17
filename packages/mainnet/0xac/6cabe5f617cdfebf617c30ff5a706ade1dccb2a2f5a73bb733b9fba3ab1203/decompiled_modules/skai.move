module 0xac6cabe5f617cdfebf617c30ff5a706ade1dccb2a2f5a73bb733b9fba3ab1203::skai {
    struct SKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SKAI>(arg0, 6, b"SKAI", b"Skillful AI by SuiAI", b"Skillful AI is standing for the transition from basic chatbots to advanced virtual assistants and tailor-made AI solutions. Skillful AI is an advanced platform that empowers individuals by providing a personalized AI ecosystem. It enables users to stay current with rapid technological advancements, offering customized virtual assistants trained in domain-specific knowledge. With a focus on context and user-specific memories, Skillful AI ensures comprehensive and tailored interactions. Additionally, it embraces developers, granting access to tools for creating and monetizing assistants, fostering a collaborative and dynamic ecosystem Powered by blockchain technology. Skillful AI is a gateway to harnessing the benefits of AI and staying ahead in a dynamic digital world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Nevtelen_990a875c75.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

