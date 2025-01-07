module 0x605a6e27943c42e6198b1e2d37e0515562bba3ff94c2b4a443f7ea7a9d9949c9::suihyp {
    struct SUIHYP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHYP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHYP>(arg0, 6, b"SUIHYP", b"SUIHYPERLIQUID", b"developing decentralized website for concentrated sui liquidity", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HYPER_fc9ca86301.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHYP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHYP>>(v1);
    }

    // decompiled from Move bytecode v6
}

