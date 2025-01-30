module 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::main {
    struct CreateFarmEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
    }

    struct AddLiquidityEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        deposit_amount: u64,
        old_total_deposit_share: u128,
        old_total_debt_share: u128,
        old_total_supply_share: u128,
        new_total_deposit_share: u128,
        new_total_debt_share: u128,
        new_total_supply_share: u128,
    }

    struct RemoveLiquidityEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        withdraw_coin_amount: u64,
        redeem_coin_amount: u64,
        old_total_deposit_share: u128,
        old_total_debt_share: u128,
        old_total_supply_share: u128,
        new_total_deposit_share: u128,
        new_total_debt_share: u128,
        new_total_supply_share: u128,
    }

    struct CompoundBorrowRewardStartEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        reward_coin: 0x1::string::String,
        reward_amount: u64,
    }

    struct CompoundBorrowRewardEndEvent has copy, drop {
        caller: address,
        farm_id: 0x2::object::ID,
        repay_coin: 0x1::string::String,
        repay_amount: u64,
    }

    struct Farm<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        collateral_weight: u64,
        total_deposit_share: u128,
        total_debt_share: u128,
        total_supply_share: u128,
        scoin_balance: 0x2::balance::Balance<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>,
        obligation_key: 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey,
        rewards: 0x2::bag::Bag,
    }

    public(friend) fun add_farm<T0, T1>(arg0: u64, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg4: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::max_percent(), 103);
        let (v0, v1, v2) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::open_obligation(arg1, arg7);
        let v3 = v1;
        let v4 = v0;
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg2, arg3, arg4, &v3, &mut v4, arg5, arg6, arg7);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::open_obligation::return_obligation(arg1, v4, v2);
        let v5 = Farm<T0, T1>{
            id                  : 0x2::object::new(arg7),
            collateral_weight   : arg0,
            total_deposit_share : 0,
            total_debt_share    : 0,
            total_supply_share  : 0,
            scoin_balance       : 0x2::balance::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(),
            obligation_key      : v3,
            rewards             : 0x2::bag::new(arg7),
        };
        0x2::transfer::public_share_object<Farm<T0, T1>>(v5);
        let v6 = CreateFarmEvent{
            caller  : 0x2::tx_context::sender(arg7),
            farm_id : 0x2::object::id<Farm<T0, T1>>(&v5),
        };
        0x2::event::emit<CreateFarmEvent>(v6);
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::Position, arg2: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig, arg3: 0x2::coin::Coin<T0>, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg7: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg8: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg9: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg10: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg11: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg12: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg13: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg14: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg15: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg3);
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg5, 0x1::type_name::get<T0>());
        let v2 = 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::mul_div(arg0.total_deposit_share, (v0 as u128), (v1 as u128));
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::unstake(arg7, arg8, arg9, &arg0.obligation_key, arg5, arg16, arg17);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::deposit_collateral::deposit_collateral<T0>(arg10, arg5, arg11, arg3, arg17);
        assert!(v1 + v0 == 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg5, 0x1::type_name::get<T0>()), 105);
        assert!(arg0.collateral_weight < 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::max_percent(), 103);
        let v3 = 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::mul_div_u64(v0, arg0.collateral_weight, 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::max_percent());
        let (v4, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg5, 0x1::type_name::get<T1>());
        let v6 = 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::mul_div(arg0.total_debt_share, (v3 as u128), (v4 as u128));
        let v7 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::borrow::borrow<T1>(arg10, arg5, &arg0.obligation_key, arg11, arg4, v3, arg12, arg16, arg17);
        assert!(0x2::coin::value<T1>(&v7) == v3, 106);
        let (v8, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg5, 0x1::type_name::get<T1>());
        assert!(v4 + v3 == v8, 107);
        if (0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::is_vesca_key_some(arg2)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake_with_ve_sca(arg7, arg8, arg9, &arg0.obligation_key, arg5, arg6, arg13, arg14, arg15, 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::borrow_mut_vesca_key(arg2), arg16, arg17);
        } else {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg7, arg8, arg9, &arg0.obligation_key, arg5, arg6, arg16, arg17);
        };
        let v10 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T1>(arg10, arg11, v7, arg16, arg17);
        let v11 = 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::mul_div(arg0.total_supply_share, (0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&v10) as u128), (0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance) as u128));
        0x2::coin::put<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.scoin_balance, v10);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg7, arg8, arg9, &arg0.obligation_key, arg5, arg6, arg16, arg17);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::increase_deposit_share(arg1, v2);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::increase_debt_share(arg1, v6);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::increase_supply_share(arg1, v11);
        arg0.total_deposit_share = arg0.total_deposit_share + v2;
        arg0.total_debt_share = arg0.total_debt_share + v6;
        arg0.total_supply_share = arg0.total_supply_share + v11;
        let v12 = AddLiquidityEvent{
            caller                  : 0x2::tx_context::sender(arg17),
            farm_id                 : 0x2::object::id<Farm<T0, T1>>(arg0),
            deposit_amount          : v0,
            old_total_deposit_share : arg0.total_deposit_share,
            old_total_debt_share    : arg0.total_debt_share,
            old_total_supply_share  : arg0.total_supply_share,
            new_total_deposit_share : arg0.total_deposit_share,
            new_total_debt_share    : arg0.total_debt_share,
            new_total_supply_share  : arg0.total_supply_share,
        };
        0x2::event::emit<AddLiquidityEvent>(v12);
    }

    public(friend) fun compound_borrow_reward_end<T0, T1>(arg0: &Farm<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg5: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg6: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg7: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg8: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T1>(arg4, arg2, arg5, arg1, arg9, arg10);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg6, arg7, arg8, &arg0.obligation_key, arg2, arg3, arg9, arg10);
        let v0 = CompoundBorrowRewardEndEvent{
            caller       : 0x2::tx_context::sender(arg10),
            farm_id      : 0x2::object::id<Farm<T0, T1>>(arg0),
            repay_coin   : 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::get_type_name_str<T1>(),
            repay_amount : 0x2::coin::value<T1>(&arg1),
        };
        0x2::event::emit<CompoundBorrowRewardEndEvent>(v0);
    }

    public(friend) fun compound_borrow_reward_start<T0, T1, T2>(arg0: &Farm<T0, T1>, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg3: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg4: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::unstake(arg2, arg3, arg4, &arg0.obligation_key, arg1, arg5, arg6);
        let v0 = 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::redeem_rewards<T2>(arg2, arg3, arg4, &arg0.obligation_key, arg1, arg5, arg6);
        let v1 = CompoundBorrowRewardStartEvent{
            caller        : 0x2::tx_context::sender(arg6),
            farm_id       : 0x2::object::id<Farm<T0, T1>>(arg0),
            reward_coin   : 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::get_type_name_str<T2>(),
            reward_amount : 0x2::coin::value<T2>(&v0),
        };
        0x2::event::emit<CompoundBorrowRewardStartEvent>(v1);
        v0
    }

    public fun info<T0, T1>(arg0: &Farm<T0, T1>) : (u64, u128, u128, u128, u64, u64) {
        (arg0.collateral_weight, arg0.total_deposit_share, arg0.total_debt_share, arg0.total_supply_share, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance), 0x2::bag::length(&arg0.rewards))
    }

    public fun info_v2<T0, T1>(arg0: &Farm<T0, T1>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : (u64, u64, u64) {
        let (v0, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg1, 0x1::type_name::get<T1>());
        (0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg1, 0x1::type_name::get<T0>()), v0, 0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::new(3000, arg0);
    }

    public(friend) fun open_position<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg6: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg7: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg8: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg9: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg10: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg11: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg12: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg13: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg14: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::Position {
        let v0 = 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::new(0x2::object::id<Farm<T0, T1>>(arg0), 0, 0, 0, arg16);
        let v1 = &mut v0;
        add_liquidity<T0, T1>(arg0, v1, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16);
        v0
    }

    public(friend) fun remove_all_liquidity<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig, arg2: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::Position, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg6: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg7: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg8: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg9: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg10: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg12: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg13: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg14: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg15: &0x2::clock::Clock, arg16: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::deposit_share(arg2);
        remove_liquidity<T0, T1>(arg0, v0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)
    }

    public(friend) fun remove_liquidity<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: u128, arg2: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::GlobalConfig, arg3: &mut 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::Position, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg6: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg7: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg8: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg9: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg10: &0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_config::IncentiveConfig, arg11: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_pool::IncentivePools, arg12: &mut 0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::incentive_account::IncentiveAccounts, arg13: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg14: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg15: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (_, v1, v2, v3) = 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::info(arg3);
        assert!(v1 >= arg1, 109);
        let v4 = 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::mul_div(v2, arg1, v1);
        let v5 = 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::mul_div(v3, arg1, v1);
        let (v6, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg4, 0x1::type_name::get<T1>());
        let v8 = 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::to_u64(0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::mul_div((v6 as u128), v4, arg0.total_debt_share));
        let v9 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T1>(arg6, arg7, 0x2::coin::take<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&mut arg0.scoin_balance, 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::to_u64(0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::mul_div((0x2::balance::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>(&arg0.scoin_balance) as u128), v5, arg0.total_supply_share)), arg17), arg16, arg17);
        assert!(0x2::coin::value<T1>(&v9) >= v8, 108);
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::unstake(arg10, arg11, arg12, &arg0.obligation_key, arg4, arg16, arg17);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::repay::repay<T1>(arg6, arg4, arg7, 0x2::coin::split<T1>(&mut v9, v8, arg17), arg16, arg17);
        let v10 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::withdraw_collateral::withdraw_collateral<T0>(arg6, arg4, &arg0.obligation_key, arg7, arg8, 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::to_u64(0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::utils::mul_div((0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::collateral(arg4, 0x1::type_name::get<T0>()) as u128), arg1, arg0.total_deposit_share)), arg9, arg16, arg17);
        if (0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::is_vesca_key_some(arg2)) {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake_with_ve_sca(arg10, arg11, arg12, &arg0.obligation_key, arg4, arg5, arg13, arg14, arg15, 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::borrow_mut_vesca_key(arg2), arg16, arg17);
        } else {
            0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg10, arg11, arg12, &arg0.obligation_key, arg4, arg5, arg16, arg17);
        };
        0x2875153e09f8145ab63527bc85c00f2bd102e12f9573c47f8cdf1a1cb62934::user::stake(arg10, arg11, arg12, &arg0.obligation_key, arg4, arg5, arg16, arg17);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::decrease_deposit_share(arg3, arg1);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::decrease_debt_share(arg3, v4);
        0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::position::decrease_supply_share(arg3, v5);
        arg0.total_deposit_share = arg0.total_deposit_share - arg1;
        arg0.total_debt_share = arg0.total_debt_share - v4;
        arg0.total_supply_share = arg0.total_supply_share - v5;
        let v11 = RemoveLiquidityEvent{
            caller                  : 0x2::tx_context::sender(arg17),
            farm_id                 : 0x2::object::id<Farm<T0, T1>>(arg0),
            withdraw_coin_amount    : 0x2::coin::value<T0>(&v10),
            redeem_coin_amount      : 0x2::coin::value<T1>(&v9),
            old_total_deposit_share : arg0.total_deposit_share,
            old_total_debt_share    : arg0.total_debt_share,
            old_total_supply_share  : arg0.total_supply_share,
            new_total_deposit_share : arg0.total_deposit_share,
            new_total_debt_share    : arg0.total_debt_share,
            new_total_supply_share  : arg0.total_supply_share,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v11);
        (v10, v9)
    }

    public(friend) fun set_collateral_weight<T0, T1>(arg0: &mut Farm<T0, T1>, arg1: u64) {
        assert!(arg1 <= 0xde726563dac34e5759c94d34e142d6b7ced4b8ca948b6d137638995568777d4f::global_config::max_percent(), 103);
        arg0.collateral_weight = arg1;
    }

    // decompiled from Move bytecode v6
}

