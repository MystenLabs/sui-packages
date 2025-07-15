module 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_vault {
    struct Deposited has copy, drop {
        user: address,
        user_id: u64,
        amount_a: u64,
        amount_b: u64,
        amount_a_used: u64,
        amount_b_used: u64,
        tokens_value: u64,
        shares: u64,
        no_score: bool,
    }

    struct Withdrawn has copy, drop {
        user: address,
        user_id: u64,
        tokens_value: u64,
        shares: u64,
        no_score: bool,
    }

    struct ClaimProfit has copy, drop {
        user: address,
        user_id: u64,
        tokens_value: u64,
        claimable_value: u64,
        claimable_profit: u64,
        claimable_reward: u64,
        claimable_compound: u64,
    }

    struct Rebalanced has copy, drop {
        is_core: bool,
        new_lower_tick: u32,
        new_upper_tick: u32,
    }

    public entry fun close_position<T0, T1>(arg0: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::assert_vault_operator(arg0, arg6);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::close_position<T0, T1>(arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun collect_fees<T0, T1>(arg0: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: bool, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::assert_vault_operator(arg0, arg8);
        assert_relactive_three_objects<T0, T1>(arg0, arg1, arg2);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::collect_fees<T0, T1>(arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: bool, arg6: u8, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::assert_vault_operator(arg0, arg9);
        assert_relactive_three_objects<T0, T1>(arg0, arg1, arg2);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::collect_reward<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::transfer_reward<T0, T1>(arg2, arg5);
    }

    public entry fun flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        let (v1, v2) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg2), 0x2::coin::into_balance<T1>(arg3), arg4, arg5, arg6, arg7);
        let v3 = 0x2::coin::from_balance<T1>(v2, arg8);
        let v4 = 0x2::coin::from_balance<T0>(v1, arg8);
        if (0x2::coin::value<T0>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v0);
        } else {
            0x2::coin::destroy_zero<T0>(v4);
        };
        if (0x2::coin::value<T1>(&v3) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v3, v0);
        } else {
            0x2::coin::destroy_zero<T1>(v3);
        };
    }

    public entry fun rebalance<T0, T1>(arg0: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: bool, arg6: u32, arg7: u32, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::assert_vault_operator(arg0, arg9);
        assert_relactive_three_objects<T0, T1>(arg0, arg1, arg2);
        let (v0, v1) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::calculate_reasonable_tick_range<T0, T1>(arg4, arg6, arg7);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::rebalance<T0, T1>(arg2, arg3, arg4, arg5, v0, v1, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::get_slippage_tolerance(arg0), arg8, arg9);
        let v2 = Rebalanced{
            is_core        : arg5,
            new_lower_tick : v0,
            new_upper_tick : v1,
        };
        0x2::event::emit<Rebalanced>(v2);
    }

    public(friend) fun assert_relactive_objects<T0, T1>(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg2: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg3: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>) {
        let (v0, v1, v2) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::relactive_ids(arg0);
        assert!(0x2::object::id<0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser>(arg1) == v0, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_object());
        assert!(0x2::object::id<0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit>(arg2) == v1, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_object());
        assert!(0x2::object::id<0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>>(arg3) == v2, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_object());
    }

    public(friend) fun assert_relactive_three_objects<T0, T1>(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>) {
        let (_, v1, v2) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::relactive_ids(arg0);
        assert!(0x2::object::id<0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit>(arg1) == v1, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_object());
        assert!(0x2::object::id<0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>>(arg2) == v2, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_object());
    }

    public(friend) fun calculate_interest_price<T0, T1>(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u128 {
        let v0 = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::interest_supply(arg0);
        if (v0 == 0) {
            1000000000
        } else {
            let (_, _, _, v5, _, _, v8) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::pool_value<T0, T1>(arg1, arg2, false);
            ((v5 + v8) as u128) * 1000000000 / (v0 as u128)
        }
    }

    public(friend) fun calculate_share_price<T0, T1>(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : u128 {
        let v0 = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::shares_supply(arg0);
        if (v0 == 0) {
            1000000000
        } else {
            let (_, _, _, v5, _, _, v8) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::pool_value<T0, T1>(arg1, arg2, true);
            ((v5 + v8) as u128) * 1000000000 / (v0 as u128)
        }
    }

    public(friend) fun claim_profit<T0, T1>(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg3: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: address, arg7: address, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert_relactive_objects<T0, T1>(arg0, arg2, arg1, arg3);
        let (v0, v1, v2) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::claim_profit_prepare(arg1, arg6, arg9);
        let v3 = v0 + v1 + v2;
        let v4 = calculate_interest_price<T0, T1>(arg1, arg3, arg5);
        let v5 = interest_to_value(v3, v4);
        assert!(v5 > 0, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::zero_profit());
        let (v6, v7) = process_withdraw<T0, T1>(arg0, arg3, arg4, arg5, false, v5, arg9, arg10);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::claim_profit_success(arg1, arg6, v3, arg9);
        let (v8, v9) = transfer_to_user<T0, T1>(arg0, arg2, arg4, arg5, arg7, v6, v7, arg8, arg9, arg10);
        if (v0 + v1 > 0) {
            0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::update_user_stats(arg2, arg6, v9, (((v9 as u128) * (v1 as u128) / ((v0 + v1) as u128)) as u64));
        };
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::update_active_time(arg2, arg6, arg9);
        let v10 = ClaimProfit{
            user               : arg7,
            user_id            : v8,
            tokens_value       : v9,
            claimable_value    : v5,
            claimable_profit   : v0,
            claimable_reward   : v1,
            claimable_compound : v2,
        };
        0x2::event::emit<ClaimProfit>(v10);
    }

    public entry fun collect_reward_for_b<T0, T1, T2>(arg0: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: bool, arg6: u8, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::rewarder::RewarderGlobalVault, arg8: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::assert_vault_operator(arg0, arg10);
        assert_relactive_three_objects<T0, T1>(arg0, arg1, arg2);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::collect_reward<T0, T1, T2>(arg2, arg3, arg4, arg5, arg6, arg7, arg9);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::swap_c_for_b<T0, T1, T2>(arg2, arg3, arg8, arg5, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::get_slippage_tolerance(arg0), arg9);
    }

    public entry fun fix_profit_shares(arg0: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::assert_vault_operator(arg0, arg2);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::fix_profit_shares(arg1);
    }

    public entry fun fix_shares(arg0: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::assert_vault_operator(arg0, arg1);
        if (!0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::fix_shares(arg0)) {
            0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::deposit_pause(arg0);
        };
    }

    public(friend) fun interest_to_value(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / 1000000000) as u64)
    }

    public entry fun new_vault<T0, T1>(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::assert_vault_admin(arg0, arg3);
        assert!(arg2 >= 0 && arg2 <= 1000, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_value());
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::create_vault(0x2::object::id<0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser>(arg0), 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::create_vault_profit(arg3), 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::create_cetus_manager<T0, T1>(arg1, arg3), arg2, arg3);
    }

    fun process_deposit<T0, T1>(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: &mut 0x2::balance::Balance<T0>, arg5: &mut 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (u64, u64, u64, u64, u64) {
        let v0 = calculate_share_price<T0, T1>(arg0, arg1, arg3);
        let v1 = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::borrow_position_manager_mut<T0, T1>(arg1, true);
        let (v2, v3) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::adjust_balance<T0, T1>(v1, arg2, arg3, arg4, arg5, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::get_slippage_tolerance(arg0), arg6);
        assert!(v2 >= 0 && v3 >= 0, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_amount());
        let (v4, v5, v6) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::add_liquidity<T0, T1>(v1, arg2, arg3, arg4, arg5, arg6, arg7);
        (v2, v3, v5, v6, value_to_shares(v4, v0))
    }

    public(friend) fun process_withdraw<T0, T1>(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: bool, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, _, _, v3, _, _, v6) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::pool_value<T0, T1>(arg1, arg3, arg4);
        assert!(arg5 <= v3 + v6, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_value());
        if (arg5 > v6 && v3 > 0) {
            let v7 = if (arg5 >= v3) {
                v0
            } else {
                (((v0 as u256) * (arg5 as u256) / (v3 as u256)) as u128)
            };
            let (_, v9, v10) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::remove_liquidity<T0, T1>(0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::borrow_position_manager_mut<T0, T1>(arg1, arg4), arg2, arg3, v7, arg6);
            let (v11, v12) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::borrow_balances_mut<T0, T1>(arg1, arg4);
            0x2::balance::join<T0>(v11, v9);
            0x2::balance::join<T1>(v12, v10);
        };
        let (v13, v14) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::borrow_balances_mut<T0, T1>(arg1, arg4);
        let v15 = 0x2::balance::value<T0>(v13);
        let v16 = 0x2::balance::value<T1>(v14);
        let v17 = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::tokens_value<T0, T1>(arg3, v15, v16);
        let v18 = if (arg5 > v17) {
            v17
        } else {
            arg5
        };
        (0x2::balance::split<T0>(v13, (((v15 as u128) * (v18 as u128) / (v17 as u128)) as u64)), 0x2::balance::split<T1>(v14, (((v16 as u128) * (v18 as u128) / (v17 as u128)) as u64)))
    }

    public entry fun recover_profit(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::AdminCap, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::get_user_address(arg2, arg3);
        let v1 = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::get_user_address(arg2, arg4);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::recover_profit_shares(arg0, arg1, arg2, v0, v1, arg5);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::recover_interest(arg0, arg1, arg2, v0, v1, arg5);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::recover_user(arg0, arg2, v0, v1, arg5);
    }

    public entry fun recover_shares(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::AdminCap, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::recover_shares(arg0, arg1, arg2, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::get_user_address(arg2, arg3), 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::get_user_address(arg2, arg4), arg5);
    }

    public entry fun recover_user(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::AdminCap, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::recover_user(arg0, arg1, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::get_user_address(arg1, arg2), 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::get_user_address(arg1, arg3), arg4);
    }

    public entry fun refund_principal<T0, T1>(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::AdminCap, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg3: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg4: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u64, arg8: u8, arg9: bool, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::get_user_address(arg3, arg7);
        assert!(!0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::is_account_locked(arg3, v0), 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::account_locked());
        withdraw<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, v0, v0, arg8, true, arg9, arg10, arg11);
    }

    public entry fun refund_profit<T0, T1>(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::AdminCap, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg3: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg4: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg6: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::get_user_address(arg3, arg7);
        assert!(!0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::is_account_locked(arg3, v0), 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::account_locked());
        claim_profit<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, v0, v0, true, arg8, arg9);
    }

    public(friend) fun shares_to_value(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / 1000000000) as u64)
    }

    public(friend) fun transfer_to_user<T0, T1>(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: address, arg5: 0x2::balance::Balance<T0>, arg6: 0x2::balance::Balance<T1>, arg7: bool, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        assert!(arg4 != @0x2012 && arg4 != @0x0, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_user());
        let v0 = 0x2::balance::value<T0>(&arg5);
        let (v1, v2) = if (arg7) {
            let (v3, v4) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::flash_swap<T0, T1>(arg2, arg3, arg5, arg6, true, v0, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::get_slippage_tolerance(arg0), arg8);
            (0x2::coin::from_balance<T0>(v3, arg9), 0x2::coin::from_balance<T1>(v4, arg9))
        } else {
            (0x2::coin::from_balance<T0>(arg5, arg9), 0x2::coin::from_balance<T1>(arg6, arg9))
        };
        let v5 = v2;
        let v6 = v1;
        if (0x2::coin::value<T0>(&v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v6, arg4);
        } else {
            0x2::coin::destroy_zero<T0>(v6);
        };
        if (0x2::coin::value<T1>(&v5) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, arg4);
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        (0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::user_id(arg1, arg4), 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::tokens_value<T0, T1>(arg3, v0, 0x2::balance::value<T1>(&arg6)))
    }

    public entry fun update_deposit_pause(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::assert_vault_admin(arg0, arg3);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::update_deposit_pause(arg1, arg2, arg3);
    }

    public entry fun update_interest<T0, T1>(arg0: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg5: bool, arg6: u8, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::assert_vault_operator(arg0, arg8);
        assert_relactive_three_objects<T0, T1>(arg0, arg1, arg2);
        let (v0, _, _) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::fees_add_liquidity<T0, T1>(arg2, arg3, arg4, arg5, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::get_slippage_tolerance(arg0), arg7, arg8);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::update_epoch_interest(arg1, value_to_interest(v0, calculate_interest_price<T0, T1>(arg1, arg2, arg4)), arg5, arg6, 0x2::clock::timestamp_ms(arg7));
    }

    public entry fun user_claim_profit<T0, T1>(arg0: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg3: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg8);
        assert!(!0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::is_account_locked(arg2, v0), 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::account_locked());
        let v1 = if (0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::is_developer(arg0, arg8)) {
            @0x2012
        } else {
            v0
        };
        claim_profit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v1, v0, arg6, arg7, arg8);
    }

    public entry fun user_deposit<T0, T1>(arg0: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg3: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: 0x2::coin::Coin<T0>, arg7: 0x2::coin::Coin<T1>, arg8: u64, arg9: u64, arg10: u64, arg11: bool, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        assert!(!0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::get_is_deposit_paused(arg0), 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::deposit_paused());
        assert_relactive_objects<T0, T1>(arg0, arg2, arg1, arg3);
        assert!(arg8 > 0 || arg9 > 0, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_deposit_amount());
        let v0 = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::tokens_value<T0, T1>(arg5, arg8, arg9);
        let (v1, v2) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::get_deposit_range(arg0);
        assert!(v0 >= v1 && v0 <= v2, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_deposit_amount());
        let v3 = 0x2::coin::into_balance<T0>(arg6);
        let v4 = 0x2::coin::into_balance<T1>(arg7);
        assert!(0x2::balance::value<T0>(&v3) >= arg8, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::insufficient_funds());
        assert!(0x2::balance::value<T1>(&v4) >= arg9, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::insufficient_funds());
        let v5 = if (arg8 > 0) {
            0x2::balance::split<T0>(&mut v3, arg8)
        } else {
            0x2::balance::zero<T0>()
        };
        let v6 = v5;
        let v7 = if (arg9 > 0) {
            0x2::balance::split<T1>(&mut v4, arg9)
        } else {
            0x2::balance::zero<T1>()
        };
        let v8 = v7;
        let v9 = &mut v6;
        let v10 = &mut v8;
        let (v11, v12, v13, v14, v15) = process_deposit<T0, T1>(arg0, arg3, arg4, arg5, v9, v10, arg12, arg13);
        let v16 = 0x2::tx_context::sender(arg13);
        let v17 = 0x2::clock::timestamp_ms(arg12);
        let (v18, v19, v20, v21) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::update_vault_shares(arg0, arg2, v16, v15, true, v17);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::update_profit_shares(arg1, arg2, v16, v18, v19, v20, v21, true, v17);
        if (0x2::balance::join<T0>(&mut v3, v6) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg13), v16);
        } else {
            0x2::balance::destroy_zero<T0>(v3);
        };
        if (0x2::balance::join<T1>(&mut v4, v8) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v4, arg13), v16);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
        if (!arg11) {
            let (v22, v23, v24, v25) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::update_user_score(arg2, v16, v15, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::get_vault_weight(arg0), true);
            0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::update_referrers_shares(arg1, arg2, v16, v22, v23, v24, v25, true, v17);
        };
        let v26 = Deposited{
            user          : v16,
            user_id       : 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::register_user(arg2, v16, arg10, arg12),
            amount_a      : v11,
            amount_b      : v12,
            amount_a_used : v13,
            amount_b_used : v14,
            tokens_value  : v0,
            shares        : v15,
            no_score      : arg11,
        };
        0x2::event::emit<Deposited>(v26);
    }

    public entry fun user_withdraw<T0, T1>(arg0: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg3: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: u8, arg7: bool, arg8: bool, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        assert!(!0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::is_principal_locked(arg2, v0), 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::principal_locked());
        assert!(!0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::is_account_locked(arg2, v0), 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::account_locked());
        let v1 = if (0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::is_developer(arg0, arg10)) {
            @0x2012
        } else {
            0x2::tx_context::sender(arg10)
        };
        withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, v1, v0, arg6, arg7, arg8, arg9, arg10);
    }

    public(friend) fun value_to_interest(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * 1000000000 / arg1) as u64)
    }

    public(friend) fun value_to_shares(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * 1000000000 / arg1) as u64)
    }

    public entry fun vault_prices<T0, T1>(arg0: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>) : (u128, u128, u128, u128, u128) {
        let v0 = calculate_share_price<T0, T1>(arg0, arg2, arg3);
        let v1 = calculate_interest_price<T0, T1>(arg1, arg2, arg3);
        let (v2, v3, v4) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::current_price_range<T0, T1>(arg2, arg3, true);
        (v2, v3, v4, v0, v1)
    }

    public(friend) fun withdraw<T0, T1>(arg0: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::Vault, arg1: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::VaultProfit, arg2: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::VaultUser, arg3: &mut 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::cetus_manager::CetusManager<T0, T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg6: address, arg7: address, arg8: u8, arg9: bool, arg10: bool, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_relactive_objects<T0, T1>(arg0, arg2, arg1, arg3);
        assert!(arg8 > 0 && arg8 <= 100, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_withdrawal_amount());
        assert!(arg7 == arg6 || 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::is_developer(arg0, arg12) && arg6 == @0x2012, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::invalid_user());
        let (v0, _, _, _, _) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::user_shares(arg0, arg6);
        let v5 = (((v0 as u128) * (arg8 as u128) / 100) as u64);
        assert!(v5 > 0, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::errors::zero_withdrawal());
        let v6 = calculate_share_price<T0, T1>(arg0, arg3, arg5);
        let (v7, v8) = process_withdraw<T0, T1>(arg0, arg3, arg4, arg5, true, shares_to_value(v5, v6), arg11, arg12);
        let v9 = 0x2::clock::timestamp_ms(arg11);
        let (v10, v11, v12, v13) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::update_vault_shares(arg0, arg2, arg6, v5, false, v9);
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::update_profit_shares(arg1, arg2, arg6, v10, v11, v12, v13, false, v9);
        let (v14, v15) = transfer_to_user<T0, T1>(arg0, arg2, arg4, arg5, arg7, v7, v8, arg9, arg11, arg12);
        if (!arg10) {
            let (v16, v17, v18, v19) = 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::update_user_score(arg2, arg6, v5, 0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_core::get_vault_weight(arg0), false);
            0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_profit::update_referrers_shares(arg1, arg2, arg6, v16, v17, v18, v19, false, v9);
        };
        0x8c60507737c396fa7298eaff6ff999acec1b9d9cc1ce48e095265db7c4288e9c::vault_user::update_active_time(arg2, arg6, arg11);
        let v20 = Withdrawn{
            user         : arg7,
            user_id      : v14,
            tokens_value : v15,
            shares       : v5,
            no_score     : arg10,
        };
        0x2::event::emit<Withdrawn>(v20);
    }

    // decompiled from Move bytecode v6
}

