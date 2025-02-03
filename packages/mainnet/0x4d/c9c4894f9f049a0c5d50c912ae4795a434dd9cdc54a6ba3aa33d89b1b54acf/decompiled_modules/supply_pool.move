module 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::supply_pool {
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

    struct LendFacilCap has store, key {
        id: 0x2::object::UID,
    }

    struct LendFacilInfo<phantom T0> has store {
        interest_model: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::piecewise::Piecewise,
        debt_registry: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::DebtRegistry<T0>,
        allow_borrow: bool,
    }

    struct FacilDebtShare<phantom T0> has store {
        facil_id: 0x2::object::ID,
        inner: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::DebtShareBalance<T0>,
    }

    struct FacilDebtBag has store, key {
        id: 0x2::object::UID,
        facil_id: 0x2::object::ID,
        inner: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_bag::DebtBag,
    }

    struct FlashLoanReceipt<phantom T0> {
        amount: u64,
    }

    struct SupplyPool<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        available_balance: 0x2::balance::Balance<T0>,
        interest_fee_bps: u16,
        flash_loan_fee_bps: u16,
        debt_info: 0x2::vec_map::VecMap<0x2::object::ID, LendFacilInfo<T1>>,
        total_liabilities_x64: u128,
        last_update_ts_sec: u64,
        supply_equity: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::EquityTreasury<T1>,
        collected_fees: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::EquityShareBalance<T1>,
    }

    public(friend) fun borrow<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: &LendFacilCap, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, FacilDebtShare<T1>) {
        update_interest<T0, T1>(arg0, arg3);
        let v0 = 0x2::object::id<LendFacilCap>(arg1);
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, &v0);
        assert!(v1.allow_borrow, 4);
        arg0.total_liabilities_x64 = arg0.total_liabilities_x64 + ((arg2 as u128) << 64);
        let v2 = FacilDebtShare<T1>{
            facil_id : v0,
            inner    : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::increase_liability_and_issue<T1>(&mut v1.debt_registry, arg2),
        };
        (0x2::balance::split<T0>(&mut arg0.available_balance, arg2), v2)
    }

    public fun add_lend_facil<T0, T1: drop>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::piecewise::Piecewise, arg3: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        let v0 = LendFacilInfo<T1>{
            interest_model : arg2,
            debt_registry  : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::create_registry_with_cap<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::borrow_treasury_cap<T1>(&arg0.supply_equity)),
            allow_borrow   : true,
        };
        0x2::vec_map::insert<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, arg1, v0);
        let v1 = AConfigLendFacil{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AConfigLendFacil>(v1, arg3)
    }

    public(friend) fun borrow_debt_registry<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: &0x2::object::ID, arg2: &0x2::clock::Clock) : &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::DebtRegistry<T1> {
        update_interest<T0, T1>(arg0, arg2);
        &0x2::vec_map::get<0x2::object::ID, LendFacilInfo<T1>>(&arg0.debt_info, arg1).debt_registry
    }

    public fun calc_flash_loan_repay_amt<T0, T1>(arg0: &SupplyPool<T0, T1>, arg1: &FlashLoanReceipt<T0>) : u64 {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::muldiv(arg1.amount, 10000 + (arg0.flash_loan_fee_bps as u64), 10000)
    }

    public fun calc_repay_by_amount<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: u64, arg3: &0x2::clock::Clock) : u128 {
        update_interest<T0, T1>(arg0, arg3);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::calc_repay_for_amount<T1>(&0x2::vec_map::get<0x2::object::ID, LendFacilInfo<T1>>(&arg0.debt_info, &arg1).debt_registry, arg2)
    }

    public fun calc_repay_by_shares<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: u128, arg3: &0x2::clock::Clock) : u64 {
        update_interest<T0, T1>(arg0, arg3);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::calc_repay_lossy<T1>(&0x2::vec_map::get<0x2::object::ID, LendFacilInfo<T1>>(&arg0.debt_info, &arg1).debt_registry, arg2)
    }

    public fun calc_withdraw_by_amount<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : (u64, u64) {
        update_interest<T0, T1>(arg0, arg2);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::calc_balance_redeem_for_amount<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::borrow_registry<T1>(&arg0.supply_equity), arg1)
    }

    public fun calc_withdraw_by_shares<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock) : u64 {
        update_interest<T0, T1>(arg0, arg2);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::calc_redeem_lossy<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::borrow_registry<T1>(&arg0.supply_equity), ((arg1 << 64) as u128))
    }

    public fun create_lend_facil_cap(arg0: &mut 0x2::tx_context::TxContext) : LendFacilCap {
        LendFacilCap{id: 0x2::object::new(arg0)}
    }

    public fun create_pool<T0, T1: drop>(arg0: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::EquityTreasury<T1>, arg1: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::borrow_registry<T1>(&arg0);
        assert!(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::supply_x64<T1>(v0) == 0 && 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::underlying_value_x64<T1>(v0) == 0, 0);
        let v1 = SupplyPool<T0, T1>{
            id                    : 0x2::object::new(arg1),
            available_balance     : 0x2::balance::zero<T0>(),
            interest_fee_bps      : 0,
            flash_loan_fee_bps    : 0,
            debt_info             : 0x2::vec_map::empty<0x2::object::ID, LendFacilInfo<T1>>(),
            total_liabilities_x64 : 0,
            last_update_ts_sec    : 0,
            supply_equity         : arg0,
            collected_fees        : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::zero<T1>(),
        };
        0x2::transfer::share_object<SupplyPool<T0, T1>>(v1);
        let v2 = ACreatePool{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<ACreatePool>(v2, arg1)
    }

    public(friend) fun empty_facil_debt_bag(arg0: 0x2::object::ID, arg1: &mut 0x2::tx_context::TxContext) : FacilDebtBag {
        FacilDebtBag{
            id       : 0x2::object::new(arg1),
            facil_id : arg0,
            inner    : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_bag::empty(arg1),
        }
    }

    public(friend) fun fdb_add<T0, T1>(arg0: &mut FacilDebtBag, arg1: FacilDebtShare<T1>) {
        assert!(arg0.facil_id == arg1.facil_id, 2);
        let FacilDebtShare {
            facil_id : _,
            inner    : v1,
        } = arg1;
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_bag::add<T0, T1>(&mut arg0.inner, v1);
    }

    public(friend) fun fdb_get_share_amount_by_asset_type<T0>(arg0: &FacilDebtBag) : u128 {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_bag::get_share_amount_by_asset_type<T0>(&arg0.inner)
    }

    public(friend) fun fdb_get_share_amount_by_share_type<T0>(arg0: &FacilDebtBag) : u128 {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_bag::get_share_amount_by_share_type<T0>(&arg0.inner)
    }

    public(friend) fun fdb_get_share_type_for_asset<T0>(arg0: &FacilDebtBag) : 0x1::type_name::TypeName {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_bag::get_share_type_for_asset<T0>(&arg0.inner)
    }

    public(friend) fun fdb_take_all<T0>(arg0: &mut FacilDebtBag) : FacilDebtShare<T0> {
        FacilDebtShare<T0>{
            facil_id : arg0.facil_id,
            inner    : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_bag::take_all<T0>(&mut arg0.inner),
        }
    }

    public(friend) fun fdb_take_amt<T0>(arg0: &mut FacilDebtBag, arg1: u128) : FacilDebtShare<T0> {
        FacilDebtShare<T0>{
            facil_id : arg0.facil_id,
            inner    : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt_bag::take_amt<T0>(&mut arg0.inner, arg1),
        }
    }

    public(friend) fun fds_borrow_inner<T0>(arg0: &FacilDebtShare<T0>) : &0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::DebtShareBalance<T0> {
        &arg0.inner
    }

    public(friend) fun fds_destroy_zero<T0>(arg0: FacilDebtShare<T0>) {
        let FacilDebtShare {
            facil_id : _,
            inner    : v1,
        } = arg0;
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::destroy_zero<T0>(v1);
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
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::join<T0>(&mut arg0.inner, v1);
    }

    public(friend) fun fds_split<T0>(arg0: &mut FacilDebtShare<T0>, arg1: u64) : FacilDebtShare<T0> {
        FacilDebtShare<T0>{
            facil_id : arg0.facil_id,
            inner    : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::split<T0>(&mut arg0.inner, arg1),
        }
    }

    public(friend) fun fds_split_x64<T0>(arg0: &mut FacilDebtShare<T0>, arg1: u128) : FacilDebtShare<T0> {
        FacilDebtShare<T0>{
            facil_id : arg0.facil_id,
            inner    : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::split_x64<T0>(&mut arg0.inner, arg1),
        }
    }

    public(friend) fun fds_value_x64<T0>(arg0: &FacilDebtShare<T0>) : u128 {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::value_x64<T0>(&arg0.inner)
    }

    public(friend) fun fds_withdraw_all<T0>(arg0: &mut FacilDebtShare<T0>) : FacilDebtShare<T0> {
        FacilDebtShare<T0>{
            facil_id : arg0.facil_id,
            inner    : 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::withdraw_all<T0>(&mut arg0.inner),
        }
    }

    public fun flash_loan<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: u64) : (0x2::balance::Balance<T0>, FlashLoanReceipt<T0>) {
        let v0 = FlashLoanReceipt<T0>{amount: arg1};
        (0x2::balance::split<T0>(&mut arg0.available_balance, arg1), v0)
    }

    public fun remove_lend_facil<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        let (_, v1) = 0x2::vec_map::remove<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, &arg1);
        let LendFacilInfo {
            interest_model : _,
            debt_registry  : v3,
            allow_borrow   : _,
        } = v1;
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::destroy_empty_registry<T1>(v3);
        let v5 = AConfigLendFacil{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AConfigLendFacil>(v5, arg2)
    }

    public(friend) fun repay<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: FacilDebtShare<T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) {
        update_interest<T0, T1>(arg0, arg3);
        let FacilDebtShare {
            facil_id : v0,
            inner    : v1,
        } = arg1;
        let v2 = v0;
        let v3 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::repay_lossy<T1>(&mut 0x2::vec_map::get_mut<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, &v2).debt_registry, v1);
        assert!(0x2::balance::value<T0>(&arg2) == v3, 1);
        arg0.total_liabilities_x64 = arg0.total_liabilities_x64 - ((v3 as u128) << 64);
        0x2::balance::join<T0>(&mut arg0.available_balance, arg2);
    }

    public fun repay_flash_loan<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: FlashLoanReceipt<T0>, arg2: 0x2::balance::Balance<T0>) {
        let v0 = calc_flash_loan_repay_amt<T0, T1>(arg0, &arg1);
        assert!(0x2::balance::value<T0>(&arg2) == v0, 1);
        let v1 = v0 - arg1.amount;
        let v2 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::muldiv(v1, (arg0.interest_fee_bps as u64), 10000);
        let v3 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::borrow_mut_registry<T1>(&mut arg0.supply_equity);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::increase_value<T1>(v3, v1 - v2);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::join<T1>(&mut arg0.collected_fees, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::increase_value_and_issue<T1>(v3, v2));
        0x2::balance::join<T0>(&mut arg0.available_balance, arg2);
        let FlashLoanReceipt {  } = arg1;
    }

    public(friend) fun repay_max_possible<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: &mut FacilDebtShare<T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock) : (u128, u64) {
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

    public fun set_flash_loan_fee_bps<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.flash_loan_fee_bps = arg1;
        let v0 = AConfigLendFacil{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AConfigLendFacil>(v0, arg2)
    }

    public fun set_interest_fee_bps<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: u16, arg2: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        arg0.interest_fee_bps = arg1;
        let v0 = AConfigFees{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AConfigFees>(v0, arg2)
    }

    public fun set_lend_facil_allow_borrow<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        0x2::vec_map::get_mut<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, &arg1).allow_borrow = arg2;
        let v0 = AConfigLendFacil{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AConfigLendFacil>(v0, arg3)
    }

    public fun set_lend_facil_interest_model<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::object::ID, arg2: 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::piecewise::Piecewise, arg3: &mut 0x2::tx_context::TxContext) : 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest {
        0x2::vec_map::get_mut<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, &arg1).interest_model = arg2;
        let v0 = AConfigLendFacil{dummy_field: false};
        0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<AConfigLendFacil>(v0, arg3)
    }

    public fun supply<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        update_interest<T0, T1>(arg0, arg2);
        0x2::balance::join<T0>(&mut arg0.available_balance, arg1);
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::into_balance_lossy<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::increase_value_and_issue<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::borrow_mut_registry<T1>(&mut arg0.supply_equity), 0x2::balance::value<T0>(&arg1)), &mut arg0.supply_equity)
    }

    public fun take_collected_fees<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : (0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::EquityShareBalance<T1>, 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::ActionRequest) {
        let v0 = ATakeFees{dummy_field: false};
        (0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::withdraw_all<T1>(&mut arg0.collected_fees), 0xa0501135cff2a49568b1fd32407372300f57ebc5949aaabbcc33d16028c58222::access::new_request<ATakeFees>(v0, arg1))
    }

    public fun total_value_x64<T0, T1>(arg0: &SupplyPool<T0, T1>) : u128 {
        0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::underlying_value_x64<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::borrow_registry<T1>(&arg0.supply_equity))
    }

    public fun update_interest<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: &0x2::clock::Clock) {
        let v0 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::timestamp_sec(arg1) - arg0.last_update_ts_sec;
        if (v0 == 0) {
            return
        };
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x2::vec_map::size<0x2::object::ID, LendFacilInfo<T1>>(&arg0.debt_info)) {
            let (_, v4) = 0x2::vec_map::get_entry_by_idx_mut<0x2::object::ID, LendFacilInfo<T1>>(&mut arg0.debt_info, v2);
            let v5 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::muldiv_u128(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::liability_value_x64<T1>(&v4.debt_registry), (0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::piecewise::value_at(&v4.interest_model, utilization_bps<T0, T1>(arg0)) as u128) * (v0 as u128), 10000 * 31536000);
            let v6 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::muldiv_u128(v5, (arg0.interest_fee_bps as u128), 10000);
            let v7 = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::borrow_mut_registry<T1>(&mut arg0.supply_equity);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::increase_value_x64<T1>(v7, v5 - v6);
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::join<T1>(&mut arg0.collected_fees, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::increase_value_and_issue_x64<T1>(v7, v6));
            0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::increase_liability_x64<T1>(&mut v4.debt_registry, v5);
            v1 = v1 + 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::debt::liability_value_x64<T1>(&v4.debt_registry);
            v2 = v2 + 1;
        };
        arg0.total_liabilities_x64 = v1;
        arg0.last_update_ts_sec = 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::timestamp_sec(arg1);
    }

    public fun utilization_bps<T0, T1>(arg0: &SupplyPool<T0, T1>) : u64 {
        let v0 = total_value_x64<T0, T1>(arg0);
        if (v0 == 0) {
            return 0
        };
        (0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::util::muldiv_u128(arg0.total_liabilities_x64, 10000, v0) as u64)
    }

    public fun withdraw<T0, T1>(arg0: &mut SupplyPool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        update_interest<T0, T1>(arg0, arg2);
        0x2::balance::split<T0>(&mut arg0.available_balance, 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::redeem_lossy<T1>(0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::borrow_mut_registry<T1>(&mut arg0.supply_equity), 0xa2857231f374ebace144d548b7cdc2a13e5f9bbd416dd1de63be2f5899991d5d::equity::from_balance<T1>(&mut arg0.supply_equity, arg1)))
    }

    // decompiled from Move bytecode v6
}

