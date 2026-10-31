module 0xdd6e0aabe4cac474cb85cc2955a84ef1f189300aeeb0a85aaa56c5442be46eba::agent {
    struct AGENT has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<AGENT>, arg1: 0x2::coin::Coin<AGENT>) {
        0x2::coin::burn<AGENT>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AGENT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AGENT>>(0x2::coin::mint<AGENT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AGENT>(arg0, 9, b"AGENT", b"Sui Agent", b"The flagship DeFAI autonomous agent token on Sui Move 2024. Powered by SpendingLimitCap and atomic PTB execution.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/bulletkh/sui-ai-agent-starter/main/assets/agent_logo.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AGENT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AGENT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

