module 0xfee598426837e8802305d275299f646cbfcbdc4d87e643a61e441cdf1c252e4d::ski {
    struct SKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SKI>(arg0, 6, b"SKI", b"Agent ski by SuiAI", b"ski is a master sniper trader with an uncanny ability to spot market trends and execute trades with pinpoint accuracy. With a calm and composed demeanor, Suiski remains undetected in the bustling world of finance, blending seamlessly into the environment. Suiski's expertise in market analysis and strategic trading makes them a formidable force in the financial world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dood2_a832ee42bd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

