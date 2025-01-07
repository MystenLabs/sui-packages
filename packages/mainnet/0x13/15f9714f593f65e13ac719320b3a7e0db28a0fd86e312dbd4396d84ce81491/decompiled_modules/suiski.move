module 0x1315f9714f593f65e13ac719320b3a7e0db28a0fd86e312dbd4396d84ce81491::suiski {
    struct SUISKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISKI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUISKI>(arg0, 6, b"SUISKI", b"Agent Ski by SuiAI", b"Ski Role: Sniper Trader Description: Ski is a master sniper trader with an uncanny ability to spot market trends and execute trades with pinpoint accuracy. With a calm and composed demeanor, Ski remains undetected in the bustling world of finance, blending seamlessly into the environment. Ski's expertise in market analysis and strategic trading makes them a formidable force in the financial world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dood2_bc99338de3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISKI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISKI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

