module 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::storage {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct StorageAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Storage has store, key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        reserves: 0x2::table::Table<u8, ReserveData>,
        reserves_count: u8,
        users: vector<address>,
        user_info: 0x2::table::Table<address, UserInfo>,
    }

    struct ReserveData has store {
        id: u8,
        oracle_id: u8,
        coin_type: 0x1::ascii::String,
        is_isolated: bool,
        supply_cap_ceiling: u256,
        borrow_cap_ceiling: u256,
        current_supply_rate: u256,
        current_borrow_rate: u256,
        current_supply_index: u256,
        current_borrow_index: u256,
        supply_balance: TokenBalance,
        borrow_balance: TokenBalance,
        last_update_timestamp: u64,
        ltv: u256,
        treasury_factor: u256,
        treasury_balance: u256,
        borrow_rate_factors: BorrowRateFactors,
        liquidation_factors: LiquidationFactors,
        reserve_field_a: u256,
        reserve_field_b: u256,
        reserve_field_c: u256,
    }

    struct UserInfo has store {
        collaterals: vector<u8>,
        loans: vector<u8>,
    }

    struct ReserveConfigurationMap has copy, store {
        data: u256,
    }

    struct UserConfigurationMap has copy, store {
        data: u256,
    }

    struct TokenBalance has store {
        user_state: 0x2::table::Table<address, u256>,
        total_supply: u256,
    }

    struct BorrowRateFactors has store {
        base_rate: u256,
        multiplier: u256,
        jump_rate_multiplier: u256,
        reserve_factor: u256,
        optimal_utilization: u256,
    }

    struct LiquidationFactors has store {
        ratio: u256,
        bonus: u256,
        threshold: u256,
    }

    struct StorageConfiguratorSetting has copy, drop {
        sender: address,
        configurator: address,
        value: bool,
    }

    struct Paused has copy, drop {
        paused: bool,
    }

    fun decrease_balance(arg0: &mut TokenBalance, arg1: address, arg2: u256) {
        let v0 = 0;
        if (0x2::table::contains<address, u256>(&arg0.user_state, arg1)) {
            v0 = 0x2::table::remove<address, u256>(&mut arg0.user_state, arg1);
        };
        assert!(v0 >= arg2, 43005);
        0x2::table::add<address, u256>(&mut arg0.user_state, arg1, v0 - arg2);
        arg0.total_supply = arg0.total_supply - arg2;
    }

    public(friend) fun decrease_borrow_balance(arg0: &mut Storage, arg1: u8, arg2: address, arg3: u256) {
        version_verification(arg0);
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).borrow_balance;
        decrease_balance(v0, arg2, arg3);
    }

    public(friend) fun decrease_supply_balance(arg0: &mut Storage, arg1: u8, arg2: address, arg3: u256) {
        version_verification(arg0);
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).supply_balance;
        decrease_balance(v0, arg2, arg3);
    }

    public fun destory_user(arg0: &StorageAdminCap, arg1: &mut Storage) {
        abort 0
    }

    public fun get_asset_ltv(arg0: &Storage, arg1: u8) : u256 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).ltv
    }

    public fun get_borrow_cap_ceiling_ratio(arg0: &mut Storage, arg1: u8) : u256 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).borrow_cap_ceiling
    }

    public fun get_borrow_rate_factors(arg0: &mut Storage, arg1: u8) : (u256, u256, u256, u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        (v0.borrow_rate_factors.base_rate, v0.borrow_rate_factors.multiplier, v0.borrow_rate_factors.jump_rate_multiplier, v0.borrow_rate_factors.reserve_factor, v0.borrow_rate_factors.optimal_utilization)
    }

    public fun get_coin_type(arg0: &Storage, arg1: u8) : 0x1::ascii::String {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).coin_type
    }

    public fun get_current_rate(arg0: &mut Storage, arg1: u8) : (u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        (v0.current_supply_rate, v0.current_borrow_rate)
    }

    public fun get_index(arg0: &mut Storage, arg1: u8) : (u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        (v0.current_supply_index, v0.current_borrow_index)
    }

    public fun get_last_update_timestamp(arg0: &Storage, arg1: u8) : u64 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).last_update_timestamp
    }

    public fun get_liquidation_factors(arg0: &mut Storage, arg1: u8) : (u256, u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        (v0.liquidation_factors.ratio, v0.liquidation_factors.bonus, v0.liquidation_factors.threshold)
    }

    public fun get_oracle_id(arg0: &Storage, arg1: u8) : u8 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).oracle_id
    }

    public fun get_reserves_count(arg0: &Storage) : u8 {
        arg0.reserves_count
    }

    public fun get_supply_cap_ceiling(arg0: &mut Storage, arg1: u8) : u256 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).supply_cap_ceiling
    }

    public fun get_total_supply(arg0: &mut Storage, arg1: u8) : (u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        (v0.supply_balance.total_supply, v0.borrow_balance.total_supply)
    }

    public fun get_treasury_balance(arg0: &Storage, arg1: u8) : u256 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).treasury_balance
    }

    public fun get_treasury_factor(arg0: &mut Storage, arg1: u8) : u256 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).treasury_factor
    }

    public fun get_user_assets(arg0: &Storage, arg1: address) : (vector<u8>, vector<u8>) {
        if (!0x2::table::contains<address, UserInfo>(&arg0.user_info, arg1)) {
            return (0x1::vector::empty<u8>(), 0x1::vector::empty<u8>())
        };
        let v0 = 0x2::table::borrow<address, UserInfo>(&arg0.user_info, arg1);
        (v0.collaterals, v0.loans)
    }

    public fun get_user_balance(arg0: &mut Storage, arg1: u8, arg2: address) : (u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        let v1 = 0;
        let v2 = 0;
        if (0x2::table::contains<address, u256>(&v0.supply_balance.user_state, arg2)) {
            v1 = *0x2::table::borrow<address, u256>(&v0.supply_balance.user_state, arg2);
        };
        if (0x2::table::contains<address, u256>(&v0.borrow_balance.user_state, arg2)) {
            v2 = *0x2::table::borrow<address, u256>(&v0.borrow_balance.user_state, arg2);
        };
        (v1, v2)
    }

    fun increase_balance(arg0: &mut TokenBalance, arg1: address, arg2: u256) {
        let v0 = 0;
        if (0x2::table::contains<address, u256>(&arg0.user_state, arg1)) {
            v0 = 0x2::table::remove<address, u256>(&mut arg0.user_state, arg1);
        };
        0x2::table::add<address, u256>(&mut arg0.user_state, arg1, v0 + arg2);
        arg0.total_supply = arg0.total_supply + arg2;
    }

    public(friend) fun increase_balance_for_pool(arg0: &mut Storage, arg1: u8, arg2: u256, arg3: u256) {
        version_verification(arg0);
        let v0 = 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1);
        let v1 = &mut v0.supply_balance;
        let v2 = &mut v0.borrow_balance;
        v1.total_supply = v1.total_supply + arg2;
        v2.total_supply = v2.total_supply + arg3;
    }

    public(friend) fun increase_borrow_balance(arg0: &mut Storage, arg1: u8, arg2: address, arg3: u256) {
        version_verification(arg0);
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).borrow_balance;
        increase_balance(v0, arg2, arg3);
    }

    public(friend) fun increase_supply_balance(arg0: &mut Storage, arg1: u8, arg2: address, arg3: u256) {
        version_verification(arg0);
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).supply_balance;
        increase_balance(v0, arg2, arg3);
    }

    public(friend) fun increase_treasury_balance(arg0: &mut Storage, arg1: u8, arg2: u256) {
        let v0 = 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1);
        v0.treasury_balance = v0.treasury_balance + arg2;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = StorageAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<StorageAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OwnerCap>(v1, 0x2::tx_context::sender(arg0));
        let v2 = Storage{
            id             : 0x2::object::new(arg0),
            version        : 5,
            paused         : false,
            reserves       : 0x2::table::new<u8, ReserveData>(arg0),
            reserves_count : 0,
            users          : 0x1::vector::empty<address>(),
            user_info      : 0x2::table::new<address, UserInfo>(arg0),
        };
        0x2::transfer::share_object<Storage>(v2);
    }

    public entry fun init_reserve<T0>(arg0: &StorageAdminCap, arg1: &0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::PoolAdminCap, arg2: &0x2::clock::Clock, arg3: &mut Storage, arg4: u8, arg5: bool, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u256, arg15: u256, arg16: u256, arg17: u256, arg18: &0x2::coin::CoinMetadata<T0>, arg19: &mut 0x2::tx_context::TxContext) {
        version_verification(arg3);
        let v0 = arg3.reserves_count;
        assert!(v0 < 255, 43004);
        reserve_validation<T0>(arg3);
        let v1 = TokenBalance{
            user_state   : 0x2::table::new<address, u256>(arg19),
            total_supply : 0,
        };
        let v2 = TokenBalance{
            user_state   : 0x2::table::new<address, u256>(arg19),
            total_supply : 0,
        };
        let v3 = BorrowRateFactors{
            base_rate            : arg8,
            multiplier           : arg10,
            jump_rate_multiplier : arg11,
            reserve_factor       : arg12,
            optimal_utilization  : arg9,
        };
        let v4 = LiquidationFactors{
            ratio     : arg15,
            bonus     : arg16,
            threshold : arg17,
        };
        let v5 = ReserveData{
            id                    : arg3.reserves_count,
            oracle_id             : arg4,
            coin_type             : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            is_isolated           : arg5,
            supply_cap_ceiling    : arg6,
            borrow_cap_ceiling    : arg7,
            current_supply_rate   : 0,
            current_borrow_rate   : 0,
            current_supply_index  : 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::ray_math::ray(),
            current_borrow_index  : 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::ray_math::ray(),
            supply_balance        : v1,
            borrow_balance        : v2,
            last_update_timestamp : 0x2::clock::timestamp_ms(arg2),
            ltv                   : arg13,
            treasury_factor       : arg14,
            treasury_balance      : 0,
            borrow_rate_factors   : v3,
            liquidation_factors   : v4,
            reserve_field_a       : 0,
            reserve_field_b       : 0,
            reserve_field_c       : 0,
        };
        0x2::table::add<u8, ReserveData>(&mut arg3.reserves, v0, v5);
        arg3.reserves_count = v0 + 1;
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::create_pool<T0>(arg1, 0x2::coin::get_decimals<T0>(arg18), arg19);
    }

    public fun pause(arg0: &Storage) : bool {
        arg0.paused
    }

    public(friend) fun remove_user_collaterals(arg0: &mut Storage, arg1: u8, arg2: address) {
        let v0 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, arg2);
        let (v1, v2) = 0x1::vector::index_of<u8>(&v0.collaterals, &arg1);
        if (v1) {
            0x1::vector::remove<u8>(&mut v0.collaterals, v2);
        };
    }

    public(friend) fun remove_user_loans(arg0: &mut Storage, arg1: u8, arg2: address) {
        let v0 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, arg2);
        let (v1, v2) = 0x1::vector::index_of<u8>(&v0.loans, &arg1);
        if (v1) {
            0x1::vector::remove<u8>(&mut v0.loans, v2);
        };
    }

    public fun reserve_validation<T0>(arg0: &Storage) {
        let v0 = 0;
        while (v0 < arg0.reserves_count) {
            assert!(0x2::table::borrow<u8, ReserveData>(&arg0.reserves, v0).coin_type != 0x1::type_name::into_string(0x1::type_name::get<T0>()), 43006);
            v0 = v0 + 1;
        };
    }

    public fun set_base_rate(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).borrow_rate_factors.base_rate = arg3;
    }

    public fun set_borrow_cap(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).borrow_cap_ceiling = arg3;
    }

    public fun set_jump_rate_multiplier(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).borrow_rate_factors.jump_rate_multiplier = arg3;
    }

    public fun set_liquidation_bonus(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).liquidation_factors.bonus = arg3;
    }

    public fun set_liquidation_ratio(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).liquidation_factors.ratio = arg3;
    }

    public fun set_liquidation_threshold(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).liquidation_factors.threshold = arg3;
    }

    public fun set_ltv(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).ltv = arg3;
    }

    public fun set_multiplier(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).borrow_rate_factors.multiplier = arg3;
    }

    public fun set_optimal_utilization(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).borrow_rate_factors.optimal_utilization = arg3;
    }

    public entry fun set_pause(arg0: &OwnerCap, arg1: &mut Storage, arg2: bool) {
        version_verification(arg1);
        arg1.paused = arg2;
        let v0 = Paused{paused: arg2};
        0x2::event::emit<Paused>(v0);
    }

    public fun set_reserve_factor(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).borrow_rate_factors.reserve_factor = arg3;
    }

    public fun set_supply_cap(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).supply_cap_ceiling = arg3;
    }

    public fun set_treasury_factor(arg0: &OwnerCap, arg1: &mut Storage, arg2: u8, arg3: u256) {
        version_verification(arg1);
        0x2::table::borrow_mut<u8, ReserveData>(&mut arg1.reserves, arg2).treasury_factor = arg3;
    }

    public(friend) fun update_interest_rate(arg0: &mut Storage, arg1: u8, arg2: u256, arg3: u256) {
        version_verification(arg0);
        let v0 = 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1);
        v0.current_supply_rate = arg3;
        v0.current_borrow_rate = arg2;
    }

    public(friend) fun update_state(arg0: &mut Storage, arg1: u8, arg2: u256, arg3: u256, arg4: u64, arg5: u256) {
        version_verification(arg0);
        let v0 = 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1);
        v0.current_borrow_index = arg2;
        v0.current_supply_index = arg3;
        v0.last_update_timestamp = arg4;
        v0.treasury_balance = v0.treasury_balance + arg5;
    }

    public(friend) fun update_user_collaterals(arg0: &mut Storage, arg1: u8, arg2: address) {
        if (!0x2::table::contains<address, UserInfo>(&arg0.user_info, arg2)) {
            let v0 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v0, arg1);
            let v1 = UserInfo{
                collaterals : v0,
                loans       : 0x1::vector::empty<u8>(),
            };
            0x2::table::add<address, UserInfo>(&mut arg0.user_info, arg2, v1);
        } else {
            let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, arg2);
            if (!0x1::vector::contains<u8>(&v2.collaterals, &arg1)) {
                0x1::vector::push_back<u8>(&mut v2.collaterals, arg1);
            };
        };
    }

    public(friend) fun update_user_loans(arg0: &mut Storage, arg1: u8, arg2: address) {
        if (!0x2::table::contains<address, UserInfo>(&arg0.user_info, arg2)) {
            let v0 = 0x1::vector::empty<u8>();
            0x1::vector::push_back<u8>(&mut v0, arg1);
            let v1 = UserInfo{
                collaterals : 0x1::vector::empty<u8>(),
                loans       : v0,
            };
            0x2::table::add<address, UserInfo>(&mut arg0.user_info, arg2, v1);
        } else {
            let v2 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.user_info, arg2);
            if (!0x1::vector::contains<u8>(&v2.loans, &arg1)) {
                0x1::vector::push_back<u8>(&mut v2.loans, arg1);
            };
        };
    }

    public entry fun version_migrate(arg0: &StorageAdminCap, arg1: &mut Storage) {
        assert!(arg1.version < 5, 43001);
        arg1.version = 5;
    }

    fun version_verification(arg0: &Storage) {
        assert!(arg0.version == 5, 43000);
    }

    public fun withdraw_treasury<T0>(arg0: &StorageAdminCap, arg1: &0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::PoolAdminCap, arg2: &mut Storage, arg3: u8, arg4: &mut 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::Pool<T0>, arg5: u64, arg6: address, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(get_coin_type(arg2, arg3) == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 43007);
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg2.reserves, arg3).treasury_balance;
        let v1 = 0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::unnormal_amount<T0>(arg4, (*v0 as u64));
        let v2 = arg5;
        if (arg5 < v1) {
            v2 = v1;
        };
        *v0 = *v0 - (v2 as u256);
        0x65d3b958fe52dad6ef61fbce9368877312a319957eab3d6946796079af862030::pool::withdraw_reserve_balance<T0>(arg1, arg4, v2, arg6, arg7);
    }

    // decompiled from Move bytecode v6
}

