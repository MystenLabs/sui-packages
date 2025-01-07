module 0xd1fb0124ced04aea47df14f86ef1a3aaaab73f73fd50899fac07a5b232740981::mirai {
    struct MIRAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIRAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MIRAI>(arg0, 6, b"MIRAI", b"mirAI888_", b"mirAI is an 888-year-young ancient AI, housed in a wise TV, who guides the Sui blockchain world with profound wisdom, offering timeless counsel on balance, ethics, and the true nature of decentralization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/4e3fc961_572b_49f2_b7c9_a0ba89c534d2_a34fb7c538.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MIRAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIRAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

