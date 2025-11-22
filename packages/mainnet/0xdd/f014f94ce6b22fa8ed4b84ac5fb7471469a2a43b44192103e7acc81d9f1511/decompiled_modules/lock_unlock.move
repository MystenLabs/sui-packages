module 0xddf014f94ce6b22fa8ed4b84ac5fb7471469a2a43b44192103e7acc81d9f1511::lock_unlock {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        pending_transfer: 0x1::option::Option<PendingTransfer>,
    }

    struct PendingTransfer has copy, drop, store {
        to: address,
        proposed_at: u64,
        ready_at: u64,
    }

    struct AdminRegistry has key {
        id: 0x2::object::UID,
        current_admin: address,
        admin_cap_holder: address,
        ownership_history: vector<AdminTransferRecord>,
        last_transfer_time: u64,
        deployed_reserve_types: vector<0x1::type_name::TypeName>,
    }

    struct AdminTransferRecord has copy, drop, store {
        from: address,
        to: address,
        timestamp: u64,
    }

    struct Reserves<phantom T0> has key {
        id: 0x2::object::UID,
        collateral_balance: 0x2::balance::Balance<T0>,
        nest_reserve: 0x2::balance::Balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>,
        total_collateral_locked: u128,
        total_nest_in_circulation: u128,
        total_nest_fees_collected: u128,
        total_locks: u64,
        total_unlocks: u64,
        is_initialized: bool,
        is_paused: bool,
        pause_timestamp: u64,
        pause_reason: vector<u8>,
        unaccounted_loss: u128,
        backing_shortages: u64,
        last_emergency_collateral_withdrawal: u64,
        last_emergency_nest_withdrawal: u64,
        critical_state: bool,
    }

    struct Locked has copy, drop {
        user: address,
        collateral_amount_in: u128,
        nest_amount_out: u128,
        nest_fee_to_staking: u128,
        total_collateral_locked: u128,
        total_nest_in_circulation: u128,
        backing_ratio_bps: u128,
        timestamp: u64,
    }

    struct Unlocked has copy, drop {
        user: address,
        nest_amount_in: u128,
        collateral_amount_out: u128,
        nest_fee_to_staking: u128,
        total_collateral_locked: u128,
        total_nest_in_circulation: u128,
        backing_ratio_bps: u128,
        timestamp: u64,
    }

    struct ReservesInitialized has copy, drop {
        nest_amount: u128,
        reserve_type: vector<u8>,
        timestamp: u64,
    }

    struct Paused has copy, drop {
        reason: vector<u8>,
        timestamp: u64,
    }

    struct Unpaused has copy, drop {
        timestamp: u64,
    }

    struct EmergencyWithdrawal has copy, drop {
        admin: address,
        token_type: vector<u8>,
        amount: u64,
        timestamp: u64,
    }

    struct AdminTransferProposed has copy, drop {
        from: address,
        to: address,
        ready_at: u64,
        timestamp: u64,
    }

    struct AdminTransferCancelled has copy, drop {
        from: address,
        to: address,
        timestamp: u64,
    }

    struct AdminTransferCompleted has copy, drop {
        from: address,
        to: address,
        timestamp: u64,
    }

    struct HealthWarning has copy, drop {
        is_healthy: bool,
        unexplained_loss: u128,
        backing_shortage: u128,
        backing_ratio: u128,
        timestamp: u64,
    }

    struct StateConsistencyCheck has copy, drop {
        is_valid: bool,
        unaccounted_loss: u128,
        timestamp: u64,
    }

    struct NestReservesRefilled has copy, drop {
        amount: u128,
        admin: address,
        new_balance: u128,
        timestamp: u64,
    }

    struct CircuitBreakerTriggered has copy, drop {
        reason: vector<u8>,
        nest_reserve: u128,
        backing_ratio: u128,
        timestamp: u64,
    }

    struct ReserveTypeRegistered has copy, drop {
        reserve_type: vector<u8>,
        timestamp: u64,
    }

    public fun calculate_lock_output(arg0: u128) : (u128, u128) {
        let v0 = arg0 * 1000000 / 3000000 / 1000000;
        if (v0 == 0) {
            return (0, 0)
        };
        let v1 = ((((v0 as u256) * (50 as u256) + (10000 as u256) - 1) / (10000 as u256)) as u128);
        if (v0 <= v1) {
            return (0, v0)
        };
        (v0 - v1, v1)
    }

    public fun calculate_unlock_output(arg0: u128) : (u128, u128) {
        if (arg0 == 0) {
            return (0, 0)
        };
        let v0 = ((((arg0 as u256) * (50 as u256) + (10000 as u256) - 1) / (10000 as u256)) as u128);
        if (arg0 <= v0) {
            return (0, arg0)
        };
        ((arg0 - v0) * 3, v0)
    }

    public entry fun cancel_admin_transfer(arg0: &mut AdminCap, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingTransfer>(&arg0.pending_transfer), 20);
        let v0 = 0x1::option::extract<PendingTransfer>(&mut arg0.pending_transfer);
        let v1 = AdminTransferCancelled{
            from      : 0x2::tx_context::sender(arg2),
            to        : v0.to,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<AdminTransferCancelled>(v1);
    }

    fun check_circuit_breaker<T0>(arg0: &mut Reserves<T0>, arg1: &0x2::clock::Clock) {
        let v0 = (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.nest_reserve) as u128);
        let v1 = 333000000000000 * 100 / 10000;
        let v2 = get_backing_ratio<T0>(arg0);
        if (v0 < v1 || v2 < 9500) {
            arg0.critical_state = true;
            let v3 = if (v0 < v1) {
                b"CRITICAL_NEST_RESERVE_LOW"
            } else {
                b"BACKING_RATIO_BELOW_THRESHOLD"
            };
            let v4 = CircuitBreakerTriggered{
                reason        : v3,
                nest_reserve  : v0,
                backing_ratio : v2,
                timestamp     : 0x2::clock::timestamp_ms(arg1),
            };
            0x2::event::emit<CircuitBreakerTriggered>(v4);
        };
    }

    fun checked_add(arg0: u128, arg1: u128) : u128 {
        let v0 = arg0 + arg1;
        assert!(v0 >= arg0 && v0 >= arg1, 8);
        v0
    }

    fun checked_mul(arg0: u128, arg1: u128) : u128 {
        let v0 = (arg0 as u256) * (arg1 as u256);
        assert!(v0 <= (340282366920938463463374607431768211455 as u256), 8);
        (v0 as u128)
    }

    fun checked_mul_u256(arg0: u128, arg1: u128) : u256 {
        let v0 = (arg0 as u256) * (arg1 as u256);
        assert!(v0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935, 8);
        v0
    }

    fun checked_sub(arg0: u128, arg1: u128) : u128 {
        assert!(arg0 >= arg1, 2);
        arg0 - arg1
    }

    public entry fun complete_admin_transfer(arg0: AdminCap, arg1: &mut AdminRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<PendingTransfer>(&arg0.pending_transfer), 20);
        let v0 = *0x1::option::borrow<PendingTransfer>(&arg0.pending_transfer);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 >= v0.ready_at, 19);
        assert!(0x2::tx_context::sender(arg3) == v0.to, 21);
        let v2 = arg1.current_admin;
        let v3 = AdminTransferRecord{
            from      : v2,
            to        : v0.to,
            timestamp : v1,
        };
        if (0x1::vector::length<AdminTransferRecord>(&arg1.ownership_history) >= 20) {
            0x1::vector::pop_back<AdminTransferRecord>(&mut arg1.ownership_history);
        };
        0x1::vector::push_back<AdminTransferRecord>(&mut arg1.ownership_history, v3);
        arg1.current_admin = v0.to;
        arg1.admin_cap_holder = v0.to;
        arg1.last_transfer_time = v1;
        let v4 = AdminCap{
            id               : 0x2::object::new(arg3),
            pending_transfer : 0x1::option::none<PendingTransfer>(),
        };
        0x2::transfer::transfer<AdminCap>(v4, v0.to);
        let AdminCap {
            id               : v5,
            pending_transfer : _,
        } = arg0;
        0x2::object::delete(v5);
        let v7 = AdminTransferCompleted{
            from      : v2,
            to        : v0.to,
            timestamp : v1,
        };
        0x2::event::emit<AdminTransferCompleted>(v7);
    }

    public entry fun create_reserves<T0>(arg0: &AdminCap, arg1: &mut AdminRegistry, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::type_name::TypeName>(&arg1.deployed_reserve_types)) {
            assert!(*0x1::vector::borrow<0x1::type_name::TypeName>(&arg1.deployed_reserve_types, v1) != v0, 23);
            v1 = v1 + 1;
        };
        0x1::vector::push_back<0x1::type_name::TypeName>(&mut arg1.deployed_reserve_types, v0);
        let v2 = Reserves<T0>{
            id                                   : 0x2::object::new(arg3),
            collateral_balance                   : 0x2::balance::zero<T0>(),
            nest_reserve                         : 0x2::balance::zero<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(),
            total_collateral_locked              : 0,
            total_nest_in_circulation            : 0,
            total_nest_fees_collected            : 0,
            total_locks                          : 0,
            total_unlocks                        : 0,
            is_initialized                       : false,
            is_paused                            : false,
            pause_timestamp                      : 0,
            pause_reason                         : 0x1::vector::empty<u8>(),
            unaccounted_loss                     : 0,
            backing_shortages                    : 0,
            last_emergency_collateral_withdrawal : 0,
            last_emergency_nest_withdrawal       : 0,
            critical_state                       : false,
        };
        0x2::transfer::share_object<Reserves<T0>>(v2);
        let v3 = ReserveTypeRegistered{
            reserve_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(v0)),
            timestamp    : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<ReserveTypeRegistered>(v3);
    }

    public entry fun emergency_withdraw_collateral<T0>(arg0: &AdminCap, arg1: &mut Reserves<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (arg1.last_emergency_collateral_withdrawal > 0) {
            assert!(v0 - arg1.last_emergency_collateral_withdrawal >= 86400000, 18);
        };
        assert!(arg2 > 0, 9);
        let v1 = 0x2::balance::value<T0>(&arg1.collateral_balance);
        assert!(v1 >= arg2, 2);
        assert!(arg2 <= v1 / 10, 7);
        arg1.last_emergency_collateral_withdrawal = v0;
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.collateral_balance, arg2), arg4), v2);
        let v3 = EmergencyWithdrawal{
            admin      : v2,
            token_type : b"COLLATERAL",
            amount     : arg2,
            timestamp  : v0,
        };
        0x2::event::emit<EmergencyWithdrawal>(v3);
    }

    public entry fun emergency_withdraw_nest<T0>(arg0: &AdminCap, arg1: &mut Reserves<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        if (arg1.last_emergency_nest_withdrawal > 0) {
            assert!(v0 - arg1.last_emergency_nest_withdrawal >= 86400000, 18);
        };
        assert!(arg2 > 0, 9);
        let v1 = 0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg1.nest_reserve);
        assert!(v1 >= arg2, 2);
        assert!(arg2 <= v1 / 10, 7);
        arg1.last_emergency_nest_withdrawal = v0;
        let v2 = 0x2::tx_context::sender(arg4);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>>(0x2::coin::from_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(0x2::balance::split<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg1.nest_reserve, arg2), arg4), v2);
        let v3 = EmergencyWithdrawal{
            admin      : v2,
            token_type : b"NEST",
            amount     : arg2,
            timestamp  : v0,
        };
        0x2::event::emit<EmergencyWithdrawal>(v3);
    }

    public fun get_admin_registry_info(arg0: &AdminRegistry) : (address, address, u64) {
        (arg0.current_admin, arg0.admin_cap_holder, arg0.last_transfer_time)
    }

    public fun get_backing_ratio<T0>(arg0: &Reserves<T0>) : u128 {
        if (arg0.total_nest_in_circulation == 0) {
            return 10000
        };
        let v0 = (arg0.total_nest_in_circulation as u256) * (3 as u256);
        assert!(v0 <= 115792089237316195423570985008687907853269984665640564039457584007913129639935, 8);
        if (v0 == 0) {
            return 0
        };
        let v1 = ((0x2::balance::value<T0>(&arg0.collateral_balance) as u128) as u256) * 10000 / v0;
        if (v1 > 10000) {
            return (v1 as u128)
        };
        (v1 as u128)
    }

    public fun get_collateral_balance<T0>(arg0: &Reserves<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.collateral_balance)
    }

    public fun get_collateral_balance_u128<T0>(arg0: &Reserves<T0>) : u128 {
        (0x2::balance::value<T0>(&arg0.collateral_balance) as u128)
    }

    public fun get_fees_collected<T0>(arg0: &Reserves<T0>) : u128 {
        arg0.total_nest_fees_collected
    }

    public fun get_health_dashboard<T0>(arg0: &Reserves<T0>) : (u128, u128, u128, u128, bool, bool, u128, u128, u64, u64) {
        let (v0, v1, v2) = verify_reserves_integrity<T0>(arg0);
        (get_backing_ratio<T0>(arg0), (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.nest_reserve) as u128), (0x2::balance::value<T0>(&arg0.collateral_balance) as u128), arg0.total_nest_in_circulation, v0, arg0.critical_state, v1, v2, arg0.total_locks, arg0.total_unlocks)
    }

    public fun get_nest_reserve<T0>(arg0: &Reserves<T0>) : u64 {
        0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.nest_reserve)
    }

    public fun get_nest_reserve_u128<T0>(arg0: &Reserves<T0>) : u128 {
        (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.nest_reserve) as u128)
    }

    public fun get_reserves_stats<T0>(arg0: &Reserves<T0>) : (u64, u64, u128, u128, u128, u64, u64, bool, bool) {
        (0x2::balance::value<T0>(&arg0.collateral_balance), 0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.nest_reserve), arg0.total_collateral_locked, arg0.total_nest_in_circulation, arg0.total_nest_fees_collected, arg0.total_locks, arg0.total_unlocks, arg0.is_initialized, arg0.is_paused)
    }

    public fun get_staking_sustainability<T0>(arg0: &Reserves<T0>) : (u128, u128, u128) {
        let v0 = (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.nest_reserve) as u128);
        let v1 = arg0.total_locks + arg0.total_unlocks;
        let v2 = if (v1 > 0) {
            arg0.total_nest_fees_collected / (v1 as u128)
        } else {
            0
        };
        let v3 = if (v2 > 0) {
            v0 / v2
        } else {
            0
        };
        (v0, v2, v3)
    }

    public fun get_total_in_circulation<T0>(arg0: &Reserves<T0>) : u128 {
        arg0.total_nest_in_circulation
    }

    public fun get_total_locked<T0>(arg0: &Reserves<T0>) : u128 {
        arg0.total_collateral_locked
    }

    public fun get_total_locks<T0>(arg0: &Reserves<T0>) : u64 {
        arg0.total_locks
    }

    public fun get_total_unlocks<T0>(arg0: &Reserves<T0>) : u64 {
        arg0.total_unlocks
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id               : 0x2::object::new(arg0),
            pending_transfer : 0x1::option::none<PendingTransfer>(),
        };
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = AdminRegistry{
            id                     : 0x2::object::new(arg0),
            current_admin          : v1,
            admin_cap_holder       : v1,
            ownership_history      : 0x1::vector::empty<AdminTransferRecord>(),
            last_transfer_time     : 0,
            deployed_reserve_types : 0x1::vector::empty<0x1::type_name::TypeName>(),
        };
        0x2::transfer::share_object<AdminRegistry>(v2);
        0x2::transfer::transfer<AdminCap>(v0, v1);
    }

    public entry fun init_reserves<T0>(arg0: &mut Reserves<T0>, arg1: 0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>, arg2: &AdminCap, arg3: &0x2::clock::Clock) {
        assert!(!arg0.is_initialized, 3);
        let v0 = (0x2::coin::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg1) as u128);
        assert!(v0 > 0, 9);
        assert!(v0 == 333000000000000, 1);
        0x2::balance::join<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg0.nest_reserve, 0x2::coin::into_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(arg1));
        arg0.is_initialized = true;
        let v1 = ReservesInitialized{
            nest_amount  : v0,
            reserve_type : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<ReservesInitialized>(v1);
    }

    public fun is_critical<T0>(arg0: &Reserves<T0>) : bool {
        arg0.critical_state
    }

    public fun is_healthy<T0>(arg0: &Reserves<T0>) : bool {
        get_backing_ratio<T0>(arg0) >= 10000
    }

    public fun is_initialized<T0>(arg0: &Reserves<T0>) : bool {
        arg0.is_initialized
    }

    public fun is_paused<T0>(arg0: &Reserves<T0>) : bool {
        arg0.is_paused
    }

    public entry fun lock<T0>(arg0: &mut Reserves<T0>, arg1: &mut 0x296c896477b53871bf0c85a268cbc1612939bc95f23e15c0513a99a019497a94::staking_pool::StakingPool, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 5);
        assert!(arg0.is_initialized, 4);
        let v0 = (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg0.nest_reserve) as u128);
        assert!(v0 >= 333000000000000 * 100 / 10000, 22);
        assert!(!arg0.critical_state, 22);
        let v1 = (0x2::coin::value<T0>(&arg2) as u128);
        assert!(v1 > 0, 9);
        assert!(v1 >= 3000000, 6);
        assert!(v1 <= 100000000000000, 7);
        let v2 = checked_mul(v1, 1000000) / 3000000 / 1000000;
        assert!(v2 > 0, 1);
        let v3 = (checked_mul_u256(v2, 50) + (10000 as u256) - 1) / (10000 as u256);
        assert!(v3 <= (340282366920938463463374607431768211455 as u256), 8);
        let v4 = (v3 as u128);
        let v5 = checked_sub(v2, v4);
        assert!(v5 > 0, 1);
        if (arg3 > 0) {
            assert!((v5 as u64) >= arg3, 17);
        };
        assert!(v0 >= v2, 2);
        assert!(arg0.total_nest_in_circulation + v5 <= 333000000000000, 11);
        assert!(arg0.total_collateral_locked + v1 <= 340282366920938463463374607431768211455, 8);
        assert!(arg0.total_nest_in_circulation + v5 <= 340282366920938463463374607431768211455, 8);
        assert!(arg0.total_nest_fees_collected + v4 <= 340282366920938463463374607431768211455, 8);
        assert!(v2 <= 18446744073709551615, 8);
        assert!(v4 <= 18446744073709551615, 8);
        assert!(v5 <= 18446744073709551615, 8);
        0x2::balance::join<T0>(&mut arg0.collateral_balance, 0x2::coin::into_balance<T0>(arg2));
        arg0.total_collateral_locked = checked_add(arg0.total_collateral_locked, v1);
        arg0.total_nest_in_circulation = checked_add(arg0.total_nest_in_circulation, v5);
        arg0.total_nest_fees_collected = checked_add(arg0.total_nest_fees_collected, v4);
        arg0.total_locks = arg0.total_locks + 1;
        let v6 = 0x2::balance::split<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg0.nest_reserve, (v4 as u64));
        let v7 = 0x2::balance::split<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg0.nest_reserve, (v5 as u64));
        let (v8, v9, _) = verify_reserves_integrity<T0>(arg0);
        assert!(v8 && v9 == 0, 14);
        check_circuit_breaker<T0>(arg0, arg4);
        let v11 = 0x2::tx_context::sender(arg5);
        if (v4 > 0) {
            0x296c896477b53871bf0c85a268cbc1612939bc95f23e15c0513a99a019497a94::staking_pool::deposit_rewards(arg1, 0x2::coin::from_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(v6, arg5), arg4);
        } else {
            0x2::balance::join<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg0.nest_reserve, v6);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>>(0x2::coin::from_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(v7, arg5), v11);
        let v12 = Locked{
            user                      : v11,
            collateral_amount_in      : v1,
            nest_amount_out           : v5,
            nest_fee_to_staking       : v4,
            total_collateral_locked   : arg0.total_collateral_locked,
            total_nest_in_circulation : arg0.total_nest_in_circulation,
            backing_ratio_bps         : get_backing_ratio<T0>(arg0),
            timestamp                 : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<Locked>(v12);
    }

    public entry fun pause<T0>(arg0: &AdminCap, arg1: &mut Reserves<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        arg1.is_paused = true;
        arg1.pause_timestamp = v0;
        arg1.pause_reason = arg2;
        let v1 = Paused{
            reason    : arg2,
            timestamp : v0,
        };
        0x2::event::emit<Paused>(v1);
    }

    public entry fun propose_admin_transfer(arg0: &mut AdminCap, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        let v1 = v0 + 172800000;
        let v2 = PendingTransfer{
            to          : arg1,
            proposed_at : v0,
            ready_at    : v1,
        };
        0x1::option::fill<PendingTransfer>(&mut arg0.pending_transfer, v2);
        let v3 = AdminTransferProposed{
            from      : 0x2::tx_context::sender(arg3),
            to        : arg1,
            ready_at  : v1,
            timestamp : v0,
        };
        0x2::event::emit<AdminTransferProposed>(v3);
    }

    public entry fun refill_nest_reserves<T0>(arg0: &AdminCap, arg1: &mut Reserves<T0>, arg2: 0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = (0x2::coin::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg2) as u128);
        assert!(v0 > 0, 9);
        0x2::balance::join<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg1.nest_reserve, 0x2::coin::into_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(arg2));
        let v1 = (0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg1.nest_reserve) as u128);
        if (arg1.critical_state) {
            if (v1 > 333000000000000 * 100 / 10000 && get_backing_ratio<T0>(arg1) >= 9500) {
                arg1.critical_state = false;
            };
        };
        let v2 = NestReservesRefilled{
            amount      : v0,
            admin       : 0x2::tx_context::sender(arg4),
            new_balance : v1,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<NestReservesRefilled>(v2);
    }

    fun safe_mul(arg0: u128, arg1: u128) : u128 {
        checked_mul(arg0, arg1)
    }

    fun safe_mul_div(arg0: u128, arg1: u128, arg2: u128) : u128 {
        assert!(arg2 > 0, 1);
        let v0 = (arg0 as u256) * (arg1 as u256) / (arg2 as u256);
        assert!(v0 <= (340282366920938463463374607431768211455 as u256), 8);
        (v0 as u128)
    }

    public entry fun unlock<T0>(arg0: &mut Reserves<T0>, arg1: &mut 0x296c896477b53871bf0c85a268cbc1612939bc95f23e15c0513a99a019497a94::staking_pool::StakingPool, arg2: 0x2::coin::Coin<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.is_paused, 5);
        assert!(arg0.is_initialized, 4);
        assert!(!arg0.critical_state, 22);
        let v0 = (0x2::coin::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg2) as u128);
        assert!(v0 > 0, 9);
        assert!(v0 <= 33333333000000, 7);
        let (v1, _, v3) = verify_reserves_integrity<T0>(arg0);
        assert!(v1, 14);
        assert!(v3 == 0, 15);
        let v4 = (checked_mul_u256(v0, 50) + (10000 as u256) - 1) / (10000 as u256);
        assert!(v4 <= (340282366920938463463374607431768211455 as u256), 8);
        let v5 = (v4 as u128);
        let v6 = checked_sub(v0, v5);
        assert!(v6 > 0, 1);
        let v7 = checked_mul(v6, 3);
        if (arg3 > 0) {
            assert!((v7 as u64) >= arg3, 17);
        };
        assert!((0x2::balance::value<T0>(&arg0.collateral_balance) as u128) >= v7, 2);
        assert!(arg0.total_collateral_locked >= v7, 2);
        assert!(arg0.total_nest_in_circulation >= v6, 2);
        assert!(arg0.total_nest_fees_collected + v5 <= 340282366920938463463374607431768211455, 8);
        assert!(v5 <= 18446744073709551615, 8);
        assert!(v7 <= 18446744073709551615, 8);
        0x2::balance::join<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg0.nest_reserve, 0x2::coin::into_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(arg2));
        arg0.total_collateral_locked = checked_sub(arg0.total_collateral_locked, v7);
        arg0.total_nest_in_circulation = checked_sub(arg0.total_nest_in_circulation, v6);
        arg0.total_nest_fees_collected = checked_add(arg0.total_nest_fees_collected, v5);
        arg0.total_unlocks = arg0.total_unlocks + 1;
        let v8 = 0x2::balance::split<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg0.nest_reserve, (v5 as u64));
        let v9 = 0x2::balance::split<T0>(&mut arg0.collateral_balance, (v7 as u64));
        let (v10, v11, v12) = verify_reserves_integrity<T0>(arg0);
        assert!(v10 && v11 == 0, 16);
        if (v12 > 0) {
            arg0.backing_shortages = arg0.backing_shortages + 1;
        };
        check_circuit_breaker<T0>(arg0, arg4);
        let v13 = 0x2::tx_context::sender(arg5);
        if (v5 > 0) {
            0x296c896477b53871bf0c85a268cbc1612939bc95f23e15c0513a99a019497a94::staking_pool::deposit_rewards(arg1, 0x2::coin::from_balance<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(v8, arg5), arg4);
        } else {
            0x2::balance::join<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&mut arg0.nest_reserve, v8);
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v9, arg5), v13);
        let v14 = StateConsistencyCheck{
            is_valid         : v10,
            unaccounted_loss : v11,
            timestamp        : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<StateConsistencyCheck>(v14);
        let v15 = Unlocked{
            user                      : v13,
            nest_amount_in            : v0,
            collateral_amount_out     : v7,
            nest_fee_to_staking       : v5,
            total_collateral_locked   : arg0.total_collateral_locked,
            total_nest_in_circulation : arg0.total_nest_in_circulation,
            backing_ratio_bps         : get_backing_ratio<T0>(arg0),
            timestamp                 : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<Unlocked>(v15);
    }

    public entry fun unpause<T0>(arg0: &AdminCap, arg1: &mut Reserves<T0>, arg2: &0x2::clock::Clock) {
        let (v0, v1, v2) = verify_reserves_integrity<T0>(arg1);
        assert!(v0, 14);
        assert!(v1 == 0, 16);
        assert!(v2 == 0, 15);
        assert!(get_backing_ratio<T0>(arg1) >= 9500, 15);
        assert!((0x2::balance::value<0x698dc77809502140ff6936d1cfd7f04d11a016315e95cf7b4851884c0f527879::nest::NEST>(&arg1.nest_reserve) as u128) >= 333000000000000 * 100 / 10000, 22);
        arg1.is_paused = false;
        arg1.critical_state = false;
        arg1.pause_reason = 0x1::vector::empty<u8>();
        let v3 = Unpaused{timestamp: 0x2::clock::timestamp_ms(arg2)};
        0x2::event::emit<Unpaused>(v3);
    }

    public fun verify_reserves_integrity<T0>(arg0: &Reserves<T0>) : (bool, u128, u128) {
        if (!arg0.is_initialized) {
            return (true, 0, 0)
        };
        let v0 = (0x2::balance::value<T0>(&arg0.collateral_balance) as u128);
        let v1 = safe_mul(arg0.total_nest_in_circulation, 3);
        let v2 = arg0.total_collateral_locked;
        let v3 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        let v4 = if (v0 < v1) {
            v1 - v0
        } else {
            0
        };
        let v5 = if (v0 >= v1) {
            if (v2 <= v0) {
                arg0.total_nest_in_circulation <= 333000000000000
            } else {
                false
            }
        } else {
            false
        };
        (v5, v3, v4)
    }

    // decompiled from Move bytecode v6
}

