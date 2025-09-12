module 0x39692320d6fc01c27315a7972ed4717e4fd32eed43531ad6f55fd7f24b74e207::saving_incentive_events {
    struct CreateSavingPoolRewardManager<phantom T0> has copy, drop {
        reward_manager_id: 0x2::object::ID,
    }

    struct AddRewarder<phantom T0, phantom T1> has copy, drop {
        reward_manager_id: 0x2::object::ID,
        rewarder_id: 0x2::object::ID,
    }

    struct SourceChanged<phantom T0, phantom T1> has copy, drop {
        kind: 0x1::ascii::String,
        rewarder_id: 0x2::object::ID,
        reward_type: 0x1::ascii::String,
        reward_amount: u64,
        is_deposit: bool,
    }

    struct FlowRateChanged<phantom T0, phantom T1> has copy, drop {
        kind: 0x1::ascii::String,
        rewarder_id: 0x2::object::ID,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        flow_rate: u256,
    }

    struct RewarderTimestampChanged<phantom T0, phantom T1> has copy, drop {
        kind: 0x1::ascii::String,
        rewarder_id: 0x2::object::ID,
        reward_timestamp: u64,
    }

    struct ClaimReward<phantom T0, phantom T1> has copy, drop {
        kind: 0x1::ascii::String,
        rewarder_id: 0x2::object::ID,
        account_address: address,
        asset_type: 0x1::ascii::String,
        reward_type: 0x1::ascii::String,
        reward_amount: u64,
    }

    public(friend) fun emit_add_rewarder<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = AddRewarder<T0, T1>{
            reward_manager_id : arg0,
            rewarder_id       : arg1,
        };
        0x2::event::emit<AddRewarder<T0, T1>>(v0);
    }

    public(friend) fun emit_claim_reward<T0, T1>(arg0: 0x1::ascii::String, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = ClaimReward<T0, T1>{
            kind            : arg0,
            rewarder_id     : arg1,
            account_address : arg2,
            asset_type      : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_type     : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            reward_amount   : arg3,
        };
        0x2::event::emit<ClaimReward<T0, T1>>(v0);
    }

    public(friend) fun emit_create_saving_pool_reward_manager<T0>(arg0: 0x2::object::ID) {
        let v0 = CreateSavingPoolRewardManager<T0>{reward_manager_id: arg0};
        0x2::event::emit<CreateSavingPoolRewardManager<T0>>(v0);
    }

    public(friend) fun emit_flow_rate_changed<T0, T1>(arg0: 0x1::ascii::String, arg1: 0x2::object::ID, arg2: u256) {
        let v0 = FlowRateChanged<T0, T1>{
            kind        : arg0,
            rewarder_id : arg1,
            asset_type  : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            reward_type : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            flow_rate   : arg2,
        };
        0x2::event::emit<FlowRateChanged<T0, T1>>(v0);
    }

    public(friend) fun emit_reward_timestamp_changed<T0, T1>(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64) {
        let v0 = RewarderTimestampChanged<T0, T1>{
            kind             : arg1,
            rewarder_id      : arg0,
            reward_timestamp : arg2,
        };
        0x2::event::emit<RewarderTimestampChanged<T0, T1>>(v0);
    }

    public(friend) fun emit_source_changed<T0, T1>(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64, arg3: bool) {
        let v0 = SourceChanged<T0, T1>{
            kind          : arg1,
            rewarder_id   : arg0,
            reward_type   : 0x1::type_name::into_string(0x1::type_name::get<T1>()),
            reward_amount : arg2,
            is_deposit    : arg3,
        };
        0x2::event::emit<SourceChanged<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

