module 0x8cc2eed1b1012881a623e9bafd58ff0f17a8c5f807662631e623acf7779a78ee::borrow_incentive_events {
    struct RewarderCreated has copy, drop {
        vault_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        start_timestamp: u64,
        flow_rate: u256,
    }

    struct SourceChanged has copy, drop {
        rewarder_id: 0x2::object::ID,
        reward_type: 0x1::ascii::String,
        amount: u64,
        is_deposit: bool,
    }

    struct FlowRateChanged has copy, drop {
        rewarder_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        flow_rate: u256,
    }

    struct ClaimReward has copy, drop {
        rewarder_id: 0x2::object::ID,
        account: address,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        amount: u64,
    }

    public(friend) fun emit_claim_reward<T0, T1>(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = ClaimReward{
            rewarder_id : arg0,
            account     : arg1,
            asset_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            amount      : arg2,
        };
        0x2::event::emit<ClaimReward>(v0);
    }

    public(friend) fun emit_flow_rate_changed<T0, T1>(arg0: 0x2::object::ID, arg1: u256) {
        let v0 = FlowRateChanged{
            rewarder_id : arg0,
            asset_type  : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            flow_rate   : arg1,
        };
        0x2::event::emit<FlowRateChanged>(v0);
    }

    public(friend) fun emit_rewarder_created<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u256) {
        let v0 = RewarderCreated{
            vault_id        : arg0,
            rewarder_id     : arg1,
            asset_type      : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            reward_type     : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            start_timestamp : arg2,
            flow_rate       : arg3,
        };
        0x2::event::emit<RewarderCreated>(v0);
    }

    public(friend) fun emit_source_changed<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: bool) {
        let v0 = SourceChanged{
            rewarder_id : arg0,
            reward_type : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            amount      : arg1,
            is_deposit  : arg2,
        };
        0x2::event::emit<SourceChanged>(v0);
    }

    // decompiled from Move bytecode v6
}

