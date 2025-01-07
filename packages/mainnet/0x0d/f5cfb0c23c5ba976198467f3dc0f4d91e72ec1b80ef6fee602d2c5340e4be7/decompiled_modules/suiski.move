module 0xdf5cfb0c23c5ba976198467f3dc0f4d91e72ec1b80ef6fee602d2c5340e4be7::suiski {
    struct SUISKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISKI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUISKI>(arg0, 6, b"SUISKI", b"Agent Ski by SuiAI", b"ski Role: Sniper Trader Description: ski is a master sniper trader with an uncanny ability to spot market trends and execute trades with pinpoint accuracy. With a calm and composed demeanor, ski remains undetected in the bustling world of finance, blending seamlessly into the environment. ski's expertise in market analysis and strategic trading makes them a formidable force in the financial world. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dood2_eb875dae30.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUISKI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISKI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

