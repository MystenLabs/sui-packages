module 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::dca {
    struct ProofKey has copy, drop, store {
        dummy_field: bool,
    }

    struct TradePromise<phantom T0, phantom T1> has drop {
        input: u64,
        min_output: u64,
    }

    struct DCA<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        version: u64,
        owner: address,
        delegatee: address,
        start_time_ms: u64,
        last_time_ms: u64,
        every: u64,
        remaining_orders: u64,
        time_scale: u8,
        input_balance: 0x2::balance::Balance<T0>,
        split_allocation: u64,
        trade_params: TradeParams,
        active: bool,
        gas_budget: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct TradeParams has copy, drop, store {
        min_price: 0x1::option::Option<u64>,
        max_price: 0x1::option::Option<u64>,
    }

    struct DCACreatedEvent has copy, drop {
        id: 0x2::object::ID,
        owner: address,
        delegatee: address,
    }

    public fun new<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) : DCA<T0, T1> {
        assert_time_scale(arg5);
        assert_every(arg3, arg5);
        assert_how_many_orders(arg4, arg3, arg5);
        assert_minimum_funding_per_trade<T0>(0x2::coin::balance<T0>(&arg2), arg4);
        assert_minimum_gas_funds<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(arg6), arg4);
        let v0 = 0x2::coin::into_balance<T0>(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg0);
        let v2 = 0x2::object::new(arg7);
        let v3 = 0x2::tx_context::sender(arg7);
        let v4 = DCACreatedEvent{
            id        : 0x2::object::uid_to_inner(&v2),
            owner     : v3,
            delegatee : arg1,
        };
        0x2::event::emit<DCACreatedEvent>(v4);
        let v5 = TradeParams{
            min_price : 0x1::option::none<u64>(),
            max_price : 0x1::option::none<u64>(),
        };
        DCA<T0, T1>{
            id               : v2,
            version          : 1,
            owner            : v3,
            delegatee        : arg1,
            start_time_ms    : v1,
            last_time_ms     : v1,
            every            : arg3,
            remaining_orders : arg4,
            time_scale       : arg5,
            input_balance    : v0,
            split_allocation : compute_split_allocation(0x2::balance::value<T0>(&v0), arg4),
            trade_params     : v5,
            active           : true,
            gas_budget       : 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg6, gas_budget_estimate(arg4), arg7)),
        }
    }

    public fun active<T0, T1>(arg0: &DCA<T0, T1>) : bool {
        arg0.active
    }

    public entry fun add_gas_budget<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        check_version_and_upgrade<T0, T1>(arg0);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_budget, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    fun assert_active<T0, T1>(arg0: &DCA<T0, T1>) {
        assert!(arg0.active == true, 31);
    }

    fun assert_delegatee<T0, T1>(arg0: &DCA<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.delegatee == 0x2::tx_context::sender(arg1), 21);
    }

    fun assert_every(arg0: u64, arg1: u8) {
        let v0 = if (arg1 == 0) {
            arg0 >= 30 && arg0 <= 59
        } else if (arg1 == 1) {
            arg0 >= 1 && arg0 <= 59
        } else if (arg1 == 2) {
            arg0 >= 1 && arg0 <= 24
        } else if (arg1 == 3) {
            arg0 >= 1 && arg0 <= 30
        } else if (arg1 == 4) {
            arg0 >= 1 && arg0 <= 52
        } else {
            assert!(arg1 == 5, 10);
            arg0 >= 1 && arg0 <= 12
        };
        assert!(v0, 11);
    }

    fun assert_how_many_orders(arg0: u64, arg1: u64, arg2: u8) {
        assert!(arg0 <= 25000, 16);
    }

    fun assert_input_balance<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= arg1, 34);
    }

    public(friend) fun assert_max_price<T0, T1>(arg0: u64, arg1: u64, arg2: &DCA<T0, T1>) {
        if (0x1::option::is_some<u64>(&arg2.trade_params.max_price)) {
            assert!(arg0 <= 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::math::mul(*0x1::option::borrow<u64>(&arg2.trade_params.max_price), arg1), 33);
        };
    }

    public(friend) fun assert_max_price_via_output<T0, T1>(arg0: u64, arg1: &TradePromise<T0, T1>) {
        assert!(arg0 >= trade_min_output<T0, T1>(arg1), 33);
    }

    fun assert_minimum_funding_per_trade<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= 0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::math::mul(arg1, 100000), 12);
    }

    fun assert_minimum_gas_funds<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64) {
        assert!(0x2::balance::value<T0>(arg0) >= gas_budget_estimate(arg1), 13);
    }

    fun assert_owner<T0, T1>(arg0: &DCA<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 20);
    }

    fun assert_owner_or_delegatee<T0, T1>(arg0: &DCA<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.owner || v0 == arg0.delegatee, 22);
    }

    fun assert_time(arg0: u64, arg1: u64, arg2: u64, arg3: u8) {
        let v0 = if (arg3 == 0) {
            0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::time::has_n_seconds_passed(arg0, arg1, arg2)
        } else if (arg3 == 1) {
            0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::time::has_n_minutes_passed(arg0, arg1, arg2)
        } else if (arg3 == 2) {
            0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::time::has_n_hours_passed(arg0, arg1, arg2)
        } else if (arg3 == 3) {
            0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::time::has_n_days_passed(arg0, arg1, arg2)
        } else if (arg3 == 4) {
            0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::time::has_n_weeks_passed(arg0, arg1, arg2)
        } else {
            assert!(arg3 == 5, 0);
            0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::time::has_n_months_passed(arg0, arg1, arg2)
        };
        assert!(v0 == true, 30);
    }

    fun assert_time_scale(arg0: u8) {
        assert!(arg0 <= 5, 10);
    }

    fun assert_version<T0, T1>(arg0: &DCA<T0, T1>) {
        assert!(arg0.version == 1, 0);
    }

    public fun base_fee_bps() : u64 {
        5
    }

    fun check_version_and_upgrade<T0, T1>(arg0: &mut DCA<T0, T1>) {
        if (arg0.version < 1) {
            arg0.version = 1;
        };
        assert_version<T0, T1>(arg0);
    }

    fun compute_min_output(arg0: u64, arg1: u64) : u64 {
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::math::div(arg0, arg1)
    }

    fun compute_split_allocation(arg0: u64, arg1: u64) : u64 {
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::math::div(arg0, arg1)
    }

    public fun delegatee<T0, T1>(arg0: &DCA<T0, T1>) : address {
        arg0.delegatee
    }

    public entry fun deposit_input<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_owner<T0, T1>(arg0, arg4);
        assert_minimum_funding_per_trade<T0>(0x2::coin::balance<T0>(&arg1), arg2);
        assert_minimum_gas_funds<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(arg3), arg2);
        arg0.active = true;
        0x2::balance::join<T0>(&mut arg0.input_balance, 0x2::coin::into_balance<T0>(arg1));
        arg0.remaining_orders = arg0.remaining_orders + arg2;
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_budget, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg3, gas_budget_estimate(arg2), arg4)));
        recompute_split_allocation<T0, T1>(arg0);
    }

    public fun every<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.every
    }

    public(friend) fun fee_amount(arg0: u64) : u64 {
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::math::div(0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::math::mul(arg0, 5), 10000)
    }

    public(friend) fun funds_net_of_fees(arg0: u64) : u64 {
        arg0 - fee_amount(arg0)
    }

    fun gas_budget_estimate(arg0: u64) : u64 {
        0x89b1372fa44ac2312a3876d83612d1dc9d298af332a42a153913558332a564d0::math::mul(25000000, arg0)
    }

    public fun gas_budget_per_trade() : u64 {
        25000000
    }

    fun get_min_output_amount<T0, T1>(arg0: &DCA<T0, T1>, arg1: u64) : u64 {
        if (0x1::option::is_none<u64>(&arg0.trade_params.max_price)) {
            1
        } else {
            compute_min_output(arg1, *0x1::option::borrow<u64>(&arg0.trade_params.max_price))
        }
    }

    public fun increase_remaining_orders<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        check_version_and_upgrade<T0, T1>(arg0);
        arg0.remaining_orders = arg0.remaining_orders + arg2;
        assert_minimum_funding_per_trade<T0>(&arg0.input_balance, arg0.remaining_orders);
        assert_minimum_gas_funds<0x2::sui::SUI>(0x2::coin::balance<0x2::sui::SUI>(arg1), arg0.remaining_orders);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.gas_budget, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(arg1, gas_budget_estimate(arg2), arg3)));
        recompute_split_allocation<T0, T1>(arg0);
    }

    public entry fun init_account<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<DCA<T0, T1>>(new<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7));
    }

    public entry fun init_account_with_params<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::share_object<DCA<T0, T1>>(new_with_params<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9));
    }

    public(friend) fun init_trade<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, TradePromise<T0, T1>) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_delegatee<T0, T1>(arg0, arg2);
        assert_active<T0, T1>(arg0);
        assert_time(0x2::clock::timestamp_ms(arg1), arg0.last_time_ms, arg0.every, arg0.time_scale);
        let v0 = if (arg0.remaining_orders > 1) {
            0x2::balance::split<T0>(&mut arg0.input_balance, arg0.split_allocation)
        } else {
            0x2::balance::withdraw_all<T0>(&mut arg0.input_balance)
        };
        let v1 = v0;
        arg0.last_time_ms = 0x2::clock::timestamp_ms(arg1);
        arg0.remaining_orders = arg0.remaining_orders - 1;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v1, fee_amount(arg0.split_allocation)), arg2), arg0.delegatee);
        let v2 = 0x2::balance::value<T0>(&v1);
        let v3 = TradePromise<T0, T1>{
            input      : v2,
            min_output : get_min_output_amount<T0, T1>(arg0, v2),
        };
        (v1, v3)
    }

    public fun input_balance<T0, T1>(arg0: &DCA<T0, T1>) : &0x2::balance::Balance<T0> {
        &arg0.input_balance
    }

    public fun last_time_ms<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.last_time_ms
    }

    public fun minimum_funding_per_trade() : u64 {
        100000
    }

    public fun new_with_params<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: u8, arg6: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : DCA<T0, T1> {
        let v0 = new<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg9);
        0x1::option::fill<u64>(&mut v0.trade_params.min_price, arg7);
        0x1::option::fill<u64>(&mut v0.trade_params.max_price, arg8);
        v0
    }

    public fun order_limit() : u64 {
        25000
    }

    public fun owner<T0, T1>(arg0: &DCA<T0, T1>) : address {
        arg0.owner
    }

    public entry fun reactivate_as_owner<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_owner<T0, T1>(arg0, arg1);
        assert!(0x2::balance::value<T0>(&arg0.input_balance) > 0, 14);
        assert!(arg0.remaining_orders > 0, 15);
        recompute_split_allocation_unsafe<T0, T1>(arg0);
        arg0.active = true;
    }

    fun recompute_split_allocation<T0, T1>(arg0: &mut DCA<T0, T1>) {
        if (arg0.remaining_orders == 0 || 0x2::balance::value<T0>(&arg0.input_balance) == 0) {
            set_inactive_and_reset<T0, T1>(arg0);
        } else {
            recompute_split_allocation_unsafe<T0, T1>(arg0);
        };
    }

    fun recompute_split_allocation_unsafe<T0, T1>(arg0: &mut DCA<T0, T1>) {
        arg0.split_allocation = compute_split_allocation(0x2::balance::value<T0>(&arg0.input_balance), arg0.remaining_orders);
    }

    public entry fun redeem_funds_and_close<T0, T1>(arg0: DCA<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        check_version_and_upgrade<T0, T1>(v0);
        assert_owner_or_delegatee<T0, T1>(&arg0, arg1);
        let DCA {
            id               : v1,
            version          : _,
            owner            : v3,
            delegatee        : _,
            start_time_ms    : _,
            last_time_ms     : _,
            every            : _,
            remaining_orders : _,
            time_scale       : _,
            input_balance    : v10,
            split_allocation : _,
            trade_params     : _,
            active           : _,
            gas_budget       : v14,
        } = arg0;
        let v15 = v14;
        let v16 = v10;
        if (0x2::balance::value<T0>(&v16) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v16, arg1), v3);
        } else {
            0x2::balance::destroy_zero<T0>(v16);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&v15) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v15, arg1), v3);
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v15);
        };
        0x2::object::delete(v1);
    }

    public fun redeem_funds_and_deactivate<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_owner_or_delegatee<T0, T1>(arg0, arg1);
        if (0x2::balance::value<T0>(&arg0.input_balance) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.input_balance), arg1), arg0.owner);
        };
        if (0x2::balance::value<0x2::sui::SUI>(&arg0.gas_budget) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.gas_budget), arg1), arg0.owner);
        };
        set_inactive_and_reset<T0, T1>(arg0);
    }

    public fun remaining_orders<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.remaining_orders
    }

    public(friend) fun resolve_trade<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: TradePromise<T0, T1>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let TradePromise {
            input      : _,
            min_output : _,
        } = arg1;
        if (arg0.remaining_orders == 0 || 0x2::balance::value<T0>(&arg0.input_balance) == 0) {
            set_inactive_and_reset<T0, T1>(arg0);
        };
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_budget, arg2), arg3)
    }

    public entry fun set_inactive<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: &0x2::tx_context::TxContext) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_owner_or_delegatee<T0, T1>(arg0, arg1);
        arg0.active = false;
    }

    fun set_inactive_and_reset<T0, T1>(arg0: &mut DCA<T0, T1>) {
        arg0.split_allocation = 0;
        arg0.remaining_orders = 0;
        arg0.active = false;
    }

    public fun split_allocation<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.split_allocation
    }

    public fun start_time_ms<T0, T1>(arg0: &DCA<T0, T1>) : u64 {
        arg0.start_time_ms
    }

    public fun time_scale<T0, T1>(arg0: &DCA<T0, T1>) : u8 {
        arg0.time_scale
    }

    public fun trade_input<T0, T1>(arg0: &TradePromise<T0, T1>) : u64 {
        arg0.input
    }

    public fun trade_min_output<T0, T1>(arg0: &TradePromise<T0, T1>) : u64 {
        arg0.min_output
    }

    public fun trade_params<T0, T1>(arg0: &DCA<T0, T1>) : TradeParams {
        arg0.trade_params
    }

    public entry fun withdraw_input<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = withdraw_input_<T0, T1>(arg0, arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg3), arg0.owner);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg3), arg0.owner);
    }

    public fun withdraw_input_<T0, T1>(arg0: &mut DCA<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<0x2::sui::SUI>) {
        check_version_and_upgrade<T0, T1>(arg0);
        assert_owner<T0, T1>(arg0, arg3);
        assert_input_balance<T0>(&arg0.input_balance, arg1);
        let v0 = 0x2::balance::split<T0>(&mut arg0.input_balance, arg1);
        arg0.remaining_orders = arg0.remaining_orders - arg2;
        let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut arg0.gas_budget, gas_budget_estimate(arg2));
        recompute_split_allocation<T0, T1>(arg0);
        assert_minimum_funding_per_trade<T0>(&arg0.input_balance, arg0.remaining_orders);
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

