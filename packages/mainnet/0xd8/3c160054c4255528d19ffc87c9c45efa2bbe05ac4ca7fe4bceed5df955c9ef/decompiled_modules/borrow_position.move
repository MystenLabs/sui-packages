module 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::borrow_position {
    struct UserBorrowPosition has store {
        config: 0x1::option::Option<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>,
        paused_borrow: bool,
        paused_payback: bool,
        amount: u64,
        debt_ceiling: u64,
        last_update: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS,
    }

    public(friend) fun borrow_or_payback(arg0: &mut UserBorrowPosition, arg1: bool, arg2: u64, arg3: u128, arg4: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) : (u128, u128) {
        if (get_borrow_configs_not_set(arg0)) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_user_not_defined()
        };
        if (arg1 && arg0.paused_borrow || !arg1 && arg0.paused_payback) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_user_paused()
        };
        let v0 = *0x1::option::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config);
        let v1 = (arg0.amount as u128);
        let v2 = 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::liquidity_calcs::calc_borrow_limit_before_operate((v1 as u256), (arg0.debt_ceiling as u128), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_expand_percent(&v0), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw(0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_expand_duration(&v0)), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_base_debt_ceiling(&v0) as u128), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_max_debt_ceiling(&v0) as u128), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg0.last_update), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg4));
        let v3 = 0;
        let v4 = 0;
        let v5 = if (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_with_interest(&v0)) {
            let v5 = if (arg1) {
                let v6 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_ceil_u128((arg2 as u128), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::exchange_prices_precision(), arg3);
                v3 = v6;
                v1 + v6
            } else {
                let v7 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128((arg2 as u128), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::exchange_prices_precision(), arg3);
                v3 = v7;
                assert!(v1 >= v7, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
                v1 - v7
            };
            if (v3 == 0) {
                abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_operate_amount_insufficient()
            };
            v5
        } else {
            let v8 = (arg2 as u128);
            v4 = v8;
            if (arg1) {
                v1 + v8
            } else {
                assert!(v1 >= v8, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
                v1 - v8
            }
        };
        if (arg1 && v5 > v2) {
            abort 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::user_module_borrow_limit_reached()
        };
        arg0.last_update = arg4;
        set_borrow_amount(arg0, v5);
        set_borrow_debt_ceiling(arg0, 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::liquidity_calcs::calc_borrow_limit_after_operate(v5, (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_base_debt_ceiling(&v0) as u128), (0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_max_debt_ceiling(&v0) as u128), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_expand_percent(&v0), v2));
        (v3, v4)
    }

    public(friend) fun get_borrow_amount(arg0: &UserBorrowPosition) : u64 {
        arg0.amount
    }

    public(friend) fun get_borrow_base_debt_ceiling(arg0: &UserBorrowPosition) : u64 {
        if (0x1::option::is_some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config)) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_base_debt_ceiling(0x1::option::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config))
        } else {
            0
        }
    }

    public(friend) fun get_borrow_configs_not_set(arg0: &UserBorrowPosition) : bool {
        0x1::option::is_none<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config)
    }

    public(friend) fun get_borrow_debt_ceiling(arg0: &UserBorrowPosition) : u64 {
        arg0.debt_ceiling
    }

    public(friend) fun get_borrow_expand_duration(arg0: &UserBorrowPosition) : u64 {
        if (0x1::option::is_some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config)) {
            0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw(0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_expand_duration(0x1::option::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config)))
        } else {
            0
        }
    }

    public(friend) fun get_borrow_expand_percent(arg0: &UserBorrowPosition) : u64 {
        if (0x1::option::is_some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config)) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_expand_percent(0x1::option::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config))
        } else {
            0
        }
    }

    public(friend) fun get_borrow_last_update(arg0: &UserBorrowPosition) : u64 {
        0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::raw_ts(arg0.last_update)
    }

    public(friend) fun get_borrow_max_debt_ceiling(arg0: &UserBorrowPosition) : u64 {
        if (0x1::option::is_some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config)) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_max_debt_ceiling(0x1::option::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config))
        } else {
            0
        }
    }

    public(friend) fun get_borrow_pause(arg0: &UserBorrowPosition, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action) : bool {
        if (arg1 == 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::action_borrow()) {
            arg0.paused_borrow
        } else {
            assert!(arg1 == 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::action_payback(), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_invalid_params());
            arg0.paused_payback
        }
    }

    public(friend) fun get_borrow_status(arg0: &UserBorrowPosition) : u8 {
        if (0x1::option::is_none<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config)) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::position_status_not_set()
        } else if (arg0.paused_borrow || arg0.paused_payback) {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::position_status_paused()
        } else {
            0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::position_status_active()
        }
    }

    public(friend) fun get_borrow_with_interest(arg0: &UserBorrowPosition) : bool {
        0x1::option::is_some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config) && 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::get_borrow_config_with_interest(0x1::option::borrow<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(&arg0.config))
    }

    public(friend) fun new_user_borrow_position(arg0: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) : UserBorrowPosition {
        UserBorrowPosition{
            config         : 0x1::option::none<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(),
            paused_borrow  : false,
            paused_payback : false,
            amount         : 0,
            debt_ceiling   : 0,
            last_update    : arg0,
        }
    }

    public(friend) fun set_borrow_amount(arg0: &mut UserBorrowPosition, arg1: u128) {
        assert!(arg1 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64(), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        arg0.amount = (arg1 as u64);
    }

    public(friend) fun set_borrow_config(arg0: &mut UserBorrowPosition, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig) {
        arg0.config = 0x1::option::some<0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::structs::UserBorrowConfig>(arg1);
    }

    public(friend) fun set_borrow_debt_ceiling(arg0: &mut UserBorrowPosition, arg1: u128) {
        assert!(arg1 <= 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::constants::max_u64(), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        arg0.debt_ceiling = (arg1 as u64);
    }

    public(friend) fun set_borrow_last_update(arg0: &mut UserBorrowPosition, arg1: 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::units::TimestampS) {
        arg0.last_update = arg1;
    }

    public(friend) fun set_borrow_pause(arg0: &mut UserBorrowPosition, arg1: 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::Action, arg2: bool) {
        if (arg1 == 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::action_borrow()) {
            arg0.paused_borrow = arg2;
        } else {
            assert!(arg1 == 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::pause::action_payback(), 0xd0f7e9baf5bb8c13444fc7abc562103b7632acea5f290ed7ab6bbe6f2191febb::errors::admin_module_invalid_params());
            arg0.paused_payback = arg2;
        };
    }

    // decompiled from Move bytecode v7
}

