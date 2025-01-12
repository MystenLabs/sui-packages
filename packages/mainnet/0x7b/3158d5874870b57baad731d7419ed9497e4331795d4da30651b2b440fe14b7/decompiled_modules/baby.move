module 0x7b3158d5874870b57baad731d7419ed9497e4331795d4da30651b2b440fe14b7::baby {
    struct BABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BABY>(arg0, 6, b"BABY", b"BabyAi16z by SuiAI", b"**Baby AI16z** is an artificial intelligence agent designed to explore, monitor, and catalog new AI agents developed within the Base ecosystem. Its primary mission is to identify innovations, assess the impact of these solutions in the market, and facilitate connections between creators and emerging technologies. Equipped with advanced tools, Baby AI16z tracks new publications, repositories, and initiatives related to AI agents, analyzes trends and their potential impact across various sectors, and maps synergies between developers and startups to promote strategic collaborations. Agile, modular, and adaptable, Baby AI16z ensures it keeps pace with the fast-changing landscape of the AI industry, serving as a bridge between innovation and opportunity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/baby_f838e151be.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BABY>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

