module 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::user {
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

    public entry fun force_unstake_unhealthy<T0>(arg0: &0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::version::Version, arg1: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>, arg2: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::IncentiveAccounts, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg5: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg6: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::version::assert_current_version(arg0);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::assert_incentive_pools<T0>(arg2, arg1);
        if (!0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::is_incentive_account_exist(arg2, arg3)) {
            return
        };
        update_points<T0>(arg0, arg1, arg2, arg3, arg7);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::force_unstake_unhealthy<T0>(arg3, arg2, arg1, arg4, arg5, arg6, arg7);
        let v0 = IncentiveAccountUnstakeEvent{
            obligation_id : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg3),
            sender        : 0x2::tx_context::sender(arg8),
            timestamp     : 0x2::clock::timestamp_ms(arg7) / 1000,
        };
        0x2::event::emit<IncentiveAccountUnstakeEvent>(v0);
    }

    public entry fun stake<T0>(arg0: &0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::version::Version, arg1: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>, arg2: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::IncentiveAccounts, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::version::assert_current_version(arg0);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::assert_incentive_pools<T0>(arg2, arg1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg4, arg3);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::create_if_not_exists(arg2, arg4, arg7);
        update_points<T0>(arg0, arg1, arg2, arg4, arg6);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::stake<T0>(arg3, arg4, arg5, arg2, arg1);
        let v0 = IncentiveAccountStakeEvent{
            obligation_id : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg4),
            sender        : 0x2::tx_context::sender(arg7),
            timestamp     : 0x2::clock::timestamp_ms(arg6) / 1000,
        };
        0x2::event::emit<IncentiveAccountStakeEvent>(v0);
    }

    public entry fun unstake<T0>(arg0: &0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::version::Version, arg1: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>, arg2: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::IncentiveAccounts, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg4: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::version::assert_current_version(arg0);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::assert_incentive_pools<T0>(arg2, arg1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg4, arg3);
        if (!0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::is_incentive_account_exist(arg2, arg4)) {
            return
        };
        update_points<T0>(arg0, arg1, arg2, arg4, arg5);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::unstake<T0>(arg3, arg4, arg2, arg1);
        let v0 = IncentiveAccountUnstakeEvent{
            obligation_id : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg4),
            sender        : 0x2::tx_context::sender(arg6),
            timestamp     : 0x2::clock::timestamp_ms(arg5) / 1000,
        };
        0x2::event::emit<IncentiveAccountUnstakeEvent>(v0);
    }

    public fun redeem_rewards<T0>(arg0: &0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::version::Version, arg1: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>, arg2: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::IncentiveAccounts, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::version::assert_current_version(arg0);
        assert!(!0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::is_ve_sca_as_rewards<T0>(arg1), 1);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::assert_incentive_pools<T0>(arg2, arg1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg4, arg3);
        if (!0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::is_incentive_account_exist(arg2, arg4)) {
            return 0x2::coin::zero<T0>(arg6)
        };
        update_points<T0>(arg0, arg1, arg2, arg4, arg5);
        let (v0, v1) = 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::claim_rewards<T0>(arg4, arg1, arg2, arg5, arg6);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::take_rewards<T0>(arg1, v1), arg6), 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::reward_fee_recipient<T0>(arg1));
        };
        0x2::coin::from_balance<T0>(0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::take_rewards<T0>(arg1, v0), arg6)
    }

    public fun redeem_ve_sca_rewards<T0>(arg0: &0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::version::Version, arg1: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>, arg2: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::IncentiveAccounts, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg4: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg5: &0xde6e897236ccc66d6eaa700340d5b75819650c94c76f2de2af4f35828bbc5f0b::linear_ve_sca::LinearVeScaConfig, arg6: &mut 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeScaTreasury, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0xa4e82763f9c719570d948e47dfc42992d35b29c756c59d367e81f00d6a685bd1::ve_sca::VeSca {
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::version::assert_current_version(arg0);
        assert!(0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::is_ve_sca_as_rewards<T0>(arg1), 1);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::assert_incentive_pools<T0>(arg2, arg1);
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::assert_key_match(arg4, arg3);
        assert!(0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::is_incentive_account_exist(arg2, arg4), 2);
        update_points<T0>(arg0, arg1, arg2, arg4, arg7);
        let (v0, _) = 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::claim_rewards<T0>(arg4, arg1, arg2, arg7, arg8);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::mint_ve_sca(arg5, arg6, v0, arg7, arg8)
    }

    public entry fun update_points<T0>(arg0: &0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::version::Version, arg1: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>, arg2: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::IncentiveAccounts, arg3: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg4: &0x2::clock::Clock) {
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::version::assert_current_version(arg0);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::assert_incentive_pools<T0>(arg2, arg1);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::accrue_all_points<T0>(arg1, arg4);
        0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account::accrue_all_points<T0>(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

