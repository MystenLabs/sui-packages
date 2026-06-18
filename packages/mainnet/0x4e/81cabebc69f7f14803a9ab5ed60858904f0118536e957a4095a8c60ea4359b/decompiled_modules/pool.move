module 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::pool {
    struct LendingPool<phantom T0> has key {
        id: 0x2::object::UID,
        config_id: 0x2::object::ID,
        reserve_count: u64,
    }

    struct ReserveKey<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct Reserve<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        coin_decimals: u8,
        cash: 0x2::balance::Balance<T0>,
        fees: 0x2::balance::Balance<T0>,
        available_amount: u64,
        borrowed_amount: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal,
        cumulative_borrow_index: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal,
        unclaimed_spread_fees: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal,
        total_shares: u128,
        price_lo_1e18: u128,
        price_hi_1e18: u128,
        price_last_update_s: u64,
        interest_last_update_s: u64,
        config: ReserveConfig,
        rate_curve_id: 0x2::object::ID,
    }

    struct ReserveConfig has copy, drop, store {
        open_ltv_bps: u64,
        close_ltv_bps: u64,
        borrow_weight_bps: u64,
        reserve_factor_bps: u64,
        borrow_fee_bps: u64,
        liquidation_bonus_bps: u64,
        protocol_liquidation_fee_bps: u64,
        supply_cap: u64,
        borrow_cap: u64,
        active: bool,
    }

    struct Obligation<phantom T0> has key {
        id: 0x2::object::UID,
        owner: address,
        pool_id: 0x2::object::ID,
        deposits: vector<Deposit>,
        borrows: vector<Borrow>,
        allowed_borrow_usd: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal,
        unhealthy_borrow_usd: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal,
        weighted_borrow_usd: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal,
        last_refresh_s: u64,
        refresh_in_progress: bool,
        required_count: u64,
        covered_types: vector<0x1::type_name::TypeName>,
    }

    struct Deposit has store {
        coin_type: 0x1::type_name::TypeName,
        shares: u128,
    }

    struct Borrow has store {
        coin_type: 0x1::type_name::TypeName,
        principal: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal,
        borrow_index_snapshot: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal,
    }

    struct ObligationCap<phantom T0> has store, key {
        id: 0x2::object::UID,
        obligation_id: 0x2::object::ID,
    }

    struct ObligationHotPotato {
        obligation_id: 0x2::object::ID,
    }

    struct BorrowReceipt<phantom T0> {
        pool_id: 0x2::object::ID,
        obligation_id: 0x2::object::ID,
        refresh_stamp_s: u64,
        allowed_borrow_usd: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal,
        weighted_borrow_usd: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal,
    }

    public fun borrow<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg3: &0x2::clock::Clock, arg4: &mut Obligation<T0>, arg5: &ObligationCap<T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, BorrowReceipt<T0>) {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg1);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_not_paused(arg1);
        assert_pool_config<T0>(arg0, arg1);
        assert_obligation_pool<T0>(arg0, arg4);
        assert_cap<T0>(arg5, arg4);
        assert!(arg6 > 0, 7);
        let v0 = now_s(arg3);
        assert!(!arg4.refresh_in_progress && arg4.last_refresh_s == v0, 20);
        accrue<T0, T1>(arg0, arg2, arg3);
        let v1 = borrow_reserve<T0, T1>(arg0);
        assert!(v1.config.active, 2);
        assert!(v0 - v1.price_last_update_s == 0, 20);
        let v2 = v1.config.borrow_weight_bps;
        let v3 = v1.config.borrow_cap;
        let v4 = v1.cumulative_borrow_index;
        let v5 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_bps(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from(arg6), v1.config.borrow_fee_bps);
        let v6 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::ceil(&v5);
        let v7 = arg6 + v6;
        let v8 = borrow_reserve_mut<T0, T1>(arg0);
        assert!(v7 <= v8.available_amount, 8);
        if (v3 > 0) {
            let v9 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(v8.borrowed_amount, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from(v7));
            assert!(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::floor(&v9) <= v3, 10);
        };
        v8.borrowed_amount = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(v8.borrowed_amount, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from(v7));
        v8.available_amount = v8.available_amount - v7;
        0x2::balance::join<T1>(&mut v8.fees, 0x2::balance::split<T1>(&mut v8.cash, v6));
        let v10 = 0x2::coin::take<T1>(&mut v8.cash, arg6, arg7);
        let v11 = v8.coin_type;
        upsert_borrow<T0>(arg4, v11, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from(v7), v4);
        arg4.weighted_borrow_usd = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(arg4.weighted_borrow_usd, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_bps(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::value_usd_ceil(v1.price_hi_1e18, v7, v1.coin_decimals), v2));
        let v12 = BorrowReceipt<T0>{
            pool_id             : 0x2::object::id<LendingPool<T0>>(arg0),
            obligation_id       : 0x2::object::id<Obligation<T0>>(arg4),
            refresh_stamp_s     : v0,
            allowed_borrow_usd  : arg4.allowed_borrow_usd,
            weighted_borrow_usd : arg4.weighted_borrow_usd,
        };
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_borrow(0x2::object::id<LendingPool<T0>>(arg0), 0x2::object::id<Obligation<T0>>(arg4), v11, 0x2::tx_context::sender(arg7), arg6, v6);
        (v10, v12)
    }

    public(friend) fun accrue<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg2: &0x2::clock::Clock) {
        let v0 = now_s(arg2);
        let v1 = 0x2::object::id<LendingPool<T0>>(arg0);
        let v2 = borrow_reserve_mut<T0, T1>(arg0);
        assert!(0x2::object::id<0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve>(arg1) == v2.rate_curve_id, 6);
        let v3 = v2.interest_last_update_s;
        let v4 = if (v0 > v3) {
            v0 - v3
        } else {
            0
        };
        let v5 = if (v4 > 604800) {
            604800
        } else {
            v4
        };
        if (v5 == 0) {
            return
        };
        let v6 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::utilization((v2.available_amount as u256), (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::floor_u128(&v2.borrowed_amount) as u256), (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::floor_u128(&v2.unclaimed_spread_fees) as u256));
        let v7 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::compound_factor(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::borrow_apr(arg1, v6), v5);
        let v8 = v2.borrowed_amount;
        let v9 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul(v8, v7);
        let v10 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::sub_or_zero(v9, v8);
        v2.unclaimed_spread_fees = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(v2.unclaimed_spread_fees, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_bps(v10, v2.config.reserve_factor_bps));
        v2.borrowed_amount = v9;
        v2.cumulative_borrow_index = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul(v2.cumulative_borrow_index, v7);
        v2.interest_last_update_s = v0;
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_reserve_accrued(v1, v2.coin_type, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(&v2.cumulative_borrow_index), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(&v2.borrowed_amount), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(&v6), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(&v10), v0);
    }

    public fun add_collateral<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg3: &0x2::clock::Clock, arg4: &mut Obligation<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg1);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_not_paused(arg1);
        assert_pool_config<T0>(arg0, arg1);
        assert_obligation_pool<T0>(arg0, arg4);
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(v0 > 0, 7);
        accrue<T0, T1>(arg0, arg2, arg3);
        let v1 = floor_div_u128((v0 as u128), share_ratio<T0, T1>(arg0));
        let v2 = borrow_reserve_mut<T0, T1>(arg0);
        assert!(v2.config.active, 2);
        if (v2.config.supply_cap > 0) {
            assert!(v2.available_amount + v0 <= v2.config.supply_cap, 9);
        };
        0x2::balance::join<T1>(&mut v2.cash, 0x2::coin::into_balance<T1>(arg5));
        v2.available_amount = v2.available_amount + v0;
        v2.total_shares = v2.total_shares + v1;
        let v3 = v2.coin_type;
        upsert_deposit<T0>(arg4, v3, v1);
        let v4 = share_ratio<T0, T1>(arg0);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_deposit(0x2::object::id<LendingPool<T0>>(arg0), v3, 0x2::tx_context::sender(arg6), v0, v1, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(&v4));
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_collateral_added(0x2::object::id<Obligation<T0>>(arg4), v3, v1);
    }

    public fun add_reserve<T0, T1>(arg0: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::RiskAdminCap, arg1: &mut LendingPool<T0>, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg3: ReserveConfig, arg4: u8, arg5: 0x2::object::ID, arg6: &mut 0x2::tx_context::TxContext) {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg2);
        assert_pool_config<T0>(arg1, arg2);
        assert!(!reserve_exists<T0, T1>(arg1), 13);
        validate_reserve_config(&arg3);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = Reserve<T1>{
            id                      : 0x2::object::new(arg6),
            coin_type               : v0,
            coin_decimals           : arg4,
            cash                    : 0x2::balance::zero<T1>(),
            fees                    : 0x2::balance::zero<T1>(),
            available_amount        : 0,
            borrowed_amount         : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero(),
            cumulative_borrow_index : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::one(),
            unclaimed_spread_fees   : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero(),
            total_shares            : 1000,
            price_lo_1e18           : 0,
            price_hi_1e18           : 0,
            price_last_update_s     : 0,
            interest_last_update_s  : 0,
            config                  : arg3,
            rate_curve_id           : arg5,
        };
        let v2 = ReserveKey<T1>{dummy_field: false};
        0x2::dynamic_object_field::add<ReserveKey<T1>, Reserve<T1>>(&mut arg1.id, v2, v1);
        arg1.reserve_count = arg1.reserve_count + 1;
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_reserve_added(0x2::object::id<LendingPool<T0>>(arg1), v0, 0x2::object::id<Reserve<T1>>(&v1), arg4);
    }

    public(friend) fun apply_repay<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &mut Obligation<T0>, arg2: 0x2::coin::Coin<T1>) : u64 {
        let v0 = 0x2::coin::value<T1>(&arg2);
        let v1 = borrow_reserve_mut<T0, T1>(arg0);
        v1.borrowed_amount = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::sub_or_zero(v1.borrowed_amount, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from(v0));
        0x2::balance::join<T1>(&mut v1.cash, 0x2::coin::into_balance<T1>(arg2));
        v1.available_amount = v1.available_amount + v0;
        reduce_borrow_principal<T0>(arg1, 0x1::type_name::with_defining_ids<T1>(), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from(v0));
        v0
    }

    fun assert_cap<T0>(arg0: &ObligationCap<T0>, arg1: &Obligation<T0>) {
        assert!(arg0.obligation_id == 0x2::object::id<Obligation<T0>>(arg1), 5);
    }

    fun assert_obligation_pool<T0>(arg0: &LendingPool<T0>, arg1: &Obligation<T0>) {
        assert!(arg1.pool_id == 0x2::object::id<LendingPool<T0>>(arg0), 4);
    }

    public(friend) fun assert_pool_config<T0>(arg0: &LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig) {
        assert!(0x2::object::id<0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig>(arg1) == arg0.config_id, 4);
    }

    public fun assert_solvent<T0>(arg0: &LendingPool<T0>, arg1: &Obligation<T0>, arg2: &0x2::clock::Clock, arg3: BorrowReceipt<T0>) {
        let BorrowReceipt {
            pool_id             : v0,
            obligation_id       : v1,
            refresh_stamp_s     : v2,
            allowed_borrow_usd  : v3,
            weighted_borrow_usd : v4,
        } = arg3;
        assert!(v0 == 0x2::object::id<LendingPool<T0>>(arg0), 4);
        assert!(v1 == 0x2::object::id<Obligation<T0>>(arg1), 5);
        let v5 = now_s(arg2);
        assert!(v2 == v5, 12);
        assert!(arg1.last_refresh_s == v5, 12);
        assert!(!arg1.refresh_in_progress, 12);
        assert!(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::le(v4, v3), 11);
    }

    public fun begin_refresh<T0>(arg0: &mut Obligation<T0>, arg1: &0x2::clock::Clock) {
        now_s(arg1);
        arg0.allowed_borrow_usd = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero();
        arg0.unhealthy_borrow_usd = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero();
        arg0.weighted_borrow_usd = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero();
        arg0.required_count = distinct_asset_count<T0>(arg0);
        arg0.covered_types = 0x1::vector::empty<0x1::type_name::TypeName>();
        arg0.refresh_in_progress = true;
    }

    fun borrow_reserve<T0, T1>(arg0: &LendingPool<T0>) : &Reserve<T1> {
        assert!(reserve_exists<T0, T1>(arg0), 14);
        let v0 = ReserveKey<T1>{dummy_field: false};
        0x2::dynamic_object_field::borrow<ReserveKey<T1>, Reserve<T1>>(&arg0.id, v0)
    }

    fun borrow_reserve_mut<T0, T1>(arg0: &mut LendingPool<T0>) : &mut Reserve<T1> {
        let v0 = ReserveKey<T1>{dummy_field: false};
        assert!(0x2::dynamic_object_field::exists_with_type<ReserveKey<T1>, Reserve<T1>>(&arg0.id, v0), 14);
        let v1 = ReserveKey<T1>{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<ReserveKey<T1>, Reserve<T1>>(&mut arg0.id, v1)
    }

    fun collateral_ltvs<T0, T1>(arg0: &LendingPool<T0>) : (u64, u64) {
        let v0 = borrow_reserve<T0, T1>(arg0);
        (v0.config.open_ltv_bps, v0.config.close_ltv_bps)
    }

    fun compound_debt_for<T0, T1>(arg0: &LendingPool<T0>, arg1: &mut Obligation<T0>) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        let v0 = find_borrow_index<T0>(arg1, 0x1::type_name::with_defining_ids<T1>());
        if (v0 == 0x1::vector::length<Borrow>(&arg1.borrows)) {
            return 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero()
        };
        let v1 = borrow_reserve<T0, T1>(arg0).cumulative_borrow_index;
        let v2 = 0x1::vector::borrow_mut<Borrow>(&mut arg1.borrows, v0);
        v2.principal = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul(v2.principal, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::div(v1, v2.borrow_index_snapshot));
        v2.borrow_index_snapshot = v1;
        v2.principal
    }

    public fun create_pool<T0>(arg0: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::AdminCap, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg1);
        let v0 = LendingPool<T0>{
            id            : 0x2::object::new(arg2),
            config_id     : 0x2::object::id<0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig>(arg1),
            reserve_count : 0,
        };
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_pool_created(0x2::object::id<LendingPool<T0>>(&v0), 0x2::object::id<0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig>(arg1), 0x1::type_name::with_defining_ids<T0>());
        0x2::transfer::share_object<LendingPool<T0>>(v0);
    }

    public(friend) fun deduct_protocol_fee_shares<T0, T1>(arg0: &mut LendingPool<T0>, arg1: u128, arg2: u64) : u128 {
        let v0 = floor_mul_bps_u128(arg1, arg2);
        if (v0 == 0) {
            return 0
        };
        let v1 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_u128(share_ratio<T0, T1>(arg0), v0);
        let v2 = (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::floor_u128(&v1) as u64);
        let v3 = borrow_reserve_mut<T0, T1>(arg0);
        assert!(v2 <= v3.available_amount, 8);
        v3.available_amount = v3.available_amount - v2;
        0x2::balance::join<T1>(&mut v3.fees, 0x2::balance::split<T1>(&mut v3.cash, v2));
        v0
    }

    public fun deposit<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg3: &0x2::clock::Clock, arg4: &mut Obligation<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg1);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_not_paused(arg1);
        assert_pool_config<T0>(arg0, arg1);
        assert_obligation_pool<T0>(arg0, arg4);
        let v0 = 0x2::coin::value<T1>(&arg5);
        assert!(v0 > 0, 7);
        accrue<T0, T1>(arg0, arg2, arg3);
        let v1 = floor_div_u128((v0 as u128), share_ratio<T0, T1>(arg0));
        let v2 = borrow_reserve_mut<T0, T1>(arg0);
        assert!(v2.config.active, 2);
        if (v2.config.supply_cap > 0) {
            assert!(v2.available_amount + v0 <= v2.config.supply_cap, 9);
        };
        0x2::balance::join<T1>(&mut v2.cash, 0x2::coin::into_balance<T1>(arg5));
        v2.available_amount = v2.available_amount + v0;
        v2.total_shares = v2.total_shares + v1;
        let v3 = v2.coin_type;
        upsert_deposit<T0>(arg4, v3, v1);
        let v4 = share_ratio<T0, T1>(arg0);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_deposit(0x2::object::id<LendingPool<T0>>(arg0), v3, 0x2::tx_context::sender(arg6), v0, v1, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(&v4));
    }

    fun distinct_asset_count<T0>(arg0: &Obligation<T0>) : u64 {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            let v2 = 0x1::vector::borrow<Deposit>(&arg0.deposits, v1).coin_type;
            if (!0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v2)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v2);
            };
            v1 = v1 + 1;
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            let v4 = 0x1::vector::borrow<Borrow>(&arg0.borrows, v3).coin_type;
            if (!0x1::vector::contains<0x1::type_name::TypeName>(&v0, &v4)) {
                0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, v4);
            };
            v3 = v3 + 1;
        };
        0x1::vector::length<0x1::type_name::TypeName>(&v0)
    }

    fun find_borrow_index<T0>(arg0: &Obligation<T0>, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<Borrow>(&arg0.borrows);
        while (v0 < v1) {
            if (0x1::vector::borrow<Borrow>(&arg0.borrows, v0).coin_type == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v1
    }

    fun find_deposit_index<T0>(arg0: &Obligation<T0>, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = 0;
        let v1 = 0x1::vector::length<Deposit>(&arg0.deposits);
        while (v0 < v1) {
            if (0x1::vector::borrow<Deposit>(&arg0.deposits, v0).coin_type == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        v1
    }

    public(friend) fun flash_put<T0, T1>(arg0: &mut LendingPool<T0>, arg1: 0x2::coin::Coin<T1>, arg2: u64) {
        let v0 = borrow_reserve_mut<T0, T1>(arg0);
        let v1 = 0x2::coin::into_balance<T1>(arg1);
        0x2::balance::join<T1>(&mut v0.fees, 0x2::balance::split<T1>(&mut v1, arg2));
        0x2::balance::join<T1>(&mut v0.cash, v1);
        v0.available_amount = v0.available_amount + 0x2::coin::value<T1>(&arg1) - arg2;
    }

    public(friend) fun flash_take<T0, T1>(arg0: &mut LendingPool<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = borrow_reserve_mut<T0, T1>(arg0);
        assert!(arg1 <= v0.available_amount, 8);
        v0.available_amount = v0.available_amount - arg1;
        0x2::coin::take<T1>(&mut v0.cash, arg1, arg2)
    }

    fun floor_div_u128(arg0: u128, arg1: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal) : u128 {
        let v0 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(&arg1);
        assert!(v0 != 0, 8);
        (((arg0 as u256) * 1000000000000000000 / v0) as u128)
    }

    fun floor_mul_bps_u128(arg0: u128, arg1: u64) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (10000 as u256)) as u128)
    }

    public fun health_factor_bps<T0>(arg0: &Obligation<T0>) : u64 {
        if (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::is_zero(&arg0.weighted_borrow_usd)) {
            return 1000000000
        };
        let v0 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_u64(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::div(arg0.unhealthy_borrow_usd, arg0.weighted_borrow_usd), 10000);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::floor(&v0)
    }

    public fun is_liquidatable<T0>(arg0: &Obligation<T0>) : bool {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::gt(arg0.weighted_borrow_usd, arg0.unhealthy_borrow_usd)
    }

    public fun new_reserve_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: bool) : ReserveConfig {
        ReserveConfig{
            open_ltv_bps                 : arg0,
            close_ltv_bps                : arg1,
            borrow_weight_bps            : arg2,
            reserve_factor_bps           : arg3,
            borrow_fee_bps               : arg4,
            liquidation_bonus_bps        : arg5,
            protocol_liquidation_fee_bps : arg6,
            supply_cap                   : arg7,
            borrow_cap                   : arg8,
            active                       : arg9,
        }
    }

    fun now_s(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public(friend) fun obligation_collateral_shares<T0, T1>(arg0: &Obligation<T0>) : u128 {
        let v0 = find_deposit_index<T0>(arg0, 0x1::type_name::with_defining_ids<T1>());
        if (v0 == 0x1::vector::length<Deposit>(&arg0.deposits)) {
            return 0
        };
        0x1::vector::borrow<Deposit>(&arg0.deposits, v0).shares
    }

    public(friend) fun obligation_collateral_shares_total<T0>(arg0: &Obligation<T0>) : u128 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            v0 = v0 + 0x1::vector::borrow<Deposit>(&arg0.deposits, v1).shares;
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun obligation_debt_amount<T0, T1>(arg0: &LendingPool<T0>, arg1: &Obligation<T0>) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        let v0 = find_borrow_index<T0>(arg1, 0x1::type_name::with_defining_ids<T1>());
        if (v0 == 0x1::vector::length<Borrow>(&arg1.borrows)) {
            return 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero()
        };
        let v1 = 0x1::vector::borrow<Borrow>(&arg1.borrows, v0);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul(v1.principal, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::div(borrow_reserve<T0, T1>(arg0).cumulative_borrow_index, v1.borrow_index_snapshot))
    }

    public(friend) fun obligation_has_debt<T0>(arg0: &Obligation<T0>) : bool {
        !0x1::vector::is_empty<Borrow>(&arg0.borrows)
    }

    public(friend) fun obligation_last_refresh_s<T0>(arg0: &Obligation<T0>) : u64 {
        arg0.last_refresh_s
    }

    public(friend) fun obligation_refresh_in_progress<T0>(arg0: &Obligation<T0>) : bool {
        arg0.refresh_in_progress
    }

    public(friend) fun obligation_unhealthy_borrow_usd<T0>(arg0: &Obligation<T0>) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        arg0.unhealthy_borrow_usd
    }

    public(friend) fun obligation_weighted_borrow_usd<T0>(arg0: &Obligation<T0>) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        arg0.weighted_borrow_usd
    }

    public fun open_obligation<T0>(arg0: &LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg2: &mut 0x2::tx_context::TxContext) : (Obligation<T0>, ObligationCap<T0>, ObligationHotPotato) {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg1);
        assert_pool_config<T0>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = Obligation<T0>{
            id                   : 0x2::object::new(arg2),
            owner                : v0,
            pool_id              : 0x2::object::id<LendingPool<T0>>(arg0),
            deposits             : 0x1::vector::empty<Deposit>(),
            borrows              : 0x1::vector::empty<Borrow>(),
            allowed_borrow_usd   : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero(),
            unhealthy_borrow_usd : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero(),
            weighted_borrow_usd  : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero(),
            last_refresh_s       : 0,
            refresh_in_progress  : false,
            required_count       : 0,
            covered_types        : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        let v2 = 0x2::object::id<Obligation<T0>>(&v1);
        let v3 = ObligationCap<T0>{
            id            : 0x2::object::new(arg2),
            obligation_id : v2,
        };
        let v4 = ObligationHotPotato{obligation_id: v2};
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_obligation_opened(v2, v0);
        (v1, v3, v4)
    }

    public(friend) fun pool_id_of<T0>(arg0: &LendingPool<T0>) : 0x2::object::ID {
        0x2::object::id<LendingPool<T0>>(arg0)
    }

    public(friend) fun rc_active(arg0: &ReserveConfig) : bool {
        arg0.active
    }

    public(friend) fun rc_borrow_weight_bps(arg0: &ReserveConfig) : u64 {
        arg0.borrow_weight_bps
    }

    public(friend) fun rc_close_ltv_bps(arg0: &ReserveConfig) : u64 {
        arg0.close_ltv_bps
    }

    public(friend) fun rc_liquidation_bonus_bps(arg0: &ReserveConfig) : u64 {
        arg0.liquidation_bonus_bps
    }

    public(friend) fun rc_open_ltv_bps(arg0: &ReserveConfig) : u64 {
        arg0.open_ltv_bps
    }

    public(friend) fun rc_protocol_liquidation_fee_bps(arg0: &ReserveConfig) : u64 {
        arg0.protocol_liquidation_fee_bps
    }

    public(friend) fun record_bad_debt<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &mut Obligation<T0>, arg2: &mut 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg3: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x1::vector::length<Borrow>(&arg1.borrows) == 1, 21);
        let v1 = find_borrow_index<T0>(arg1, v0);
        assert!(v1 == 0, 21);
        let v2 = borrow_reserve_mut<T0, T1>(arg0);
        v2.borrowed_amount = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::sub_or_zero(v2.borrowed_amount, 0x1::vector::borrow<Borrow>(&arg1.borrows, v1).principal);
        let Borrow {
            coin_type             : _,
            principal             : _,
            borrow_index_snapshot : _,
        } = 0x1::vector::pop_back<Borrow>(&mut arg1.borrows);
        arg1.weighted_borrow_usd = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::zero();
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::add_bad_debt(arg2, arg3);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_bad_debt(0x2::object::id<LendingPool<T0>>(arg0), 0x2::object::id<Obligation<T0>>(arg1), v0, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(&arg3));
    }

    fun reduce_borrow_principal<T0>(arg0: &mut Obligation<T0>, arg1: 0x1::type_name::TypeName, arg2: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal) {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        if (v0 == 0x1::vector::length<Borrow>(&arg0.borrows)) {
            return
        };
        let v1 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.borrows, v0);
        v1.principal = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::sub_or_zero(v1.principal, arg2);
        if (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::is_zero(&v1.principal)) {
            let Borrow {
                coin_type             : _,
                principal             : _,
                borrow_index_snapshot : _,
            } = 0x1::vector::remove<Borrow>(&mut arg0.borrows, v0);
        };
    }

    public fun refresh_asset<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::OracleRegistry, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg3: &0x2::clock::Clock, arg4: &mut Obligation<T0>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        assert!(arg4.refresh_in_progress, 20);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x1::vector::contains<0x1::type_name::TypeName>(&arg4.covered_types, &v0), 18);
        let v1 = now_s(arg3);
        let v2 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::get_price<T1>(arg1, arg5, arg3);
        let v3 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::publish_time_s(&v2);
        assert!(v1 >= v3 && v1 - v3 <= 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::feed_max_age_secs<T1>(arg1), 19);
        accrue<T0, T1>(arg0, arg2, arg3);
        refresh_reserve_price<T0, T1>(arg0, &v2, arg3);
        let v4 = reserve_coin_decimals<T0, T1>(arg0);
        let v5 = false;
        let v6 = obligation_collateral_shares<T0, T1>(arg4);
        if (v6 > 0) {
            let v7 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_u128(share_ratio<T0, T1>(arg0), v6);
            let v8 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::value_usd(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::low_1e18(&v2), (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::floor_u128(&v7) as u64), v4);
            let (v9, v10) = collateral_ltvs<T0, T1>(arg0);
            arg4.allowed_borrow_usd = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(arg4.allowed_borrow_usd, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_bps(v8, v9));
            arg4.unhealthy_borrow_usd = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(arg4.unhealthy_borrow_usd, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_bps(v8, v10));
            v5 = true;
        };
        let v11 = obligation_debt_amount<T0, T1>(arg0, arg4);
        if (!0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::is_zero(&v11)) {
            arg4.weighted_borrow_usd = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(arg4.weighted_borrow_usd, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_bps(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::value_usd_ceil(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::high_1e18(&v2), 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::ceil(&v11), v4), reserve_borrow_weight<T0, T1>(arg0)));
            v5 = true;
        };
        assert!(v5, 3);
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg4.covered_types, v0);
    }

    public fun refresh_pair<T0, T1, T2>(arg0: &mut LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::OracleRegistry, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg3: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg4: &0x2::clock::Clock, arg5: &mut Obligation<T0>, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        begin_refresh<T0>(arg5, arg4);
        refresh_asset<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        refresh_asset<T0, T2>(arg0, arg1, arg3, arg4, arg5, arg7);
        seal_refresh<T0>(arg5, arg4);
    }

    public(friend) fun refresh_reserve_price<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::PriceResult, arg2: &0x2::clock::Clock) {
        let v0 = borrow_reserve_mut<T0, T1>(arg0);
        v0.price_lo_1e18 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::low_1e18(arg1);
        v0.price_hi_1e18 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::high_1e18(arg1);
        v0.price_last_update_s = now_s(arg2);
    }

    public fun remove_collateral<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg3: &0x2::clock::Clock, arg4: &mut Obligation<T0>, arg5: &ObligationCap<T0>, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, BorrowReceipt<T0>) {
        remove_shares_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, arg7)
    }

    fun remove_shares_internal<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg3: &0x2::clock::Clock, arg4: &mut Obligation<T0>, arg5: &ObligationCap<T0>, arg6: u128, arg7: bool, arg8: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, BorrowReceipt<T0>) {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg1);
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_not_paused(arg1);
        assert_pool_config<T0>(arg0, arg1);
        assert_obligation_pool<T0>(arg0, arg4);
        assert_cap<T0>(arg5, arg4);
        assert!(arg6 > 0, 7);
        let v0 = now_s(arg3);
        assert!(!arg4.refresh_in_progress && arg4.last_refresh_s == v0, 20);
        accrue<T0, T1>(arg0, arg2, arg3);
        let v1 = 0x1::type_name::with_defining_ids<T1>();
        assert!(arg6 <= obligation_collateral_shares<T0, T1>(arg4), 17);
        let v2 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_u128(share_ratio<T0, T1>(arg0), arg6);
        let v3 = (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::floor_u128(&v2) as u64);
        seize_collateral_shares<T0, T1>(arg0, arg4, arg6);
        let v4 = borrow_reserve_mut<T0, T1>(arg0);
        assert!(v3 <= v4.available_amount, 8);
        v4.available_amount = v4.available_amount - v3;
        let v5 = 0x2::coin::take<T1>(&mut v4.cash, v3, arg8);
        let (v6, _) = reserve_price_lo_hi<T0, T1>(arg0);
        let v8 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::oracle::value_usd(v6, v3, reserve_coin_decimals<T0, T1>(arg0));
        let (v9, v10) = collateral_ltvs<T0, T1>(arg0);
        arg4.allowed_borrow_usd = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::sub_or_zero(arg4.allowed_borrow_usd, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_bps(v8, v9));
        arg4.unhealthy_borrow_usd = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::sub_or_zero(arg4.unhealthy_borrow_usd, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_bps(v8, v10));
        let v11 = share_ratio<T0, T1>(arg0);
        if (arg7) {
            0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_withdraw(0x2::object::id<LendingPool<T0>>(arg0), v1, 0x2::tx_context::sender(arg8), v3, arg6, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(&v11));
        } else {
            0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_withdraw(0x2::object::id<LendingPool<T0>>(arg0), v1, 0x2::tx_context::sender(arg8), v3, arg6, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::value(&v11));
            0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_collateral_removed(0x2::object::id<Obligation<T0>>(arg4), v1, arg6);
        };
        let v12 = BorrowReceipt<T0>{
            pool_id             : 0x2::object::id<LendingPool<T0>>(arg0),
            obligation_id       : 0x2::object::id<Obligation<T0>>(arg4),
            refresh_stamp_s     : v0,
            allowed_borrow_usd  : arg4.allowed_borrow_usd,
            weighted_borrow_usd : arg4.weighted_borrow_usd,
        };
        (v5, v12)
    }

    public fun repay<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg3: &0x2::clock::Clock, arg4: &mut Obligation<T0>, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg1);
        assert_pool_config<T0>(arg0, arg1);
        assert_obligation_pool<T0>(arg0, arg4);
        accrue<T0, T1>(arg0, arg2, arg3);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = compound_debt_for<T0, T1>(arg0, arg4);
        assert!(!0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::is_zero(&v1), 16);
        let v2 = 0x2::coin::value<T1>(&arg5);
        let v3 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::ceil(&v1);
        let v4 = if (v2 < v3) {
            v2
        } else {
            v3
        };
        let v5 = borrow_reserve_mut<T0, T1>(arg0);
        v5.borrowed_amount = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::sub_or_zero(v5.borrowed_amount, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from(v4));
        0x2::balance::join<T1>(&mut v5.cash, 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg5, v4, arg6)));
        v5.available_amount = v5.available_amount + v4;
        reduce_borrow_principal<T0>(arg4, v0, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from(v4));
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::events::emit_repay(0x2::object::id<LendingPool<T0>>(arg0), 0x2::object::id<Obligation<T0>>(arg4), v0, 0x2::tx_context::sender(arg6), v4);
        arg5
    }

    public(friend) fun reserve_available<T0, T1>(arg0: &LendingPool<T0>) : u64 {
        borrow_reserve<T0, T1>(arg0).available_amount
    }

    fun reserve_borrow_weight<T0, T1>(arg0: &LendingPool<T0>) : u64 {
        borrow_reserve<T0, T1>(arg0).config.borrow_weight_bps
    }

    public(friend) fun reserve_coin_decimals<T0, T1>(arg0: &LendingPool<T0>) : u8 {
        borrow_reserve<T0, T1>(arg0).coin_decimals
    }

    public(friend) fun reserve_config<T0, T1>(arg0: &LendingPool<T0>) : ReserveConfig {
        borrow_reserve<T0, T1>(arg0).config
    }

    public(friend) fun reserve_exists<T0, T1>(arg0: &LendingPool<T0>) : bool {
        let v0 = ReserveKey<T1>{dummy_field: false};
        0x2::dynamic_object_field::exists_with_type<ReserveKey<T1>, Reserve<T1>>(&arg0.id, v0)
    }

    public(friend) fun reserve_price_lo_hi<T0, T1>(arg0: &LendingPool<T0>) : (u128, u128) {
        let v0 = borrow_reserve<T0, T1>(arg0);
        (v0.price_lo_1e18, v0.price_hi_1e18)
    }

    public fun seal_refresh<T0>(arg0: &mut Obligation<T0>, arg1: &0x2::clock::Clock) {
        assert!(arg0.refresh_in_progress, 20);
        assert!(0x1::vector::length<0x1::type_name::TypeName>(&arg0.covered_types) == arg0.required_count, 18);
        arg0.last_refresh_s = now_s(arg1);
        arg0.refresh_in_progress = false;
    }

    public(friend) fun seize_collateral_shares<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &mut Obligation<T0>, arg2: u128) : u128 {
        let v0 = find_deposit_index<T0>(arg1, 0x1::type_name::with_defining_ids<T1>());
        assert!(v0 < 0x1::vector::length<Deposit>(&arg1.deposits), 17);
        let v1 = 0x1::vector::borrow_mut<Deposit>(&mut arg1.deposits, v0);
        assert!(arg2 <= v1.shares, 17);
        v1.shares = v1.shares - arg2;
        let v2 = borrow_reserve_mut<T0, T1>(arg0);
        v2.total_shares = v2.total_shares - arg2;
        if (v1.shares == 0) {
            let Deposit {
                coin_type : _,
                shares    : _,
            } = 0x1::vector::remove<Deposit>(&mut arg1.deposits, v0);
        };
        arg2
    }

    public fun set_reserve_config<T0, T1>(arg0: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::RiskAdminCap, arg1: &mut LendingPool<T0>, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg3: ReserveConfig) {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg2);
        assert_pool_config<T0>(arg1, arg2);
        assert!(reserve_exists<T0, T1>(arg1), 14);
        validate_reserve_config(&arg3);
        borrow_reserve_mut<T0, T1>(arg1).config = arg3;
    }

    public fun share_obligation<T0>(arg0: Obligation<T0>, arg1: ObligationHotPotato) {
        let ObligationHotPotato { obligation_id: v0 } = arg1;
        assert!(0x2::object::id<Obligation<T0>>(&arg0) == v0, 5);
        0x2::transfer::share_object<Obligation<T0>>(arg0);
    }

    public(friend) fun share_ratio<T0, T1>(arg0: &LendingPool<T0>) : 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal {
        let v0 = borrow_reserve<T0, T1>(arg0);
        let v1 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::floor_u128(&v0.unclaimed_spread_fees);
        let v2 = (v0.available_amount as u128) + 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::floor_u128(&v0.borrowed_amount);
        let v3 = if (v2 > v1) {
            v2 - v1
        } else {
            0
        };
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::from_scaled(((v3 as u256) + 1) * 1000000000000000000 / ((v0.total_shares as u256) + 1000000))
    }

    public(friend) fun take_collateral_underlying<T0, T1>(arg0: &mut LendingPool<T0>, arg1: u128, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul_u128(share_ratio<T0, T1>(arg0), arg1);
        let v1 = (0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::floor_u128(&v0) as u64);
        let v2 = borrow_reserve_mut<T0, T1>(arg0);
        assert!(v1 <= v2.available_amount, 8);
        v2.available_amount = v2.available_amount - v1;
        0x2::coin::take<T1>(&mut v2.cash, v1, arg2)
    }

    fun upsert_borrow<T0>(arg0: &mut Obligation<T0>, arg1: 0x1::type_name::TypeName, arg2: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal, arg3: 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::Decimal) {
        let v0 = find_borrow_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<Borrow>(&arg0.borrows)) {
            let v1 = 0x1::vector::borrow_mut<Borrow>(&mut arg0.borrows, v0);
            v1.principal = 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::add(0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::mul(v1.principal, 0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::decimal::div(arg3, v1.borrow_index_snapshot)), arg2);
            v1.borrow_index_snapshot = arg3;
        } else {
            let v2 = Borrow{
                coin_type             : arg1,
                principal             : arg2,
                borrow_index_snapshot : arg3,
            };
            0x1::vector::push_back<Borrow>(&mut arg0.borrows, v2);
        };
    }

    fun upsert_deposit<T0>(arg0: &mut Obligation<T0>, arg1: 0x1::type_name::TypeName, arg2: u128) {
        if (arg2 == 0) {
            return
        };
        let v0 = find_deposit_index<T0>(arg0, arg1);
        if (v0 < 0x1::vector::length<Deposit>(&arg0.deposits)) {
            let v1 = 0x1::vector::borrow_mut<Deposit>(&mut arg0.deposits, v0);
            v1.shares = v1.shares + arg2;
        } else {
            let v2 = Deposit{
                coin_type : arg1,
                shares    : arg2,
            };
            0x1::vector::push_back<Deposit>(&mut arg0.deposits, v2);
        };
    }

    fun validate_reserve_config(arg0: &ReserveConfig) {
        assert!(arg0.close_ltv_bps > arg0.open_ltv_bps, 15);
        assert!(arg0.close_ltv_bps <= 10000, 15);
        assert!(arg0.borrow_weight_bps >= 10000, 15);
    }

    public fun withdraw<T0, T1>(arg0: &mut LendingPool<T0>, arg1: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::interest::RateCurve, arg3: &0x2::clock::Clock, arg4: &mut Obligation<T0>, arg5: &ObligationCap<T0>, arg6: u128, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, BorrowReceipt<T0>) {
        remove_shares_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, arg7)
    }

    public fun withdraw_fees<T0, T1>(arg0: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::AdminCap, arg1: &mut LendingPool<T0>, arg2: &0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::GlobalConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4e81cabebc69f7f14803a9ab5ed60858904f0118536e957a4095a8c60ea4359b::ploan::assert_version(arg2);
        assert_pool_config<T0>(arg1, arg2);
        let v0 = borrow_reserve_mut<T0, T1>(arg1);
        assert!(arg3 <= 0x2::balance::value<T1>(&v0.fees), 8);
        0x2::coin::take<T1>(&mut v0.fees, arg3, arg4)
    }

    // decompiled from Move bytecode v7
}

