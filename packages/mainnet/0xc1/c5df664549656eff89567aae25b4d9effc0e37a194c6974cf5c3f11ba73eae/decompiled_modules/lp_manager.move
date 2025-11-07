module 0xc1c5df664549656eff89567aae25b4d9effc0e37a194c6974cf5c3f11ba73eae::lp_manager {
    struct LPBurnEvent has copy, drop {
        lp_position_id: 0x2::object::ID,
        burn_recipient: address,
        token_symbol: vector<u8>,
        timestamp_ms: u64,
    }

    struct BurnReceipt has key {
        id: 0x2::object::UID,
        burned_object_id: 0x2::object::ID,
        burn_recipient: address,
    }

    public entry fun burn<T0: store + key>(arg0: T0, arg1: address, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = LPBurnEvent{
            lp_position_id : 0x2::object::id<T0>(&arg0),
            burn_recipient : arg1,
            token_symbol   : arg2,
            timestamp_ms   : arg3,
        };
        0x2::event::emit<LPBurnEvent>(v0);
        0x2::transfer::public_transfer<T0>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

