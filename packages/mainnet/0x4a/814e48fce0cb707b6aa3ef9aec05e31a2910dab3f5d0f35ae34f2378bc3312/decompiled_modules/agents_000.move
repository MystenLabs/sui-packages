module 0x4a814e48fce0cb707b6aa3ef9aec05e31a2910dab3f5d0f35ae34f2378bc3312::agents_000 {
    struct AGENT_00000 has drop {
        dummy_field: bool,
    }

    public entry fun create_agent_00000(arg0: &0x4a814e48fce0cb707b6aa3ef9aec05e31a2910dab3f5d0f35ae34f2378bc3312::faucet::AdminCap, arg1: &mut 0x4a814e48fce0cb707b6aa3ef9aec05e31a2910dab3f5d0f35ae34f2378bc3312::faucet::AgentFactory, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = AGENT_00000{dummy_field: false};
        0x4a814e48fce0cb707b6aa3ef9aec05e31a2910dab3f5d0f35ae34f2378bc3312::faucet::create<AGENT_00000>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

