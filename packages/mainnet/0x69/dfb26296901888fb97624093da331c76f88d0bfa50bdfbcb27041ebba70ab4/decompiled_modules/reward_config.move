module 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reward_config {
    struct RewardConfigKey has copy, drop, store {
        reserve: address,
        option: u8,
    }

    struct RewardConfig<phantom T0> has copy, drop, store {
        reserve: address,
        reward_token_type: 0x1::string::String,
        option: u8,
        total_funds: u64,
        total_distributed: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        started_at: u64,
        end_at: u64,
        initial_global_reward_index: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        last_global_reward_index: 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal,
        last_updated_at: u64,
        phase: u16,
    }

    struct NewRewardConfigEvent has copy, drop {
        reserve: 0x2::object::ID,
        market_type: 0x1::string::String,
        option: u8,
        total_funds: u64,
        total_distributed_sf: u256,
        started_at: u64,
        end_at: u64,
        reward_token_type: 0x1::string::String,
        initial_global_reward_index_sf: u256,
        last_global_reward_index_sf: u256,
        last_updated_at: u64,
        phase: u16,
    }

    struct UpdateRewardConfigEvent has copy, drop {
        reserve: 0x2::object::ID,
        market_type: 0x1::string::String,
        reward_token_type: 0x1::string::String,
        option: u8,
        last_global_reward_index_sf: u256,
        last_updated_at: u64,
        phase: u16,
    }

    public(friend) fun change_reward_config<T0, T1, T2>(arg0: &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg1: u64, arg2: u8, arg3: u64, arg4: u64) {
        let v0 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg0);
        let v1 = RewardConfigKey{
            reserve : 0x2::object::id_to_address(&v0),
            option  : arg2,
        };
        let v2 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::borrow_mut<RewardConfigKey, vector<RewardConfig<T0>>, T0, T1>(arg0, v1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<RewardConfig<T0>>(v2)) {
            let v4 = 0x1::vector::borrow_mut<RewardConfig<T0>>(v2, v3);
            if (v4.reward_token_type == 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T2>()) {
                v4.total_funds = arg1;
                v4.started_at = arg3;
                v4.end_at = arg4;
                v4.last_updated_at = arg3;
                break
            };
            v3 = v3 + 1;
        };
    }

    public fun distribution_rate<T0>(arg0: &RewardConfig<T0>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(arg0.total_funds), 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(arg0.end_at - arg0.started_at))
    }

    public(friend) fun last_global_reward_index<T0>(arg0: &RewardConfig<T0>) : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::Decimal {
        arg0.last_global_reward_index
    }

    public(friend) fun new<T0, T1, T2>(arg0: &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg1: u8, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg3 < arg4, 3001);
        let v0 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T2>();
        let v1 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg0);
        let v2 = 0x2::object::id_to_address(&v1);
        let v3 = RewardConfigKey{
            reserve : v2,
            option  : arg1,
        };
        if (!0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::contain<RewardConfigKey, vector<RewardConfig<T0>>, T0, T1>(arg0, v3)) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::add<RewardConfigKey, vector<RewardConfig<T0>>, T0, T1>(arg0, v3, 0x1::vector::empty<RewardConfig<T0>>());
        };
        let v4 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::borrow_mut<RewardConfigKey, vector<RewardConfig<T0>>, T0, T1>(arg0, v3);
        let v5 = 0;
        let v6 = 0x1::option::none<RewardConfig<T0>>();
        while (v5 < 0x1::vector::length<RewardConfig<T0>>(v4)) {
            let v7 = 0x1::vector::remove<RewardConfig<T0>>(v4, v5);
            if (v7.reward_token_type == v0) {
                assert!(v7.last_updated_at >= v7.end_at, 3002);
                assert!(arg3 >= v7.end_at, 3001);
                0x1::option::fill<RewardConfig<T0>>(&mut v6, v7);
            };
            v5 = v5 + 1;
        };
        let (v8, v9) = if (0x1::option::is_some<RewardConfig<T0>>(&v6)) {
            let v10 = 0x1::option::extract<RewardConfig<T0>>(&mut v6);
            (v10.last_global_reward_index, v10.phase + 1)
        } else {
            (0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0), 1)
        };
        let v11 = RewardConfig<T0>{
            reserve                     : v2,
            reward_token_type           : v0,
            option                      : arg1,
            total_funds                 : arg2,
            total_distributed           : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0),
            started_at                  : arg3,
            end_at                      : arg4,
            initial_global_reward_index : v8,
            last_global_reward_index    : v8,
            last_updated_at             : 0x2::clock::timestamp_ms(arg5),
            phase                       : v9,
        };
        0x1::vector::push_back<RewardConfig<T0>>(v4, v11);
        let v12 = NewRewardConfigEvent{
            reserve                        : 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg0),
            market_type                    : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T0>(),
            option                         : arg1,
            total_funds                    : arg2,
            total_distributed_sf           : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_scaled_val(v11.total_distributed),
            started_at                     : arg3,
            end_at                         : arg4,
            reward_token_type              : v0,
            initial_global_reward_index_sf : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_scaled_val(v11.initial_global_reward_index),
            last_global_reward_index_sf    : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_scaled_val(v11.last_global_reward_index),
            last_updated_at                : v11.last_updated_at,
            phase                          : v9,
        };
        0x2::event::emit<NewRewardConfigEvent>(v12);
    }

    public(friend) fun new_reward_config_key(arg0: address, arg1: u8) : RewardConfigKey {
        RewardConfigKey{
            reserve : arg0,
            option  : arg1,
        }
    }

    public(friend) fun phase<T0>(arg0: &RewardConfig<T0>) : u16 {
        arg0.phase
    }

    public(friend) fun reward_token_type<T0>(arg0: &RewardConfig<T0>) : 0x1::string::String {
        arg0.reward_token_type
    }

    public(friend) fun update_reward_config<T0, T1>(arg0: &mut 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>, arg1: u8, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::check_reserve_status_and_stale<T0, T1>(arg0, v0);
        assert!(arg1 == 0 || arg1 == 1, 3003);
        let v1 = if (arg1 == 0) {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::total_supply<T0, T1>(arg0)
        } else {
            0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::borrowed_amount<T0, T1>(arg0)
        };
        let v2 = 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg0);
        let v3 = RewardConfigKey{
            reserve : 0x2::object::id_to_address(&v2),
            option  : arg1,
        };
        let v4 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::borrow_mut<RewardConfigKey, vector<RewardConfig<T0>>, T0, T1>(arg0, v3);
        let v5 = 0;
        while (v5 < 0x1::vector::length<RewardConfig<T0>>(v4)) {
            let v6 = 0x1::vector::borrow_mut<RewardConfig<T0>>(v4, v5);
            if (v6.end_at < v6.last_updated_at) {
                continue
            };
            let v7 = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64(v0, v6.end_at) - 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::max_u64(v6.last_updated_at, v6.started_at);
            if (v7 > 0 && !0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::eq(v1, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(0))) {
                let v8 = distribution_rate<T0>(v6);
                v6.total_distributed = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(v8, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v0 - v6.started_at));
                v6.last_global_reward_index = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::add(v6.last_global_reward_index, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::div(0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::mul(v8, 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::from(v7)), v1));
            };
            v6.last_updated_at = 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::min_u64(v0, v6.end_at);
            v5 = v5 + 1;
            let v9 = UpdateRewardConfigEvent{
                reserve                     : 0x2::object::id<0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::reserve::Reserve<T0, T1>>(arg0),
                market_type                 : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::utils::get_type<T0>(),
                reward_token_type           : v6.reward_token_type,
                option                      : arg1,
                last_global_reward_index_sf : 0x69dfb26296901888fb97624093da331c76f88d0bfa50bdfbcb27041ebba70ab4::decimal::to_scaled_val(v6.last_global_reward_index),
                last_updated_at             : v6.last_updated_at,
                phase                       : v6.phase,
            };
            0x2::event::emit<UpdateRewardConfigEvent>(v9);
        };
    }

    // decompiled from Move bytecode v6
}

