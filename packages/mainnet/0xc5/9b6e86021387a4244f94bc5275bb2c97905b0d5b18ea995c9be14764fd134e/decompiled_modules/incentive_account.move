module 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_account {
    struct IncentiveProgramLockKey has drop {
        dummy_field: bool,
    }

    struct IncentiveState has store {
        pool_type: 0x1::type_name::TypeName,
        amount: u64,
        points: u64,
        total_points: u64,
        index: u64,
    }

    struct IncentiveAccount has store, key {
        id: 0x2::object::UID,
        incentive_states: 0x2::table::Table<0x1::type_name::TypeName, IncentiveState>,
        incentive_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct IncentiveAccounts has store, key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::TypedID<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>, IncentiveAccount>,
        incentive_pools_id: 0x2::object::ID,
    }

    struct IncentiveAccountRedeemRewardsEvent has copy, drop {
        sender: address,
        stake_type: 0x1::type_name::TypeName,
        obligation_id: 0x2::object::ID,
        rewards_type: 0x1::type_name::TypeName,
        rewards: u64,
        rewards_fee: u64,
        timestamp: u64,
    }

    public fun incentive_account(arg0: &IncentiveAccounts, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : &IncentiveAccount {
        0x2::table::borrow<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::TypedID<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>, IncentiveAccount>(&arg0.accounts, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::new<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1))
    }

    public(friend) fun accrue_all_points<T0>(arg0: &0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>, arg1: &mut IncentiveAccounts, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::TypedID<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>, IncentiveAccount>(&mut arg1.accounts, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::new<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg2));
        assert!(0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::is_points_up_to_date<T0>(arg0, arg3), 3);
        let v1 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v0.incentive_types);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            accrue_points<T0>(arg0, v0, *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2));
            v2 = v2 + 1;
        };
    }

    fun accrue_points<T0>(arg0: &0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>, arg1: &mut IncentiveAccount, arg2: 0x1::type_name::TypeName) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentiveState>(&mut arg1.incentive_states, arg2);
        let v1 = 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::incentive_pool<T0>(arg0, arg2);
        if (v0.index >= 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::index(v1)) {
            return
        };
        if (v0.amount == 0) {
            v0.index = 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::index(v1);
            return
        };
        let v2 = 0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v0.amount, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::index(v1) - v0.index, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::base_index_rate());
        v0.index = 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::index(v1);
        v0.points = v0.points + v2;
        v0.total_points = v0.total_points + v2;
    }

    fun add_all_debts_from_obligation<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &mut IncentiveAccount, arg2: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>) {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt_types(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let (v3, _) = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::debt(arg0, v2);
            if (0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::is_pool_exist<T0>(arg2, v2)) {
                0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::stake<T0>(arg2, v2, v3);
                if (0x2::table::contains<0x1::type_name::TypeName, IncentiveState>(&arg1.incentive_states, v2)) {
                    let v5 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentiveState>(&mut arg1.incentive_states, v2);
                    v5.amount = v3;
                    v5.index = 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::index(0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::incentive_pool<T0>(arg2, v2));
                } else {
                    0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.incentive_types, v2);
                    let v6 = IncentiveState{
                        pool_type    : v2,
                        amount       : v3,
                        points       : 0,
                        total_points : 0,
                        index        : 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::index(0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::incentive_pool<T0>(arg2, v2)),
                    };
                    0x2::table::add<0x1::type_name::TypeName, IncentiveState>(&mut arg1.incentive_states, v2, v6);
                };
            };
            v1 = v1 + 1;
        };
    }

    public fun amount(arg0: &IncentiveState) : u64 {
        arg0.amount
    }

    public fun assert_incentive_pools<T0>(arg0: &IncentiveAccounts, arg1: &0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>) {
        assert!(arg0.incentive_pools_id == 0x2::object::id<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>>(arg1), 4);
    }

    public(friend) fun claim_rewards<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>, arg2: &mut IncentiveAccounts, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x2::table::borrow_mut<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::TypedID<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>, IncentiveAccount>(&mut arg2.accounts, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::new<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg0));
        let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v2.incentive_types);
        let v4 = 0;
        while (v4 < 0x1::vector::length<0x1::type_name::TypeName>(&v3)) {
            let v5 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v4);
            let v6 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentiveState>(&mut v2.incentive_states, v5);
            let (v7, v8) = 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::claim_rewards<T0>(arg1, v6.points);
            v6.points = v6.points - v7;
            let (v9, v10) = 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::reward_fee_rates<T0>(arg1);
            let v11 = if (v10 > 0 && v9 > 0) {
                0xad013d5fde39e15eabda32b3dbdafd67dac32b798ce63237c27a8f73339b9b6f::u64::mul_div(v8, v9, v10)
            } else {
                0
            };
            v1 = v1 + v11;
            let v12 = v0 + v8;
            v0 = v12 - v11;
            let v13 = IncentiveAccountRedeemRewardsEvent{
                sender        : 0x2::tx_context::sender(arg4),
                stake_type    : v5,
                obligation_id : 0x2::object::id<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg0),
                rewards_type  : 0x1::type_name::get<T0>(),
                rewards       : v8,
                rewards_fee   : v11,
                timestamp     : 0x2::clock::timestamp_ms(arg3) / 1000,
            };
            0x2::event::emit<IncentiveAccountRedeemRewardsEvent>(v13);
            v4 = v4 + 1;
        };
        (v0, v1)
    }

    public(friend) fun create_if_not_exists(arg0: &mut IncentiveAccounts, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::TypedID<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>, IncentiveAccount>(&arg0.accounts, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::new<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1))) {
            let v0 = IncentiveAccount{
                id               : 0x2::object::new(arg2),
                incentive_states : 0x2::table::new<0x1::type_name::TypeName, IncentiveState>(arg2),
                incentive_types  : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            };
            0x2::table::add<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::TypedID<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>, IncentiveAccount>(&mut arg0.accounts, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::new<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1), v0);
        };
    }

    public(friend) fun create_incentive_accounts<T0>(arg0: &0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>, arg1: &mut 0x2::tx_context::TxContext) : IncentiveAccounts {
        IncentiveAccounts{
            id                 : 0x2::object::new(arg1),
            accounts           : 0x2::table::new<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::TypedID<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>, IncentiveAccount>(arg1),
            incentive_pools_id : 0x2::object::id<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>>(arg0),
        }
    }

    public(friend) fun force_unstake_unhealthy<T0>(arg0: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg1: &mut IncentiveAccounts, arg2: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::TypedID<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>, IncentiveAccount>(&mut arg1.accounts, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::new<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg0));
        remove_all_amount_from_incentive_state<T0>(v0, arg2);
        let v1 = IncentiveProgramLockKey{dummy_field: false};
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::lock_obligation::force_unlock_unhealthy<IncentiveProgramLockKey>(arg0, arg3, arg4, arg5, arg6, v1);
    }

    public fun incentive_state(arg0: &IncentiveAccount, arg1: 0x1::type_name::TypeName) : &IncentiveState {
        0x2::table::borrow<0x1::type_name::TypeName, IncentiveState>(&arg0.incentive_states, arg1)
    }

    public fun incentive_types(arg0: &IncentiveAccount) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.incentive_types
    }

    public fun index(arg0: &IncentiveState) : u64 {
        arg0.index
    }

    public fun is_incentive_account_exist(arg0: &IncentiveAccounts, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation) : bool {
        0x2::table::contains<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::TypedID<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>, IncentiveAccount>(&arg0.accounts, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::new<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1))
    }

    public fun points(arg0: &IncentiveState) : u64 {
        arg0.points
    }

    public fun pool_type(arg0: &IncentiveState) : 0x1::type_name::TypeName {
        arg0.pool_type
    }

    fun remove_all_amount_from_incentive_state<T0>(arg0: &mut IncentiveAccount, arg1: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>) {
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.incentive_types);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1);
            let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, IncentiveState>(&mut arg0.incentive_states, v2);
            if (v3.amount > 0) {
                if (0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::is_pool_exist<T0>(arg1, v2)) {
                    0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::unstake<T0>(arg1, v2, v3.amount);
                };
                v3.amount = 0;
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun stake<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation_access::ObligationAccessStore, arg3: &mut IncentiveAccounts, arg4: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>) {
        let v0 = 0x2::table::borrow_mut<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::TypedID<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>, IncentiveAccount>(&mut arg3.accounts, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::new<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1));
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::lock_key(arg1);
        if (0x1::option::is_some<0x1::type_name::TypeName>(&v1)) {
            assert!(0x1::option::destroy_some<0x1::type_name::TypeName>(v1) == 0x1::type_name::get<IncentiveProgramLockKey>(), 1);
            abort 2
        };
        remove_all_amount_from_incentive_state<T0>(v0, arg4);
        add_all_debts_from_obligation<T0>(arg1, v0, arg4);
        let v2 = IncentiveProgramLockKey{dummy_field: false};
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::lock<IncentiveProgramLockKey>(arg1, arg0, arg2, true, true, false, false, true, v2);
    }

    public fun total_points(arg0: &IncentiveState) : u64 {
        arg0.total_points
    }

    public(friend) fun unstake<T0>(arg0: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::ObligationKey, arg1: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation, arg2: &mut IncentiveAccounts, arg3: &mut 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::incentive_pool::IncentivePools<T0>) {
        let v0 = 0x2::table::borrow_mut<0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::TypedID<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>, IncentiveAccount>(&mut arg2.accounts, 0xe3d09900eac53114d80735435c4be60c361d52e657c6832c6f9b05b8936aadda::typed_id::new<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::Obligation>(arg1));
        remove_all_amount_from_incentive_state<T0>(v0, arg3);
        let v1 = IncentiveProgramLockKey{dummy_field: false};
        0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::obligation::unlock<IncentiveProgramLockKey>(arg1, arg0, v1);
    }

    // decompiled from Move bytecode v6
}

