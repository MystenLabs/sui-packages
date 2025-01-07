module 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct PoolCreateEvent has copy, drop, store {
        pool_id: 0x2::object::ID,
    }

    struct SwapTokenEvent<phantom T0, phantom T1> has copy, drop {
        pool_index: u64,
        x_to_y: bool,
        in_amount: u64,
        out_amount: u64,
    }

    struct LiquidityEvent<phantom T0, phantom T1> has copy, drop {
        pool_index: u64,
        is_added: bool,
        x_amount: u64,
        y_amount: u64,
        lsp_amount: u64,
        lsp_id: 0x2::object::ID,
    }

    struct SnapshotEvent<phantom T0, phantom T1> has copy, drop, store {
        pool_index: u64,
        x: u64,
        y: u64,
        lsp: u64,
    }

    struct SwapCap has key {
        id: 0x2::object::UID,
        registry_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct PoolCreateInfo has copy, drop, store {
        pool_id: 0x2::object::ID,
        reverse: bool,
    }

    struct PoolCreateInfoKey<phantom T0, phantom T1> has copy, drop, store {
        dummy_field: bool,
    }

    struct LSP<phantom T0, phantom T1> has drop {
        dummy_field: bool,
    }

    struct PoolNoAdminSetupInfo has store {
        allowance: bool,
        fee_direction: u8,
        admin_fee: u64,
        lp_fee: u64,
        th_fee: u64,
        withdraw_fee: u64,
    }

    struct PoolBoostMultiplierData has copy, drop, store {
        epoch: u64,
        boost_multiplier: u64,
    }

    struct PoolRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        pool_counter: u64,
        pool_no_admin: PoolNoAdminSetupInfo,
        pool_th_reward_nepoch: u64,
        pool_boost_multiplier_data: vector<PoolBoostMultiplierData>,
    }

    struct PoolTotalTradeInfo has store {
        x: u128,
        y: u128,
        x_last_epoch: u128,
        y_last_epoch: u128,
        x_current_epoch: u128,
        y_current_epoch: u128,
    }

    struct PoolTokenHolderRewardInfo<phantom T0, phantom T1> has store {
        type: u8,
        x: 0x2::balance::Balance<T0>,
        y: 0x2::balance::Balance<T1>,
        x_supply: u64,
        y_supply: u64,
        nepoch: u64,
        start_epcoh: u64,
        end_epoch: u64,
        total_stake_amount: u64,
        total_stake_boost: u128,
    }

    struct PoolLiquidityMiningInfo has store {
        permission: 0x1::option::Option<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::permission::Permission<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenBank>>,
        speed: u256,
        ampt: 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::vpt::ValuePerToken,
        last_epoch: u64,
    }

    struct PoolFeeInfo has store {
        direction: u8,
        admin: u64,
        lp: u64,
        th: u64,
        withdraw: u64,
    }

    struct PoolBalanceInfo<phantom T0, phantom T1> has store {
        x: 0x2::balance::Balance<T0>,
        y: 0x2::balance::Balance<T1>,
        x_admin: 0x2::balance::Balance<T0>,
        y_admin: 0x2::balance::Balance<T1>,
        x_th: 0x2::balance::Balance<T0>,
        y_th: 0x2::balance::Balance<T1>,
        bx: u64,
        by: u64,
    }

    struct PoolStableInfo has store {
        amp: u64,
        x_scale: u64,
        y_scale: u64,
    }

    struct Pool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        index: u64,
        pool_type: u8,
        lsp_supply: u64,
        freeze: u8,
        trade_epoch: u64,
        boost_multiplier_data: vector<PoolBoostMultiplierData>,
        fee: PoolFeeInfo,
        stable: PoolStableInfo,
        balance: PoolBalanceInfo<T0, T1>,
        total_trade: PoolTotalTradeInfo,
        th_reward: PoolTokenHolderRewardInfo<T0, T1>,
        mining: PoolLiquidityMiningInfo,
    }

    struct PoolLsp<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        pool_id: 0x2::object::ID,
        value: u64,
        pool_x: u64,
        pool_y: u64,
        pool_lsp: u64,
        pool_mining_ampt: 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::vpt::ValuePerToken,
        start_epoch: u64,
        end_epoch: u64,
        boost_multiplier: u64,
    }

    fun abs_sub(arg0: u256, arg1: u256) : u256 {
        if (arg0 < arg1) {
            arg1 - arg0
        } else {
            arg0 - arg1
        }
    }

    public entry fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        do_add_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    public entry fun add_liquidity_all<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::merge_coins<T0>(arg1, arg5);
        let v1 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::merge_coins<T1>(arg2, arg5);
        do_add_liquidity<T0, T1>(arg0, 0x1::vector::singleton<0x2::coin::Coin<T0>>(v0), 0x1::vector::singleton<0x2::coin::Coin<T1>>(v1), 0x2::coin::value<T0>(&v0), 0x2::coin::value<T1>(&v1), arg3, arg4, arg5);
    }

    fun add_liquidity_direct_impl<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: bool, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : PoolLsp<T0, T1> {
        assert!(arg0.version == 0, 200000);
        if (0x2::tx_context::sender(arg8) != arg0.owner) {
            assert!(arg0.freeze & 2 == 0, 134010);
        };
        let v0 = 0x2::coin::into_balance<T0>(0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::merge_coins<T0>(arg1, arg8));
        let v1 = 0x2::coin::into_balance<T1>(0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::merge_coins<T1>(arg2, arg8));
        assert!(0x2::balance::value<T0>(&v0) >= arg3, 134008);
        assert!(0x2::balance::value<T1>(&v1) >= arg4, 134008);
        update_pool_mining<T0, T1>(arg0, arg7);
        let v2 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::get_epoch(arg7);
        let v3 = v2 + arg5;
        let v4 = 10;
        if (v3 > v2) {
            let v5 = 0;
            let v6 = 0x1::vector::length<PoolBoostMultiplierData>(&arg0.boost_multiplier_data);
            while (v5 < v6) {
                let v7 = 0x1::vector::borrow<PoolBoostMultiplierData>(&arg0.boost_multiplier_data, v5);
                if (v7.epoch == arg5) {
                    v4 = v7.boost_multiplier;
                    break
                };
                v5 = v5 + 1;
            };
            assert!(v5 < v6, 134018);
        };
        let v8 = 0x2::tx_context::sender(arg8);
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::transfer_or_destroy_zero<T0>(0x2::coin::from_balance<T0>(v0, arg8), v8);
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::transfer_or_destroy_zero<T1>(0x2::coin::from_balance<T1>(v1, arg8), v8);
        let (v9, v10, v11) = get_amounts<T0, T1>(arg0);
        let v12 = if (v11 > 0) {
            if (arg0.pool_type == 100) {
                if (arg6) {
                    compute_deposit_allow_price_move(arg3, arg4, v9, v10, v11)
                } else {
                    compute_deposit(arg3, arg4, v9, v10, v11)
                }
            } else {
                compute_deposit_stable(arg3, arg4, v9, v10, v11, arg0.stable.x_scale, arg0.stable.y_scale, arg0.stable.amp)
            }
        } else {
            0x2::math::sqrt(v9 + arg3) * 0x2::math::sqrt(v10 + arg4)
        };
        0x2::balance::join<T0>(&mut arg0.balance.x, 0x2::balance::split<T0>(&mut v0, arg3));
        0x2::balance::join<T1>(&mut arg0.balance.y, 0x2::balance::split<T1>(&mut v1, arg4));
        let v13 = increase_lsp_supply<T0, T1>(arg0, v12, v2, v3, v4, arg8);
        let v14 = LiquidityEvent<T0, T1>{
            pool_index : arg0.index,
            is_added   : true,
            x_amount   : arg3,
            y_amount   : arg4,
            lsp_amount : v12,
            lsp_id     : 0x2::object::uid_to_inner(&v13.id),
        };
        0x2::event::emit<LiquidityEvent<T0, T1>>(v14);
        v13
    }

    public entry fun change_fee<T0, T1>(arg0: &SwapCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        do_change_fee<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun change_pool_mining_speed<T0, T1>(arg0: &SwapCap, arg1: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenCap, arg2: &mut Pool<T0, T1>, arg3: u64) {
        do_change_pool_mining_speed<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun claim_th_reward<T0, T1>(arg0: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenFarm, arg1: &mut 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::StakedToken, arg2: &mut Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        do_claim_th_reward<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    fun claim_th_reward_impl<T0, T1>(arg0: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenFarm, arg1: &mut 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::StakedToken, arg2: &mut Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        assert!(arg2.version == 0, 200000);
        assert!(arg2.th_reward.type == 210, 134022);
        let v0 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::get_epoch(arg3);
        update_th_reward_impl<T0, T1>(arg0, arg2, v0);
        let v1 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::staked_token_pop_data<u64, u64>(arg1, arg2.index);
        if (0x1::option::get_with_default<u64>(&v1, 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::staked_token_get_start_epoch(arg1)) >= arg2.th_reward.start_epcoh) {
            return 134017
        };
        let v2 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::staked_token_get_boost(arg1);
        let v3 = arg2.th_reward.total_stake_boost;
        let v4 = v3;
        if (v3 == 0) {
            v2 = 0;
            v4 = 1;
        };
        let v5 = 0x2::tx_context::sender(arg4);
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::transfer_or_destroy_zero<T0>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg2.th_reward.x, ((v2 * (arg2.th_reward.x_supply as u128) / v4) as u64)), arg4), v5);
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::transfer_or_destroy_zero<T1>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg2.th_reward.y, ((v2 * (arg2.th_reward.y_supply as u128) / v4) as u64)), arg4), v5);
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::staked_token_add_data<u64, u64>(arg1, arg2.index, v0);
        0
    }

    fun collect_admin_and_th_fee_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>) {
        if (arg0.fee.direction == 200) {
            let v0 = collect_fee<T0>(arg1, arg0.fee.admin);
            0x2::balance::join<T0>(&mut arg0.balance.x_admin, v0);
            0x2::balance::join<T0>(&mut arg0.balance.x_th, collect_fee<T0>(arg1, arg0.fee.th));
        };
    }

    fun collect_admin_and_th_fee_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T1>) {
        if (arg0.fee.direction == 201) {
            let v0 = collect_fee<T1>(arg1, arg0.fee.admin);
            0x2::balance::join<T1>(&mut arg0.balance.y_admin, v0);
            0x2::balance::join<T1>(&mut arg0.balance.y_th, collect_fee<T1>(arg1, arg0.fee.th));
        };
    }

    fun collect_fee<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::split_partial_balance<T0>(arg0, 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::ratio::ratio(arg1, 10000))
    }

    fun collect_withdraw_fee<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::balance::Balance<T1>) {
        let v0 = arg0.fee.withdraw;
        0x2::balance::join<T0>(&mut arg0.balance.x_admin, collect_fee<T0>(arg1, v0));
        0x2::balance::join<T1>(&mut arg0.balance.y_admin, collect_fee<T1>(arg2, v0));
    }

    fun compute_amount(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128);
        let v1 = (arg1 as u128);
        let v2 = (arg2 as u128);
        let v3 = v2 * v0 / (v1 + v0);
        assert!(v3 <= 18446744073709551615, 134005);
        assert!((v1 + v0) * (v2 - v3) >= v1 * v2, 134006);
        (v3 as u64)
    }

    fun compute_amount_stable(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        let v0 = (arg3 as u256);
        let v1 = (arg4 as u256);
        ((ss_swap_to((arg0 as u256) * v0, (arg1 as u256) * v0, (arg2 as u256) * v1, (arg5 as u256)) / v1) as u64)
    }

    fun compute_deposit(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg0 as u128) * (arg4 as u128) / (arg2 as u128);
        let v1 = (arg1 as u128) * (arg4 as u128) / (arg3 as u128);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        (v2 as u64)
    }

    fun compute_deposit_allow_price_move(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = (arg4 as u256);
        (0x2::math::sqrt_u128(((((arg2 + arg0) as u256) * ((arg3 + arg1) as u256) * v0 * v0 / (arg2 as u256) * (arg3 as u256)) as u128)) as u64) - arg4
    }

    fun compute_deposit_stable(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : u64 {
        let v0 = (arg5 as u256);
        let v1 = (arg6 as u256);
        (ss_compute_mint_amount_for_deposit((arg0 as u256) * v0, (arg1 as u256) * v1, (arg2 as u256) * v0, (arg3 as u256) * v1, (arg4 as u256), (arg7 as u256)) as u64)
    }

    fun compute_withdraw(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        ((((arg0 as u128) * (arg3 as u128) / (arg2 as u128)) as u64), (((arg1 as u128) * (arg3 as u128) / (arg2 as u128)) as u64))
    }

    fun compute_withdraw_stable(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : (u64, u64) {
        let v0 = (arg4 as u256);
        let v1 = (arg5 as u256);
        let (v2, v3) = ss_compute_withdraw((arg3 as u256), (arg2 as u256), (arg0 as u256) * v0, (arg1 as u256) * v1, (arg6 as u256));
        (((v2 / v0) as u64), ((v3 / v1) as u64))
    }

    public entry fun create_pool<T0, T1>(arg0: &SwapCap, arg1: &mut PoolRegistry, arg2: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenFarm, arg3: u8, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: u8, arg13: u64, arg14: u64, arg15: u8, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        do_create_pool<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    fun create_pool_impl<T0, T1>(arg0: &mut PoolRegistry, arg1: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenFarm, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u8, arg11: u8, arg12: u64, arg13: u64, arg14: u8, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 == 200 || arg4 == 201, 13400);
        assert!(arg2 == 100 || arg2 == 101, 13400);
        assert!(arg3 == 210 || arg3 == 211, 13400);
        assert!(arg6 + arg5 + arg7 < 10000, 134001);
        let v0 = PoolCreateInfoKey<T0, T1>{dummy_field: false};
        let v1 = PoolCreateInfoKey<T1, T0>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<PoolCreateInfoKey<T0, T1>>(&mut arg0.id, v0) == false && 0x2::dynamic_field::exists_<PoolCreateInfoKey<T1, T0>>(&mut arg0.id, v1) == false, 134013);
        let v2 = 0x2::object::new(arg16);
        let v3 = 0x2::object::uid_to_inner(&v2);
        arg0.pool_counter = arg0.pool_counter + 1;
        let v4 = 0;
        let v5 = 0;
        if (arg2 == 101) {
            assert!(arg10 <= 18 && arg11 <= 18, 134014);
            assert!(arg9 >= 1 && arg9 <= 1000000, 13400);
            if (arg10 < arg11) {
                v4 = 0x2::math::pow(10, arg11 - arg10);
                v5 = 1;
            } else {
                v4 = 1;
                v5 = 0x2::math::pow(10, arg10 - arg11);
            };
        };
        let v6 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::get_epoch(arg15);
        let v7 = arg0.pool_th_reward_nepoch;
        let (v8, v9) = get_th_reward_start_and_end_epoch(v6, v7);
        let v10 = PoolFeeInfo{
            direction : arg4,
            admin     : arg5,
            lp        : arg6,
            th        : arg7,
            withdraw  : arg8,
        };
        let v11 = PoolStableInfo{
            amp     : arg9,
            x_scale : v4,
            y_scale : v5,
        };
        let v12 = PoolBalanceInfo<T0, T1>{
            x       : 0x2::balance::zero<T0>(),
            y       : 0x2::balance::zero<T1>(),
            x_admin : 0x2::balance::zero<T0>(),
            y_admin : 0x2::balance::zero<T1>(),
            x_th    : 0x2::balance::zero<T0>(),
            y_th    : 0x2::balance::zero<T1>(),
            bx      : arg12,
            by      : arg13,
        };
        let v13 = PoolTotalTradeInfo{
            x               : 0,
            y               : 0,
            x_last_epoch    : 0,
            y_last_epoch    : 0,
            x_current_epoch : 0,
            y_current_epoch : 0,
        };
        let v14 = PoolTokenHolderRewardInfo<T0, T1>{
            type               : arg3,
            x                  : 0x2::balance::zero<T0>(),
            y                  : 0x2::balance::zero<T1>(),
            x_supply           : 0,
            y_supply           : 0,
            nepoch             : v7,
            start_epcoh        : v8,
            end_epoch          : v9,
            total_stake_amount : 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::token_farm_get_total_stake_amount(arg1),
            total_stake_boost  : 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::token_farm_get_total_stake_boost(arg1),
        };
        let v15 = PoolLiquidityMiningInfo{
            permission : 0x1::option::none<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::permission::Permission<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenBank>>(),
            speed      : 0,
            ampt       : 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::vpt::zero(),
            last_epoch : v6 + 1,
        };
        let v16 = Pool<T0, T1>{
            id                    : v2,
            version               : 0,
            owner                 : 0x2::tx_context::sender(arg16),
            index                 : arg0.pool_counter,
            pool_type             : arg2,
            lsp_supply            : 0,
            freeze                : arg14,
            trade_epoch           : v6,
            boost_multiplier_data : arg0.pool_boost_multiplier_data,
            fee                   : v10,
            stable                : v11,
            balance               : v12,
            total_trade           : v13,
            th_reward             : v14,
            mining                : v15,
        };
        let v17 = &mut v16;
        do_update_th_reward<T0, T1>(arg1, v17, arg15, arg16);
        let v18 = PoolCreateInfoKey<T0, T1>{dummy_field: false};
        let v19 = PoolCreateInfo{
            pool_id : v3,
            reverse : false,
        };
        0x2::dynamic_field::add<PoolCreateInfoKey<T0, T1>, PoolCreateInfo>(&mut arg0.id, v18, v19);
        let v20 = PoolCreateInfoKey<T1, T0>{dummy_field: false};
        let v21 = PoolCreateInfo{
            pool_id : v3,
            reverse : true,
        };
        0x2::dynamic_field::add<PoolCreateInfoKey<T1, T0>, PoolCreateInfo>(&mut arg0.id, v20, v21);
        0x2::transfer::share_object<Pool<T0, T1>>(v16);
        let v22 = PoolCreateEvent{pool_id: v3};
        0x2::event::emit<PoolCreateEvent>(v22);
    }

    public entry fun create_pool_no_admin<T0, T1>(arg0: &mut PoolRegistry, arg1: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenFarm, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_create_pool_no_admin<T0, T1>(arg0, arg1, arg2, arg3);
    }

    public entry fun create_registry(arg0: &mut SwapCap, arg1: u64, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        do_create_registry(arg0, arg1, arg2, arg3);
    }

    fun destroy_zero_lsp<T0, T1>(arg0: PoolLsp<T0, T1>) {
        assert!(arg0.value == 0, 13400);
        let PoolLsp {
            id               : v0,
            pool_id          : _,
            value            : _,
            pool_x           : _,
            pool_y           : _,
            pool_lsp         : _,
            pool_mining_ampt : _,
            start_epoch      : _,
            end_epoch        : _,
            boost_multiplier : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun do_add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = do_add_liquidity_direct<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7);
        0x2::transfer::transfer<PoolLsp<T0, T1>>(v0, 0x2::tx_context::sender(arg7));
    }

    public fun do_add_liquidity_admin<T0, T1>(arg0: &SwapCap, arg1: &mut Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = do_add_liquidity_direct_admin<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8);
        0x2::transfer::transfer<PoolLsp<T0, T1>>(v0, 0x2::tx_context::sender(arg8));
    }

    public fun do_add_liquidity_direct<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: vector<0x2::coin::Coin<T1>>, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : PoolLsp<T0, T1> {
        add_liquidity_direct_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, false, arg6, arg7)
    }

    public fun do_add_liquidity_direct_admin<T0, T1>(arg0: &SwapCap, arg1: &mut Pool<T0, T1>, arg2: vector<0x2::coin::Coin<T0>>, arg3: vector<0x2::coin::Coin<T1>>, arg4: u64, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : PoolLsp<T0, T1> {
        let v0 = get_k2_per_lsp<T0, T1>(arg1);
        let v1 = add_liquidity_direct_impl<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, true, arg7, arg8);
        assert!(get_k2_per_lsp<T0, T1>(arg1) >= v0, 134006);
        v1
    }

    public fun do_change_basis<T0, T1>(arg0: &SwapCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        arg1.balance.bx = arg2;
        arg1.balance.by = arg3;
    }

    public fun do_change_fee<T0, T1>(arg0: &SwapCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        let v0 = if (arg2 == 18446744073709551615) {
            arg1.fee.admin
        } else {
            arg2
        };
        let v1 = if (arg3 == 18446744073709551615) {
            arg1.fee.lp
        } else {
            arg3
        };
        let v2 = if (arg4 == 18446744073709551615) {
            arg1.fee.th
        } else {
            arg4
        };
        assert!(v1 + v0 + v2 < 10000, 134001);
        arg1.fee.lp = v1;
        arg1.fee.admin = v0;
        arg1.fee.th = v2;
    }

    public fun do_change_owner<T0, T1>(arg0: &SwapCap, arg1: &mut Pool<T0, T1>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.owner = arg2;
    }

    public fun do_change_pool_mining_speed<T0, T1>(arg0: &SwapCap, arg1: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenCap, arg2: &mut Pool<T0, T1>, arg3: u64) {
        assert!(arg2.version == 0, 200000);
        arg2.mining.speed = (arg3 as u256);
        if (0x1::option::is_none<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::permission::Permission<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenBank>>(&arg2.mining.permission)) {
            0x1::option::fill<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::permission::Permission<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenBank>>(&mut arg2.mining.permission, 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::token_cap_cp_token_bank_permission(arg1));
        };
    }

    public fun do_claim_th_reward<T0, T1>(arg0: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenFarm, arg1: &mut 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::StakedToken, arg2: &mut Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = claim_th_reward_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        assert!(v0 == 0, v0);
    }

    public fun do_create_pool<T0, T1>(arg0: &SwapCap, arg1: &mut PoolRegistry, arg2: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenFarm, arg3: u8, arg4: u8, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u8, arg12: u8, arg13: u64, arg14: u64, arg15: u8, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        create_pool_impl<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17);
    }

    public fun do_create_pool_no_admin<T0, T1>(arg0: &mut PoolRegistry, arg1: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenFarm, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 200000);
        let v0 = &arg0.pool_no_admin;
        create_pool_impl<T0, T1>(arg0, arg1, 100, 210, v0.fee_direction, v0.admin_fee, v0.lp_fee, v0.th_fee, v0.withdraw_fee, 0, 0, 0, 0, 0, 0, arg2, arg3);
    }

    public fun do_create_registry(arg0: &mut SwapCap, arg1: u64, arg2: vector<u64>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 >= 1, 13400);
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.registry_id), 134021);
        let v0 = 0x1::vector::empty<PoolBoostMultiplierData>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg2)) {
            let v2 = PoolBoostMultiplierData{
                epoch            : *0x1::vector::borrow<u64>(&arg2, v1),
                boost_multiplier : *0x1::vector::borrow<u64>(&arg2, v1 + 1),
            };
            0x1::vector::push_back<PoolBoostMultiplierData>(&mut v0, v2);
            v1 = v1 + 2;
        };
        let v3 = 0x2::object::new(arg3);
        0x1::option::fill<0x2::object::ID>(&mut arg0.registry_id, 0x2::object::uid_to_inner(&v3));
        let v4 = PoolNoAdminSetupInfo{
            allowance     : true,
            fee_direction : 201,
            admin_fee     : 2,
            lp_fee        : 25,
            th_fee        : 3,
            withdraw_fee  : 10,
        };
        let v5 = PoolRegistry{
            id                         : v3,
            version                    : 0,
            pool_counter               : 0,
            pool_no_admin              : v4,
            pool_th_reward_nepoch      : arg1,
            pool_boost_multiplier_data : v0,
        };
        0x2::transfer::share_object<PoolRegistry>(v5);
    }

    public fun do_redeem_admin_balance<T0, T1>(arg0: &SwapCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 0, 200000);
        let v0 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.balance.x_admin, 0x2::math::min(0x2::balance::value<T0>(&arg1.balance.x_admin), arg2)), arg4), v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg1.balance.y_admin, 0x2::math::min(0x2::balance::value<T1>(&arg1.balance.y_admin), arg3)), arg4), v0);
    }

    public fun do_remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenBank, arg2: PoolLsp<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.version == 0, 200000);
        if (0x2::tx_context::sender(arg5) != arg0.owner) {
            assert!(arg0.freeze & 4 == 0, 134010);
        };
        assert!(arg3 > 0, 13400);
        assert!(arg2.value >= arg3, 134008);
        assert!(0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::get_epoch(arg4) >= arg2.end_epoch, 134019);
        update_pool_mining<T0, T1>(arg0, arg4);
        let v0 = 0x2::tx_context::sender(arg5);
        let (v1, v2, v3) = get_amounts<T0, T1>(arg0);
        let (v4, v5) = if (arg0.pool_type == 100) {
            compute_withdraw(v1, v2, v3, arg3)
        } else {
            compute_withdraw_stable(v1, v2, v3, arg3, arg0.stable.x_scale, arg0.stable.y_scale, arg0.stable.amp)
        };
        let v6 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::vpt::diff(&arg0.mining.ampt, &arg2.pool_mining_ampt, (arg2.value as u256) * (arg2.boost_multiplier as u256));
        assert!(v6 <= 18446744073709551615, 134006);
        let v7 = (v6 as u64);
        if (0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::token_bank_get_balance_value(arg1) >= v7 && 0x1::option::is_some<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::permission::Permission<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenBank>>(&arg0.mining.permission) && v7 > 0) {
            0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::do_send_liquidity_mine_token(0x1::option::borrow<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::permission::Permission<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenBank>>(&arg0.mining.permission), arg1, v7, v0, arg5);
        };
        let v8 = remove_lsp_supply<T0, T1>(arg0, arg2, arg3, arg5);
        if (v8.value > 0) {
            0x2::transfer::transfer<PoolLsp<T0, T1>>(v8, v0);
        } else {
            destroy_zero_lsp<T0, T1>(v8);
        };
        let v9 = 0x2::balance::split<T1>(&mut arg0.balance.y, v5);
        let v10 = 0x2::balance::split<T0>(&mut arg0.balance.x, v4);
        let v11 = &mut v10;
        let v12 = &mut v9;
        collect_withdraw_fee<T0, T1>(arg0, v11, v12);
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::transfer_or_destroy_zero<T0>(0x2::coin::from_balance<T0>(v10, arg5), v0);
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::transfer_or_destroy_zero<T1>(0x2::coin::from_balance<T1>(v9, arg5), v0);
        let (v13, v14, v15) = get_amounts<T0, T1>(arg0);
        let v16 = (v3 as u128);
        let v17 = (v15 as u128);
        assert!((v1 as u128) * v17 <= (v13 as u128) * v16, 134006);
        assert!((v2 as u128) * v17 <= (v14 as u128) * v16, 134006);
        let v18 = LiquidityEvent<T0, T1>{
            pool_index : arg0.index,
            is_added   : false,
            x_amount   : v4,
            y_amount   : v5,
            lsp_amount : arg3,
            lsp_id     : 0x2::object::uid_to_inner(&arg2.id),
        };
        0x2::event::emit<LiquidityEvent<T0, T1>>(v18);
    }

    public fun do_set_pool_freeze<T0, T1>(arg0: &SwapCap, arg1: &mut Pool<T0, T1>, arg2: u8) {
        assert!(arg1.version == 0, 200000);
        arg1.freeze = arg2;
    }

    public fun do_swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = do_swap_x_to_y_direct<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        let v2 = v1;
        assert!(0x2::coin::value<T1>(&v2) >= arg3, 134011);
        let v3 = 0x2::tx_context::sender(arg5);
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::transfer_or_destroy_zero<T0>(v0, v3);
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::transfer_or_destroy_zero<T1>(v2, v3);
    }

    public fun do_swap_x_to_y_direct<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(arg0.version == 0, 200000);
        assert!(arg2 > 0 || 0x1::vector::length<0x2::coin::Coin<T0>>(&arg1) == 0, 13400);
        if (0x2::tx_context::sender(arg4) != arg0.owner) {
            assert!(arg0.freeze & 1 == 0, 134010);
        };
        let v0 = 0x2::coin::into_balance<T0>(0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::merge_coins<T0>(arg1, arg4));
        assert!(0x2::balance::value<T0>(&v0) >= arg2, 134008);
        let v1 = 0x2::balance::split<T0>(&mut v0, arg2);
        let v2 = &mut v1;
        collect_admin_and_th_fee_x<T0, T1>(arg0, v2);
        let v3 = &mut v1;
        let v4 = collect_fee<T0>(v3, arg0.fee.lp);
        let v5 = swap_x_to_y_direct_no_fee_impl<T0, T1>(arg0, v1);
        let v6 = 0x2::balance::value<T1>(&v5);
        let v7 = &mut v5;
        collect_admin_and_th_fee_y<T0, T1>(arg0, v7);
        0x2::balance::join<T0>(&mut arg0.balance.x, v4);
        process_auto_buyback<T0, T1>(arg0);
        update_pool_mining<T0, T1>(arg0, arg3);
        let v8 = 0x2::coin::from_balance<T1>(v5, arg4);
        let v9 = SwapTokenEvent<T0, T1>{
            pool_index : arg0.index,
            x_to_y     : true,
            in_amount  : arg2,
            out_amount : 0x2::coin::value<T1>(&v8),
        };
        0x2::event::emit<SwapTokenEvent<T0, T1>>(v9);
        let v10 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::get_epoch(arg3);
        arg0.total_trade.x = arg0.total_trade.x + (arg2 as u128);
        arg0.total_trade.y = arg0.total_trade.y + (v6 as u128);
        if (v10 != arg0.trade_epoch) {
            arg0.total_trade.x_last_epoch = arg0.total_trade.x_current_epoch;
            arg0.total_trade.y_last_epoch = arg0.total_trade.y_current_epoch;
            arg0.total_trade.x_current_epoch = (arg2 as u128);
            arg0.total_trade.y_current_epoch = (v6 as u128);
            arg0.trade_epoch = v10;
            let (v11, v12, v13) = get_amounts<T0, T1>(arg0);
            let v14 = SnapshotEvent<T0, T1>{
                pool_index : arg0.index,
                x          : v11,
                y          : v12,
                lsp        : v13,
            };
            0x2::event::emit<SnapshotEvent<T0, T1>>(v14);
        } else {
            arg0.total_trade.x_current_epoch = arg0.total_trade.x_current_epoch + (arg2 as u128);
            arg0.total_trade.y_current_epoch = arg0.total_trade.y_current_epoch + (v6 as u128);
        };
        (0x2::coin::from_balance<T0>(v0, arg4), v8)
    }

    public fun do_swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = do_swap_y_to_x_direct<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        let v2 = v1;
        assert!(0x2::coin::value<T0>(&v2) >= arg3, 134011);
        let v3 = 0x2::tx_context::sender(arg5);
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::transfer_or_destroy_zero<T1>(v0, v3);
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::transfer_or_destroy_zero<T0>(v2, v3);
    }

    public fun do_swap_y_to_x_direct<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>) {
        assert!(arg0.version == 0, 200000);
        assert!(arg2 > 0 || 0x1::vector::length<0x2::coin::Coin<T1>>(&arg1) == 0, 13400);
        if (0x2::tx_context::sender(arg4) != arg0.owner) {
            assert!(arg0.freeze & 1 == 0, 134010);
        };
        let v0 = 0x2::coin::into_balance<T1>(0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::merge_coins<T1>(arg1, arg4));
        assert!(0x2::balance::value<T1>(&v0) >= arg2, 134008);
        let v1 = 0x2::balance::split<T1>(&mut v0, arg2);
        let v2 = &mut v1;
        collect_admin_and_th_fee_y<T0, T1>(arg0, v2);
        let v3 = &mut v1;
        let v4 = collect_fee<T1>(v3, arg0.fee.lp);
        let v5 = swap_y_to_x_direct_no_fee_impl<T0, T1>(arg0, v1);
        let v6 = &mut v5;
        collect_admin_and_th_fee_x<T0, T1>(arg0, v6);
        0x2::balance::join<T1>(&mut arg0.balance.y, v4);
        process_auto_buyback<T0, T1>(arg0);
        update_pool_mining<T0, T1>(arg0, arg3);
        let v7 = 0x2::coin::from_balance<T0>(v5, arg4);
        let v8 = SwapTokenEvent<T0, T1>{
            pool_index : arg0.index,
            x_to_y     : false,
            in_amount  : arg2,
            out_amount : 0x2::coin::value<T0>(&v7),
        };
        0x2::event::emit<SwapTokenEvent<T0, T1>>(v8);
        let v9 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::get_epoch(arg3);
        if (v9 != arg0.trade_epoch) {
            arg0.total_trade.y_last_epoch = arg0.total_trade.y_current_epoch;
            arg0.total_trade.x_last_epoch = arg0.total_trade.x_current_epoch;
            arg0.total_trade.y_current_epoch = (arg2 as u128);
            arg0.total_trade.x_current_epoch = (0x2::balance::value<T0>(&v5) as u128);
            arg0.trade_epoch = v9;
            let (v10, v11, v12) = get_amounts<T0, T1>(arg0);
            let v13 = SnapshotEvent<T0, T1>{
                pool_index : arg0.index,
                x          : v10,
                y          : v11,
                lsp        : v12,
            };
            0x2::event::emit<SnapshotEvent<T0, T1>>(v13);
        } else {
            arg0.total_trade.y_current_epoch = arg0.total_trade.y_current_epoch + (arg2 as u128);
            arg0.total_trade.x_current_epoch = arg0.total_trade.x_current_epoch + (0x2::balance::value<T0>(&v5) as u128);
        };
        (0x2::coin::from_balance<T1>(v0, arg4), v7)
    }

    public fun do_update_th_reward<T0, T1>(arg0: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenFarm, arg1: &mut Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        update_th_reward_impl<T0, T1>(arg0, arg1, 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::get_epoch(arg2));
    }

    public entry fun freeze_pool<T0, T1>(arg0: &SwapCap, arg1: &mut Pool<T0, T1>) {
        do_set_pool_freeze<T0, T1>(arg0, arg1, 1 | 2 | 4);
    }

    public fun get_admin_amounts<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance.x_admin), 0x2::balance::value<T1>(&arg0.balance.y_admin))
    }

    public fun get_amounts<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64) {
        (0x2::balance::value<T0>(&arg0.balance.x) + arg0.balance.bx, 0x2::balance::value<T1>(&arg0.balance.y) + arg0.balance.by, arg0.lsp_supply)
    }

    public fun get_k<T0, T1>(arg0: &Pool<T0, T1>) : u256 {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        if (arg0.pool_type == 100) {
            (v0 as u256) * (v1 as u256)
        } else {
            let v4 = ss_compute_d((v0 as u256), (v1 as u256), (arg0.stable.amp as u256));
            v4 * v4
        }
    }

    public fun get_k2_per_lsp<T0, T1>(arg0: &Pool<T0, T1>) : u256 {
        let (v0, v1, v2) = get_amounts<T0, T1>(arg0);
        let v3 = (v2 as u256);
        if (v3 == 0) {
            0
        } else {
            (v0 as u256) * (v1 as u256) / v3 * v3
        }
    }

    fun get_th_reward_start_and_end_epoch(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = arg0 / arg1 * arg1;
        (v0, v0 + arg1 - 1)
    }

    fun increase_lsp_supply<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : PoolLsp<T0, T1> {
        arg0.lsp_supply = arg0.lsp_supply + arg1;
        let (v0, v1, v2) = get_amounts<T0, T1>(arg0);
        let v3 = PoolLsp<T0, T1>{
            id               : 0x2::object::new(arg5),
            pool_id          : 0x2::object::uid_to_inner(&arg0.id),
            value            : arg1,
            pool_x           : v0,
            pool_y           : v1,
            pool_lsp         : v2,
            pool_mining_ampt : arg0.mining.ampt,
            start_epoch      : arg2,
            end_epoch        : arg3,
            boost_multiplier : arg4,
        };
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::vpt::add_amount(&mut arg0.mining.ampt, (arg1 as u256) * (arg4 as u256));
        v3
    }

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<POOL>(arg0, arg1);
        init_impl(arg1);
    }

    fun init_impl(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SwapCap{
            id          : 0x2::object::new(arg0),
            registry_id : 0x1::option::none<0x2::object::ID>(),
        };
        0x2::transfer::transfer<SwapCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun pool_create_info_get_pool_id(arg0: &PoolCreateInfo) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_get_balance_x_admin_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance.x_admin)
    }

    public fun pool_get_balance_x_th_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance.x_th)
    }

    public fun pool_get_balance_x_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.balance.x)
    }

    public fun pool_get_balance_y_admin_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance.y_admin)
    }

    public fun pool_get_balance_y_th_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance.y_th)
    }

    public fun pool_get_balance_y_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.balance.y)
    }

    public fun pool_get_boost_multiplier_data<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : PoolBoostMultiplierData {
        *0x1::vector::borrow<PoolBoostMultiplierData>(&arg0.boost_multiplier_data, arg1)
    }

    public fun pool_get_boost_multiplier_length<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x1::vector::length<PoolBoostMultiplierData>(&arg0.boost_multiplier_data)
    }

    public fun pool_get_fee_admin<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee.admin
    }

    public fun pool_get_fee_direction<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.fee.direction
    }

    public fun pool_get_fee_lp<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee.lp
    }

    public fun pool_get_fee_th<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee.th
    }

    public fun pool_get_fee_withdraw<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.fee.withdraw
    }

    public fun pool_get_freeze<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.freeze
    }

    public fun pool_get_id<T0, T1>(arg0: &Pool<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun pool_get_index<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.index
    }

    public fun pool_get_lsp_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.lsp_supply
    }

    public fun pool_get_mining_ampt<T0, T1>(arg0: &Pool<T0, T1>) : 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::vpt::ValuePerToken {
        arg0.mining.ampt
    }

    public fun pool_get_mining_has_permission<T0, T1>(arg0: &Pool<T0, T1>) : bool {
        0x1::option::is_some<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::permission::Permission<0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenBank>>(&arg0.mining.permission)
    }

    public fun pool_get_mining_last_epoch<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.mining.last_epoch
    }

    public fun pool_get_mining_speed<T0, T1>(arg0: &Pool<T0, T1>) : u256 {
        arg0.mining.speed
    }

    public fun pool_get_owner<T0, T1>(arg0: &Pool<T0, T1>) : address {
        arg0.owner
    }

    public fun pool_get_pool_type<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.pool_type
    }

    public fun pool_get_stable_amp<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.stable.amp
    }

    public fun pool_get_stable_x_scale<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.stable.x_scale
    }

    public fun pool_get_stable_y_scale<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.stable.y_scale
    }

    public fun pool_get_th_reward_end_epoch<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.th_reward.end_epoch
    }

    public fun pool_get_th_reward_nepoch<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.th_reward.nepoch
    }

    public fun pool_get_th_reward_start_epcoh<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.th_reward.start_epcoh
    }

    public fun pool_get_th_reward_total_stake_amount<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.th_reward.total_stake_amount
    }

    public fun pool_get_th_reward_total_stake_boost<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.th_reward.total_stake_boost
    }

    public fun pool_get_th_reward_type<T0, T1>(arg0: &Pool<T0, T1>) : u8 {
        arg0.th_reward.type
    }

    public fun pool_get_th_reward_x_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.th_reward.x_supply
    }

    public fun pool_get_th_reward_x_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T0>(&arg0.th_reward.x)
    }

    public fun pool_get_th_reward_y_supply<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.th_reward.y_supply
    }

    public fun pool_get_th_reward_y_value<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.th_reward.y)
    }

    public fun pool_get_total_trade_x<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.total_trade.x
    }

    public fun pool_get_total_trade_x_current_epoch<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.total_trade.x_current_epoch
    }

    public fun pool_get_total_trade_x_last_epoch<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.total_trade.x_last_epoch
    }

    public fun pool_get_total_trade_y<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.total_trade.y
    }

    public fun pool_get_total_trade_y_current_epoch<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.total_trade.y_current_epoch
    }

    public fun pool_get_total_trade_y_last_epoch<T0, T1>(arg0: &Pool<T0, T1>) : u128 {
        arg0.total_trade.y_last_epoch
    }

    public fun pool_get_trade_epoch<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.trade_epoch
    }

    public fun pool_lsp_get_id<T0, T1>(arg0: &PoolLsp<T0, T1>) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun pool_lsp_get_pool_id<T0, T1>(arg0: &PoolLsp<T0, T1>) : 0x2::object::ID {
        arg0.pool_id
    }

    public fun pool_lsp_get_pool_x<T0, T1>(arg0: &PoolLsp<T0, T1>) : u64 {
        arg0.pool_x
    }

    public fun pool_lsp_get_pool_y<T0, T1>(arg0: &PoolLsp<T0, T1>) : u64 {
        arg0.pool_y
    }

    public fun pool_lsp_get_value<T0, T1>(arg0: &PoolLsp<T0, T1>) : u64 {
        arg0.value
    }

    public fun pool_registry_get_id(arg0: &PoolRegistry) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun pool_registry_get_no_admin_pool_admin_fee(arg0: &PoolRegistry) : u64 {
        arg0.pool_no_admin.admin_fee
    }

    public fun pool_registry_get_no_admin_pool_allowance(arg0: &PoolRegistry) : bool {
        arg0.pool_no_admin.allowance
    }

    public fun pool_registry_get_no_admin_pool_fee_direction(arg0: &PoolRegistry) : u8 {
        arg0.pool_no_admin.fee_direction
    }

    public fun pool_registry_get_no_admin_pool_lp_fee(arg0: &PoolRegistry) : u64 {
        arg0.pool_no_admin.lp_fee
    }

    public fun pool_registry_get_no_admin_pool_th_fee(arg0: &PoolRegistry) : u64 {
        arg0.pool_no_admin.th_fee
    }

    public fun pool_registry_get_no_admin_pool_withdraw_fee(arg0: &PoolRegistry) : u64 {
        arg0.pool_no_admin.withdraw_fee
    }

    public fun pool_registry_get_pool_counter(arg0: &PoolRegistry) : u64 {
        arg0.pool_counter
    }

    public fun pool_registry_set_no_admin_pool_admin_fee(arg0: &SwapCap, arg1: &mut PoolRegistry, arg2: u64) {
        arg1.pool_no_admin.admin_fee = arg2;
    }

    public fun pool_registry_set_no_admin_pool_allowance(arg0: &SwapCap, arg1: &mut PoolRegistry, arg2: bool) {
        arg1.pool_no_admin.allowance = arg2;
    }

    public fun pool_registry_set_no_admin_pool_fee_direction(arg0: &SwapCap, arg1: &mut PoolRegistry, arg2: u8) {
        arg1.pool_no_admin.fee_direction = arg2;
    }

    public fun pool_registry_set_no_admin_pool_lp_fee(arg0: &SwapCap, arg1: &mut PoolRegistry, arg2: u64) {
        arg1.pool_no_admin.lp_fee = arg2;
    }

    public fun pool_registry_set_no_admin_pool_th_fee(arg0: &SwapCap, arg1: &mut PoolRegistry, arg2: u64) {
        arg1.pool_no_admin.th_fee = arg2;
    }

    public fun pool_registry_set_no_admin_pool_withdraw_fee(arg0: &SwapCap, arg1: &mut PoolRegistry, arg2: u64) {
        arg1.pool_no_admin.withdraw_fee = arg2;
    }

    fun process_auto_buyback<T0, T1>(arg0: &mut Pool<T0, T1>) {
        if (arg0.th_reward.type == 211) {
            if (arg0.fee.direction == 200 && 0x2::balance::value<T0>(&arg0.balance.x_th) > 0) {
                let v0 = 0x2::balance::split<T0>(&mut arg0.balance.x_th, 0x2::balance::value<T0>(&arg0.balance.x_th));
                let v1 = swap_x_to_y_direct_no_fee_impl<T0, T1>(arg0, v0);
                0x2::balance::join<T1>(&mut arg0.balance.y_th, v1);
            } else if (arg0.fee.direction == 201 && 0x2::balance::value<T1>(&arg0.balance.y_th) > 0) {
                let v2 = 0x2::balance::split<T1>(&mut arg0.balance.y_th, 0x2::balance::value<T1>(&arg0.balance.y_th));
                let v3 = swap_y_to_x_direct_no_fee_impl<T0, T1>(arg0, v2);
                0x2::balance::join<T0>(&mut arg0.balance.x_th, v3);
            };
        };
    }

    public entry fun redeem_admin_balance<T0, T1>(arg0: &SwapCap, arg1: &mut Pool<T0, T1>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        do_redeem_admin_balance<T0, T1>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun remove_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenBank, arg2: PoolLsp<T0, T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        do_remove_liquidity<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun remove_liquidity_all<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenBank, arg2: PoolLsp<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        do_remove_liquidity<T0, T1>(arg0, arg1, arg2, arg2.value, arg3, arg4);
    }

    fun remove_lsp_supply<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: PoolLsp<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : PoolLsp<T0, T1> {
        let v0 = 0x2::math::min(arg1.value, arg2);
        arg0.lsp_supply = arg0.lsp_supply - v0;
        0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::vpt::dec_amount(&mut arg0.mining.ampt, (v0 as u256) * (arg1.boost_multiplier as u256));
        let v1 = PoolLsp<T0, T1>{
            id               : 0x2::object::new(arg3),
            pool_id          : arg1.pool_id,
            value            : arg1.value - v0,
            pool_x           : arg1.pool_x,
            pool_y           : arg1.pool_y,
            pool_lsp         : arg1.pool_lsp,
            pool_mining_ampt : arg1.pool_mining_ampt,
            start_epoch      : arg1.start_epoch,
            end_epoch        : arg1.end_epoch,
            boost_multiplier : arg1.boost_multiplier,
        };
        let PoolLsp {
            id               : v2,
            pool_id          : _,
            value            : _,
            pool_x           : _,
            pool_y           : _,
            pool_lsp         : _,
            pool_mining_ampt : _,
            start_epoch      : _,
            end_epoch        : _,
            boost_multiplier : _,
        } = arg1;
        0x2::object::delete(v2);
        v1
    }

    fun ss_check_lsp_value_increase(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : bool {
        arg1 / arg3 >= arg0 / arg2
    }

    fun ss_compute_d(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg0 + arg1;
        if (v0 == 0) {
            return 0
        };
        let v1 = v0;
        let v2 = 0;
        while (v2 < 256) {
            let v3 = v1;
            let v4 = ss_compute_next_d(arg2, v1, v1 * v1 / arg0 * (2 as u256) * v1 / arg1 * (2 as u256), v0);
            v1 = v4;
            if (abs_sub(v4, v3) <= 1) {
                break
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun ss_compute_mint_amount_for_deposit(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256) : u256 {
        let v0 = ss_compute_d(arg2, arg3, arg5);
        let v1 = ss_compute_d(arg2 + arg0, arg3 + arg1, arg5);
        if (v1 <= v0) {
            0
        } else {
            let v3 = arg4 * (v1 - v0) / v0;
            ss_validate_lsp_value_increase(v0, v1, arg4, arg4 + v3);
            v3
        }
    }

    fun ss_compute_next_d(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        let v0 = (2 as u256);
        let v1 = arg0 * v0;
        arg1 * (arg2 * v0 + arg3 * v1) / (arg1 * (v1 - 1) + arg2 * (v0 + 1))
    }

    fun ss_compute_withdraw(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : (u256, u256) {
        let v0 = arg0 * arg2 / arg1;
        let v1 = arg0 * arg3 / arg1;
        ss_validate_lsp_value_increase(ss_compute_d(arg2, arg3, arg4), ss_compute_d(arg2 - v0, arg3 - v1, arg4), arg1, arg1 - arg0);
        (v0, v1)
    }

    fun ss_compute_withdraw_one(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256) : u256 {
        let v0 = ss_compute_d(arg2, arg3, arg4);
        let v1 = v0 - arg0 * v0 / arg1;
        ss_validate_lsp_value_increase(v0, v1, arg1, arg1 - arg0);
        arg2 - ss_compute_y(arg3, v1, arg4) + 1
    }

    fun ss_compute_y(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = (2 as u256);
        let v1 = arg2 * v0;
        let v2 = arg1;
        let v3 = 0;
        while (v3 < 256) {
            let v4 = v2;
            let v5 = (v2 * v2 + arg1 * arg1 / arg0 * v0 * arg1 / v1 * v0) / (v2 * 2 + arg1 / v1 + arg0 - arg1);
            v2 = v5;
            if (abs_sub(v5, v4) <= 1) {
                break
            };
            v3 = v3 + 1;
        };
        v2
    }

    fun ss_swap_to(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : u256 {
        let (v0, v1) = ss_swap_to_internal(arg0, arg1, arg2, arg3);
        assert!(ss_compute_d(arg0 + arg1, arg2 + v0, arg3) >= v1, 134006);
        v0
    }

    fun ss_swap_to_internal(arg0: u256, arg1: u256, arg2: u256, arg3: u256) : (u256, u256) {
        let v0 = ss_compute_d(arg1, arg2, arg3);
        (arg2 - ss_compute_y(arg1 + arg0, v0, arg3) - 1, v0)
    }

    fun ss_validate_lsp_value_increase(arg0: u256, arg1: u256, arg2: u256, arg3: u256) {
        assert!(ss_check_lsp_value_increase(arg0, arg1, arg2, arg3), 134006);
    }

    public entry fun swap_x_to_y<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        do_swap_x_to_y<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun swap_x_to_y_all<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T0>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::merge_coins<T0>(arg1, arg4);
        do_swap_x_to_y<T0, T1>(arg0, 0x1::vector::singleton<0x2::coin::Coin<T0>>(v0), 0x2::coin::value<T0>(&v0), arg2, arg3, arg4);
    }

    fun swap_x_to_y_direct_no_fee_impl<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T1> {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        assert!(v0 > 0 && v1 > 0, 134002);
        let v3 = if (arg0.pool_type == 100) {
            compute_amount(0x2::balance::value<T0>(&arg1), v0, v1)
        } else {
            compute_amount_stable(0x2::balance::value<T0>(&arg1), v0, v1, arg0.stable.x_scale, arg0.stable.y_scale, arg0.stable.amp)
        };
        0x2::balance::join<T0>(&mut arg0.balance.x, arg1);
        0x2::balance::split<T1>(&mut arg0.balance.y, v3)
    }

    public entry fun swap_y_to_x<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        do_swap_y_to_x<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public entry fun swap_y_to_x_all<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<0x2::coin::Coin<T1>>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::merge_coins<T1>(arg1, arg4);
        do_swap_y_to_x<T0, T1>(arg0, 0x1::vector::singleton<0x2::coin::Coin<T1>>(v0), 0x2::coin::value<T1>(&v0), arg2, arg3, arg4);
    }

    fun swap_y_to_x_direct_no_fee_impl<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T0> {
        let (v0, v1, _) = get_amounts<T0, T1>(arg0);
        assert!(v0 > 0 && v1 > 0, 134002);
        let v3 = if (arg0.pool_type == 100) {
            compute_amount(0x2::balance::value<T1>(&arg1), v1, v0)
        } else {
            compute_amount_stable(0x2::balance::value<T1>(&arg1), v1, v0, arg0.stable.y_scale, arg0.stable.x_scale, arg0.stable.amp)
        };
        0x2::balance::join<T1>(&mut arg0.balance.y, arg1);
        0x2::balance::split<T0>(&mut arg0.balance.x, v3)
    }

    public entry fun unfreeze_pool<T0, T1>(arg0: &SwapCap, arg1: &mut Pool<T0, T1>) {
        do_set_pool_freeze<T0, T1>(arg0, arg1, 0);
    }

    fun update_pool_mining<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x2::clock::Clock) {
        if (arg0.mining.speed > 0) {
            let v0 = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::get_epoch(arg1);
            if (v0 > arg0.mining.last_epoch) {
                arg0.mining.last_epoch = v0;
                if (0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::vpt::amount(&arg0.mining.ampt) > 0) {
                    0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::vpt::add_sum(&mut arg0.mining.ampt, ((v0 - arg0.mining.last_epoch) as u256) * arg0.mining.speed);
                };
            };
        };
    }

    public entry fun update_th_reward<T0, T1>(arg0: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenFarm, arg1: &mut Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        do_update_th_reward<T0, T1>(arg0, arg1, arg2, arg3);
    }

    fun update_th_reward_impl<T0, T1>(arg0: &0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::TokenFarm, arg1: &mut Pool<T0, T1>, arg2: u64) {
        assert!(arg1.version == 0, 200000);
        if (arg2 > arg1.th_reward.end_epoch) {
            let (v0, v1) = get_th_reward_start_and_end_epoch(arg2, arg1.th_reward.nepoch);
            arg1.th_reward.start_epcoh = v0;
            arg1.th_reward.end_epoch = v1;
            0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::join_balance<T0>(&mut arg1.balance.x_admin, &mut arg1.th_reward.x);
            0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::join_balance<T1>(&mut arg1.balance.y_admin, &mut arg1.th_reward.y);
            0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::join_balance<T0>(&mut arg1.th_reward.x, &mut arg1.balance.x_th);
            0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::utils::join_balance<T1>(&mut arg1.th_reward.y, &mut arg1.balance.y_th);
            arg1.th_reward.x_supply = 0x2::balance::value<T0>(&arg1.th_reward.x);
            arg1.th_reward.y_supply = 0x2::balance::value<T1>(&arg1.th_reward.y);
            arg1.th_reward.total_stake_amount = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::token_farm_get_total_stake_amount(arg0);
            arg1.th_reward.total_stake_boost = 0x1866b128d3d3fa3789c2858180df5bca0d5970ce9571d6149d69ba368606d902::TOKEN::token_farm_get_total_stake_boost(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

