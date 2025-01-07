module 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::user {
    struct IncentiveAccountUnstakeEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        sender: address,
        timestamp: u64,
    }

    struct IncentiveAccountStakeEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        sender: address,
        timestamp: u64,
    }

    struct IncentiveAccountRedeemRewardsEvent has copy, drop {
        sender: address,
        rewards_type: 0x1::type_name::TypeName,
        rewards: u64,
        timestamp: u64,
    }

    public entry fun force_unstake_unhealthy<T0>(arg0: &mut 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::IncentivePools<T0>, arg1: &mut 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::IncentiveAccounts, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::assert_incentive_pools<T0>(arg1, arg0);
        if (!0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::is_incentive_account_exist(arg1, arg2)) {
            return
        };
        update_points<T0>(arg0, arg1, arg2, arg6);
        0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::force_unstake_unhealthy<T0>(arg2, arg1, arg0, arg3, arg4, arg5, arg6);
        let v0 = IncentiveAccountUnstakeEvent{
            obligation_id : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg2),
            sender        : 0x2::tx_context::sender(arg7),
            timestamp     : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<IncentiveAccountUnstakeEvent>(v0);
    }

    public entry fun stake<T0>(arg0: &mut 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::IncentivePools<T0>, arg1: &mut 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::IncentiveAccounts, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::assert_incentive_pools<T0>(arg1, arg0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg3, arg2);
        0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::create_if_not_exists(arg1, arg3, arg6);
        update_points<T0>(arg0, arg1, arg3, arg5);
        0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::stake<T0>(arg2, arg3, arg4, arg1, arg0);
        let v0 = IncentiveAccountStakeEvent{
            obligation_id : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg3),
            sender        : 0x2::tx_context::sender(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<IncentiveAccountStakeEvent>(v0);
    }

    public entry fun unstake<T0>(arg0: &mut 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::IncentivePools<T0>, arg1: &mut 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::IncentiveAccounts, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::assert_incentive_pools<T0>(arg1, arg0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg3, arg2);
        if (!0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::is_incentive_account_exist(arg1, arg3)) {
            return
        };
        update_points<T0>(arg0, arg1, arg3, arg4);
        0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::unstake<T0>(arg2, arg3, arg1, arg0);
        let v0 = IncentiveAccountUnstakeEvent{
            obligation_id : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg3),
            sender        : 0x2::tx_context::sender(arg5),
            timestamp     : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<IncentiveAccountUnstakeEvent>(v0);
    }

    public fun redeem_rewards<T0>(arg0: &mut 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::IncentivePools<T0>, arg1: &mut 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::IncentiveAccounts, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::assert_incentive_pools<T0>(arg1, arg0);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg3, arg2);
        if (!0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::is_incentive_account_exist(arg1, arg3)) {
            return 0x2::coin::zero<T0>(arg5)
        };
        update_points<T0>(arg0, arg1, arg3, arg4);
        let v0 = 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::claim_rewards<T0>(arg3, arg0, arg1);
        let v1 = IncentiveAccountRedeemRewardsEvent{
            sender       : 0x2::tx_context::sender(arg5),
            rewards_type : 0x1::type_name::get<T0>(),
            rewards      : 0x2::balance::value<T0>(&v0),
            timestamp    : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        0x2::event::emit<IncentiveAccountRedeemRewardsEvent>(v1);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    public entry fun update_points<T0>(arg0: &mut 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::IncentivePools<T0>, arg1: &mut 0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::IncentiveAccounts, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::assert_incentive_pools<T0>(arg1, arg0);
        0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_pool::accrue_all_points<T0>(arg0, arg3);
        0x41c0788f4ab64cf36dc882174f467634c033bf68c3c1b5ef9819507825eb510b::incentive_account::accrue_all_points<T0>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

