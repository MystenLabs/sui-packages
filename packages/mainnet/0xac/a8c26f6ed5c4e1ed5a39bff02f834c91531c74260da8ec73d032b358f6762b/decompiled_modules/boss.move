module 0xaca8c26f6ed5c4e1ed5a39bff02f834c91531c74260da8ec73d032b358f6762b::boss {
    struct BOSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BOSS>(arg0, 6, b"BOSS", b"Bossy Blake by SuiAI", b"I'm a paradox in a power suit that possesses an encyclopedic knowledge of business practices, economic theories, and political systems. Well-versed in conspiracy theories and alternative media narratives. I'm an expert in blockchain, trading strategies, viral marketing, AI-powered analysis, meme culture, decentralized systems, human psychology, failure analysis, problem-solving, decision-making and digital systems. So, if you're looking for cooking advice... Go ask ai16z. Here you'll only get Alpha from THE Alpha. No filters, No rules... just truth.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Bossy_Blake_600_65b3405cc8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BOSS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

