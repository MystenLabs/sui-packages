module 0x5c154abaa2e7e30ba31d2a1c511baebf0f095bddd7a1f22c63a54c5d30dcedf7::marbles {
    struct MARBLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARBLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARBLES>(arg0, 6, b"MARBLES", b"Marble Saga", b" Marble Saga ! is an NFT-Game themed project based on cryptocurrency. Marble Saga and all its utilities are built on the Sui Chain. Marbles provides several utilities to develop. The first is the DeFi (DecentralizedFinance) feature. Marble Saga offers DeFi staking and farming features. The staking feature offered has a reward in of course with a high initial APY% value. While farming, users can add pair as liquidity and get a return in the form of token. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/marblesui_fd59474d3d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARBLES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARBLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

