module 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::supply_pool {
    struct ACreatePool has drop {
        dummy_field: bool,
    }

    struct AConfigLendFacil has drop {
        dummy_field: bool,
    }

    struct AConfigFees has drop {
        dummy_field: bool,
    }

    struct ATakeFees has drop {
        dummy_field: bool,
    }

    struct ADeposit has drop {
        dummy_field: bool,
    }

    struct AMigrate has drop {
        dummy_field: bool,
    }

    struct SupplyInfo has copy, drop {
        supply_pool_id: 0x2::object::ID,
        deposited: u64,
        share_balance: u64,
    }

    struct WithdrawInfo has copy, drop {
        supply_pool_id: 0x2::object::ID,
        share_balance: u64,
        withdrawn: u64,
    }

    struct LendFacilCap has store, key {
        id: 0x2::object::UID,
    }

    struct LendFacilInfo<phantom T0> has store {
        interest_model: 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::piecewise::Piecewise,
        debt_registry: 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::DebtRegistry<T0>,
        max_liability_outstanding: u64,
        max_utilization_bps: u64,
    }

    struct FacilDebtShare<phantom T0> has store {
        facil_id: 0x2::object::ID,
        inner: 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::DebtShareBalance<T0>,
    }

    struct FacilDebtBag has store, key {
        id: 0x2::object::UID,
        facil_id: 0x2::object::ID,
        inner: 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt_bag::DebtBag,
    }

    struct SupplyPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        available_balance: 0x2::balance::Balance<T0>,
        interest_fee_bps: u16,
        debt_info: 0x2::vec_map::VecMap<0x2::object::ID, LendFacilInfo<T1>>,
        total_liabilities_x64: u128,
        last_update_ts_sec: u64,
        supply_equity: 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::EquityTreasury<T1>,
        collected_fees: 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::EquityShareBalance<T1>,
        version: u16,
    }

    public(friend) fun borrow<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: &LendFacilCap, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, FacilDebtShare<T1>) {
        check_version<T0, T1>(arg0);
        update_interest<T0, T1>(arg0, arg3);
        let v0 = 0x2::object::id<LendFacilCap>(arg1);
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, &v0);
        arg0.total_liabilities_x64 = arg0.total_liabilities_x64 + ((arg2 as u128) << 64);
        assert!(((0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::liability_value_x64<T1>(&v1.debt_registry) >> 64) as u64) < v1.max_liability_outstanding, 4);
        assert!(utilization_bps<T0, T1>(arg0) <= v1.max_utilization_bps, 3);
        let v2 = FacilDebtShare<T1>{
            facil_id : v0,
            inner    : 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::increase_liability_and_issue<T1>(&mut v1.debt_registry, arg2),
        };
        (0x2::balance::split<T0>(&mut arg0.available_balance, arg2), v2)
    }

    public fun add_lend_facil<T0, T1: drop>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::piecewise::Piecewise, arg3: &mut 0x2::tx_context::TxContext) : 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::ActionRequest {
        check_version<T0, T1>(arg0);
        let v0 = LendFacilInfo<T1>{
            interest_model            : arg2,
            debt_registry             : 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::create_registry_with_cap<T1>(0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::borrow_treasury_cap<T1>(&arg0.supply_equity)),
            max_liability_outstanding : 0,
            max_utilization_bps       : 10000,
        };
        0x2::vec_map::insert<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, arg1, v0);
        let v1 = AConfigLendFacil{dummy_field: false};
        0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::new_request<AConfigLendFacil>(v1, arg3)
    }

    public(friend) fun borrow_debt_registry<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: &0x2::object::ID, arg2: &0x2::clock::Clock) : &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::DebtRegistry<T1> {
        check_version<T0, T1>(arg0);
        update_interest<T0, T1>(arg0, arg2);
        &0x2::vec_map::get<0x2::object::ID, LendFacilInfo<T1>>(&arg0.debt_info, arg1).debt_registry
    }

    public fun calc_repay_by_amount<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) : u128 {
        check_version<T0, T1>(arg0);
        update_interest<T0, T1>(arg0, arg3);
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::calc_repay_for_amount<T1>(&0x2::vec_map::get<0x2::object::ID, LendFacilInfo<T1>>(&arg0.debt_info, &arg1).debt_registry, arg2)
    }

    public fun calc_repay_by_shares<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: u128, arg3: &0x2::clock::Clock) : u64 {
        check_version<T0, T1>(arg0);
        update_interest<T0, T1>(arg0, arg3);
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::calc_repay_lossy<T1>(&0x2::vec_map::get<0x2::object::ID, LendFacilInfo<T1>>(&arg0.debt_info, &arg1).debt_registry, arg2)
    }

    public fun calc_withdraw_by_amount<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64) {
        check_version<T0, T1>(arg0);
        update_interest<T0, T1>(arg0, arg2);
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::calc_balance_redeem_for_amount<T1>(0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::borrow_registry<T1>(&arg0.supply_equity), arg1)
    }

    public fun calc_withdraw_by_shares<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        check_version<T0, T1>(arg0);
        update_interest<T0, T1>(arg0, arg2);
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::calc_redeem_lossy<T1>(0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::borrow_registry<T1>(&arg0.supply_equity), (arg1 as u128) << 64)
    }

    public(friend) fun check_version<T0, T1>(arg0: &SupplyPool<T0, T1>) {
        assert!(arg0.version == 1, 5);
    }

    public fun create_lend_facil_cap(arg0: &mut 0x2::tx_context::TxContext) : LendFacilCap {
        LendFacilCap{id: 0x2::object::new(arg0)}
    }

    public fun create_pool<T0, T1: drop>(arg0: 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::EquityTreasury<T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::ActionRequest {
        let v0 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::borrow_registry<T1>(&arg0);
        assert!(0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::supply_x64<T1>(v0) == 0 && 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::underlying_value_x64<T1>(v0) == 0, 0);
        let v1 = SupplyPool<T0, T1>{
            id                    : 0x2::object::new(arg1),
            available_balance     : 0x2::balance::zero<T0>(),
            interest_fee_bps      : 0,
            debt_info             : 0x2::vec_map::empty<0x2::object::ID, LendFacilInfo<T1>>(),
            total_liabilities_x64 : 0,
            last_update_ts_sec    : 0,
            supply_equity         : arg0,
            collected_fees        : 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::zero<T1>(),
            version               : 1,
        };
        0x2::transfer::share_object<SupplyPool<T0, T1>>(v1);
        let v2 = ACreatePool{dummy_field: false};
        0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::new_request<ACreatePool>(v2, arg1)
    }

    public(friend) fun empty_facil_debt_bag(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : FacilDebtBag {
        FacilDebtBag{
            id       : 0x2::object::new(arg1),
            facil_id : arg0,
            inner    : 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt_bag::empty(arg1),
        }
    }

    public(friend) fun fdb_add<T0, T1>(arg0: &mut FacilDebtBag, arg1: FacilDebtShare<T1>) {
        assert!(arg0.facil_id == arg1.facil_id, 2);
        let FacilDebtShare {
            facil_id : _,
            inner    : v1,
        } = arg1;
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt_bag::add<T0, T1>(&mut arg0.inner, v1);
    }

    public(friend) fun fdb_get_share_amount_by_asset_type<T0>(arg0: &FacilDebtBag) : u128 {
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt_bag::get_share_amount_by_asset_type<T0>(&arg0.inner)
    }

    public(friend) fun fdb_get_share_amount_by_share_type<T0>(arg0: &FacilDebtBag) : u128 {
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt_bag::get_share_amount_by_share_type<T0>(&arg0.inner)
    }

    public(friend) fun fdb_get_share_type_for_asset<T0>(arg0: &FacilDebtBag) : 0x1::type_name::TypeName {
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt_bag::get_share_type_for_asset<T0>(&arg0.inner)
    }

    public(friend) fun fdb_take_all<T0>(arg0: &mut FacilDebtBag) : FacilDebtShare<T0> {
        FacilDebtShare<T0>{
            facil_id : arg0.facil_id,
            inner    : 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt_bag::take_all<T0>(&mut arg0.inner),
        }
    }

    public(friend) fun fdb_take_amt<T0>(arg0: &mut FacilDebtBag, arg1: u128) : FacilDebtShare<T0> {
        FacilDebtShare<T0>{
            facil_id : arg0.facil_id,
            inner    : 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt_bag::take_amt<T0>(&mut arg0.inner, arg1),
        }
    }

    public(friend) fun fds_borrow_inner<T0>(arg0: &FacilDebtShare<T0>) : &0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::DebtShareBalance<T0> {
        &arg0.inner
    }

    public(friend) fun fds_destroy_zero<T0>(arg0: FacilDebtShare<T0>) {
        let FacilDebtShare {
            facil_id : _,
            inner    : v1,
        } = arg0;
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::destroy_zero<T0>(v1);
    }

    public(friend) fun fds_facil_id<T0>(arg0: &FacilDebtShare<T0>) : 0x2::object::ID {
        arg0.facil_id
    }

    public(friend) fun fds_join<T0>(arg0: &mut FacilDebtShare<T0>, arg1: FacilDebtShare<T0>) {
        assert!(arg0.facil_id == arg1.facil_id, 2);
        let FacilDebtShare {
            facil_id : _,
            inner    : v1,
        } = arg1;
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::join<T0>(&mut arg0.inner, v1);
    }

    public(friend) fun fds_split<T0>(arg0: &mut FacilDebtShare<T0>, arg1: u64) : FacilDebtShare<T0> {
        FacilDebtShare<T0>{
            facil_id : arg0.facil_id,
            inner    : 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::split<T0>(&mut arg0.inner, arg1),
        }
    }

    public(friend) fun fds_split_x64<T0>(arg0: &mut FacilDebtShare<T0>, arg1: u128) : FacilDebtShare<T0> {
        FacilDebtShare<T0>{
            facil_id : arg0.facil_id,
            inner    : 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::split_x64<T0>(&mut arg0.inner, arg1),
        }
    }

    public(friend) fun fds_value_x64<T0>(arg0: &FacilDebtShare<T0>) : u128 {
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::value_x64<T0>(&arg0.inner)
    }

    public(friend) fun fds_withdraw_all<T0>(arg0: &mut FacilDebtShare<T0>) : FacilDebtShare<T0> {
        FacilDebtShare<T0>{
            facil_id : arg0.facil_id,
            inner    : 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::withdraw_all<T0>(&mut arg0.inner),
        }
    }

    public fun migrate_supply_pool_version<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::ActionRequest {
        assert!(arg0.version < 1, 6);
        arg0.version = 1;
        let v0 = AMigrate{dummy_field: false};
        0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::new_request<AMigrate>(v0, arg1)
    }

    public fun remove_lend_facil<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::ActionRequest {
        check_version<T0, T1>(arg0);
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, &arg1);
        let LendFacilInfo {
            interest_model            : _,
            debt_registry             : v3,
            max_liability_outstanding : _,
            max_utilization_bps       : _,
        } = v1;
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::destroy_empty_registry<T1>(v3);
        let v6 = AConfigLendFacil{dummy_field: false};
        0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::new_request<AConfigLendFacil>(v6, arg2)
    }

    public(friend) fun repay<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: FacilDebtShare<T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        check_version<T0, T1>(arg0);
        update_interest<T0, T1>(arg0, arg3);
        let FacilDebtShare {
            facil_id : v0,
            inner    : v1,
        } = arg1;
        let v2 = v0;
        let v3 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::repay_lossy<T1>(&mut 0x2::vec_map::get_mut<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, &v2).debt_registry, v1);
        assert!(0x2::balance::value<T0>(&arg2) == v3, 1);
        arg0.total_liabilities_x64 = arg0.total_liabilities_x64 - ((v3 as u128) << 64);
        0x2::balance::join<T0>(&mut arg0.available_balance, arg2);
    }

    public(friend) fun repay_max_possible<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: &mut FacilDebtShare<T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : (u128, u64) {
        check_version<T0, T1>(arg0);
        let v0 = arg1.facil_id;
        let v1 = calc_repay_by_shares<T0, T1>(arg0, v0, fds_value_x64<T1>(arg1), arg3);
        let v2 = calc_repay_by_amount<T0, T1>(arg0, v0, 0x2::balance::value<T0>(arg2), arg3);
        let (v3, v4) = if (0x2::balance::value<T0>(arg2) >= v1) {
            let v3 = fds_value_x64<T1>(arg1);
            (v3, v1)
        } else {
            (v2, 0x2::balance::value<T0>(arg2))
        };
        repay<T0, T1>(arg0, fds_split_x64<T1>(arg1, v3), 0x2::balance::split<T0>(arg2, v4), arg3);
        (v3, v4)
    }

    public fun set_interest_fee_bps<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::ActionRequest {
        check_version<T0, T1>(arg0);
        arg0.interest_fee_bps = arg1;
        let v0 = AConfigFees{dummy_field: false};
        0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::new_request<AConfigFees>(v0, arg2)
    }

    public fun set_lend_facil_interest_model<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::piecewise::Piecewise, arg3: &mut 0x2::tx_context::TxContext) : 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::ActionRequest {
        check_version<T0, T1>(arg0);
        0x2::vec_map::get_mut<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, &arg1).interest_model = arg2;
        let v0 = AConfigLendFacil{dummy_field: false};
        0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::new_request<AConfigLendFacil>(v0, arg3)
    }

    public fun set_lend_facil_max_liability_outstanding<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::ActionRequest {
        check_version<T0, T1>(arg0);
        0x2::vec_map::get_mut<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, &arg1).max_liability_outstanding = arg2;
        let v0 = AConfigLendFacil{dummy_field: false};
        0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::new_request<AConfigLendFacil>(v0, arg3)
    }

    public fun set_lend_facil_max_utilization_bps<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::ActionRequest {
        check_version<T0, T1>(arg0);
        0x2::vec_map::get_mut<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, &arg1).max_utilization_bps = arg2;
        let v0 = AConfigLendFacil{dummy_field: false};
        0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::new_request<AConfigLendFacil>(v0, arg3)
    }

    public fun supply<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::ActionRequest) {
        check_version<T0, T1>(arg0);
        update_interest<T0, T1>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg0.available_balance, arg1);
        let v0 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::into_balance_lossy<T1>(0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::increase_value_and_issue<T1>(0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::borrow_mut_registry<T1>(&mut arg0.supply_equity), 0x2::balance::value<T0>(&arg1)), &mut arg0.supply_equity);
        let v1 = SupplyInfo{
            supply_pool_id : 0x2::object::uid_to_inner(&arg0.id),
            deposited      : 0x2::balance::value<T0>(&arg1),
            share_balance  : 0x2::balance::value<T1>(&v0),
        };
        0x2::event::emit<SupplyInfo>(v1);
        let v2 = ADeposit{dummy_field: false};
        (v0, 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::new_request<ADeposit>(v2, arg3))
    }

    public fun take_collected_fees<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::EquityShareBalance<T1>, 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::ActionRequest) {
        check_version<T0, T1>(arg0);
        let v0 = ATakeFees{dummy_field: false};
        (0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::withdraw_all<T1>(&mut arg0.collected_fees), 0xd9dd55ac7eb676dc78f7d0ae3bc5529d7fd6b52ac0d0edb2d7820c52d080026::access::new_request<ATakeFees>(v0, arg1))
    }

    public fun total_value_x64<T0, T1>(arg0: &SupplyPool<T0, T1>) : u128 {
        0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::underlying_value_x64<T1>(0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::borrow_registry<T1>(&arg0.supply_equity))
    }

    public fun update_interest<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: &0x2::clock::Clock) {
        check_version<T0, T1>(arg0);
        let v0 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::util::timestamp_sec(arg1) - arg0.last_update_ts_sec;
        if (v0 == 0) {
            return
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x2::vec_map::size<0x2::object::ID, LendFacilInfo<T1>>(&arg0.debt_info)) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, v2);
            let v5 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::util::muldiv_u128(0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::liability_value_x64<T1>(&v4.debt_registry), (0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::piecewise::value_at(&v4.interest_model, utilization_bps<T0, T1>(arg0)) as u128) * (v0 as u128), 10000 * 31536000);
            let v6 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::util::muldiv_u128(v5, (arg0.interest_fee_bps as u128), 10000);
            let v7 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::borrow_mut_registry<T1>(&mut arg0.supply_equity);
            0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::increase_value_x64<T1>(v7, v5 - v6);
            0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::join<T1>(&mut arg0.collected_fees, 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::increase_value_and_issue_x64<T1>(v7, v6));
            0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::increase_liability_x64<T1>(&mut v4.debt_registry, v5);
            v1 = v1 + 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::debt::liability_value_x64<T1>(&v4.debt_registry);
            v2 = v2 + 1;
        };
        arg0.total_liabilities_x64 = v1;
        arg0.last_update_ts_sec = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::util::timestamp_sec(arg1);
    }

    public fun utilization_bps<T0, T1>(arg0: &SupplyPool<T0, T1>) : u64 {
        let v0 = total_value_x64<T0, T1>(arg0);
        if (v0 == 0) {
            return 0
        };
        (0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::util::muldiv_u128(arg0.total_liabilities_x64, 10000, v0) as u64)
    }

    public fun withdraw<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        check_version<T0, T1>(arg0);
        update_interest<T0, T1>(arg0, arg2);
        let v0 = 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::redeem_lossy<T1>(0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::borrow_mut_registry<T1>(&mut arg0.supply_equity), 0x51e0ccce48f0763f98f1cb4856847c2e1531adacada99cdd7626ab999db57523::equity::from_balance<T1>(&mut arg0.supply_equity, arg1));
        let v1 = WithdrawInfo{
            supply_pool_id : 0x2::object::uid_to_inner(&arg0.id),
            share_balance  : 0x2::balance::value<T1>(&arg1),
            withdrawn      : v0,
        };
        0x2::event::emit<WithdrawInfo>(v1);
        0x2::balance::split<T0>(&mut arg0.available_balance, v0)
    }

    // decompiled from Move bytecode v6
}

