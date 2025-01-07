module 0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::storage {
    struct Storage has store, key {
        id: 0x2::object::UID,
        owner: address,
        paused: bool,
        reserves: 0x2::table::Table<u8, ReserveData>,
        reserves_list: vector<u8>,
        configurator: 0x2::table::Table<address, bool>,
        reserves_count: u8,
        users: vector<address>,
        user_info: 0x2::table::Table<address, UserInfo>,
    }

    struct ReserveData has store {
        id: u8,
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
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).borrow_balance;
        decrease_balance(v0, arg2, arg3);
    }

    public(friend) fun decrease_supply_balance(arg0: &mut Storage, arg1: u8, arg2: address, arg3: u256) {
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).supply_balance;
        decrease_balance(v0, arg2, arg3);
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

    public fun get_supply_cap_ceiling(arg0: &mut Storage, arg1: u8) : u256 {
        0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1).supply_cap_ceiling
    }

    public fun get_total_supply(arg0: &mut Storage, arg1: u8) : (u256, u256) {
        let v0 = 0x2::table::borrow<u8, ReserveData>(&arg0.reserves, arg1);
        (v0.supply_balance.total_supply, v0.borrow_balance.total_supply)
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

    public(friend) fun increase_borrow_balance(arg0: &mut Storage, arg1: u8, arg2: address, arg3: u256) {
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).borrow_balance;
        increase_balance(v0, arg2, arg3);
    }

    public(friend) fun increase_supply_balance(arg0: &mut Storage, arg1: u8, arg2: address, arg3: u256) {
        let v0 = &mut 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1).supply_balance;
        increase_balance(v0, arg2, arg3);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::table::new<address, bool>(arg0);
        0x2::table::add<address, bool>(&mut v0, 0x2::tx_context::sender(arg0), true);
        let v1 = Storage{
            id             : 0x2::object::new(arg0),
            owner          : 0x2::tx_context::sender(arg0),
            paused         : false,
            reserves       : 0x2::table::new<u8, ReserveData>(arg0),
            reserves_list  : 0x1::vector::empty<u8>(),
            configurator   : v0,
            reserves_count : 0,
            users          : 0x1::vector::empty<address>(),
            user_info      : 0x2::table::new<address, UserInfo>(arg0),
        };
        0x2::transfer::share_object<Storage>(v1);
    }

    public entry fun init_reserve<T0>(arg0: &0x2::clock::Clock, arg1: &mut Storage, arg2: bool, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: u256, arg13: u256, arg14: u256, arg15: u8, arg16: &mut 0x2::tx_context::TxContext) {
        only_configurator(arg1, arg16);
        let v0 = arg1.reserves_count;
        assert!(v0 < 255, 43003);
        reserve_validation<T0>(arg1);
        let v1 = TokenBalance{
            user_state   : 0x2::table::new<address, u256>(arg16),
            total_supply : 0,
        };
        let v2 = TokenBalance{
            user_state   : 0x2::table::new<address, u256>(arg16),
            total_supply : 0,
        };
        let v3 = BorrowRateFactors{
            base_rate            : arg5,
            multiplier           : arg7,
            jump_rate_multiplier : arg8,
            reserve_factor       : arg9,
            optimal_utilization  : arg6,
        };
        let v4 = LiquidationFactors{
            ratio     : arg12,
            bonus     : arg13,
            threshold : arg14,
        };
        let v5 = ReserveData{
            id                    : arg1.reserves_count,
            coin_type             : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            is_isolated           : arg2,
            supply_cap_ceiling    : arg3,
            borrow_cap_ceiling    : arg4,
            current_supply_rate   : 0,
            current_borrow_rate   : 0,
            current_supply_index  : 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray(),
            current_borrow_index  : 0x21f91d20796f1ccd18071dc5881b9815f8e7ed7a149ba88d9005c6973f45c88::ray_math::ray(),
            supply_balance        : v1,
            borrow_balance        : v2,
            last_update_timestamp : 0x2::clock::timestamp_ms(arg0),
            ltv                   : arg10,
            treasury_factor       : arg11,
            treasury_balance      : 0,
            borrow_rate_factors   : v3,
            liquidation_factors   : v4,
        };
        0x2::table::add<u8, ReserveData>(&mut arg1.reserves, v0, v5);
        0x1::vector::push_back<u8>(&mut arg1.reserves_list, v0);
        arg1.reserves_count = v0 + 1;
        0x18bea44d07e87a733c429818f82ddaa860372c459cc333cdba88403938cb0de8::pool::create_pool<T0>(arg15, arg16);
    }

    fun only_configurator(arg0: &Storage, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, bool>(&arg0.configurator, v0), 43002);
        assert!(*0x2::table::borrow<address, bool>(&arg0.configurator, v0), 43002);
    }

    fun only_owner(arg0: &mut Storage, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 43001);
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

    public entry fun set_configurator(arg0: &mut Storage, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        only_owner(arg0, arg3);
        if (!0x2::table::contains<address, bool>(&arg0.configurator, arg1)) {
            0x2::table::add<address, bool>(&mut arg0.configurator, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<address, bool>(&mut arg0.configurator, arg1) = arg2;
        };
        let v0 = StorageConfiguratorSetting{
            sender       : 0x2::tx_context::sender(arg3),
            configurator : arg1,
            value        : arg2,
        };
        0x2::event::emit<StorageConfiguratorSetting>(v0);
    }

    public entry fun set_pause(arg0: &mut Storage, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        only_configurator(arg0, arg2);
        arg0.paused = arg1;
        let v0 = Paused{paused: arg1};
        0x2::event::emit<Paused>(v0);
    }

    public(friend) fun update_interest_rate(arg0: &mut Storage, arg1: u8, arg2: u256, arg3: u256) {
        let v0 = 0x2::table::borrow_mut<u8, ReserveData>(&mut arg0.reserves, arg1);
        v0.current_supply_rate = arg3;
        v0.current_borrow_rate = arg2;
    }

    public(friend) fun update_state(arg0: &mut Storage, arg1: u8, arg2: u256, arg3: u256, arg4: u64, arg5: u256) {
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
        if (!0x1::vector::contains<address>(&arg0.users, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.users, arg2);
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
        if (!0x1::vector::contains<address>(&arg0.users, &arg2)) {
            0x1::vector::push_back<address>(&mut arg0.users, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

