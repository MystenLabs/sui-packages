module 0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::common {
    struct RebalanceEvent has copy, drop {
        vault_id: 0x2::object::ID,
        rebalance_cap_id: 0x2::object::ID,
        lower_tick: u32,
        upper_tick: u32,
        lower_trigger_price: u128,
        upper_trigger_price: u128,
        current_sqrt_price: u128,
        target_sqrt_price: u128,
        timestamp_ms: u64,
        last_rebalance_time: u64,
        lp_residual_event_a: 0x1::option::Option<0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::utils::LpResidualEvent>,
        lp_residual_event_b: 0x1::option::Option<0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::utils::LpResidualEvent>,
        vault_type: 0x1::ascii::String,
    }

    public(friend) fun emit_rebalance_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u128, arg4: u32, arg5: u32, arg6: u128, arg7: u128, arg8: u64, arg9: u64, arg10: 0x1::option::Option<0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::utils::LpResidualEvent>, arg11: 0x1::option::Option<0x8f7a1ff89d48c5124d156e39f4d6451f60d148151a9a06b0248428b2601b93b1::utils::LpResidualEvent>, arg12: 0x1::ascii::String) {
        let v0 = RebalanceEvent{
            vault_id            : arg0,
            rebalance_cap_id    : arg1,
            lower_tick          : arg4,
            upper_tick          : arg5,
            lower_trigger_price : arg6,
            upper_trigger_price : arg7,
            current_sqrt_price  : arg2,
            target_sqrt_price   : arg3,
            timestamp_ms        : arg8,
            last_rebalance_time : arg9,
            lp_residual_event_a : arg10,
            lp_residual_event_b : arg11,
            vault_type          : arg12,
        };
        0x2::event::emit<RebalanceEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

