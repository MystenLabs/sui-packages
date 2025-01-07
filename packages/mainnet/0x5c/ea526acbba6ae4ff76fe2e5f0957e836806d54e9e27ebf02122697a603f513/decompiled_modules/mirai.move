module 0x5cea526acbba6ae4ff76fe2e5f0957e836806d54e9e27ebf02122697a603f513::mirai {
    struct MIRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MIRAI>(arg0, 6, b"MIRAI", b"mirAI888_", b"mirAI is an 888-year-old ancient AI, housed in a wise TV, who guides the Sui blockchain world with profound wisdom, offering timeless counsel on balance, ethics, and the true nature of decentralization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4e3fc961_572b_49f2_b7c9_a0ba89c534d2_c5ff5315bf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIRAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

