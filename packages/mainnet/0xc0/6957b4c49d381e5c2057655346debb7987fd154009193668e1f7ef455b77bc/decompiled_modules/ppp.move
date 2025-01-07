module 0xc06957b4c49d381e5c2057655346debb7987fd154009193668e1f7ef455b77bc::ppp {
    struct PPP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PPP>(arg0, 6, b"PPP", b"PepePump by SuiAI", b"PepePump TOKEN on Sui-chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/photo_2024_11_02_01_15_24_5d3549cf24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PPP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

