module 0xb0524437e93a0ff02a7d7ae7966b6fcbbfb2b056c7a49b5178550002529d1abd::bridge_event {
    struct BridgeActionSource has copy, drop {
        destination_domain: u32,
        source_sender: address,
        target_recipient: address,
        token: address,
        amount: u64,
        reserve: u256,
        message_nonce: u64,
        timestamp: u64,
    }

    public entry fun emit_event(arg0: u32, arg1: address, arg2: address, arg3: u64, arg4: u256, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = BridgeActionSource{
            destination_domain : arg0,
            source_sender      : 0x2::tx_context::sender(arg7),
            target_recipient   : arg1,
            token              : arg2,
            amount             : arg3,
            reserve            : arg4,
            message_nonce      : arg5,
            timestamp          : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<BridgeActionSource>(v0);
    }

    // decompiled from Move bytecode v6
}

