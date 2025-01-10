module 0x31aa2c80324e07a2cfc0c2241523da89e53895e64a7b1d0d6bb4007d6bd93451::sad {
    struct SAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SAD>(arg0, 6, b"SAD", b"SUI Addict by SuiAI", b" The rallying call for enthusiasts worldwide. Harness the power of AI to bull-post and reap alpha on the premier blockchain. We're constantly evolving, building, and pushing boundaries. Join us on this journey, or be left behind in the dust.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/109566be31f14ed4928884d9ef623d9a_1121726609_1_791a6259ce.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAD>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAD>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

