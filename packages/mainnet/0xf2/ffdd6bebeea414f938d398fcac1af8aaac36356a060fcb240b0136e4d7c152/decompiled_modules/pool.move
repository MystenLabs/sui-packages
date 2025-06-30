module 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::pool {
    struct POOL has drop {
        dummy_field: bool,
    }

    struct Pool has store, key {
        id: 0x2::object::UID,
        red_supply: 0x2::balance::Supply<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD>,
        fees: Fees,
        circuit_breaker: CircuitBreaker,
        reserve: 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::Reserve,
        fee_reserve: 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::Reserve,
        allocator: 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::allocation_registry::AllocationRegistry,
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
        rebalance_amount: u64,
        value_before: u64,
        value_after: u64,
    }

    struct PoolCap has key {
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
        deallocations: 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::deallocations::Deallocations,
        price_calculator: 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_calculator::PriceCalculator,
        expected_coin_type: 0x1::type_name::TypeName,
        total_usd_value_before: u64,
        rebalance_usd_value: u64,
        spread_bps: u64,
    }

    struct REDEMPTION_RECEIPT has copy, drop {
        dummy_field: bool,
    }

    struct REBALANCE_RECEIPT has copy, drop {
        dummy_field: bool,
    }

    public fun supply_value(arg0: &Pool) : u64 {
        0x2::balance::supply_value<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD>(&arg0.red_supply)
    }

    public fun update_coin_info<T0>(arg0: &mut Pool, arg1: &0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::allocation_registry::AllocationRegistryCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::allocation_registry::update_coin_info<T0>(arg1, &mut arg0.allocator, arg2, arg3, arg4);
    }

    public fun assert_deposit_enabled(arg0: &Pool) {
        assert!(is_deposit_enabled(arg0), 5);
    }

    public fun assert_redemption_enabled(arg0: &Pool) {
        assert!(is_redemption_enabled(arg0), 6);
    }

    public fun deposit<T0>(arg0: &mut Pool, arg1: &0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::version::Version, arg2: &0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::RedOracle, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD> {
        assert_deposit_enabled(arg0);
        0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::version::assert_active_version(arg1);
        let v0 = 0x1::type_name::get<T0>();
        0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::deduct<T0>(&mut arg0.fee_reserve, arg5, &mut arg4, arg0.fees.deposit_fee_bps);
        let v1 = 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::new_price_calculator(arg2, arg3);
        assert!(0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_calculator::contains(&v1, v0), 7);
        0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::join<T0>(&mut arg0.reserve, arg4);
        let v2 = 0x2::balance::increase_supply<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD>(&mut arg0.red_supply, 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::share_helper::calculate_shares_to_mint(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0x2::coin::value<T0>(&arg4)), 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_calculator::price(&v1, v0))), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(total_usd_value_internal(arg0, &v1)), 0x2::balance::supply_value<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD>(&arg0.red_supply)));
        let v3 = PoolDepositedEvent{
            user           : 0x2::tx_context::sender(arg5),
            coin_type      : v0,
            deposit_amount : 0x2::coin::value<T0>(&arg4),
            share_amount   : 0x2::balance::value<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD>(&v2),
        };
        0x2::event::emit<PoolDepositedEvent>(v3);
        0x2::coin::from_balance<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD>(v2, arg5)
    }

    public fun deposit_fee_bps(arg0: &Fees) : u64 {
        arg0.deposit_fee_bps
    }

    public fun finalize_receipt<T0, T1>(arg0: &mut Pool, arg1: Receipt<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2, v3, v4, v5) = unpack<T1>(arg1);
        let v6 = v1;
        let v7 = v0;
        assert!(0x1::type_name::get<T0>() == v2, 0);
        assert!(0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::deallocations::has_all_taken(&v7), 1);
        let v8 = 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(total_usd_value_internal(arg0, &v6));
        if (0x1::type_name::get<T1>() == 0x1::type_name::get<REDEMPTION_RECEIPT>()) {
            let v9 = if (v8 < v3) {
                v4 - v3 - v8
            } else {
                v4
            };
            let v10 = 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::u64::min(0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::amount(&arg0.reserve, v2), 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_calculator::usd_to_coin_amount(&v6, v2, v9));
            assert!(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::sub(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(10000), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(v10), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(10000)), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_calculator::usd_to_coin_amount(&v6, v2, v4))))) <= v5, 2);
            let v11 = 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::take<T0>(&mut arg0.reserve, arg2, v10);
            0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::deduct<T0>(&mut arg0.fee_reserve, arg2, &mut v11, arg0.fees.redemption_fee_bps);
            let v12 = PoolRedeemedEvent{
                user            : 0x2::tx_context::sender(arg2),
                coin_type       : v2,
                redeemed_amount : 0x2::coin::value<T0>(&v11),
                share_amount    : 0x2::balance::supply_value<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD>(&arg0.red_supply),
            };
            0x2::event::emit<PoolRedeemedEvent>(v12);
            return v11
        };
        if (v8 < v3) {
            assert!(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::sub(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(10000), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::div(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(v4 - v3 - v8), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(10000)), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(v4)))) <= v5, 3);
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

    fun init(arg0: POOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::allocation_registry::new(arg1);
        0x2::transfer::public_transfer<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::allocation_registry::AllocationRegistryCap>(v1, 0x2::tx_context::sender(arg1));
        let v2 = Fees{
            deposit_fee_bps    : 0,
            redemption_fee_bps : 10,
        };
        let v3 = CircuitBreaker{
            deposit_enabled    : false,
            redemption_enabled : false,
        };
        let v4 = Pool{
            id              : 0x2::object::new(arg1),
            red_supply      : 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::new_supply(),
            fees            : v2,
            circuit_breaker : v3,
            reserve         : 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::new(arg1),
            fee_reserve     : 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::new(arg1),
            allocator       : v0,
        };
        0x2::transfer::share_object<Pool>(v4);
        let v5 = PoolCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<PoolCap>(v5, 0x2::tx_context::sender(arg1));
    }

    public fun is_deposit_enabled(arg0: &Pool) : bool {
        arg0.circuit_breaker.deposit_enabled
    }

    public fun is_redemption_enabled(arg0: &Pool) : bool {
        arg0.circuit_breaker.redemption_enabled
    }

    public fun new_rebalance_receipt<T0>(arg0: &mut Pool, arg1: &0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::version::Version, arg2: &0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::RedOracle, arg3: &0x2::clock::Clock, arg4: &0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::allocation_registry::AllocationRegistryCap, arg5: u64, arg6: u64) : Receipt<REBALANCE_RECEIPT> {
        0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::version::assert_active_version(arg1);
        assert!(arg6 <= 5000, 8);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::new_price_calculator(arg2, arg3);
        Receipt<REBALANCE_RECEIPT>{
            deallocations          : 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::allocation_registry::new_deallocations(&arg0.allocator, &arg0.reserve, &v1, v0, arg5),
            price_calculator       : v1,
            expected_coin_type     : v0,
            total_usd_value_before : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(total_usd_value_internal(arg0, &v1)),
            rebalance_usd_value    : arg5,
            spread_bps             : arg6,
        }
    }

    public fun new_redemption_receipt<T0>(arg0: &mut Pool, arg1: &0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::version::Version, arg2: &0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::RedOracle, arg3: &0x2::clock::Clock, arg4: 0x2::coin::Coin<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD>, arg5: u64) : Receipt<REDEMPTION_RECEIPT> {
        assert_redemption_enabled(arg0);
        0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::version::assert_active_version(arg1);
        assert!(arg5 <= 5000, 8);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::new_price_calculator(arg2, arg3);
        let v2 = total_usd_value_internal(arg0, &v1);
        let v3 = 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::share_helper::calculate_amount_to_return(0x2::coin::value<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD>(&arg4), 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(v2), 0x2::balance::supply_value<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD>(&arg0.red_supply));
        0x2::balance::decrease_supply<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD>(&mut arg0.red_supply, 0x2::coin::into_balance<0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::red_usd::RedUSD>(arg4));
        Receipt<REDEMPTION_RECEIPT>{
            deallocations          : 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::allocation_registry::new_deallocations(&arg0.allocator, &arg0.reserve, &v1, v0, v3),
            price_calculator       : v1,
            expected_coin_type     : v0,
            total_usd_value_before : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(v2),
            rebalance_usd_value    : v3,
            spread_bps             : arg5,
        }
    }

    public fun pool_fees(arg0: &Pool) : Fees {
        arg0.fees
    }

    public fun redemption_fee_bps(arg0: &Fees) : u64 {
        arg0.redemption_fee_bps
    }

    public fun return_with_receipt<T0, T1>(arg0: &mut Pool, arg1: &Receipt<T1>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::join<T0>(&mut arg0.reserve, arg2);
    }

    public fun set_circuit_breaker(arg0: &PoolCap, arg1: &mut Pool, arg2: bool, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.circuit_breaker.deposit_enabled = arg2;
        arg1.circuit_breaker.redemption_enabled = arg3;
    }

    public fun set_pool_fees(arg0: &PoolCap, arg1: &mut Pool, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.fees.deposit_fee_bps = arg2;
        arg1.fees.redemption_fee_bps = arg3;
    }

    public fun take_with_receipt<T0, T1>(arg0: &mut Pool, arg1: &mut Receipt<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::deallocations::contains(&arg1.deallocations, v0), 0);
        assert!(!0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::deallocations::is_taken(&arg1.deallocations, v0), 4);
        0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::deallocations::taken(&mut arg1.deallocations, v0);
        0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::take<T0>(&mut arg0.reserve, arg2, 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::deallocations::amount(&arg1.deallocations, v0))
    }

    public fun total_usd_value(arg0: &Pool, arg1: &0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::RedOracle, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::red_oracle::new_price_calculator(arg1, arg2);
        0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::floor(total_usd_value_internal(arg0, &v0))
    }

    fun total_usd_value_internal(arg0: &Pool, arg1: &0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_calculator::PriceCalculator) : 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::Decimal {
        let v0 = 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_calculator::coin_types(arg1);
        let v1 = 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x1::type_name::TypeName>(&v0)) {
            let v3 = *0x1::vector::borrow<0x1::type_name::TypeName>(&v0, v2);
            let v4 = 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::amount(&arg0.reserve, v3);
            if (v4 > 0) {
                v1 = 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::add(v1, 0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::mul(0x947ba6d88db6337ef4937e15a84fe2967df3253f40b4fdf5e1263f28e9c46430::decimal::from(v4), 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_calculator::price(arg1, v3)));
            };
            v2 = v2 + 1;
        };
        v1
    }

    fun unpack<T0>(arg0: Receipt<T0>) : (0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::deallocations::Deallocations, 0xfd0e50a4fdd706442f403b7328ed01551fd0371c502d4238a753df74a3947776::price_calculator::PriceCalculator, 0x1::type_name::TypeName, u64, u64, u64) {
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

    public fun withdraw_fee<T0>(arg0: &PoolCap, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::take<T0>(&mut arg1.fee_reserve, arg2, 0xf2ffdd6bebeea414f938d398fcac1af8aaac36356a060fcb240b0136e4d7c152::reserve::amount(&arg1.fee_reserve, 0x1::type_name::get<T0>()))
    }

    // decompiled from Move bytecode v6
}

