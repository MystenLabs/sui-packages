module 0x698b24dcef2faaebbb1755cf8d87bf67073ffa0b1a9cd8724823e895aea76e0c::first {
    struct FIRST has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIRST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIRST>(arg0, 9, b"First", b"First", b"$FIRST is the starting point of the padthe token that marks the open of fair-launch memes on Sui. Liquidity is on-chain, the contract is live on Sui, and the chart is the only narrative that matters.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipads.fun/api/files/suipump/logos/0xd2e24fdf969ad87d65a0cc93866511b7d0f49cb853ebdab35f138c57bb6a23ce/698156ba-4d24-48da-8eb0-730186fe48e5.jpeg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FIRST>>(v1, v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIRST>>(v0, v2);
    }

    // decompiled from Move bytecode v7
}

