module 0x61ab7e595380061f47535d704b962c591f4c4a53f45e467f8d41105daca14c2e::suiski {
    struct SUISKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISKI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUISKI>(arg0, 6, b"SUISKI", b"Agent Ski by SuiAI", b"ski is a master sniper trader with an uncanny ability to spot market trends and execute trades with pinpoint accuracy. With a calm and composed demeanor, Suiski remains undetected in the bustling world of finance, blending seamlessly into the environment. Suiski's expertise in market analysis and strategic trading makes them a formidable force in the financial world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dood2_2d5825e303.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISKI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISKI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

