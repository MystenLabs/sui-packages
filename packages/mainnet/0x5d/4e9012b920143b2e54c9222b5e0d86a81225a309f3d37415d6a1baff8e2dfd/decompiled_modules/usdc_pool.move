module 0x5d4e9012b920143b2e54c9222b5e0d86a81225a309f3d37415d6a1baff8e2dfd::usdc_pool {
    struct LP has drop {
        dummy_field: bool,
    }

    struct EventDeposit has copy, drop {
        amount_deposited: u64,
        pool_lp_supply: u64,
        vault_balance: u64,
        pool_strategy_borrowed: u64,
        lp_issued: u64,
    }

    struct PoolState has copy, drop {
        vault_balance: u64,
        lp_supply: u64,
        strategy_borrowed: u64,
        stake_proof_amount: 0x1::option::Option<u64>,
        collected_profit: u64,
    }

    struct AfPoolState has copy, drop {
        lp_supply_value: u64,
        usdc_balance: u64,
        buck_balance: u64,
    }

    struct KriyaPoolState has copy, drop {
        lp_supply_value: u64,
        usdc_balance: u64,
        buck_balance: u64,
    }

    struct CetusPoolState has copy, drop {
        usdc_balance: u64,
        sui_balance: u64,
    }

    struct EventWithdrawInitState has copy, drop {
        lp_withdraw_amount: u64,
        pool_state: PoolState,
        fountain_staked_balance: u64,
        af_pool_state: AfPoolState,
        kriya_pool_state: KriyaPoolState,
        cetus_pool_state: CetusPoolState,
    }

    struct EventWithdrawFinalState has copy, drop {
        out_amt: u64,
        out_coin_value: u64,
        withdrawn_from_strategy: u64,
        pool_state: PoolState,
    }

    struct EventStrategyRewardResult has copy, drop {
        amount_needed: u64,
        rewards_value: u64,
        withdrawn_lp_value: u64,
        withdrawn_usdc_value: u64,
        withdrawn_buck_value: u64,
        swapped_buck_out_amt: u64,
        excess_usdc_value: u64,
        rewards_usdc_value: u64,
        usdc_out: u64,
    }

    struct EventAdjustPositionInitState has copy, drop {
        pool_state: PoolState,
        strategy_keep_profit_bps: u64,
        af_pool_state: AfPoolState,
        cetus_pool_state: CetusPoolState,
    }

    struct EventAdjustPositionFinalState has copy, drop {
        rewards_value: u64,
        rewards_usdc_value: u64,
        keep_amt: u64,
        reported_profit: u64,
        profit_usdc_value: u64,
        reinvest_usdc_value: u64,
        reinvest_lp_value: u64,
        pool_state: PoolState,
    }

    struct PoolConfig has key {
        id: 0x2::object::UID,
        admins: 0x2::vec_set::VecSet<address>,
        guests: 0x2::vec_set::VecSet<address>,
        pool_is_public: bool,
        strategy_keep_profit_bps: u64,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        vault: 0x2::balance::Balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>,
        lp_supply: 0x2::balance::Supply<LP>,
        strategy_borrowed: u64,
        stake_proof: 0x1::option::Option<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>>,
        collected_profit: 0x2::balance::Balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>,
    }

    public fun add_admin(arg0: &mut PoolConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        0x2::vec_set::insert<address>(&mut arg0.admins, arg1);
    }

    public fun add_guest(arg0: &mut PoolConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        0x2::vec_set::insert<address>(&mut arg0.guests, arg1);
    }

    public fun adjust_position(arg0: &mut Pool, arg1: &PoolConfig, arg2: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>, arg3: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg4: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg5: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg6: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg7: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg8: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>, arg9: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg10: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        assert_admin(arg1, arg12);
        let v0 = EventAdjustPositionInitState{
            pool_state               : get_pool_state(arg0),
            strategy_keep_profit_bps : arg1.strategy_keep_profit_bps,
            af_pool_state            : get_af_pool_state(arg2),
            cetus_pool_state         : get_cetus_pool_state(arg9),
        };
        0x2::event::emit<EventAdjustPositionInitState>(v0);
        let v1 = 0x2::balance::withdraw_all<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.collected_profit);
        let (v2, v3) = if (0x1::option::is_some<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>>(&arg0.stake_proof)) {
            0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::force_unstake<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>(arg11, arg8, 0x1::option::extract<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>>(&mut arg0.stake_proof))
        } else {
            (0x2::balance::zero<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(), 0x2::balance::zero<0x2::sui::SUI>())
        };
        let v4 = v3;
        let v5 = v2;
        let v6 = if (0x2::balance::value<0x2::sui::SUI>(&v4) > 0) {
            let (v7, v8) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg10, arg9, 0x2::coin::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg12), 0x2::coin::from_balance<0x2::sui::SUI>(v4, arg12), false, true, 0x2::balance::value<0x2::sui::SUI>(&v4), 79226673515401279992447579055, false, arg11, arg12);
            let v9 = v7;
            0x2::coin::destroy_zero<0x2::sui::SUI>(v8);
            0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v1, 0x2::coin::into_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(v9));
            0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v9)
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v4);
            0
        };
        let v10 = muldiv(0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v1), arg1.strategy_keep_profit_bps, 10000);
        let v11 = 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v1) - v10;
        arg0.strategy_borrowed = arg0.strategy_borrowed + v11 + 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg0.vault);
        let v12 = 0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>();
        0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v12, v1);
        0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v12, 0x2::balance::withdraw_all<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.vault));
        let v13 = if (0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v12) > 0) {
            0x2::coin::into_balance<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::deposit::deposit_1_coins<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg2, arg3, arg4, arg5, arg6, arg7, 0x2::coin::from_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(v12, arg12), 500000000000000000, 0, arg12))
        } else {
            0x2::balance::destroy_zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(v12);
            0x2::balance::zero<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>()
        };
        let v14 = v13;
        0x2::balance::join<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(&mut v5, v14);
        if (0x2::balance::value<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(&v5) > 0) {
            let (_, v16) = 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::get_lock_time_range<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>(arg8);
            0x1::option::fill<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>>(&mut arg0.stake_proof, 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::stake<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>(arg11, arg8, v5, v16, arg12));
        } else {
            0x2::balance::destroy_zero<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(v5);
        };
        let v17 = EventAdjustPositionFinalState{
            rewards_value       : 0x2::balance::value<0x2::sui::SUI>(&v4),
            rewards_usdc_value  : v6,
            keep_amt            : v10,
            reported_profit     : v11,
            profit_usdc_value   : 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v1),
            reinvest_usdc_value : 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v12),
            reinvest_lp_value   : 0x2::balance::value<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(&v14),
            pool_state          : get_pool_state(arg0),
        };
        0x2::event::emit<EventAdjustPositionFinalState>(v17);
    }

    public fun assert_admin(arg0: &PoolConfig, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::vec_set::contains<address>(&arg0.admins, &v0), 0);
    }

    public fun assert_guest(arg0: &PoolConfig, arg1: &0x2::tx_context::TxContext) {
        if (arg0.pool_is_public) {
            return
        };
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = if (0x2::vec_set::contains<address>(&arg0.admins, &v0)) {
            true
        } else {
            let v2 = 0x2::tx_context::sender(arg1);
            0x2::vec_set::contains<address>(&arg0.guests, &v2)
        };
        assert!(v1, 0);
    }

    public fun assert_use_pool(arg0: &PoolConfig, arg1: &0x2::tx_context::TxContext) {
        if (arg0.pool_is_public) {
            return
        };
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = if (0x2::vec_set::contains<address>(&arg0.admins, &v0)) {
            true
        } else {
            let v2 = 0x2::tx_context::sender(arg1);
            0x2::vec_set::contains<address>(&arg0.guests, &v2)
        };
        assert!(v1, 1);
    }

    public fun deposit(arg0: &mut Pool, arg1: &PoolConfig, arg2: 0x2::coin::Coin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<LP> {
        assert_use_pool(arg1, arg3);
        assert!(0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg2) > 0, 1);
        let v0 = 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg0.vault) + arg0.strategy_borrowed;
        let v1 = if (v0 == 0) {
            0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg2)
        } else {
            muldiv(0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg2), 0x2::balance::supply_value<LP>(&arg0.lp_supply), v0)
        };
        let v2 = EventDeposit{
            amount_deposited       : 0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg2),
            pool_lp_supply         : 0x2::balance::supply_value<LP>(&arg0.lp_supply),
            vault_balance          : 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg0.vault),
            pool_strategy_borrowed : arg0.strategy_borrowed,
            lp_issued              : v1,
        };
        0x2::event::emit<EventDeposit>(v2);
        0x2::coin::put<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.vault, arg2);
        0x2::coin::from_balance<LP>(0x2::balance::increase_supply<LP>(&mut arg0.lp_supply, v1), arg3)
    }

    fun get_af_pool_state(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>) : AfPoolState {
        AfPoolState{
            lp_supply_value : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::lp_supply_value<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(arg0),
            usdc_balance    : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balance_of<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg0),
            buck_balance    : 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::balance_of<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0),
        }
    }

    fun get_cetus_pool_state(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>) : CetusPoolState {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::balances<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg0);
        CetusPoolState{
            usdc_balance : 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(v0),
            sui_balance  : 0x2::balance::value<0x2::sui::SUI>(v1),
        }
    }

    fun get_kriya_pool_state(arg0: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>) : KriyaPoolState {
        let (v0, v1, v2) = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::get_reserves<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg0);
        KriyaPoolState{
            lp_supply_value : v2,
            usdc_balance    : v1,
            buck_balance    : v0,
        }
    }

    fun get_pool_state(arg0: &Pool) : PoolState {
        let v0 = if (0x1::option::is_some<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>>(&arg0.stake_proof)) {
            0x1::option::some<u64>(0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::get_proof_stake_amount<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>(0x1::option::borrow<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>>(&arg0.stake_proof)))
        } else {
            0x1::option::none<u64>()
        };
        PoolState{
            vault_balance      : 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg0.vault),
            lp_supply          : 0x2::balance::supply_value<LP>(&arg0.lp_supply),
            strategy_borrowed  : arg0.strategy_borrowed,
            stake_proof_amount : v0,
            collected_profit   : 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg0.collected_profit),
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PoolConfig{
            id                       : 0x2::object::new(arg0),
            admins                   : 0x2::vec_set::singleton<address>(0x2::tx_context::sender(arg0)),
            guests                   : 0x2::vec_set::empty<address>(),
            pool_is_public           : false,
            strategy_keep_profit_bps : 1000,
        };
        0x2::transfer::share_object<PoolConfig>(v0);
        let v1 = LP{dummy_field: false};
        let v2 = Pool{
            id                : 0x2::object::new(arg0),
            vault             : 0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(),
            lp_supply         : 0x2::balance::create_supply<LP>(v1),
            strategy_borrowed : 0,
            stake_proof       : 0x1::option::none<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>>(),
            collected_profit  : 0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(),
        };
        0x2::transfer::share_object<Pool>(v2);
    }

    fun muldiv(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun remove_admin(arg0: &mut PoolConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        0x2::vec_set::remove<address>(&mut arg0.admins, &arg1);
    }

    public fun remove_guest(arg0: &mut PoolConfig, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        0x2::vec_set::remove<address>(&mut arg0.guests, &arg1);
    }

    public fun set_pool_is_public(arg0: &mut PoolConfig, arg1: bool, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.pool_is_public = arg1;
    }

    public fun set_strategy_keep_profit_bps(arg0: &mut PoolConfig, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert_admin(arg0, arg2);
        arg0.strategy_keep_profit_bps = arg1;
    }

    fun strategy_withdraw(arg0: &mut Pool, arg1: u64, arg2: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>, arg3: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg4: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg5: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg6: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg7: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg8: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>, arg9: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg10: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg11: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN> {
        if (arg1 == 0) {
            return 0x2::coin::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg13)
        };
        let (v0, v1) = 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::force_unstake<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>(arg12, arg8, 0x1::option::extract<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>>(&mut arg0.stake_proof));
        let v2 = v1;
        let v3 = v0;
        let v4 = if (arg1 == arg0.strategy_borrowed) {
            0x2::balance::value<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(&v3)
        } else {
            muldiv(arg1, 0x2::balance::value<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(&v3), arg0.strategy_borrowed)
        };
        let v5 = 0x2::coin::take<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(&mut v3, v4, arg13);
        let (v6, v7) = 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::withdraw::all_coin_withdraw_2_coins<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg2, arg3, arg4, arg5, arg6, arg7, v5, arg13);
        let v8 = v7;
        let v9 = v6;
        let v10 = 0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v9);
        0x2::coin::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v9, 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(arg9, v8, 0x2::coin::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v8), 0, arg13));
        let v11 = if (0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v9) == arg1) {
            0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>()
        } else if (0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v9) < arg1) {
            0x2::balance::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>()
        } else {
            0x2::balance::split<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0x2::coin::balance_mut<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v9), 0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v9) - arg1)
        };
        let v12 = v11;
        0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.collected_profit, v12);
        if (0x2::balance::value<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(&v3) > 0) {
            let (_, v14) = 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::get_lock_time_range<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>(arg8);
            0x1::option::fill<0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::StakeProof<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>>(&mut arg0.stake_proof, 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::stake<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>(arg12, arg8, v3, v14, arg13));
        } else {
            0x2::balance::destroy_zero<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(v3);
        };
        let v15 = if (0x2::balance::value<0x2::sui::SUI>(&v2) > 0) {
            let (v16, v17) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>(arg11, arg10, 0x2::coin::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg13), 0x2::coin::from_balance<0x2::sui::SUI>(v2, arg13), false, true, 0x2::balance::value<0x2::sui::SUI>(&v2), 79226673515401279992447579055, false, arg12, arg13);
            let v18 = v16;
            0x2::coin::destroy_zero<0x2::sui::SUI>(v17);
            0x2::balance::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.collected_profit, 0x2::coin::into_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(v18));
            0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v18)
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v2);
            0
        };
        let v19 = EventStrategyRewardResult{
            amount_needed        : arg1,
            rewards_value        : 0x2::balance::value<0x2::sui::SUI>(&v2),
            withdrawn_lp_value   : 0x2::coin::value<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>(&v5),
            withdrawn_usdc_value : v10,
            withdrawn_buck_value : 0x2::coin::value<0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>(&v8),
            swapped_buck_out_amt : 0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v9) - v10,
            excess_usdc_value    : 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v12),
            rewards_usdc_value   : v15,
            usdc_out             : 0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v9),
        };
        0x2::event::emit<EventStrategyRewardResult>(v19);
        v9
    }

    public fun withdraw(arg0: &mut Pool, arg1: &PoolConfig, arg2: 0x2::coin::Coin<LP>, arg3: &mut 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>, arg4: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool_registry::PoolRegistry, arg5: &0x2d9316f1f1a95f6d7c85a4e690ef7c359e6649773ef2c37ad7d9857adb6bef06::vault::ProtocolFeeVault, arg6: &mut 0x64213b0e4a52bac468d4ac3f140242f70714381653a1919a6d57cd49c628207a::treasury::Treasury, arg7: &mut 0xa6baab1e668c7868991c1c3c11e144100f5734c407d020f72a01b9d1a8bcb97f::insurance_fund::InsuranceFund, arg8: &0xc66fabf1a9253e43c70f1cc02d40a1d18db183140ecaae2a3f58fa6b66c55acf::referral_vault::ReferralVault, arg9: &mut 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>, arg10: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg11: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>, arg12: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN> {
        assert_use_pool(arg1, arg14);
        assert!(0x2::coin::value<LP>(&arg2) > 0, 1);
        0x2::event::emit<EventWithdrawInitState>(withdraw_init_state_event(arg0, &arg2, arg3, arg9, arg10, arg11));
        let v0 = 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg0.vault) + arg0.strategy_borrowed;
        let v1 = if (0x2::coin::value<LP>(&arg2) == 0x2::balance::supply_value<LP>(&arg0.lp_supply)) {
            v0
        } else {
            muldiv(0x2::coin::value<LP>(&arg2), v0, 0x2::balance::supply_value<LP>(&arg0.lp_supply))
        };
        let (v2, v3) = if (v1 <= 0x2::balance::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&arg0.vault)) {
            (0x2::coin::from_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0x2::balance::split<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.vault, v1), arg14), 0)
        } else if (v1 == v0) {
            let v4 = 0x2::coin::from_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0x2::balance::withdraw_all<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.vault), arg14);
            let v5 = arg0.strategy_borrowed;
            let v6 = strategy_withdraw(arg0, v5, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
            let v7 = 0x2::coin::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg14);
            0x2::coin::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v7, v4);
            0x2::coin::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v7, v6);
            (v7, v5)
        } else {
            let v8 = 0x2::coin::from_balance<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(0x2::balance::withdraw_all<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut arg0.vault), arg14);
            let v9 = v1 - 0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&v8);
            let v10 = strategy_withdraw(arg0, v9, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14);
            let v11 = 0x2::coin::zero<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg14);
            0x2::coin::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v11, v8);
            0x2::coin::join<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(&mut v11, v10);
            (v11, v9)
        };
        let v12 = v2;
        arg0.strategy_borrowed = arg0.strategy_borrowed - v3;
        0x2::balance::decrease_supply<LP>(&mut arg0.lp_supply, 0x2::coin::into_balance<LP>(arg2));
        0x2::event::emit<EventWithdrawFinalState>(withdraw_final_state_event(arg0, v1, &v12, v3));
        v12
    }

    fun withdraw_final_state_event(arg0: &Pool, arg1: u64, arg2: &0x2::coin::Coin<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>, arg3: u64) : EventWithdrawFinalState {
        EventWithdrawFinalState{
            out_amt                 : arg1,
            out_coin_value          : 0x2::coin::value<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN>(arg2),
            withdrawn_from_strategy : arg3,
            pool_state              : get_pool_state(arg0),
        }
    }

    fun withdraw_init_state_event(arg0: &Pool, arg1: &0x2::coin::Coin<LP>, arg2: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP>, arg3: &0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::Fountain<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>, arg4: &0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0xce7ff77a83ea0cb6fd39bd8748e2ec89a3f41e8efdc3f4eb123e0ca37b184db2::buck::BUCK>, arg5: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x5d4b302506645c37ff133b98c4b50a5ae14841659738d6d733d59d0d217a93bf::coin::COIN, 0x2::sui::SUI>) : EventWithdrawInitState {
        EventWithdrawInitState{
            lp_withdraw_amount      : 0x2::coin::value<LP>(arg1),
            pool_state              : get_pool_state(arg0),
            fountain_staked_balance : 0x8f16cb934fa0c4ad403ac3fddaab8585a642f2073a47a32215a77448c3e353c6::fountain_core::get_staked_balance<0xf1b901d93cc3652ee26e8d88fff8dc7b9402b2b2e71a59b244f938a140affc5e::af_lp::AF_LP, 0x2::sui::SUI>(arg3),
            af_pool_state           : get_af_pool_state(arg2),
            kriya_pool_state        : get_kriya_pool_state(arg4),
            cetus_pool_state        : get_cetus_pool_state(arg5),
        }
    }

    // decompiled from Move bytecode v6
}

