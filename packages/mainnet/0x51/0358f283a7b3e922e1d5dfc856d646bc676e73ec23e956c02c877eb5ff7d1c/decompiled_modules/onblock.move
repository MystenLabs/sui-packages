module 0x510358f283a7b3e922e1d5dfc856d646bc676e73ec23e956c02c877eb5ff7d1c::onblock {
    struct ONBLOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: ONBLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<ONBLOCK>(arg0, 6, b"ONBLOCK", b"Onblock AI by SuiAI", b"Onblock AI is an AI agent that helps users navigate the blockchain world by analyzing smart contracts, tracking transactions, detecting scams, and providing real-time insights.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2384_aade3d9489.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ONBLOCK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONBLOCK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

