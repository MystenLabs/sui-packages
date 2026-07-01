module 0xc6129ed341b014213284742d681766c48ea3cbb287f91685f0c0ccd608e17982::events {
    struct BridgeInitialized has copy, drop {
        bridge_id: address,
    }

    struct Paused has copy, drop {
        paused: bool,
    }

    struct Minted has copy, drop {
        recipient: address,
        amount: u64,
        evm_origin_chain: u16,
        evm_nonce: u64,
        vaa_hash: vector<u8>,
    }

    struct WithdrawalInitiated has copy, drop {
        withdrawal_id: vector<u8>,
        burner: address,
        amount: u64,
        evm_recipient: vector<u8>,
        evm_destination_chain: u16,
        wormhole_sequence: u64,
    }

    public(friend) fun emit_bridge_initialized(arg0: address) {
        let v0 = BridgeInitialized{bridge_id: arg0};
        0x2::event::emit<BridgeInitialized>(v0);
    }

    public(friend) fun emit_minted(arg0: address, arg1: u64, arg2: u16, arg3: u64, arg4: vector<u8>) {
        let v0 = Minted{
            recipient        : arg0,
            amount           : arg1,
            evm_origin_chain : arg2,
            evm_nonce        : arg3,
            vaa_hash         : arg4,
        };
        0x2::event::emit<Minted>(v0);
    }

    public(friend) fun emit_paused(arg0: bool) {
        let v0 = Paused{paused: arg0};
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun emit_withdrawal_initiated(arg0: vector<u8>, arg1: address, arg2: u64, arg3: vector<u8>, arg4: u16, arg5: u64) {
        let v0 = WithdrawalInitiated{
            withdrawal_id         : arg0,
            burner                : arg1,
            amount                : arg2,
            evm_recipient         : arg3,
            evm_destination_chain : arg4,
            wormhole_sequence     : arg5,
        };
        0x2::event::emit<WithdrawalInitiated>(v0);
    }

    // decompiled from Move bytecode v7
}

