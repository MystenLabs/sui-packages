module 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::red_pool {
    struct RED_POOL has drop {
        dummy_field: bool,
    }

    struct RedPool has store, key {
        id: 0x2::object::UID,
        red_supply: 0x2::balance::Supply<RED_POOL>,
        fees: Fees,
        circuit_breaker: CircuitBreaker,
        reserve: 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::Reserve,
        fee_reserve: 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::Reserve,
        allocator: 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::allocation_registry::AllocationRegistry,
        max_spread_limit_bps: u64,
    }

    struct PoolDepositedEvent has copy, drop {
        user: address,
        coin_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        share_amount: u64,
    }

    struct PoolRedeemedEvent has copy, drop {
        user: address,
        coin_type: 0x1::type_name::TypeName,
        redeemed_amount: u64,
        share_amount: u64,
    }

    struct PoolRebalancedEvent has copy, drop {
        authority: address,
        rebalance_amount: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal,
        value_before: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal,
        value_after: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal,
    }

    struct RedPoolCap has key {
        id: 0x2::object::UID,
    }

    struct Fees has copy, drop, store {
        deposit_fee_bps: u64,
        redemption_fee_bps: u64,
    }

    struct CircuitBreaker has copy, drop, store {
        deposit_enabled: bool,
        redemption_enabled: bool,
    }

    struct Receipt<phantom T0> {
        deallocations: 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::deallocations::Deallocations,
        price_calculator: 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator::PriceCalculator,
        expected_coin_type: 0x1::type_name::TypeName,
        total_usd_value_before: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal,
        rebalance_usd_value: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal,
        spread_bps: u64,
    }

    struct REDEMPTION_RECEIPT has copy, drop {
        dummy_field: bool,
    }

    struct REBALANCE_RECEIPT has copy, drop {
        dummy_field: bool,
    }

    public fun supply_value(arg0: &RedPool) : u64 {
        0x2::balance::supply_value<RED_POOL>(&arg0.red_supply)
    }

    public fun coin_stats<T0>(arg0: &RedPool) : 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::allocation_registry::CoinStats {
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::allocation_registry::coin_stats<T0>(&arg0.allocator)
    }

    public fun update_coin_stats<T0>(arg0: &mut RedPool, arg1: &0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::allocation_registry::AllocationRegistryCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::allocation_registry::update_coin_stats<T0>(arg1, &mut arg0.allocator, arg2, arg3, arg4);
    }

    public fun deallocations<T0>(arg0: &RedPool, arg1: &0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::RedOracle, arg2: &0x2::clock::Clock, arg3: u64) : 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::deallocations::Deallocations {
        let v0 = 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::new_price_calculator(arg1, arg2);
        new_deallocation_from_usd_value<T0>(arg0, &v0, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg3))
    }

    public fun assert_deposit_enabled(arg0: &RedPool) {
        assert!(is_deposit_enabled(arg0), 5);
    }

    public fun assert_redemption_enabled(arg0: &RedPool) {
        assert!(is_redemption_enabled(arg0), 6);
    }

    public fun deallocations_from_redusd<T0>(arg0: &RedPool, arg1: &0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::RedOracle, arg2: &0x2::clock::Clock, arg3: u64) : 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::deallocations::Deallocations {
        let v0 = 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::new_price_calculator(arg1, arg2);
        new_deallocation_from_usd_value<T0>(arg0, &v0, 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::share_calculator::calculate_usd_to_return(arg3, total_usd_value_internal(arg0, &v0), 0x2::balance::supply_value<RED_POOL>(&arg0.red_supply)))
    }

    public fun deposit<T0>(arg0: &mut RedPool, arg1: &0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::version::Version, arg2: &0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::RedOracle, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<RED_POOL> {
        assert_deposit_enabled(arg0);
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::version::assert_active_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::deduct<T0>(&mut arg0.fee_reserve, arg5, &mut arg4, arg0.fees.deposit_fee_bps);
        let v1 = 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::new_price_calculator(arg2, arg3);
        assert!(0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator::contains(&v1, v0), 7);
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::join<T0>(&mut arg0.reserve, arg4);
        let v2 = 0x2::balance::increase_supply<RED_POOL>(&mut arg0.red_supply, 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::share_calculator::calculate_shares_to_mint(0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator::coin_amount_to_usd(&v1, v0, 0x2::coin::value<T0>(&arg4)), total_usd_value_internal(arg0, &v1), 0x2::balance::supply_value<RED_POOL>(&arg0.red_supply)));
        let v3 = PoolDepositedEvent{
            user           : 0x2::tx_context::sender(arg5),
            coin_type      : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg4),
            share_amount   : 0x2::balance::value<RED_POOL>(&v2),
        };
        0x2::event::emit<PoolDepositedEvent>(v3);
        0x2::coin::from_balance<RED_POOL>(v2, arg5)
    }

    public fun deposit_fee_bps(arg0: &Fees) : u64 {
        arg0.deposit_fee_bps
    }

    public fun finalize_receipt<T0, T1>(arg0: &mut RedPool, arg1: Receipt<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2, v3, v4, v5) = unpack<T1>(arg1);
        let v6 = v1;
        let v7 = v0;
        assert!(0x1::type_name::get<T0>() == v2, 0);
        assert!(0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::deallocations::has_all_taken(&v7), 1);
        let v8 = total_usd_value_internal(arg0, &v6);
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<REDEMPTION_RECEIPT>()) {
            let v9 = if (0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::lt(v8, v3)) {
                0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::sub(v4, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::sub(v3, v8))
            } else {
                v4
            };
            let v10 = 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::u64::min(0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::amount(&arg0.reserve, v2), 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator::usd_to_coin_amount(&v6, v2, v9));
            assert!(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::sub(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(10000), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(v10), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(10000)), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator::usd_to_coin_amount(&v6, v2, v4))))) <= v5, 2);
            let v11 = 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::take<T0>(&mut arg0.reserve, arg2, v10);
            0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::deduct<T0>(&mut arg0.fee_reserve, arg2, &mut v11, arg0.fees.redemption_fee_bps);
            let v12 = PoolRedeemedEvent{
                user            : 0x2::tx_context::sender(arg2),
                coin_type       : v2,
                redeemed_amount : 0x2::coin::value<T0>(&v11),
                share_amount    : 0x2::balance::supply_value<RED_POOL>(&arg0.red_supply),
            };
            0x2::event::emit<PoolRedeemedEvent>(v12);
            return v11
        };
        if (0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::lt(v8, v3)) {
            assert!(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::sub(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(10000), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::sub(v4, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::sub(v3, v8)), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(10000)), v4))) <= v5, 3);
        };
        let v13 = PoolRebalancedEvent{
            authority        : 0x2::tx_context::sender(arg2),
            rebalance_amount : v4,
            value_before     : v3,
            value_after      : v8,
        };
        0x2::event::emit<PoolRebalancedEvent>(v13);
        0x2::coin::zero<T0>(arg2)
    }

    fun init(arg0: RED_POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::allocation_registry::new(arg1);
        0x2::transfer::public_transfer<0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::allocation_registry::AllocationRegistryCap>(v1, 0x2::tx_context::sender(arg1));
        let (v2, v3) = 0x2::coin::create_currency<RED_POOL>(arg0, 6, b"redUSD", b"Red Ocean protocol liquidity token", b"A liquidity token on the Red Ocean protocol that represents your deposit and earned yield.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://redocean.finance/logo.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RED_POOL>>(v3);
        let v4 = Fees{
            deposit_fee_bps    : 0,
            redemption_fee_bps : 10,
        };
        let v5 = CircuitBreaker{
            deposit_enabled    : false,
            redemption_enabled : false,
        };
        let v6 = RedPool{
            id                   : 0x2::object::new(arg1),
            red_supply           : 0x2::coin::treasury_into_supply<RED_POOL>(v2),
            fees                 : v4,
            circuit_breaker      : v5,
            reserve              : 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::new(arg1),
            fee_reserve          : 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::new(arg1),
            allocator            : v0,
            max_spread_limit_bps : 5000,
        };
        0x2::transfer::share_object<RedPool>(v6);
        let v7 = RedPoolCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<RedPoolCap>(v7, 0x2::tx_context::sender(arg1));
    }

    public fun is_deposit_enabled(arg0: &RedPool) : bool {
        arg0.circuit_breaker.deposit_enabled
    }

    public fun is_redemption_enabled(arg0: &RedPool) : bool {
        arg0.circuit_breaker.redemption_enabled
    }

    public fun max_spread_limit_bps(arg0: &RedPool) : u64 {
        arg0.max_spread_limit_bps
    }

    fun new_deallocation_from_usd_value<T0>(arg0: &RedPool, arg1: &0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator::PriceCalculator, arg2: 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal) : 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::deallocations::Deallocations {
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::allocation_registry::new_deallocations(&arg0.allocator, &arg0.reserve, arg1, 0x1::type_name::get<T0>(), arg2)
    }

    public fun new_rebalance_receipt<T0>(arg0: &mut RedPool, arg1: &0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::version::Version, arg2: &0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::RedOracle, arg3: &0x2::clock::Clock, arg4: &0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::allocation_registry::AllocationRegistryCap, arg5: u64, arg6: u64) : Receipt<REBALANCE_RECEIPT> {
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::version::assert_active_version(arg1);
        assert!(arg6 <= arg0.max_spread_limit_bps, 8);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(arg5);
        let v2 = 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::new_price_calculator(arg2, arg3);
        Receipt<REBALANCE_RECEIPT>{
            deallocations          : 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::allocation_registry::new_deallocations(&arg0.allocator, &arg0.reserve, &v2, v0, v1),
            price_calculator       : v2,
            expected_coin_type     : v0,
            total_usd_value_before : total_usd_value_internal(arg0, &v2),
            rebalance_usd_value    : v1,
            spread_bps             : arg6,
        }
    }

    public fun new_redemption_receipt<T0>(arg0: &mut RedPool, arg1: &0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::version::Version, arg2: &0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::RedOracle, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<RED_POOL>, arg5: u64) : Receipt<REDEMPTION_RECEIPT> {
        assert_redemption_enabled(arg0);
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::version::assert_active_version(arg1);
        assert!(arg5 <= arg0.max_spread_limit_bps, 8);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::new_price_calculator(arg2, arg3);
        let v2 = total_usd_value_internal(arg0, &v1);
        let v3 = 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::share_calculator::calculate_usd_to_return(0x2::coin::value<RED_POOL>(&arg4), v2, 0x2::balance::supply_value<RED_POOL>(&arg0.red_supply));
        0x2::balance::decrease_supply<RED_POOL>(&mut arg0.red_supply, 0x2::coin::into_balance<RED_POOL>(arg4));
        Receipt<REDEMPTION_RECEIPT>{
            deallocations          : 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::allocation_registry::new_deallocations(&arg0.allocator, &arg0.reserve, &v1, v0, v3),
            price_calculator       : v1,
            expected_coin_type     : v0,
            total_usd_value_before : v2,
            rebalance_usd_value    : v3,
            spread_bps             : arg5,
        }
    }

    public fun pool_fees(arg0: &RedPool) : Fees {
        arg0.fees
    }

    public fun redemption_fee_bps(arg0: &Fees) : u64 {
        arg0.redemption_fee_bps
    }

    public fun return_with_receipt<T0, T1>(arg0: &mut RedPool, arg1: &Receipt<T1>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::join<T0>(&mut arg0.reserve, arg2);
    }

    public fun set_circuit_breaker(arg0: &RedPoolCap, arg1: &mut RedPool, arg2: bool, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.circuit_breaker.deposit_enabled = arg2;
        arg1.circuit_breaker.redemption_enabled = arg3;
    }

    public fun set_max_spread_limit_bps(arg0: &RedPoolCap, arg1: &mut RedPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= 10000, 8);
        arg1.max_spread_limit_bps = arg2;
    }

    public fun set_pool_fees(arg0: &RedPoolCap, arg1: &mut RedPool, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.fees.deposit_fee_bps = arg2;
        arg1.fees.redemption_fee_bps = arg3;
    }

    public fun take_with_receipt<T0, T1>(arg0: &mut RedPool, arg1: &mut Receipt<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::deallocations::contains(&arg1.deallocations, v0), 0);
        assert!(!0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::deallocations::is_taken(&arg1.deallocations, v0), 4);
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::deallocations::taken(&mut arg1.deallocations, v0);
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::take<T0>(&mut arg0.reserve, arg2, 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::deallocations::amount(&arg1.deallocations, v0))
    }

    public fun total_usd_value(arg0: &RedPool, arg1: &0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::RedOracle, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::red_oracle::new_price_calculator(arg1, arg2);
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::usd_calculator::decimal_usd_to_u64(total_usd_value_internal(arg0, &v0))
    }

    fun total_usd_value_internal(arg0: &RedPool, arg1: &0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator::PriceCalculator) : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal {
        let v0 = 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator::coin_types(arg1);
        let v1 = 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let v4 = 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::amount(&arg0.reserve, v3);
            if (v4 > 0) {
                v1 = 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::add(v1, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator::coin_amount_to_usd(arg1, v3, v4));
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun unpack<T0>(arg0: Receipt<T0>) : (0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::deallocations::Deallocations, 0x1b56015b0e1a49d29c7dd95f9f017c198a59e60d09a97031e394fd0292811375::price_calculator::PriceCalculator, 0x1::type_name::TypeName, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal, u64) {
        let Receipt {
            deallocations          : v0,
            price_calculator       : v1,
            expected_coin_type     : v2,
            total_usd_value_before : v3,
            rebalance_usd_value    : v4,
            spread_bps             : v5,
        } = arg0;
        (v0, v1, v2, v3, v4, v5)
    }

    public fun withdraw_fee<T0>(arg0: &RedPoolCap, arg1: &mut RedPool, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::take<T0>(&mut arg1.fee_reserve, arg2, 0x7e30d2b545257c794147131e15a29e035321ab61450b223d1234d89ffe639b2b::reserve::amount(&arg1.fee_reserve, 0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

