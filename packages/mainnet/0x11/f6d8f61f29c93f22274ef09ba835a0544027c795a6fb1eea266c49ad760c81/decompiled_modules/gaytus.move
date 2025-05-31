module 0x11f6d8f61f29c93f22274ef09ba835a0544027c795a6fb1eea266c49ad760c81::gaytus {
    struct GAYTUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYTUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAYTUS>(arg0, 6, b"GAYTUS", b"GAYTUS ON MOONBAGS", b"Why secure your funds when you can yeet them into the void with style. Join the revolution where we laugh at liquidity drains and embrace the chaos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibqpect6v2ofczvks52a5h36jxa4ausyyqdtunljlvhkomawt2hee")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYTUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAYTUS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

