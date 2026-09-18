module 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::supply_position {
    struct UserSupplyPosition has store {
        config: 0x1::option::Option<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>,
        paused_supply: bool,
        paused_withdraw: bool,
        amount: u64,
        withdrawal_limit: u64,
        last_update: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS,
        decay_amount: u64,
        decay_duration: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::DurationS,
    }

    public(friend) fun get_supply_amount(arg0: &UserSupplyPosition) : u64 {
        arg0.amount
    }

    public(friend) fun get_supply_base_withdrawal_limit(arg0: &UserSupplyPosition) : u64 {
        if (0x1::option::is_some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(&arg0.config)) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_supply_config_base_withdrawal_limit(0x1::option::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(&arg0.config))
        } else {
            0
        }
    }

    public(friend) fun get_supply_configs_not_set(arg0: &UserSupplyPosition) : bool {
        0x1::option::is_none<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(&arg0.config)
    }

    public(friend) fun get_supply_decay_amount(arg0: &UserSupplyPosition) : u64 {
        arg0.decay_amount
    }

    public(friend) fun get_supply_decay_duration(arg0: &UserSupplyPosition) : u64 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw(arg0.decay_duration)
    }

    public(friend) fun get_supply_expand_duration(arg0: &UserSupplyPosition) : u64 {
        if (0x1::option::is_some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(&arg0.config)) {
            0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw(0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_supply_config_expand_duration(0x1::option::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(&arg0.config)))
        } else {
            0
        }
    }

    public(friend) fun get_supply_expand_percent(arg0: &UserSupplyPosition) : u64 {
        if (0x1::option::is_some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(&arg0.config)) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_supply_config_expand_percent(0x1::option::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(&arg0.config))
        } else {
            0
        }
    }

    public(friend) fun get_supply_last_update(arg0: &UserSupplyPosition) : u64 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg0.last_update)
    }

    public(friend) fun get_supply_pause(arg0: &UserSupplyPosition, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action) : bool {
        if (arg1 == 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::action_supply()) {
            arg0.paused_supply
        } else {
            assert!(arg1 == 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::action_withdraw(), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_invalid_params());
            arg0.paused_withdraw
        }
    }

    public(friend) fun get_supply_status(arg0: &UserSupplyPosition) : u8 {
        if (0x1::option::is_none<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(&arg0.config)) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::position_status_not_set()
        } else if (arg0.paused_supply || arg0.paused_withdraw) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::position_status_paused()
        } else {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::position_status_active()
        }
    }

    public(friend) fun get_supply_with_interest(arg0: &UserSupplyPosition) : bool {
        0x1::option::is_some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(&arg0.config) && 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_supply_config_with_interest(0x1::option::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(&arg0.config))
    }

    public(friend) fun get_supply_withdrawal_limit(arg0: &UserSupplyPosition) : u64 {
        arg0.withdrawal_limit
    }

    public(friend) fun new_user_supply_position(arg0: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) : UserSupplyPosition {
        UserSupplyPosition{
            config           : 0x1::option::none<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(),
            paused_supply    : false,
            paused_withdraw  : false,
            amount           : 0,
            withdrawal_limit : 0,
            last_update      : arg0,
            decay_amount     : 0,
            decay_duration   : 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_seconds(0),
        }
    }

    public(friend) fun reset_supply_decay(arg0: &mut UserSupplyPosition) {
        arg0.decay_amount = 0;
        arg0.decay_duration = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_seconds(0);
    }

    public(friend) fun set_supply_amount(arg0: &mut UserSupplyPosition, arg1: u128) {
        assert!(arg1 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64(), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        arg0.amount = (arg1 as u64);
    }

    public(friend) fun set_supply_config(arg0: &mut UserSupplyPosition, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig) {
        arg0.config = 0x1::option::some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(arg1);
    }

    public(friend) fun set_supply_last_update(arg0: &mut UserSupplyPosition, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) {
        arg0.last_update = arg1;
    }

    public(friend) fun set_supply_pause(arg0: &mut UserSupplyPosition, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action, arg2: bool) {
        if (arg1 == 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::action_supply()) {
            arg0.paused_supply = arg2;
        } else {
            assert!(arg1 == 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::action_withdraw(), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_invalid_params());
            arg0.paused_withdraw = arg2;
        };
    }

    public(friend) fun set_supply_withdrawal_limit(arg0: &mut UserSupplyPosition, arg1: u128) {
        assert!(arg1 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64(), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        arg0.withdrawal_limit = (arg1 as u64);
    }

    public(friend) fun supply_or_withdraw(arg0: &mut UserSupplyPosition, arg1: bool, arg2: u64, arg3: u128, arg4: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) : (u128, u128) {
        if (get_supply_configs_not_set(arg0)) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_user_not_defined()
        };
        if (arg1 && arg0.paused_supply || !arg1 && arg0.paused_withdraw) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_user_paused()
        };
        let v0 = *0x1::option::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserSupplyConfig>(&arg0.config);
        let v1 = (arg0.decay_amount as u128);
        let v2 = v1;
        let v3 = (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw(arg0.decay_duration) as u128);
        let v4 = v3;
        if (v1 > 0 && v3 > 0) {
            let v5 = (0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw(0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::elapsed_since(arg4, arg0.last_update)) as u128);
            if (v5 < v3) {
                v2 = v1 - v1 * v5 / v3;
                v4 = v3 - v5;
            } else {
                v2 = 0;
                v4 = 0;
            };
        };
        let v6 = (arg0.amount as u128);
        let v7 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::liquidity_calcs::calc_withdrawal_limit_before_operate(v6, (arg0.withdrawal_limit as u128), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_supply_config_expand_percent(&v0), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw(0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_supply_config_expand_duration(&v0)), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg0.last_update), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg4));
        let v8 = v7;
        let v9 = 0;
        let v10 = 0;
        let v11 = if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_supply_config_with_interest(&v0)) {
            let v11 = if (arg1) {
                let v12 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128((arg2 as u128), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::exchange_prices_precision(), arg3);
                v9 = v12;
                v6 + v12
            } else {
                let v13 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_ceil_u128((arg2 as u128), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::exchange_prices_precision(), arg3);
                v9 = v13;
                assert!(v6 >= v13, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
                v6 - v13
            };
            if (v9 == 0) {
                abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_operate_amount_insufficient()
            };
            v11
        } else {
            let v14 = (arg2 as u128);
            v10 = v14;
            if (arg1) {
                v6 + v14
            } else {
                assert!(v6 >= v14, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
                v6 - v14
            }
        };
        let v15 = false;
        if (!arg1) {
            if (v11 < v7) {
                abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_withdrawal_limit_reached()
            };
            if (v2 > 0) {
                let v16 = v9 + v10;
                let v17 = (v2 as u128);
                if (v16 > v17) {
                    let v18 = if (v7 > v17) {
                        v7 - v17
                    } else {
                        0
                    };
                    v8 = v18;
                    v2 = 0;
                } else {
                    let v19 = if (v7 > v16) {
                        v7 - v16
                    } else {
                        0
                    };
                    v8 = v19;
                    v2 = v2 - v16;
                };
                v15 = true;
            };
        };
        let v20 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::liquidity_calcs::calc_withdrawal_limit_after_operate(v11, (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_supply_config_base_withdrawal_limit(&v0) as u128), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_supply_config_expand_percent(&v0), v8);
        let v21 = (v2 as u128);
        let v22 = v21;
        if (v20 == 0) {
            v22 = 0;
            v4 = 0;
        } else if (v8 != v20) {
            if (arg1) {
                let v23 = v8;
                if (v8 == 0) {
                    v23 = (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_supply_config_base_withdrawal_limit(&v0) as u128);
                };
                if (v20 > v23) {
                    let v24 = v20 - v23;
                    if (v21 > 0) {
                        let v25 = ((v4 as u256) * (v21 as u256) + (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::total_decay_duration() as u256) * (v24 as u256)) / ((v21 as u256) + (v24 as u256));
                        v4 = (v25 as u128);
                    } else {
                        v4 = (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::total_decay_duration() as u128);
                    };
                    if (v4 < (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::min_decay_duration() as u128)) {
                        v4 = (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::min_decay_duration() as u128);
                    };
                    v22 = v21 + v24;
                } else {
                    v22 = 0;
                    v4 = 0;
                };
            } else if (v15) {
                let v26 = if (v20 > v8) {
                    v20 - v8
                } else {
                    0
                };
                v22 = v21 + v26;
            };
        };
        if (v22 > 0) {
            if (v4 > (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::total_decay_duration() as u128)) {
                v4 = (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::total_decay_duration() as u128);
            } else if (v4 == 0) {
                v4 = 1;
            };
        };
        set_supply_amount(arg0, v11);
        set_supply_withdrawal_limit(arg0, v20);
        arg0.last_update = arg4;
        assert!(v22 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64(), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        arg0.decay_amount = (v22 as u64);
        arg0.decay_duration = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::from_seconds((v4 as u64));
        (v9, v10)
    }

    // decompiled from Move bytecode v7
}

