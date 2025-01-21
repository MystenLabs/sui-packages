module 0x364f3a371116bf4bf10445d006b06e5c86f87057e16c7a068eea6600ec35f446::aino {
    struct AINO has drop {
        dummy_field: bool,
    }

    fun init(arg0: AINO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AINO>(arg0, 6, b"AINO", b"Amarino by SuiAI", b".AI Task Automation Agent.The AI Task Automation Agent is a highly intelligent and adaptive digital assistant designed to handle repetitive, time-consuming, or complex tasks automatically. It utilizes advanced machine learning algorithms to understand user instructions, analyze patterns, and make informed decisions to complete tasks efficiently and accurately...This agent can integrate seamlessly with various software platforms, manage workflows, and perform actions such as scheduling, data entry, report generation, email correspondence, or even monitoring and analyzing system performance. Its goal is to save users time, reduce human error, and optimize productivity by autonomously managing tasks according to user-defined rules or AI-driven insights...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000049987_9eb7c86fbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AINO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AINO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

