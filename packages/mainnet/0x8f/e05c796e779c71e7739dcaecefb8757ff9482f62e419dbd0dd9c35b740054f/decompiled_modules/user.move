module 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::user {
    struct IncentiveAccountUnstakeEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        sender: address,
        timestamp: u64,
    }

    struct IncentiveAccountStakeEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        pool_records: vector<0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::PoolRecordData>,
        timestamp: u64,
    }

    struct IncentiveAccountRedeemRewardsEvent has copy, drop {
        sender: address,
        rewards_type: 0x1::type_name::TypeName,
        rewards: u64,
        rewards_fee: u64,
        timestamp: u64,
    }

    struct RefreshInactiveBoostEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        sender: address,
        timestamp: u64,
    }

    struct DeactivateBoostEvent has copy, drop {
        obligation_id: 0x2::object::ID,
        ve_sca_key: 0x2::object::ID,
        sender: address,
        timestamp: u64,
    }

    public entry fun force_unstake_unhealthy(arg0: &0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::IncentiveConfig, arg1: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::IncentivePools, arg2: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::IncentiveAccounts, arg3: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg4: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0xe7511600c924f1d0ac4b3fa5de3ae26b8845545902b015dc5fc7894307365d7b::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::assert_version_and_status(arg0);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::assert_incentive_pools(arg2, arg1);
        if (!0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_incentive_account_exist(arg2, arg3)) {
            return
        };
        if (0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_ve_sca_key_binded(arg2, arg3) == true) {
            0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::unbind_ve_sca_from_incentive_account(arg1, 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::get_binded_ve_sca(arg2, arg3), 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::typed_id::new<0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation>(arg3));
            0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::unbind_ve_sca(arg2, arg3);
        };
        update_points_internal(arg1, arg2, arg3, arg7);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::force_unstake_unhealthy(arg3, arg2, arg1, arg4, arg5, arg6, arg7);
        let v0 = IncentiveAccountUnstakeEvent{
            obligation_id : 0x2::object::id<0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation>(arg3),
            sender        : 0x2::tx_context::sender(arg8),
            timestamp     : 0x2::clock::timestamp_ms(arg7) / 1000,
        };
        0x2::event::emit<IncentiveAccountUnstakeEvent>(v0);
    }

    public entry fun stake(arg0: &0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::IncentiveConfig, arg1: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::IncentivePools, arg2: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::IncentiveAccounts, arg3: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::ObligationKey, arg4: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg5: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation_access::ObligationAccessStore, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::assert_version_and_status(arg0);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::assert_incentive_pools(arg2, arg1);
        0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::assert_key_match(arg4, arg3);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::create_if_not_exists(arg2, arg4, arg7);
        assert!(0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_ve_sca_key_binded(arg2, arg4) == false, 3);
        update_points_internal(arg1, arg2, arg4, arg6);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::stake(arg3, arg4, arg5, arg2, arg1, 0, 0, arg7);
        let v0 = IncentiveAccountStakeEvent{
            obligation_id : 0x2::object::id<0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation>(arg4),
            pool_records  : 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::pool_records_data(arg2, arg4),
            timestamp     : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<IncentiveAccountStakeEvent>(v0);
    }

    public entry fun unstake(arg0: &0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::IncentiveConfig, arg1: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::IncentivePools, arg2: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::IncentiveAccounts, arg3: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::ObligationKey, arg4: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::assert_version_and_status(arg0);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::assert_incentive_pools(arg2, arg1);
        0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::assert_key_match(arg4, arg3);
        if (!0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_incentive_account_exist(arg2, arg4)) {
            return
        };
        if (0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_ve_sca_key_binded(arg2, arg4) == true) {
            0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::unbind_ve_sca_from_incentive_account(arg1, 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::get_binded_ve_sca(arg2, arg4), 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::typed_id::new<0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation>(arg4));
            0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::unbind_ve_sca(arg2, arg4);
        };
        update_points_internal(arg1, arg2, arg4, arg5);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::unstake(arg3, arg4, arg2, arg1);
        let v0 = IncentiveAccountUnstakeEvent{
            obligation_id : 0x2::object::id<0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation>(arg4),
            sender        : 0x2::tx_context::sender(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<IncentiveAccountUnstakeEvent>(v0);
    }

    public fun deactivate_boost(arg0: &0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::IncentiveConfig, arg1: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::IncentivePools, arg2: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::IncentiveAccounts, arg3: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg4: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::assert_version_and_status(arg0);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::assert_incentive_pools(arg2, arg1);
        if (!0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_incentive_account_exist(arg2, arg3)) {
            return
        };
        update_points_internal(arg1, arg2, arg3, arg5);
        assert!(0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_ve_sca_key_binded(arg2, arg3) == true, 4);
        let v0 = 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::get_binded_ve_sca(arg2, arg3);
        assert!(*0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::typed_id::as_id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&v0) == 0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg4), 6);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::unbind_ve_sca_from_incentive_account(arg1, v0, 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::typed_id::new<0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation>(arg3));
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::unbind_ve_sca(arg2, arg3);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::recalculate_stake(arg3, arg2, arg1, 0, 0, arg6);
        let v1 = DeactivateBoostEvent{
            obligation_id : 0x2::object::id<0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation>(arg3),
            ve_sca_key    : 0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg4),
            sender        : 0x2::tx_context::sender(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<DeactivateBoostEvent>(v1);
    }

    public fun redeem_rewards<T0>(arg0: &0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::IncentiveConfig, arg1: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::IncentivePools, arg2: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::IncentiveAccounts, arg3: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::ObligationKey, arg4: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::assert_version_and_status(arg0);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::assert_incentive_pools(arg2, arg1);
        0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::assert_key_match(arg4, arg3);
        if (!0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_incentive_account_exist(arg2, arg4)) {
            return 0x2::coin::zero<T0>(arg6)
        };
        update_points_internal(arg1, arg2, arg4, arg5);
        let v0 = 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::claim_rewards<T0>(arg4, arg1, arg2);
        let v1 = 0x2::balance::value<T0>(&v0);
        let (v2, v3) = 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::reward_fee(arg1);
        let v4 = if (v2 > 0 && v3 > 0) {
            let v5 = 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::utils::mul_div(v1, v2, v3);
            if (v5 > 0) {
                v5
            } else {
                1
            }
        } else {
            0
        };
        let v6 = IncentiveAccountRedeemRewardsEvent{
            sender       : 0x2::tx_context::sender(arg6),
            rewards_type : 0x1::type_name::get<T0>(),
            rewards      : v1,
            rewards_fee  : v4,
            timestamp    : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<IncentiveAccountRedeemRewardsEvent>(v6);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v0, v4), arg6), 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::reward_fee_recipient(arg1));
        };
        0x2::coin::from_balance<T0>(v0, arg6)
    }

    public entry fun refresh_inactive_boost(arg0: &0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::IncentiveConfig, arg1: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::IncentivePools, arg2: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::IncentiveAccounts, arg3: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg4: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::assert_version_and_status(arg0);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::assert_incentive_pools(arg2, arg1);
        if (!0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_incentive_account_exist(arg2, arg4)) {
            return
        };
        assert!(0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_ve_sca_key_binded(arg2, arg4) == true, 4);
        let v0 = 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::get_binded_ve_sca(arg2, arg4);
        assert!(0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::ve_sca_amount(*0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::typed_id::as_id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(&v0), arg3, arg5) == 0, 5);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::unbind_ve_sca_from_incentive_account(arg1, v0, 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::typed_id::new<0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation>(arg4));
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::unbind_ve_sca(arg2, arg4);
        update_points_internal(arg1, arg2, arg4, arg5);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::recalculate_stake(arg4, arg2, arg1, 0, 0, arg6);
        let v1 = RefreshInactiveBoostEvent{
            obligation_id : 0x2::object::id<0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation>(arg4),
            sender        : 0x2::tx_context::sender(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<RefreshInactiveBoostEvent>(v1);
    }

    public entry fun stake_with_ve_sca(arg0: &0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::IncentiveConfig, arg1: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::IncentivePools, arg2: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::IncentiveAccounts, arg3: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::ObligationKey, arg4: &mut 0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg5: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation_access::ObligationAccessStore, arg6: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::config::VeScaProtocolConfig, arg7: &mut 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::VeScaTreasury, arg8: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaTable, arg9: &0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::assert_version_and_status(arg0);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::assert_incentive_pools(arg2, arg1);
        0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::assert_key_match(arg4, arg3);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::create_if_not_exists(arg2, arg4, arg11);
        let v0 = 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::typed_id::new<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg9);
        if (0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::is_ve_sca_key_binded(arg2, arg4) == false) {
            assert!(0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::is_ve_sca_binded(arg1, v0) == false, 1);
            0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::bind_ve_sca_to_incentive_account(arg1, v0, 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::typed_id::new<0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation>(arg4));
            0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::bind_ve_sca(arg2, arg4, v0);
        };
        assert!(0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::typed_id::to_id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::get_binded_ve_sca(arg2, arg4)) == 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::typed_id::to_id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(v0), 2);
        update_points_internal(arg1, arg2, arg4, arg10);
        0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::refresh(arg6, arg7, arg10);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::stake(arg3, arg4, arg5, arg2, arg1, 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::ve_sca_amount(0x2::object::id<0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::ve_sca::VeScaKey>(arg9), arg8, arg10), 0xcfe2d87aa5712b67cad2732edb6a2201bfdf592377e5c0968b7cb02099bd8e21::treasury::total_ve_sca_amount(arg7, arg10), arg11);
        let v1 = IncentiveAccountStakeEvent{
            obligation_id : 0x2::object::id<0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation>(arg4),
            pool_records  : 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::pool_records_data(arg2, arg4),
            timestamp     : 0x2::clock::timestamp_ms(arg10) / 1000,
        };
        0x2::event::emit<IncentiveAccountStakeEvent>(v1);
    }

    public entry fun update_points(arg0: &0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::IncentiveConfig, arg1: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::IncentivePools, arg2: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::IncentiveAccounts, arg3: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg4: &0x2::clock::Clock) {
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_config::assert_version_and_status(arg0);
        update_points_internal(arg1, arg2, arg3, arg4);
    }

    fun update_points_internal(arg0: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::IncentivePools, arg1: &mut 0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::IncentiveAccounts, arg2: &0xb03fa00e2d9f17d78a9d48bd94d8852abec68c19d55e819096b1e062e69bfad1::obligation::Obligation, arg3: &0x2::clock::Clock) {
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::assert_incentive_pools(arg1, arg0);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_pool::accrue_all_points(arg0, arg3);
        0x8fe05c796e779c71e7739dcaecefb8757ff9482f62e419dbd0dd9c35b740054f::incentive_account::accrue_all_points(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

