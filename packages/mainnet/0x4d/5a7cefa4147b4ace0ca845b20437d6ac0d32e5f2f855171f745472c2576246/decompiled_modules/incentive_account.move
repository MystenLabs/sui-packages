module 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_account {
    struct IncentiveProgramLockKey has drop {
        dummy_field: bool,
    }

    struct EarningWeightData has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        weighted_amount: u64,
    }

    struct PoolRecordData has copy, drop, store {
        pool_type: 0x1::type_name::TypeName,
        earning_weights: vector<EarningWeightData>,
        debt_amount: u64,
    }

    struct PoolPoint has store {
        weighted_amount: u64,
        points: u64,
        total_points: u64,
        index: u64,
    }

    struct AccountPoolRecord has store {
        pool_type: 0x1::type_name::TypeName,
        points: 0x2::table::Table<0x1::type_name::TypeName, PoolPoint>,
        points_list: vector<0x1::type_name::TypeName>,
        amount: u64,
    }

    struct IncentiveAccount has store, key {
        id: 0x2::object::UID,
        pool_records: 0x2::table::Table<0x1::type_name::TypeName, AccountPoolRecord>,
        pool_types: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        binded_ve_sca_key: 0x1::option::Option<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>>,
    }

    struct IncentiveAccounts has key {
        id: 0x2::object::UID,
        accounts: 0x2::table::Table<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>,
        incentive_pools_id: 0x2::object::ID,
    }

    public fun incentive_account(arg0: &IncentiveAccounts, arg1: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation) : &IncentiveAccount {
        0x2::table::borrow<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&arg0.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg1))
    }

    public fun account_pool_record(arg0: &IncentiveAccount, arg1: 0x1::type_name::TypeName) : &AccountPoolRecord {
        0x2::table::borrow<0x1::type_name::TypeName, AccountPoolRecord>(&arg0.pool_records, arg1)
    }

    public(friend) fun accrue_all_points(arg0: &0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools, arg1: &mut IncentiveAccounts, arg2: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&mut arg1.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg2));
        assert!(0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::is_points_up_to_date(arg0, arg3), 3);
        let v1 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v0.pool_types);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v1)) {
            accrue_points(arg0, v0, *0x1::vector::borrow<0x1::type_name::TypeName>(&v1, v2));
            v2 = v2 + 1;
        };
    }

    fun accrue_points(arg0: &0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools, arg1: &mut IncentiveAccount, arg2: 0x1::type_name::TypeName) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountPoolRecord>(&mut arg1.pool_records, arg2);
        let v1 = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::incentive_pool(arg0, arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0.points_list)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0.points_list, v2);
            let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PoolPoint>(&mut v0.points, v3);
            let v5 = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::pool_point(v1, v3);
            if (v4.index >= 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::index(v5)) {
                v2 = v2 + 1;
                continue
            };
            if (v0.amount == 0) {
                v4.index = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::index(v5);
                v2 = v2 + 1;
                continue
            };
            let v6 = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::utils::mul_div(v4.weighted_amount, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::index(v5) - v4.index, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::base_index_rate());
            v4.index = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::index(v5);
            v4.points = v4.points + v6;
            v4.total_points = v4.total_points + v6;
            v2 = v2 + 1;
        };
    }

    fun add_all_debts_from_obligation(arg0: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation, arg1: &mut IncentiveAccount, arg2: &mut 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::debt_types(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v1);
            let (v3, _) = 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::debt(arg0, v2);
            if (0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::is_pool_exist(arg2, v2)) {
                0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::stake(arg2, v2, v3);
                let v5 = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::incentive_pool_mut(arg2, v2);
                update_weighted_amount(v5, arg1, arg3, arg4, v3, arg5);
            };
            v1 = v1 + 1;
        };
    }

    public fun amount(arg0: &AccountPoolRecord) : u64 {
        arg0.amount
    }

    public fun assert_incentive_pools(arg0: &IncentiveAccounts, arg1: &0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools) {
        assert!(arg0.incentive_pools_id == 0x2::object::id<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools>(arg1), 4);
    }

    public(friend) fun bind_ve_sca(arg0: &mut IncentiveAccounts, arg1: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation, arg2: 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>) {
        0x2::table::borrow_mut<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&mut arg0.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg1)).binded_ve_sca_key = 0x1::option::some<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>>(arg2);
    }

    fun calc_weighted_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            return 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::utils::mul_div(arg2, arg4, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::weight_scale())
        };
        0x2::math::min(arg2, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::utils::mul_div(arg2, arg4, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::weight_scale()) + 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::utils::mul_div(0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::utils::mul_div(arg3, arg0, arg1), 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::weight_scale() - arg4, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::weight_scale()))
    }

    public(friend) fun claim_rewards<T0>(arg0: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation, arg1: &mut 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools, arg2: &mut IncentiveAccounts) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::table::borrow_mut<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&mut arg2.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg0));
        let v2 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v1.pool_types);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            let v5 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PoolPoint>(&mut 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountPoolRecord>(&mut v1.pool_records, v4).points, 0x1::type_name::get<T0>());
            let (v6, v7) = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::claim_rewards<T0>(arg1, v4, v5.points);
            v5.points = v5.points - v6;
            0x2::balance::join<T0>(&mut v0, v7);
            v3 = v3 + 1;
        };
        v0
    }

    public(friend) fun create_if_not_exists(arg0: &mut IncentiveAccounts, arg1: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation, arg2: &mut 0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&arg0.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg1))) {
            let v0 = IncentiveAccount{
                id                : 0x2::object::new(arg2),
                pool_records      : 0x2::table::new<0x1::type_name::TypeName, AccountPoolRecord>(arg2),
                pool_types        : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
                binded_ve_sca_key : 0x1::option::none<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>>(),
            };
            0x2::table::add<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&mut arg0.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg1), v0);
        };
    }

    public(friend) fun create_incentive_accounts(arg0: &0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools>, arg1: &mut 0x2::tx_context::TxContext) : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<IncentiveAccounts> {
        let v0 = IncentiveAccounts{
            id                 : 0x2::object::new(arg1),
            accounts           : 0x2::table::new<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(arg1),
            incentive_pools_id : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::to_id<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools>(*arg0),
        };
        0x2::transfer::share_object<IncentiveAccounts>(v0);
        0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<IncentiveAccounts>(&v0)
    }

    public(friend) fun force_unstake_unhealthy(arg0: &mut 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation, arg1: &mut IncentiveAccounts, arg2: &mut 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools, arg3: &mut 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::market::Market, arg4: &0xca5a5a62f01c79a104bf4d31669e29daa387f325c241de4edbe30986a9bc8b0d::coin_decimals_registry::CoinDecimalsRegistry, arg5: &0x1478a432123e4b3d61878b629f2c692969fdb375644f1251cd278a4b1e7d7cd6::x_oracle::XOracle, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::table::borrow_mut<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&mut arg1.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg0));
        reset_all_amount_from_incentive_record(v0, arg2);
        let v1 = IncentiveProgramLockKey{dummy_field: false};
        0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::lock_obligation::force_unlock_unhealthy<IncentiveProgramLockKey>(arg0, arg3, arg4, arg5, arg6, v1);
    }

    public fun get_binded_ve_sca(arg0: &IncentiveAccounts, arg1: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation) : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey> {
        *0x1::option::borrow<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>>(&0x2::table::borrow<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&arg0.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg1)).binded_ve_sca_key)
    }

    fun increase_weighted_amount(arg0: &mut 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePool, arg1: &mut AccountPoolRecord, arg2: 0x1::type_name::TypeName, arg3: u64) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PoolPoint>(&mut arg1.points, arg2);
        assert!(v0.weighted_amount == 0, 4);
        v0.weighted_amount = arg3;
        0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::increase_weighted_amount(0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::pool_point_mut(arg0, arg2), arg3);
    }

    public fun index(arg0: &PoolPoint) : u64 {
        arg0.index
    }

    public fun is_incentive_account_exist(arg0: &IncentiveAccounts, arg1: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation) : bool {
        0x2::table::contains<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&arg0.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg1))
    }

    public fun is_ve_sca_key_binded(arg0: &IncentiveAccounts, arg1: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation) : bool {
        0x1::option::is_some<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>>(&0x2::table::borrow<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&arg0.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg1)).binded_ve_sca_key)
    }

    public fun point_list(arg0: &AccountPoolRecord) : &vector<0x1::type_name::TypeName> {
        &arg0.points_list
    }

    public fun points(arg0: &PoolPoint) : u64 {
        arg0.points
    }

    public fun pool_point(arg0: &AccountPoolRecord, arg1: 0x1::type_name::TypeName) : &PoolPoint {
        0x2::table::borrow<0x1::type_name::TypeName, PoolPoint>(&arg0.points, arg1)
    }

    public fun pool_records_data(arg0: &IncentiveAccounts, arg1: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation) : vector<PoolRecordData> {
        let v0 = 0x2::table::borrow<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&arg0.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg1));
        let v1 = 0x1::vector::empty<PoolRecordData>();
        let v2 = 0;
        let v3 = 0x2::vec_set::into_keys<0x1::type_name::TypeName>(v0.pool_types);
        while (v2 < 0x2::vec_set::size<0x1::type_name::TypeName>(&v0.pool_types)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v3, v2);
            let v5 = 0x2::table::borrow<0x1::type_name::TypeName, AccountPoolRecord>(&v0.pool_records, v4);
            let v6 = 0;
            let v7 = 0x1::vector::empty<EarningWeightData>();
            while (v6 < 0x1::vector::length<0x1::type_name::TypeName>(&v5.points_list)) {
                let v8 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v5.points_list, v6);
                let v9 = EarningWeightData{
                    coin_type       : v8,
                    weighted_amount : 0x2::table::borrow<0x1::type_name::TypeName, PoolPoint>(&v5.points, v8).weighted_amount,
                };
                0x1::vector::push_back<EarningWeightData>(&mut v7, v9);
                v6 = v6 + 1;
            };
            let v10 = PoolRecordData{
                pool_type       : v4,
                earning_weights : v7,
                debt_amount     : v5.amount,
            };
            0x1::vector::push_back<PoolRecordData>(&mut v1, v10);
            v2 = v2 + 1;
        };
        v1
    }

    public fun pool_type(arg0: &AccountPoolRecord) : 0x1::type_name::TypeName {
        arg0.pool_type
    }

    public fun pool_types(arg0: &IncentiveAccount) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        arg0.pool_types
    }

    public(friend) fun recalculate_stake(arg0: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation, arg1: &mut IncentiveAccounts, arg2: &mut 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::borrow_mut<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&mut arg1.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg0));
        reset_all_amount_from_incentive_record(v0, arg2);
        add_all_debts_from_obligation(arg0, v0, arg2, arg3, arg4, arg5);
    }

    fun reset_all_amount_from_incentive_record(arg0: &mut IncentiveAccount, arg1: &mut 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools) {
        let v0 = 0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.pool_types);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(v0)) {
            let v2 = *0x1::vector::borrow<0x1::type_name::TypeName>(v0, v1);
            let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountPoolRecord>(&mut arg0.pool_records, v2);
            if (v3.amount > 0) {
                if (0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::is_pool_exist(arg1, v2)) {
                    0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::unstake(arg1, v2, v3.amount);
                };
                v3.amount = 0;
                let v4 = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::incentive_pool_mut(arg1, v2);
                reset_all_weighted_amount_from_account_pool_record(v3, v4);
            };
            v1 = v1 + 1;
        };
    }

    fun reset_all_weighted_amount_from_account_pool_record(arg0: &mut AccountPoolRecord, arg1: &mut 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x1::type_name::TypeName>(&arg0.points_list)) {
            let v1 = *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0.points_list, v0);
            reset_weighted_amount(arg1, arg0, v1);
            v0 = v0 + 1;
        };
    }

    fun reset_weighted_amount(arg0: &mut 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePool, arg1: &mut AccountPoolRecord, arg2: 0x1::type_name::TypeName) {
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PoolPoint>(&mut arg1.points, arg2);
        0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::decrease_weighted_amount(0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::pool_point_mut(arg0, arg2), v0.weighted_amount);
        v0.weighted_amount = 0;
    }

    public(friend) fun stake(arg0: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::ObligationKey, arg1: &mut 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation, arg2: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation_access::ObligationAccessStore, arg3: &mut IncentiveAccounts, arg4: &mut 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::lock_key(arg1);
        if (0x1::option::is_some<0x1::type_name::TypeName>(&v0)) {
            assert!(0x1::option::destroy_some<0x1::type_name::TypeName>(v0) == 0x1::type_name::get<IncentiveProgramLockKey>(), 1);
            abort 2
        };
        recalculate_stake(arg1, arg3, arg4, arg5, arg6, arg7);
        let v1 = IncentiveProgramLockKey{dummy_field: false};
        0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::lock<IncentiveProgramLockKey>(arg1, arg0, arg2, true, true, false, false, true, v1);
    }

    public fun total_points(arg0: &PoolPoint) : u64 {
        arg0.total_points
    }

    public(friend) fun unbind_ve_sca(arg0: &mut IncentiveAccounts, arg1: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation) {
        0x2::table::borrow_mut<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&mut arg0.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg1)).binded_ve_sca_key = 0x1::option::none<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xb220d034bdf335d77ae5bfbf6daf059c2cc7a1f719b12bfed75d1736fac038c8::ve_sca::VeScaKey>>();
    }

    public(friend) fun unstake(arg0: &0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::ObligationKey, arg1: &mut 0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation, arg2: &mut IncentiveAccounts, arg3: &mut 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePools) {
        let v0 = 0x2::table::borrow_mut<0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::TypedID<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>, IncentiveAccount>(&mut arg2.accounts, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::typed_id::new<0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::Obligation>(arg1));
        reset_all_amount_from_incentive_record(v0, arg3);
        let v1 = IncentiveProgramLockKey{dummy_field: false};
        0xc9f859f98ca352a11b97a038c4b4162bee437b8df8caa047990fe9cb03d4f778::obligation::unlock<IncentiveProgramLockKey>(arg1, arg0, v1);
    }

    fun update_point_index(arg0: &0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePool, arg1: &mut AccountPoolRecord, arg2: 0x1::type_name::TypeName) {
        0x2::table::borrow_mut<0x1::type_name::TypeName, PoolPoint>(&mut arg1.points, arg2).index = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::index(0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::pool_point(arg0, arg2));
    }

    fun update_weighted_amount(arg0: &mut 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::IncentivePool, arg1: &mut IncentiveAccount, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::pool_type(arg0);
        if (!0x2::table::contains<0x1::type_name::TypeName, AccountPoolRecord>(&arg1.pool_records, v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg1.pool_types, v0);
            let v1 = AccountPoolRecord{
                pool_type   : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::pool_type(arg0),
                points      : 0x2::table::new<0x1::type_name::TypeName, PoolPoint>(arg5),
                points_list : 0x1::vector::empty<0x1::type_name::TypeName>(),
                amount      : arg4,
            };
            0x2::table::add<0x1::type_name::TypeName, AccountPoolRecord>(&mut arg1.pool_records, v0, v1);
        };
        let v2 = *0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::points_list(arg0);
        let v3 = 0;
        while (v3 < 0x1::vector::length<0x1::type_name::TypeName>(&v2)) {
            let v4 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v2, v3);
            let v5 = 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::pool_point(arg0, v4);
            let v6 = 0x2::table::borrow_mut<0x1::type_name::TypeName, AccountPoolRecord>(&mut arg1.pool_records, v0);
            v6.amount = arg4;
            if (!0x2::table::contains<0x1::type_name::TypeName, PoolPoint>(&v6.points, v4)) {
                let v7 = PoolPoint{
                    weighted_amount : 0,
                    points          : 0,
                    total_points    : 0,
                    index           : 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::index(v5),
                };
                0x2::table::add<0x1::type_name::TypeName, PoolPoint>(&mut v6.points, v4, v7);
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v6.points_list, v4);
            };
            let v8 = calc_weighted_amount(arg2, arg3, v6.amount, 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::stakes(arg0), 0x41354112a4df1cd228ea558aaf309700025b36270c743a008b38f514848798fc::incentive_pool::base_weight(v5));
            increase_weighted_amount(arg0, v6, v4, v8);
            update_point_index(arg0, v6, v4);
            v3 = v3 + 1;
        };
    }

    public fun weighted_amount(arg0: &PoolPoint) : u64 {
        arg0.weighted_amount
    }

    // decompiled from Move bytecode v6
}

