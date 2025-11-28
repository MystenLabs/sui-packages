module 0xb313ebe68034b4910ed5153b25e526f26b37256eb2ec14ed9a840e05f16c0470::deagent_token {
    struct DEAGENT_TOKEN has drop {
        dummy_field: bool,
    }

    public fun get_coin_value(arg0: &0x2::coin::Coin<DEAGENT_TOKEN>) : u64 {
        0x2::coin::value<DEAGENT_TOKEN>(arg0)
    }

    fun init(arg0: DEAGENT_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEAGENT_TOKEN>(arg0, 9, b"AIA", b"DeAgentAI", b"AIA is the native utility and governance token of DeAgentAI, the leading decentralized AI Agent infrastructure platform. It is used to access AI services, stake for rewards, participate in governance, and unlock cross-chain utilities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.deagent.ai/DA-AA.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DEAGENT_TOKEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEAGENT_TOKEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun join_coins(arg0: &mut 0x2::coin::Coin<DEAGENT_TOKEN>, arg1: 0x2::coin::Coin<DEAGENT_TOKEN>) {
        0x2::coin::join<DEAGENT_TOKEN>(arg0, arg1);
    }

    public fun split_coin(arg0: &mut 0x2::coin::Coin<DEAGENT_TOKEN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEAGENT_TOKEN>>(0x2::coin::split<DEAGENT_TOKEN>(arg0, arg1, arg3), arg2);
    }

    public fun transfer_coin(arg0: 0x2::coin::Coin<DEAGENT_TOKEN>, arg1: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DEAGENT_TOKEN>>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

