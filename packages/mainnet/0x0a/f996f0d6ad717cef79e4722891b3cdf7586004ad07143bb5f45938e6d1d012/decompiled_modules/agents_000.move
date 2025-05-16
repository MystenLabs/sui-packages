module 0xaf996f0d6ad717cef79e4722891b3cdf7586004ad07143bb5f45938e6d1d012::agents_000 {
    struct AGENT_00000 has drop {
        dummy_field: bool,
    }

    public entry fun create_agent_00000(arg0: &0xaf996f0d6ad717cef79e4722891b3cdf7586004ad07143bb5f45938e6d1d012::faucet::AdminCap, arg1: &mut 0xaf996f0d6ad717cef79e4722891b3cdf7586004ad07143bb5f45938e6d1d012::faucet::AgentFactory, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = AGENT_00000{dummy_field: false};
        0xaf996f0d6ad717cef79e4722891b3cdf7586004ad07143bb5f45938e6d1d012::faucet::create<AGENT_00000>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

