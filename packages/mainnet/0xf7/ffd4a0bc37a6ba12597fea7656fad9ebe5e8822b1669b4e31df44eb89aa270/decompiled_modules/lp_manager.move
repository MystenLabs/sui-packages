module 0xf7ffd4a0bc37a6ba12597fea7656fad9ebe5e8822b1669b4e31df44eb89aa270::lp_manager {
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

