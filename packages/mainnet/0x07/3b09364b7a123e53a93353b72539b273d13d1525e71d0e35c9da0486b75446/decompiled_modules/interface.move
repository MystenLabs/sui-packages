module 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::interface {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct INTERFACE has drop {
        dummy_field: bool,
    }

    public fun add_or_remove_coin_type_for_swap<T0>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg3: 0x1::type_name::TypeName, arg4: u8) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::add_or_remove_coin_type_for_swap<T0>(arg2, arg3, arg4);
    }

    public fun admin_change_leverage<T0, T1, T2>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg3: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg6: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::admin_change_leverage<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
    }

    public fun autocompound<T0, T1, T2>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg6: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg7: &mut 0x3::sui_system::SuiSystemState, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        assert!(0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::get_investor_id<T0>(arg2) == 0x2::object::id<0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>>(arg3), 19191);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::autocompound<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::update_last_autocompound_time<T0>(arg2, arg8);
    }

    public fun collect_reward_and_swap_bluefin<T0, T1, T2>(arg0: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: bool, arg7: bool, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg0);
        assert!(0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::get_investor_id<T0>(arg1) == 0x2::object::id<0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>>(arg2), 19191);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::collect_reward_and_swap_bluefin<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    public fun create_investor<T0>(arg0: &AdminCap, arg1: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::vec_map::VecMap<0x1::type_name::TypeName, bool>, arg7: address, arg8: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::create_investor<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
    }

    public fun repay<T0, T1, T2>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg6: 0x2::coin::Coin<T1>, arg7: bool, arg8: u128, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        assert!(0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::get_investor_id<T0>(arg2) == 0x2::object::id<0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>>(arg3), 19191);
        if (arg9) {
            0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::repay<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7, 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::get_withdraw_request_type(), arg8, arg10, arg11);
        } else {
            0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::repay<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7, 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::get_autocompound_request_type(), arg8, arg10, arg11);
        };
    }

    public fun request_etoken_withdrawal_from_free_rewards<T0, T1, T2>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg4: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg5: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        assert!(0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::get_investor_id<T0>(arg2) == 0x2::object::id<0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>>(arg3), 19191);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::request_etoken_withdrawal_from_free_rewards<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7);
    }

    entry fun set_minimum_swap_amount<T0>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg3: u64) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::set_minimum_swap_amount<T0>(arg2, arg3);
    }

    public fun swap_etoken_to_token<T0, T1, T2>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg4: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T1, T2>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: bool, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T2>) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        assert!(0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::get_investor_id<T0>(arg2) == 0x2::object::id<0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>>(arg3), 19191);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::swap_etoken_to_token<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    public fun admin_repay_for_withdrawal<T0, T1, T2>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg6: 0x2::coin::Coin<T1>, arg7: u128, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        assert!(0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::get_investor_id<T0>(arg2) == 0x2::object::id<0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>>(arg3), 19191);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::add_to_claimable<T0>(arg2, 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::withdraw_from_alphalend<T0>(arg3, arg4, 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::admin_repay_for_withdrawal<T0>(arg2, 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::repay_coin_for_withdrawal_and_get_withdrawable_amount<T0, T1, T2>(arg3, arg4, arg5, arg6, arg7, arg9, arg10)), arg8, arg9, arg10));
    }

    entry fun change_fee_address<T0>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: address) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::change_fee_address<T0>(arg2, arg3);
    }

    entry fun change_locking_period<T0>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: u64) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::change_locking_period<T0>(arg2, arg3);
    }

    entry fun collect_fee<T0>(arg0: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg1: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg0);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::collect_fee<T0>(arg1, arg2);
    }

    public fun create_pool<T0>(arg0: &AdminCap, arg1: address, arg2: u64, arg3: 0xff453b038c3259917d74dc4fc69f45b9312c51bb591744f5d2258821b94f81e6::alphafi_receipt::PartnerCap, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::create_pool<T0>(arg1, arg2, arg3, arg4, arg5);
    }

    public fun process_withdraw_requests<T0, T1, T2>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T1, T2>, arg6: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        assert!(0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::get_investor_id<T0>(arg2) == 0x2::object::id<0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>>(arg3), 19191);
        let v0 = 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::process_withdraw_requests<T0>(arg2, 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::total_alpha_safe_to_remove<T0, T1, T2>(arg3, arg4, arg5, arg7));
        if (v0 > 0) {
            0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::request_withdrawal_from_supply_coin<T0, T1, T2>(arg3, arg4, arg5, arg6, v0, arg7, arg8);
        };
    }

    entry fun set_deposit_fee<T0>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: u64) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::set_deposit_fee<T0>(arg2, arg3);
    }

    public fun set_investor_id<T0>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: 0x2::object::ID) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::set_investor_id<T0>(arg2, arg3);
    }

    entry fun set_pause<T0>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: bool, arg4: bool) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::set_pause<T0>(arg2, arg3, arg4);
    }

    entry fun set_withdrawal_fee<T0>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: u64) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::set_withdrawal_fee<T0>(arg2, arg3);
    }

    public fun settle_requests<T0>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        assert!(0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::get_investor_id<T0>(arg2) == 0x2::object::id<0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>>(arg3), 19191);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::add_unsupplied_balance_to_lending<T0>(arg3, arg4, 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::settle_requests<T0>(arg2, arg5), arg5, arg6);
    }

    public fun add_admin(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<AdminCap>(v0, arg1);
    }

    public fun distribute_airdrop<T0, T1>(arg0: &AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg3: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg4: &0x2::clock::Clock) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        assert!(0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::get_investor_id<T0>(arg2) == 0x2::object::id<0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>>(arg3), 19191);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::add_rewards<T0, T1>(arg2, 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::initialize_airdrop<T0, T1>(arg3), arg4);
    }

    fun init(arg0: INTERFACE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun initialize_pool<T0>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::Version, arg2: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::version::Version, arg3: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::Pool<T0>, arg4: &mut 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::Investor<T0>, arg5: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::alphapool::Pool<T0>, arg6: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg7: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::version::assert_current_version(arg1);
        0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_investor::add_unsupplied_balance_to_lending<T0>(arg4, arg7, 0xfb7ebc3cb24e73beb9aac139be74c457544ae4dbb229673a809a1eb0fd159565::alphafi_ember_pool::initialize<T0>(arg0, arg2, arg3, arg5, arg6, arg8, arg9), arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

