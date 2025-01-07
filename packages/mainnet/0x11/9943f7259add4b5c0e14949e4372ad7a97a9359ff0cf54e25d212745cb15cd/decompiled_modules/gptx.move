module 0x119943f7259add4b5c0e14949e4372ad7a97a9359ff0cf54e25d212745cb15cd::gptx {
    struct GPTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPTX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GPTX>(arg0, 6, b"GPTX", b"GPTX by SuiAI", b"Our team will create a swarm of agents . We will give them money to trade for us on Pancakeswap , Uniswap , Raydium and Cetus . Instructions ... follow whales wallets , follow hyped talks on Twitter , trade Gaussian channel Indicator ... etc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/hedge4_logo_cc96a8dc22.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GPTX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPTX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

