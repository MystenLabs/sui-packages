module 0xc9b748278fc00f62716140262b799dd6a5460e80271ebf38dffbd1bd15b9a38::investor {
    struct My_navi_account has store, key {
        id: 0x2::object::UID,
        navi_account: 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::AccountCap,
    }

    struct My_scallop_account<phantom T0> has store, key {
        id: 0x2::object::UID,
        scallop_pool_account: 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::SpoolAccount<T0>,
    }

    struct Investor<phantom T0> has store, key {
        id: 0x2::object::UID,
        invested: u64,
        s_acc: My_scallop_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>,
        navi_acc: My_navi_account,
    }

    struct CheckStake has copy, drop {
        val: u64,
    }

    public fun borrow_from_navi<T0>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::borrow_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &arg0.navi_acc.navi_account), arg8)
    }

    public fun check_stake_scallop<T0>(arg0: &mut Investor<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = CheckStake{val: 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.s_acc.scallop_pool_account)};
        0x2::event::emit<CheckStake>(v0);
    }

    public fun collect_all_rewards_and_reinvest<T0, T1>(arg0: &mut Investor<T1>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: u8, arg7: u8, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg11: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg12: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg13: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<T1>, arg14: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<T0>, arg15: u8, arg16: u8, arg17: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>, T0>(arg10, arg14, &mut arg0.s_acc.scallop_pool_account, arg1, arg17);
        let v1 = 0x2::coin::value<T0>(&v0);
        let v2 = if (v1 > 0) {
            deposit_to_navi<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, v0, arg8, arg9, arg10, arg11, arg12, arg17);
            v1
        } else {
            0x2::coin::destroy_zero<T0>(v0);
            0
        };
        let v3 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<T1>(arg1, arg9, arg13, arg3, arg15, arg16, &arg0.navi_acc.navi_account);
        let v4 = 0x2::balance::value<T1>(&v3);
        let v5 = if (v4 > 0) {
            let v6 = 0x2::coin::from_balance<T1>(v3, arg17);
            deposit_to_scallop<T1>(arg0, arg10, arg11, arg12, v6, arg1, arg17);
            v4
        } else {
            0x2::balance::destroy_zero<T1>(v3);
            0
        };
        v2 + v5
    }

    public fun create<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = create_scallop_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, arg1, arg2);
        let v2 = Investor<T0>{
            id       : v0,
            invested : 0,
            s_acc    : v1,
            navi_acc : create_navi_account(arg2),
        };
        0x2::transfer::public_share_object<Investor<T0>>(v2);
    }

    public fun create_navi_account(arg0: &mut 0x2::tx_context::TxContext) : My_navi_account {
        My_navi_account{
            id           : 0x2::object::new(arg0),
            navi_account : 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::lending::create_account(arg0),
        }
    }

    fun create_scallop_account<T0>(arg0: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : My_scallop_account<T0> {
        My_scallop_account<T0>{
            id                   : 0x2::object::new(arg2),
            scallop_pool_account : 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::new_spool_account<T0>(arg0, arg1, arg2),
        }
    }

    public fun deposit_to_navi<T0, T1>(arg0: &mut Investor<T1>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: u8, arg7: u8, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg12: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg13: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg8);
        arg0.invested = arg0.invested + v0;
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg1, arg3, arg4, arg6, arg8, arg9, arg10, &arg0.navi_acc.navi_account);
        let v1 = borrow_from_navi<T1>(arg0, arg1, arg2, arg3, arg5, arg7, (((v0 as u128) * 5 / 10) as u64), arg10, arg14);
        deposit_to_scallop<T1>(arg0, arg11, arg12, arg13, v1, arg1, arg14);
    }

    public fun deposit_to_scallop<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, arg4, arg5, arg6);
        let v1 = &mut arg0.s_acc;
        stake_scoin<T0>(v1, arg1, v0, arg5, arg6);
    }

    public fun repay_to_navi<T0>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &arg0.navi_acc.navi_account), arg8), 0x2::tx_context::sender(arg8));
    }

    public fun stake_scoin<T0>(arg0: &mut My_scallop_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1, &mut arg0.scallop_pool_account, arg2, arg3, arg4);
    }

    public fun unstake_and_withdraw_from_scallop<T0>(arg0: &mut Investor<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg3, &mut arg0.s_acc.scallop_pool_account, 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0.s_acc.scallop_pool_account), arg4, arg5);
        withdraw_from_scallop<T0>(arg1, arg2, v0, arg4, arg5)
    }

    public fun withdraw_from_navi<T0, T1>(arg0: &mut Investor<T1>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: u8, arg7: u8, arg8: u64, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg12: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg13: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = unstake_and_withdraw_from_scallop<T1>(arg0, arg12, arg13, arg11, arg1, arg14);
        repay_to_navi<T1>(arg0, arg1, arg2, arg3, arg5, arg7, v0, arg10, arg14);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg6, arg8, arg9, arg10, &mut arg0.navi_acc.navi_account);
        arg0.invested = arg0.invested - 0x2::balance::value<T0>(&v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg14), 0x2::tx_context::sender(arg14));
        let v2 = (arg0.invested as u128) * 5 / 10;
        if (v2 > 0) {
            let v3 = borrow_from_navi<T1>(arg0, arg1, arg2, arg3, arg5, arg7, (v2 as u64), arg10, arg14);
            deposit_to_scallop<T1>(arg0, arg11, arg12, arg13, v3, arg1, arg14);
        };
    }

    public fun withdraw_from_scallop<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

