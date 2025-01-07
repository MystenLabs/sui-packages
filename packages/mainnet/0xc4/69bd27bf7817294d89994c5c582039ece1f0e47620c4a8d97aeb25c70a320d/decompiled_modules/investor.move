module 0xc469bd27bf7817294d89994c5c582039ece1f0e47620c4a8d97aeb25c70a320d::investor {
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
        safe_borrow: u256,
        performance_fee: u64,
        max_cap_performance_fee: u64,
    }

    struct VSUI has drop {
        dummy_field: bool,
    }

    struct CheckStake has copy, drop {
        val: u64,
        loan: u64,
    }

    fun borrow_from_navi<T0>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: u64, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::borrow_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &arg0.navi_acc.navi_account), arg8)
    }

    public fun change_safe_borrow<T0>(arg0: &0xc469bd27bf7817294d89994c5c582039ece1f0e47620c4a8d97aeb25c70a320d::alpha::Admin_cap, arg1: &mut Investor<T0>, arg2: u256) {
        arg1.safe_borrow = arg2;
    }

    public(friend) fun collect_all_rewards_and_reinvest<T0, T1>(arg0: &mut Investor<T1>, arg1: &mut Investor<VSUI>, arg2: &mut 0xc469bd27bf7817294d89994c5c582039ece1f0e47620c4a8d97aeb25c70a320d::distributor::Distributor, arg3: &0x2::clock::Clock, arg4: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<0x2::sui::SUI>, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg9: u8, arg10: u8, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg12: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg13: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg14: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg15: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg16: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::IncentiveFundsPool<VSUI>, arg17: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::rewards_pool::RewardsPool<0x2::sui::SUI>, arg18: u8, arg19: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg20: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg21: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<VSUI, 0x2::sui::SUI>, arg22: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg23: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::redeem_rewards<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>, 0x2::sui::SUI>(arg13, arg17, &mut arg0.s_acc.scallop_pool_account, arg3, arg23);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<VSUI>(arg3, arg12, arg16, arg5, arg18, 1, &arg0.navi_acc.navi_account);
        0x2::balance::join<VSUI>(&mut v1, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::claim_reward_with_account_cap<VSUI>(arg3, arg12, arg16, arg5, arg10, 3, &arg0.navi_acc.navi_account));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v0, 0x2::coin::value<0x2::sui::SUI>(&v0) * arg0.performance_fee / 100, arg23), 0xc469bd27bf7817294d89994c5c582039ece1f0e47620c4a8d97aeb25c70a320d::distributor::get_fee_wallet_address(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<VSUI>>(0x2::coin::from_balance<VSUI>(0x2::balance::split<VSUI>(&mut v1, 0x2::balance::value<VSUI>(&v1) * arg0.performance_fee / 100), arg23), 0xc469bd27bf7817294d89994c5c582039ece1f0e47620c4a8d97aeb25c70a320d::distributor::get_fee_wallet_address(arg2));
        let v2 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v3 = 0x1::string::utf8(b"SUI");
        if (0x1::string::index_of(&v2, &v3) < 0x1::string::length(&v2)) {
            let v4 = 0x2::coin::value<0x2::sui::SUI>(&v0);
            if (v4 > 0) {
                deposit_to_navi<0x2::sui::SUI, T1>(arg0, arg3, arg4, arg5, arg7, arg8, arg9, arg10, v0, arg11, arg12, arg13, arg14, arg15, arg23);
                arg0.invested = arg0.invested + v4;
            } else {
                0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
            };
            if (0x2::balance::value<VSUI>(&v1) > 0) {
                let v5 = 0x2::coin::from_balance<VSUI>(v1, arg23);
                deposit_to_scallop<VSUI>(arg1, arg13, arg14, arg15, v5, arg3, arg23);
            } else {
                0x2::balance::destroy_zero<VSUI>(v1);
            };
        } else {
            let v6 = 0x2::coin::from_balance<VSUI>(v1, arg23);
            let v7 = convert_vsui<T1>(v6, arg22, arg21, arg20, arg3, arg23);
            let v8 = convert_sui<T0>(v0, arg22, arg19, arg3, arg23);
            let v9 = 0x2::coin::value<T0>(&v8);
            if (v9 > 0) {
                deposit_to_navi<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg8, arg9, arg10, v8, arg11, arg12, arg13, arg14, arg15, arg23);
                arg0.invested = arg0.invested + v9;
            } else {
                0x2::coin::destroy_zero<T0>(v8);
            };
            if (0x2::coin::value<T1>(&v7) > 0) {
                deposit_to_scallop<T1>(arg0, arg13, arg14, arg15, v7, arg3, arg23);
            } else {
                0x2::coin::destroy_zero<T1>(v7);
            };
        };
        (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg5, arg9, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc.navi_account)) as u64)
    }

    fun convert_sui<T0>(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0xc469bd27bf7817294d89994c5c582039ece1f0e47620c4a8d97aeb25c70a320d::converter::swap_a2b<0x2::sui::SUI, T0>(arg1, arg2, arg0, true, 0x2::coin::value<0x2::sui::SUI>(&arg0), arg3, arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg4));
        v1
    }

    fun convert_vsui<T0>(arg0: 0x2::coin::Coin<VSUI>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<VSUI, 0x2::sui::SUI>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0xc469bd27bf7817294d89994c5c582039ece1f0e47620c4a8d97aeb25c70a320d::converter::swap_a2b<VSUI, 0x2::sui::SUI>(arg1, arg2, arg0, true, 0x2::coin::value<VSUI>(&arg0), arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<VSUI>>(v0, 0x2::tx_context::sender(arg5));
        convert_sui<T0>(v1, arg1, arg3, arg4, arg5)
    }

    public fun create<T0>(arg0: &0xc469bd27bf7817294d89994c5c582039ece1f0e47620c4a8d97aeb25c70a320d::alpha::Admin_cap, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: &0x2::clock::Clock, arg3: u256, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = create_scallop_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1, arg2, arg5);
        let v2 = Investor<T0>{
            id                      : v0,
            invested                : 0,
            s_acc                   : v1,
            navi_acc                : create_navi_account(arg5),
            safe_borrow             : arg3,
            performance_fee         : 0,
            max_cap_performance_fee : arg4,
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

    public(friend) fun deposit_to_navi<T0, T1>(arg0: &mut Investor<T1>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: u8, arg7: u8, arg8: 0x2::coin::Coin<T0>, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg11: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg12: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg13: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg8);
        arg0.invested = arg0.invested + v0;
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::deposit_with_account_cap<T0>(arg1, arg3, arg4, arg6, arg8, arg9, arg10, &arg0.navi_acc.navi_account);
        let v1 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_asset_ltv(arg3, arg6);
        let (_, v3, _) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg3, arg6));
        let (_, v6, _) = 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::get_token_price(arg1, arg2, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::get_oracle_id(arg3, arg7));
        let v8 = (((v0 as u256) * v3 * ((v1 - v1 * arg0.safe_borrow / 100) as u256) / 100 / v6) as u64);
        let v9 = borrow_from_navi<T1>(arg0, arg1, arg2, arg3, arg5, arg7, v8, arg10, arg14);
        deposit_to_scallop<T1>(arg0, arg11, arg12, arg13, v9, arg1, arg14);
    }

    fun deposit_to_scallop<T0>(arg0: &mut Investor<T0>, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: 0x2::coin::Coin<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, arg4, arg5, arg6);
        0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0);
        let v1 = &mut arg0.s_acc;
        stake_scoin<T0>(v1, arg1, v0, arg5, arg6);
    }

    fun repay_to_navi<T0>(arg0: &mut Investor<T0>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: 0x2::coin::Coin<T0>, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg8: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::repay_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, &arg0.navi_acc.navi_account), arg8), 0x2::tx_context::sender(arg8));
    }

    public fun set_performance_fee<T0>(arg0: &0xc469bd27bf7817294d89994c5c582039ece1f0e47620c4a8d97aeb25c70a320d::alpha::Admin_cap, arg1: &mut Investor<T0>, arg2: u64) {
        assert!(arg2 <= arg1.max_cap_performance_fee, 9);
        arg1.performance_fee = arg2;
    }

    fun stake_scoin<T0>(arg0: &mut My_scallop_account<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg1: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg2: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::stake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg1, &mut arg0.scallop_pool_account, arg2, arg3, arg4);
    }

    fun unstake_and_withdraw_from_scallop<T0>(arg0: &mut Investor<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::user::unstake<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg3, &mut arg0.s_acc.scallop_pool_account, arg5, arg4, arg6);
        withdraw_from_scallop<T0>(arg1, arg2, v0, arg4, arg6)
    }

    public(friend) fun withdraw_from_navi<T0, T1>(arg0: &mut Investor<T1>, arg1: &0x2::clock::Clock, arg2: &0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T1>, arg6: u8, arg7: u8, arg8: u64, arg9: u64, arg10: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg11: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg12: &mut 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool::Spool, arg13: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg14: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg15: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let v0 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_loan_balance(arg3, arg7, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc.navi_account));
        let v1 = (((arg8 as u256) * v0 / (arg9 as u256)) as u64);
        let v2 = 0xe87f1b2d498106a2c61421cec75b7b5c5e348512b0dc263949a0e7a3c256571a::spool_account::stake_amount<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.s_acc.scallop_pool_account);
        let v3 = (arg8 as u128) * (v2 as u128) / (arg9 as u128);
        let v4 = CheckStake{
            val  : (v3 as u64),
            loan : v2,
        };
        0x2::event::emit<CheckStake>(v4);
        let v5 = unstake_and_withdraw_from_scallop<T1>(arg0, arg13, arg14, arg12, arg1, (v3 as u64), arg15);
        let v6 = 0x2::coin::split<T1>(&mut v5, v1, arg15);
        let v7 = CheckStake{
            val  : 0x2::coin::value<T1>(&v5),
            loan : (v0 as u64),
        };
        0x2::event::emit<CheckStake>(v7);
        let v8 = CheckStake{
            val  : 123,
            loan : v1,
        };
        0x2::event::emit<CheckStake>(v8);
        let v9 = CheckStake{
            val  : 321,
            loan : (0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::logic::user_collateral_balance(arg3, arg6, 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::account::account_owner(&arg0.navi_acc.navi_account)) as u64),
        };
        0x2::event::emit<CheckStake>(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v5, 0x2::tx_context::sender(arg15));
        repay_to_navi<T1>(arg0, arg1, arg2, arg3, arg5, arg7, v6, arg11, arg15);
        let v10 = 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::withdraw_with_account_cap<T0>(arg1, arg2, arg3, arg4, arg6, arg8, arg10, arg11, &mut arg0.navi_acc.navi_account);
        let v11 = if (0x2::balance::value<T0>(&v10) > arg0.invested) {
            0
        } else {
            arg0.invested - 0x2::balance::value<T0>(&v10)
        };
        arg0.invested = v11;
        v10
    }

    fun withdraw_from_scallop<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg2: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg0, arg1, arg2, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

