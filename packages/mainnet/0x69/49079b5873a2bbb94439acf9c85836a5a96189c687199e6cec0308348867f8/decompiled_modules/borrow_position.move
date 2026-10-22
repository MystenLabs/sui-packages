module 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position {
    struct UserBorrowPosition has store {
        config: 0x1::option::Option<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>,
        paused_borrow: bool,
        paused_payback: bool,
        amount: u64,
        debt_ceiling: u64,
        last_update: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS,
    }

    public(friend) fun borrow_or_payback(arg0: &mut UserBorrowPosition, arg1: bool, arg2: u64, arg3: u128, arg4: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS) : (u128, u128) {
        if (get_borrow_configs_not_set(arg0)) {
            abort 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::user_module_user_not_defined()
        };
        if (arg1 && arg0.paused_borrow || !arg1 && arg0.paused_payback) {
            abort 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::user_module_user_paused()
        };
        let v0 = *0x1::option::borrow<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config);
        let v1 = (arg0.amount as u128);
        let v2 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::liquidity_calcs::calc_borrow_limit_before_operate((v1 as u256), (arg0.debt_ceiling as u128), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_expand_percent(&v0), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::raw(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_expand_duration(&v0)), (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_base_debt_ceiling(&v0) as u128), (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_max_debt_ceiling(&v0) as u128), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::raw_ts(arg0.last_update), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::raw_ts(arg4));
        let v3 = 0;
        let v4 = 0;
        let v5 = if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_with_interest(&v0)) {
            let v5 = if (arg1) {
                let v6 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_ceil_u128((arg2 as u128), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::exchange_prices_precision(), arg3);
                v3 = v6;
                v1 + v6
            } else {
                let v7 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::math::mul_div_u128((arg2 as u128), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::exchange_prices_precision(), arg3);
                v3 = v7;
                assert!(v1 >= v7, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::overflow());
                v1 - v7
            };
            if (v3 == 0) {
                abort 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::user_module_operate_amount_insufficient()
            };
            v5
        } else {
            let v8 = (arg2 as u128);
            v4 = v8;
            if (arg1) {
                v1 + v8
            } else {
                assert!(v1 >= v8, 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::overflow());
                v1 - v8
            }
        };
        if (arg1 && v5 > v2) {
            abort 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::user_module_borrow_limit_reached()
        };
        arg0.last_update = arg4;
        set_borrow_amount(arg0, v5);
        set_borrow_debt_ceiling(arg0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::liquidity_calcs::calc_borrow_limit_after_operate(v5, (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_base_debt_ceiling(&v0) as u128), (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_max_debt_ceiling(&v0) as u128), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_expand_percent(&v0), v2));
        (v3, v4)
    }

    public(friend) fun get_borrow_amount(arg0: &UserBorrowPosition) : u64 {
        arg0.amount
    }

    public(friend) fun get_borrow_base_debt_ceiling(arg0: &UserBorrowPosition) : u64 {
        if (0x1::option::is_some<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_base_debt_ceiling(0x1::option::borrow<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config))
        } else {
            0
        }
    }

    public(friend) fun get_borrow_configs_not_set(arg0: &UserBorrowPosition) : bool {
        0x1::option::is_none<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config)
    }

    public(friend) fun get_borrow_debt_ceiling(arg0: &UserBorrowPosition) : u64 {
        arg0.debt_ceiling
    }

    public(friend) fun get_borrow_expand_duration(arg0: &UserBorrowPosition) : u64 {
        if (0x1::option::is_some<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config)) {
            0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::raw(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_expand_duration(0x1::option::borrow<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config)))
        } else {
            0
        }
    }

    public(friend) fun get_borrow_expand_percent(arg0: &UserBorrowPosition) : u64 {
        if (0x1::option::is_some<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_expand_percent(0x1::option::borrow<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config))
        } else {
            0
        }
    }

    public(friend) fun get_borrow_last_update(arg0: &UserBorrowPosition) : u64 {
        0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::raw_ts(arg0.last_update)
    }

    public(friend) fun get_borrow_max_debt_ceiling(arg0: &UserBorrowPosition) : u64 {
        if (0x1::option::is_some<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_max_debt_ceiling(0x1::option::borrow<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config))
        } else {
            0
        }
    }

    public(friend) fun get_borrow_pause(arg0: &UserBorrowPosition, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::Action) : bool {
        if (arg1 == 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_borrow()) {
            arg0.paused_borrow
        } else {
            assert!(arg1 == 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_payback(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
            arg0.paused_payback
        }
    }

    public(friend) fun get_borrow_status(arg0: &UserBorrowPosition) : u8 {
        if (0x1::option::is_none<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::position_status_not_set()
        } else if (arg0.paused_borrow || arg0.paused_payback) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::position_status_paused()
        } else {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::position_status_active()
        }
    }

    public(friend) fun get_borrow_with_interest(arg0: &UserBorrowPosition) : bool {
        0x1::option::is_some<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config) && 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_borrow_config_with_interest(0x1::option::borrow<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(&arg0.config))
    }

    public(friend) fun new_user_borrow_position(arg0: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS) : UserBorrowPosition {
        UserBorrowPosition{
            config         : 0x1::option::none<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(),
            paused_borrow  : false,
            paused_payback : false,
            amount         : 0,
            debt_ceiling   : 0,
            last_update    : arg0,
        }
    }

    public(friend) fun set_borrow_amount(arg0: &mut UserBorrowPosition, arg1: u128) {
        assert!(arg1 <= 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::max_u64(), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::overflow());
        arg0.amount = (arg1 as u64);
    }

    public(friend) fun set_borrow_config(arg0: &mut UserBorrowPosition, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig) {
        arg0.config = 0x1::option::some<0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::UserBorrowConfig>(arg1);
    }

    public(friend) fun set_borrow_debt_ceiling(arg0: &mut UserBorrowPosition, arg1: u128) {
        assert!(arg1 <= 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::max_u64(), 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::errors::overflow());
        arg0.debt_ceiling = (arg1 as u64);
    }

    public(friend) fun set_borrow_last_update(arg0: &mut UserBorrowPosition, arg1: 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::TimestampS) {
        arg0.last_update = arg1;
    }

    public(friend) fun set_borrow_pause(arg0: &mut UserBorrowPosition, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::Action, arg2: bool) {
        if (arg1 == 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_borrow()) {
            arg0.paused_borrow = arg2;
        } else {
            assert!(arg1 == 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_payback(), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::admin_module_invalid_params());
            arg0.paused_payback = arg2;
        };
    }

    // decompiled from Move bytecode v7
}

