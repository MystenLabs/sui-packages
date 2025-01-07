module 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::lending_core_storage {
    struct Storage has key {
        id: 0x2::object::UID,
        app_cap: 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::AppCap,
        reserves: 0x2::table::Table<u16, ReserveData>,
        user_infos: 0x2::table::Table<u64, UserInfo>,
    }

    struct UserInfo has store {
        average_liquidity: u256,
        last_average_update: u256,
        liquid_assets: vector<u16>,
        collaterals: vector<u16>,
        loans: vector<u16>,
    }

    struct ReserveData has store {
        is_isolated_asset: bool,
        borrowable_in_isolation: bool,
        isolate_debt: u256,
        last_update_timestamp: u256,
        treasury: u64,
        treasury_factor: u256,
        supply_cap_ceiling: u256,
        borrow_cap_ceiling: u256,
        current_borrow_rate: u256,
        current_liquidity_rate: u256,
        current_borrow_index: u256,
        current_liquidity_index: u256,
        collateral_coefficient: u256,
        borrow_coefficient: u256,
        borrow_rate_factors: BorrowRateFactors,
        otoken_scaled: ScaledBalance,
        dtoken_scaled: ScaledBalance,
    }

    struct ScaledBalance has store {
        user_state: 0x2::table::Table<u64, u256>,
        total_supply: u256,
    }

    struct BorrowRateFactors has store {
        base_borrow_rate: u256,
        borrow_rate_slope1: u256,
        borrow_rate_slope2: u256,
        optimal_utilization: u256,
    }

    public fun get_app_id(arg0: &mut Storage) : u16 {
        0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::get_app_id(&arg0.app_cap)
    }

    public(friend) fun add_user_collateral(arg0: &mut Storage, arg1: u64, arg2: u16) {
        let v0 = 0x2::table::borrow_mut<u64, UserInfo>(&mut arg0.user_infos, arg1);
        if (!0x1::vector::contains<u16>(&v0.collaterals, &arg2) && !0x1::vector::contains<u16>(&v0.liquid_assets, &arg2)) {
            0x1::vector::push_back<u16>(&mut v0.collaterals, arg2);
        };
    }

    public(friend) fun add_user_liquid_asset(arg0: &mut Storage, arg1: u64, arg2: u16) {
        let v0 = 0x2::table::borrow_mut<u64, UserInfo>(&mut arg0.user_infos, arg1);
        if (!0x1::vector::contains<u16>(&v0.liquid_assets, &arg2) && !0x1::vector::contains<u16>(&v0.collaterals, &arg2)) {
            0x1::vector::push_back<u16>(&mut v0.liquid_assets, arg2);
        };
    }

    public(friend) fun add_user_loan(arg0: &mut Storage, arg1: u64, arg2: u16) {
        let v0 = 0x2::table::borrow_mut<u64, UserInfo>(&mut arg0.user_infos, arg1);
        if (!0x1::vector::contains<u16>(&v0.loans, &arg2)) {
            0x1::vector::push_back<u16>(&mut v0.loans, arg2);
        };
    }

    public fun borrow_storage_id(arg0: &Storage) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun burn_dtoken_scaled(arg0: &mut Storage, arg1: u16, arg2: u64, arg3: u256) {
        let v0 = &mut 0x2::table::borrow_mut<u16, ReserveData>(&mut arg0.reserves, arg1).dtoken_scaled;
        let v1 = if (0x2::table::contains<u64, u256>(&v0.user_state, arg2)) {
            0x2::table::remove<u64, u256>(&mut v0.user_state, arg2)
        } else {
            0
        };
        assert!(v1 >= arg3, 1);
        0x2::table::add<u64, u256>(&mut v0.user_state, arg2, v1 - arg3);
        v0.total_supply = v0.total_supply - arg3;
    }

    public(friend) fun burn_otoken_scaled(arg0: &mut Storage, arg1: u16, arg2: u64, arg3: u256) {
        let v0 = &mut 0x2::table::borrow_mut<u16, ReserveData>(&mut arg0.reserves, arg1).otoken_scaled;
        let v1 = if (0x2::table::contains<u64, u256>(&v0.user_state, arg2)) {
            0x2::table::remove<u64, u256>(&mut v0.user_state, arg2)
        } else {
            0
        };
        assert!(v1 >= arg3, 1);
        0x2::table::add<u64, u256>(&mut v0.user_state, arg2, v1 - arg3);
        v0.total_supply = v0.total_supply - arg3;
    }

    public fun can_borrow_in_isolation(arg0: &mut Storage, arg1: u16) : bool {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).borrowable_in_isolation
    }

    public fun ensure_user_info_exist(arg0: &mut Storage, arg1: &0x2::clock::Clock, arg2: u64) {
        if (!0x2::table::contains<u64, UserInfo>(&mut arg0.user_infos, arg2)) {
            let v0 = UserInfo{
                average_liquidity   : 0,
                last_average_update : get_timestamp(arg1),
                liquid_assets       : 0x1::vector::empty<u16>(),
                collaterals         : 0x1::vector::empty<u16>(),
                loans               : 0x1::vector::empty<u16>(),
            };
            0x2::table::add<u64, UserInfo>(&mut arg0.user_infos, arg2, v0);
        };
    }

    public fun exist_reserve(arg0: &mut Storage, arg1: u16) : bool {
        0x2::table::contains<u16, ReserveData>(&mut arg0.reserves, arg1)
    }

    public fun exist_user_info(arg0: &mut Storage, arg1: u64) : bool {
        0x2::table::contains<u64, UserInfo>(&mut arg0.user_infos, arg1)
    }

    public(friend) fun get_app_cap(arg0: &mut Storage) : &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::AppCap {
        &arg0.app_cap
    }

    public fun get_borrow_coefficient(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).borrow_coefficient
    }

    public fun get_borrow_index(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).current_borrow_index
    }

    public fun get_borrow_rate(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).current_borrow_rate
    }

    public fun get_borrow_rate_factors(arg0: &mut Storage, arg1: u16) : (u256, u256, u256, u256) {
        let v0 = &0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).borrow_rate_factors;
        (v0.base_borrow_rate, v0.borrow_rate_slope1, v0.borrow_rate_slope2, v0.optimal_utilization)
    }

    public fun get_collateral_coefficient(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).collateral_coefficient
    }

    public fun get_dtoken_scaled_total_supply(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).dtoken_scaled.total_supply
    }

    public fun get_dtoken_scaled_total_supply_v2(arg0: &Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).dtoken_scaled.total_supply
    }

    public fun get_isolate_debt(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).isolate_debt
    }

    public fun get_last_update_timestamp(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).last_update_timestamp
    }

    public fun get_liquidity_index(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).current_liquidity_index
    }

    public fun get_liquidity_rate(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).current_liquidity_rate
    }

    public fun get_otoken_scaled_total_supply(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).otoken_scaled.total_supply
    }

    public fun get_otoken_scaled_total_supply_v2(arg0: &Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).otoken_scaled.total_supply
    }

    public fun get_reserve_borrow_ceiling(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).borrow_cap_ceiling
    }

    public fun get_reserve_length(arg0: &mut Storage) : u64 {
        0x2::table::length<u16, ReserveData>(&arg0.reserves)
    }

    public fun get_reserve_supply_ceiling(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).supply_cap_ceiling
    }

    public fun get_reserve_treasury(arg0: &mut Storage, arg1: u16) : u64 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).treasury
    }

    public fun get_storage_id(arg0: &mut Storage) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun get_timestamp(arg0: &0x2::clock::Clock) : u256 {
        ((0x2::clock::timestamp_ms(arg0) / 1000) as u256)
    }

    public fun get_treasury_factor(arg0: &mut Storage, arg1: u16) : u256 {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).treasury_factor
    }

    public fun get_user_average_liquidity(arg0: &mut Storage, arg1: u64) : u256 {
        0x2::table::borrow<u64, UserInfo>(&mut arg0.user_infos, arg1).average_liquidity
    }

    public fun get_user_collaterals(arg0: &mut Storage, arg1: u64) : vector<u16> {
        0x2::table::borrow<u64, UserInfo>(&mut arg0.user_infos, arg1).collaterals
    }

    public fun get_user_last_timestamp(arg0: &mut Storage, arg1: u64) : u256 {
        0x2::table::borrow<u64, UserInfo>(&mut arg0.user_infos, arg1).last_average_update
    }

    public fun get_user_liquid_assets(arg0: &mut Storage, arg1: u64) : vector<u16> {
        0x2::table::borrow<u64, UserInfo>(&mut arg0.user_infos, arg1).liquid_assets
    }

    public fun get_user_loans(arg0: &mut Storage, arg1: u64) : vector<u16> {
        0x2::table::borrow<u64, UserInfo>(&mut arg0.user_infos, arg1).loans
    }

    public fun get_user_scaled_dtoken(arg0: &mut Storage, arg1: u64, arg2: u16) : u256 {
        let v0 = 0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg2);
        if (0x2::table::contains<u64, u256>(&v0.dtoken_scaled.user_state, arg1)) {
            *0x2::table::borrow<u64, u256>(&v0.dtoken_scaled.user_state, arg1)
        } else {
            0
        }
    }

    public fun get_user_scaled_dtoken_v2(arg0: &Storage, arg1: u64, arg2: u16) : u256 {
        let v0 = 0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg2);
        if (0x2::table::contains<u64, u256>(&v0.dtoken_scaled.user_state, arg1)) {
            *0x2::table::borrow<u64, u256>(&v0.dtoken_scaled.user_state, arg1)
        } else {
            0
        }
    }

    public fun get_user_scaled_otoken(arg0: &mut Storage, arg1: u64, arg2: u16) : u256 {
        let v0 = 0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg2);
        if (0x2::table::contains<u64, u256>(&v0.otoken_scaled.user_state, arg1)) {
            *0x2::table::borrow<u64, u256>(&v0.otoken_scaled.user_state, arg1)
        } else {
            0
        }
    }

    public fun get_user_scaled_otoken_v2(arg0: &Storage, arg1: u64, arg2: u16) : u256 {
        let v0 = 0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg2);
        if (0x2::table::contains<u64, u256>(&v0.otoken_scaled.user_state, arg1)) {
            *0x2::table::borrow<u64, u256>(&v0.otoken_scaled.user_state, arg1)
        } else {
            0
        }
    }

    public fun initialize_cap_with_governance(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::TotalAppInfo, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Storage{
            id         : 0x2::object::new(arg2),
            app_cap    : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::app_manager::register_cap_with_governance(arg0, arg1, arg2),
            reserves   : 0x2::table::new<u16, ReserveData>(arg2),
            user_infos : 0x2::table::new<u64, UserInfo>(arg2),
        };
        0x2::transfer::share_object<Storage>(v0);
    }

    public fun is_isolated_asset(arg0: &mut Storage, arg1: u16) : bool {
        0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).is_isolated_asset
    }

    public(friend) fun mint_dtoken_scaled(arg0: &mut Storage, arg1: u16, arg2: u64, arg3: u256) {
        let v0 = &mut 0x2::table::borrow_mut<u16, ReserveData>(&mut arg0.reserves, arg1).dtoken_scaled;
        let v1 = if (0x2::table::contains<u64, u256>(&v0.user_state, arg2)) {
            0x2::table::remove<u64, u256>(&mut v0.user_state, arg2)
        } else {
            0
        };
        0x2::table::add<u64, u256>(&mut v0.user_state, arg2, arg3 + v1);
        v0.total_supply = v0.total_supply + arg3;
    }

    public(friend) fun mint_otoken_scaled(arg0: &mut Storage, arg1: u16, arg2: u64, arg3: u256) {
        let v0 = &mut 0x2::table::borrow_mut<u16, ReserveData>(&mut arg0.reserves, arg1).otoken_scaled;
        let v1 = if (0x2::table::contains<u64, u256>(&v0.user_state, arg2)) {
            0x2::table::remove<u64, u256>(&mut v0.user_state, arg2)
        } else {
            0
        };
        0x2::table::add<u64, u256>(&mut v0.user_state, arg2, arg3 + v1);
        v0.total_supply = v0.total_supply + arg3;
    }

    public fun register_new_reserve(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut Storage, arg2: &0x2::clock::Clock, arg3: u16, arg4: bool, arg5: bool, arg6: u64, arg7: u256, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u256, arg15: u256, arg16: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<u16, ReserveData>(&arg1.reserves, arg3), 0);
        let v0 = BorrowRateFactors{
            base_borrow_rate    : arg12,
            borrow_rate_slope1  : arg13,
            borrow_rate_slope2  : arg14,
            optimal_utilization : arg15,
        };
        let v1 = ScaledBalance{
            user_state   : 0x2::table::new<u64, u256>(arg16),
            total_supply : 0,
        };
        let v2 = ScaledBalance{
            user_state   : 0x2::table::new<u64, u256>(arg16),
            total_supply : 0,
        };
        let v3 = ReserveData{
            is_isolated_asset       : arg4,
            borrowable_in_isolation : arg5,
            isolate_debt            : 0,
            last_update_timestamp   : get_timestamp(arg2),
            treasury                : arg6,
            treasury_factor         : arg7,
            supply_cap_ceiling      : arg8,
            borrow_cap_ceiling      : arg9,
            current_borrow_rate     : 0,
            current_liquidity_rate  : 0,
            current_borrow_index    : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            current_liquidity_index : 0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::ray_math::ray(),
            collateral_coefficient  : arg10,
            borrow_coefficient      : arg11,
            borrow_rate_factors     : v0,
            otoken_scaled           : v1,
            dtoken_scaled           : v2,
        };
        0x2::table::add<u16, ReserveData>(&mut arg1.reserves, arg3, v3);
    }

    public(friend) fun remove_user_collateral(arg0: &mut Storage, arg1: u64, arg2: u16) {
        let v0 = 0x2::table::borrow_mut<u64, UserInfo>(&mut arg0.user_infos, arg1);
        let (v1, v2) = 0x1::vector::index_of<u16>(&v0.collaterals, &arg2);
        if (v1) {
            0x1::vector::remove<u16>(&mut v0.collaterals, v2);
        };
    }

    public(friend) fun remove_user_liquid_asset(arg0: &mut Storage, arg1: u64, arg2: u16) {
        let v0 = 0x2::table::borrow_mut<u64, UserInfo>(&mut arg0.user_infos, arg1);
        let (v1, v2) = 0x1::vector::index_of<u16>(&v0.liquid_assets, &arg2);
        if (v1) {
            0x1::vector::remove<u16>(&mut v0.liquid_assets, v2);
        };
    }

    public(friend) fun remove_user_loan(arg0: &mut Storage, arg1: u64, arg2: u16) {
        let v0 = 0x2::table::borrow_mut<u64, UserInfo>(&mut arg0.user_infos, arg1);
        let (v1, v2) = 0x1::vector::index_of<u16>(&v0.loans, &arg2);
        if (v1) {
            0x1::vector::remove<u16>(&mut v0.loans, v2);
        };
    }

    public fun set_borrow_cap_ceiling(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut Storage, arg2: u16, arg3: u256) {
        0x2::table::borrow_mut<u16, ReserveData>(&mut arg1.reserves, arg2).borrow_cap_ceiling = arg3;
    }

    public fun set_borrow_coefficient(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut Storage, arg2: u16, arg3: u256) {
        0x2::table::borrow_mut<u16, ReserveData>(&mut arg1.reserves, arg2).borrow_coefficient = arg3;
    }

    public fun set_borrow_rate_factors(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut Storage, arg2: u16, arg3: u256, arg4: u256, arg5: u256, arg6: u256) {
        let v0 = &mut 0x2::table::borrow_mut<u16, ReserveData>(&mut arg1.reserves, arg2).borrow_rate_factors;
        v0.base_borrow_rate = arg3;
        v0.borrow_rate_slope1 = arg4;
        v0.borrow_rate_slope2 = arg5;
        v0.optimal_utilization = arg6;
    }

    public fun set_borrowable_in_isolation(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut Storage, arg2: u16, arg3: bool) {
        0x2::table::borrow_mut<u16, ReserveData>(&mut arg1.reserves, arg2).borrowable_in_isolation = arg3;
    }

    public fun set_collateral_coefficient(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut Storage, arg2: u16, arg3: u256) {
        0x2::table::borrow_mut<u16, ReserveData>(&mut arg1.reserves, arg2).collateral_coefficient = arg3;
    }

    public fun set_is_isolated_asset(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut Storage, arg2: u16, arg3: bool) {
        0x2::table::borrow_mut<u16, ReserveData>(&mut arg1.reserves, arg2).is_isolated_asset = arg3;
    }

    public fun set_supply_cap_ceiling(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut Storage, arg2: u16, arg3: u256) {
        0x2::table::borrow_mut<u16, ReserveData>(&mut arg1.reserves, arg2).supply_cap_ceiling = arg3;
    }

    public fun set_treasury_factor(arg0: &0x826915f8ca6d11597dfe6599b8aa02a4c08bd8d39674855254a06ee83fe7220e::genesis::GovernanceCap, arg1: &mut Storage, arg2: u16, arg3: u256) {
        0x2::table::borrow_mut<u16, ReserveData>(&mut arg1.reserves, arg2).treasury_factor = arg3;
    }

    public(friend) fun update_interest_rate(arg0: &mut Storage, arg1: u16, arg2: u256, arg3: u256) {
        let v0 = 0x2::table::borrow_mut<u16, ReserveData>(&mut arg0.reserves, arg1);
        v0.current_borrow_rate = arg2;
        v0.current_liquidity_rate = arg3;
    }

    public(friend) fun update_isolate_debt(arg0: &mut Storage, arg1: u16, arg2: u256) {
        0x2::table::borrow_mut<u16, ReserveData>(&mut arg0.reserves, arg1).isolate_debt = arg2;
    }

    public(friend) fun update_state(arg0: &mut Storage, arg1: u16, arg2: u256, arg3: u256, arg4: u256, arg5: u256) {
        let v0 = 0x2::table::borrow_mut<u16, ReserveData>(&mut arg0.reserves, arg1);
        v0.current_borrow_index = arg2;
        v0.current_liquidity_index = arg3;
        v0.last_update_timestamp = arg4;
        let v1 = 0x2::table::borrow<u16, ReserveData>(&arg0.reserves, arg1).treasury;
        mint_otoken_scaled(arg0, arg1, v1, arg5);
    }

    public(friend) fun update_user_average_liquidity(arg0: &mut Storage, arg1: &0x2::clock::Clock, arg2: u64, arg3: u256) {
        let v0 = 0x2::table::borrow_mut<u64, UserInfo>(&mut arg0.user_infos, arg2);
        v0.last_average_update = get_timestamp(arg1);
        v0.average_liquidity = arg3;
    }

    // decompiled from Move bytecode v6
}

