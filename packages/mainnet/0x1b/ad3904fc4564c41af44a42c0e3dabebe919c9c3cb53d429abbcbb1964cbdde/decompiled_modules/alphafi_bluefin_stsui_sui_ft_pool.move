module 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_pool {
    struct Pool<phantom T0, phantom T1, phantom T2> has store, key {
        id: 0x2::object::UID,
        tokensInvested: u128,
        deposit_fee: u64,
        deposit_fee_max_cap: u64,
        withdrawal_fee: u64,
        withdraw_fee_max_cap: u64,
        treasury_cap: 0x2::coin::TreasuryCap<T2>,
        paused: bool,
    }

    struct ALPHAFI_BLUEFIN_STSUI_SUI_FT_POOL has drop {
        dummy_field: bool,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    struct AfterTransactionEvent has copy, drop {
        tokensInvested: u128,
        xtokenSupply: u64,
        liquidity: u128,
    }

    struct LiquidityChangeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        event_type: u8,
        total_amount_a: u64,
        total_amount_b: u64,
        fee_collected_a: u64,
        fee_collected_b: u64,
        amount_a: u64,
        amount_b: u64,
        x_tokens_change: u64,
        x_token_supply: u64,
        tokens_invested: u128,
        sender: address,
    }

    struct DebugEvent has copy, drop {
        a: u256,
        b: u256,
        c: u256,
        d: u256,
    }

    public fun deposit<T0: drop, T1, T2, T3>(arg0: &0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::Version, arg1: &mut Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg5: &mut 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::Investor<T0, T1>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg9: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::assert_current_version(arg0);
        assert!(arg1.paused == false, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::pool_paused());
        assert!(0x2::coin::value<T0>(&arg2) > 0 || 0x2::coin::value<T1>(&arg3) > 0, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::zero_deposit_error());
        update_pool<T0, T1, T2, T3>(arg0, arg1, arg5, arg4, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::coin::into_balance<T1>(arg3);
        let v2 = (0x2::balance::value<T0>(&v0) as u128) * (arg1.deposit_fee as u128) / 10000;
        let v3 = (0x2::balance::value<T1>(&v1) as u128) * (arg1.deposit_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, (v2 as u64)), arg12), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v1, (v3 as u64)), arg12), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg4));
        let (_, v5, v6, v7) = 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::get_balances_in_ratio<T0, T1>(arg5, v0, v1, arg7, false, arg12);
        let v8 = v6;
        let v9 = v5;
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::deposit<T0, T1>(arg5, arg6, arg7, v9, v8, v7, arg11);
        arg1.tokensInvested = 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::get_total_liquidity<T0, T1>(arg5);
        let v10 = ((((arg1.tokensInvested - arg1.tokensInvested) as u256) * (1000000000000000000000000000000000000 as u256) / exchange_rate<T0, T1, T2>(arg1)) as u64);
        assert!(v10 > 0, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::insufficient_deposit_amount());
        let (v11, v12) = 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::get_amounts<T0, T1>(arg5, arg7);
        let v13 = LiquidityChangeEvent{
            pool_id         : 0x2::object::uid_to_inner(&arg1.id),
            event_type      : 0,
            total_amount_a  : v11,
            total_amount_b  : v12,
            fee_collected_a : (v2 as u64),
            fee_collected_b : (v3 as u64),
            amount_a        : 0x2::balance::value<T0>(&v9),
            amount_b        : 0x2::balance::value<T1>(&v8),
            x_tokens_change : v10,
            x_token_supply  : 0x2::coin::total_supply<T2>(&arg1.treasury_cap),
            tokens_invested : arg1.tokensInvested,
            sender          : 0x2::tx_context::sender(arg12),
        };
        0x2::event::emit<LiquidityChangeEvent>(v13);
        0x2::coin::mint<T2>(&mut arg1.treasury_cap, v10, arg12)
    }

    public fun user_emergency_withdraw<T0, T1, T2>(arg0: &0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::Version, arg1: 0x2::coin::Coin<T2>, arg2: &mut Pool<T0, T1, T2>, arg3: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg4: &mut 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::Investor<T0, T1>, arg5: &mut 0x2::tx_context::TxContext) {
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::assert_current_version(arg0);
        assert!(arg2.paused == true, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::pool_paused());
        let (v0, v1) = 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::user_emergency_withdraw<T0, T1>(arg4, 0x2::coin::value<T2>(&arg1), 0x2::coin::total_supply<T2>(&arg2.treasury_cap));
        let v2 = v1;
        let v3 = v0;
        0x2::coin::burn<T2>(&mut arg2.treasury_cap, arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v3, (((0x2::balance::value<T0>(&v3) as u128) * (arg2.withdrawal_fee as u128) / 10000) as u64)), arg5), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v2, (((0x2::balance::value<T1>(&v2) as u128) * (arg2.withdrawal_fee as u128) / 10000) as u64)), arg5), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v3, arg5), 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v2, arg5), 0x2::tx_context::sender(arg5));
        let v4 = AfterTransactionEvent{
            tokensInvested : arg2.tokensInvested,
            xtokenSupply   : 0x2::coin::total_supply<T2>(&arg2.treasury_cap),
            liquidity      : 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::get_total_liquidity<T0, T1>(arg4),
        };
        0x2::event::emit<AfterTransactionEvent>(v4);
    }

    public fun withdraw<T0: drop, T1, T2, T3>(arg0: &0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::Version, arg1: 0x2::coin::Coin<T2>, arg2: &mut Pool<T0, T1, T2>, arg3: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg4: &mut 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::Investor<T0, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg8: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::assert_current_version(arg0);
        assert!(arg2.paused == false, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::pool_paused());
        update_pool<T0, T1, T2, T3>(arg0, arg2, arg4, arg3, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        let v0 = 0x2::coin::value<T2>(&arg1);
        let (v1, v2) = 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::withdraw<T0, T1>(arg4, get_liquiity_for_fungible_token<T0, T1, T2>(arg2, v0), arg5, arg6, arg10);
        let v3 = v2;
        let v4 = v1;
        0x2::coin::burn<T2>(&mut arg2.treasury_cap, arg1);
        arg2.tokensInvested = 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::get_total_liquidity<T0, T1>(arg4);
        let v5 = (0x2::balance::value<T0>(&v4) as u128) * (arg2.withdrawal_fee as u128) / 10000;
        let v6 = (0x2::balance::value<T1>(&v3) as u128) * (arg2.withdrawal_fee as u128) / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v4, (v5 as u64)), arg11), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg3));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v3, (v6 as u64)), arg11), 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::get_fee_wallet_address(arg3));
        let (v7, v8) = 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::get_amounts<T0, T1>(arg4, arg6);
        let v9 = LiquidityChangeEvent{
            pool_id         : 0x2::object::uid_to_inner(&arg2.id),
            event_type      : 1,
            total_amount_a  : v7,
            total_amount_b  : v8,
            fee_collected_a : (v5 as u64),
            fee_collected_b : (v6 as u64),
            amount_a        : 0x2::balance::value<T0>(&v4),
            amount_b        : 0x2::balance::value<T1>(&v3),
            x_tokens_change : v0,
            x_token_supply  : 0x2::coin::total_supply<T2>(&arg2.treasury_cap),
            tokens_invested : arg2.tokensInvested,
            sender          : 0x2::tx_context::sender(arg11),
        };
        0x2::event::emit<LiquidityChangeEvent>(v9);
        (v4, v3)
    }

    public fun create<T0, T1, T2>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::DevCap, arg1: &0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::Version, arg2: 0x2::coin::TreasuryCap<T2>, arg3: &mut 0x2::tx_context::TxContext) {
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::assert_current_version(arg1);
        assert!(0x2::coin::total_supply<T2>(&arg2) == 0, 9223372264488042495);
        let v0 = Pool<T0, T1, T2>{
            id                   : 0x2::object::new(arg3),
            tokensInvested       : 0,
            deposit_fee          : 0,
            deposit_fee_max_cap  : 100,
            withdrawal_fee       : 0,
            withdraw_fee_max_cap : 100,
            treasury_cap         : arg2,
            paused               : false,
        };
        0x2::transfer::public_share_object<Pool<T0, T1, T2>>(v0);
    }

    fun exchange_rate<T0, T1, T2>(arg0: &Pool<T0, T1, T2>) : u256 {
        if (arg0.tokensInvested == 0 || 0x2::coin::total_supply<T2>(&arg0.treasury_cap) == 0) {
            (1000000000000000000000000000000000000 as u256)
        } else {
            (arg0.tokensInvested as u256) * (1000000000000000000000000000000000000 as u256) / (0x2::coin::total_supply<T2>(&arg0.treasury_cap) as u256)
        }
    }

    public fun get_fungible_token_amounts<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: &mut 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::Investor<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: u64) : (u64, u64) {
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::get_amounts_by_liquidity<T0, T1>(arg1, arg2, get_liquiity_for_fungible_token<T0, T1, T2>(arg0, arg3))
    }

    public fun get_fungible_token_price<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: &mut 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::Investor<T0, T1>, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg5: u64, arg6: &0x2::clock::Clock) : u256 {
        let (v0, v1) = get_fungible_token_amounts<T0, T1, T2>(arg0, arg1, arg2, arg5);
        let v2 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg6, arg3, (v0 as u256), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg4, 20));
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::calculator::calculate_value(arg6, arg3, (v1 as u256), 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg4, 0));
        let v4 = DebugEvent{
            a : (v0 as u256),
            b : (v1 as u256),
            c : (v2 as u256),
            d : (v3 as u256),
        };
        0x2::event::emit<DebugEvent>(v4);
        v2 + v3
    }

    fun get_liquiity_for_fungible_token<T0, T1, T2>(arg0: &Pool<T0, T1, T2>, arg1: u64) : u128 {
        (((arg1 as u256) * exchange_rate<T0, T1, T2>(arg0) / (1000000000000000000000000000000000000 as u256)) as u128)
    }

    fun init(arg0: ALPHAFI_BLUEFIN_STSUI_SUI_FT_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<ALPHAFI_BLUEFIN_STSUI_SUI_FT_POOL>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    entry fun set_deposit_fee<T0, T1, T2>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::Version, arg2: &mut Pool<T0, T1, T2>, arg3: u64) {
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.deposit_fee_max_cap, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::fee_too_high_error());
        arg2.deposit_fee = arg3;
    }

    entry fun set_pause<T0, T1, T2>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::EmergencyCap, arg1: &0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::Version, arg2: &mut Pool<T0, T1, T2>, arg3: &0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::Investor<T0, T1>, arg4: bool) {
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::assert_current_version(arg1);
        assert!(0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::is_emergency<T0, T1>(arg3) == false || arg2.paused == false, 10001);
        arg2.paused = arg4;
    }

    entry fun set_withdrawal_fee<T0, T1, T2>(arg0: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::AdminCap, arg1: &0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::Version, arg2: &mut Pool<T0, T1, T2>, arg3: u64) {
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::assert_current_version(arg1);
        assert!(arg3 <= arg2.withdraw_fee_max_cap, 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::error::fee_too_high_error());
        arg2.withdrawal_fee = arg3;
    }

    public fun update_pool<T0: drop, T1, T2, T3>(arg0: &0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::Version, arg1: &mut Pool<T0, T1, T2>, arg2: &mut 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::Investor<T0, T1>, arg3: &0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg4: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg5: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg7: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg8: &mut 0x3::sui_system::SuiSystemState, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::assert_current_version(arg0);
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::autocompound<T0, T1, T3>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        arg1.tokensInvested = 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::get_total_liquidity<T0, T1>(arg2);
    }

    public fun user_deposit<T0: drop, T1, T2, T3>(arg0: &0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::Version, arg1: &mut Pool<T0, T1, T2>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg5: &mut 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::Investor<T0, T1>, arg6: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg8: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg9: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg10: &mut 0x3::sui_system::SuiSystemState, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::assert_current_version(arg0);
        let v0 = deposit<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(v0, 0x2::tx_context::sender(arg12));
    }

    public fun user_withdraw<T0: drop, T1, T2, T3>(arg0: &0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::Version, arg1: 0x2::coin::Coin<T2>, arg2: &mut Pool<T0, T1, T2>, arg3: &mut 0xfcadd5525628c306cc87d980c18aec71daa8a51f17a5eba34e3a105eb64a8b7e::distributor::Distributor, arg4: &mut 0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::alphafi_bluefin_stsui_sui_ft_investor::Investor<T0, T1>, arg5: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg6: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg7: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T3, T1>, arg8: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg9: &mut 0x3::sui_system::SuiSystemState, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0xb50bdf22ee4719d18759aeb5f92f26b1aaa6274bddd1d6a2afee5b7759a165a9::version::assert_current_version(arg0);
        let (v0, v1) = withdraw<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg11), 0x2::tx_context::sender(arg11));
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v1, arg11), 0x2::tx_context::sender(arg11));
    }

    // decompiled from Move bytecode v6
}

