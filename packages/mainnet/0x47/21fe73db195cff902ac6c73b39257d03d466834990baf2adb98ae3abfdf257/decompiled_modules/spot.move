module 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::spot {
    struct LPFeePercentageUpdated has copy, drop {
        vault: 0x2::object::ID,
        previous_fee_percentage: u64,
        current_fee_percentage: u64,
    }

    struct LPRewardPercentageUpdated has copy, drop {
        vault: 0x2::object::ID,
        previous_reward_percentage: u64,
        current_reward_percentage: u64,
    }

    public entry fun collect_fee<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::ProtocolConfig, arg2: &mut 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::Vault, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::object::ID, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::verify_version(arg1);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::verify_user(arg2, arg7);
        let v0 = 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::get_mutable_id(arg2, arg7);
        let (_, _, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg3, arg4, get_mutable_position_from_df(v0, arg5));
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::utils::transfer_balance<T0>(v3, arg6, arg7);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::utils::transfer_balance<T1>(v4, arg6, arg7);
    }

    public fun collect_reward<T0, T1, T2>(arg0: &0x2::clock::Clock, arg1: &0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::ProtocolConfig, arg2: &mut 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::Vault, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::object::ID, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::verify_version(arg1);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::verify_user(arg2, arg7);
        let v0 = 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::get_mutable_id(arg2, arg7);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::utils::transfer_balance<T2>(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_reward<T0, T1, T2>(arg0, arg3, arg4, get_mutable_position_from_df(v0, arg5)), arg6, arg7);
    }

    public entry fun open_position<T0, T1>(arg0: &0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::ProtocolConfig, arg1: &mut 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::Vault, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: u32, arg5: u32, arg6: &mut 0x2::tx_context::TxContext) {
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::verify_version(arg0);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::verify_user(arg1, arg6);
        let v0 = 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::get_mutable_id(arg1, arg6);
        let v1 = positions_key();
        if (!0x2::dynamic_field::exists_<0x1::string::String>(v0, v1)) {
            0x2::dynamic_field::add<0x1::string::String, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(v0, v1, 0x1::vector::empty<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>());
        };
        0x1::vector::push_back<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x2::dynamic_field::borrow_mut<0x1::string::String, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(v0, v1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::open_position<T0, T1>(arg2, arg3, arg4, arg5, arg6));
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::ProtocolConfig, arg2: &mut 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::Vault, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::object::ID, arg6: u128, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::verify_version(arg1);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::verify_user(arg2, arg9);
        let v0 = 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::get_mutable_id(arg2, arg9);
        let (v1, v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg3, arg4, get_mutable_position_from_df(v0, arg5), arg6, arg0);
        assert!(v1 >= arg7 && v2 >= arg8, 1010);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::return_funds_to_reserves<T0>(arg2, v3, arg9);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::return_funds_to_reserves<T1>(arg2, v4, arg9);
    }

    public entry fun close_position<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::ProtocolConfig, arg2: &mut 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::Vault, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::object::ID, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::verify_version(arg1);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::verify_user(arg2, arg7);
        let v0 = 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::get_mutable_id(arg2, arg7);
        let v1 = remove_position_from_df(v0, arg5);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::liquidity(&v1);
        if (v2 > 0) {
            let (_, _, v5, v6) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::remove_liquidity<T0, T1>(arg3, arg4, &mut v1, v2, arg0);
            0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::return_funds_to_reserves<T0>(arg2, v5, arg7);
            0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::return_funds_to_reserves<T1>(arg2, v6, arg7);
        };
        let (_, _, v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::collect_fee<T0, T1>(arg0, arg3, arg4, &mut v1);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::utils::transfer_balance<T0>(v9, arg6, arg7);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::utils::transfer_balance<T1>(v10, arg6, arg7);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::close_position_v2<T0, T1>(arg0, arg3, arg4, v1);
    }

    fun get_fee_percentage(arg0: &mut 0x2::object::UID) : u64 {
        if (!0x2::dynamic_field::exists_<0x1::string::String>(arg0, lp_fee_percent_key())) {
            10000000
        } else {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(arg0, lp_fee_percent_key())
        }
    }

    fun get_mutable_position_from_df(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) : &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(arg0, positions_key());
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0)) {
            let v2 = 0x1::vector::borrow_mut<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, v1);
            if (0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v2) == arg1) {
                return v2
            };
            v1 = v1 + 1;
        };
        abort 1011
    }

    fun get_reward_percentage(arg0: &mut 0x2::object::UID) : u64 {
        if (!0x2::dynamic_field::exists_<0x1::string::String>(arg0, lp_reward_percent_key())) {
            10000000
        } else {
            *0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(arg0, lp_reward_percent_key())
        }
    }

    fun lp_fee_percent_key() : 0x1::string::String {
        0x1::string::utf8(b"lp_fee_percent")
    }

    fun lp_reward_percent_key() : 0x1::string::String {
        0x1::string::utf8(b"lp_reward_percent")
    }

    fun positions_key() : 0x1::string::String {
        0x1::string::utf8(b"positions")
    }

    public entry fun provide_liquidity_with_fixed_amount<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::ProtocolConfig, arg2: &mut 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::Vault, arg3: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: bool, arg10: &mut 0x2::tx_context::TxContext) {
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::verify_version(arg1);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::verify_user(arg2, arg10);
        let v0 = 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::get_mutable_id(arg2, arg10);
        let (v1, v2, v3, v4) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::add_liquidity_with_fixed_amount<T0, T1>(arg0, arg3, arg4, get_mutable_position_from_df(v0, arg5), 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::request_funds<T0>(arg2, arg7, arg10), 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::request_funds<T1>(arg2, arg8, arg10), arg6, arg9);
        assert!(v1 <= arg7 && v2 <= arg8, 1010);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::return_funds_to_reserves<T0>(arg2, v3, arg10);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::return_funds_to_reserves<T1>(arg2, v4, arg10);
    }

    fun remove_position_from_df(arg0: &mut 0x2::object::UID, arg1: 0x2::object::ID) : 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position {
        let v0 = 0x2::dynamic_field::borrow_mut<0x1::string::String, vector<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>>(arg0, positions_key());
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0)) {
            if (0x2::object::id<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(0x1::vector::borrow<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, v1)) == arg1) {
                return 0x1::vector::remove<0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::position::Position>(v0, v1)
            };
            v1 = v1 + 1;
        };
        abort 1011
    }

    public entry fun set_lp_fee_percent(arg0: &0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::ProtocolConfig, arg1: &mut 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::Vault, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::verify_version(arg0);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::verify_manager(arg1, arg3);
        let v0 = lp_fee_percent_key();
        let v1 = 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::get_mutable_id(arg1, arg3);
        if (!0x2::dynamic_field::exists_<0x1::string::String>(v1, v0)) {
            0x2::dynamic_field::add<0x1::string::String, u64>(v1, v0, 10000000);
        };
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(v1, v0);
        *v2 = arg2;
        let v3 = LPFeePercentageUpdated{
            vault                   : 0x2::object::id<0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::Vault>(arg1),
            previous_fee_percentage : *v2,
            current_fee_percentage  : *v2,
        };
        0x2::event::emit<LPFeePercentageUpdated>(v3);
    }

    public entry fun set_lp_reward_percent(arg0: &0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::ProtocolConfig, arg1: &mut 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::Vault, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::admin::verify_version(arg0);
        0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::verify_manager(arg1, arg3);
        let v0 = lp_reward_percent_key();
        let v1 = 0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::get_mutable_id(arg1, arg3);
        if (!0x2::dynamic_field::exists_<0x1::string::String>(v1, v0)) {
            0x2::dynamic_field::add<0x1::string::String, u64>(v1, v0, 10000000);
        };
        let v2 = 0x2::dynamic_field::borrow_mut<0x1::string::String, u64>(v1, v0);
        *v2 = arg2;
        let v3 = LPRewardPercentageUpdated{
            vault                      : 0x2::object::id<0x4721fe73db195cff902ac6c73b39257d03d466834990baf2adb98ae3abfdf257::vault::Vault>(arg1),
            previous_reward_percentage : *v2,
            current_reward_percentage  : *v2,
        };
        0x2::event::emit<LPRewardPercentageUpdated>(v3);
    }

    // decompiled from Move bytecode v6
}

