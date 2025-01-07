module 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::launchpad {
    struct LaunchCap has store, key {
        id: 0x2::object::UID,
    }

    struct Phase has store {
        min_deposit: u64,
        max_deposit: u64,
        started_at_ms: u64,
        ended_at_ms: u64,
        soft_cap: u64,
        hard_cap: u64,
        min_sale_amount: u64,
        max_sale_amount: u64,
        fixed_price: u64,
        total_deposit_amount: u64,
        witdrawable: bool,
        claimable: bool,
        deposits: 0x2::table::Table<address, u64>,
        whitelist: 0x2::table::Table<address, u64>,
        claimed: 0x2::table::Table<address, bool>,
        vesting_schedule: 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::distributor::VestingSchedule,
    }

    struct Launchpad<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        phases: vector<Phase>,
        version: u64,
    }

    struct Deposit has copy, drop {
        sender: address,
        phase_index: u64,
        amount: u64,
    }

    struct Withdraw has copy, drop {
        sender: address,
        phase_index: u64,
        amount: u64,
    }

    struct Claim has copy, drop {
        sender: address,
        phase_index: u64,
        sale_amount: u64,
        refund_amount: u64,
    }

    struct Release has copy, drop {
        sender: address,
        phase_index: u64,
        amount: u64,
    }

    public entry fun deposit<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0, T1>(arg0);
        check_phase_exists<T0, T1>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::vector::borrow_mut<Phase>(&mut arg0.phases, arg1);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.started_at_ms, 2);
        assert!(0x2::clock::timestamp_ms(arg3) < v1.ended_at_ms, 3);
        assert!(0x2::table::length<address, u64>(&v1.whitelist) == 0 || 0x2::table::contains<address, u64>(&v1.whitelist, v0), 4);
        let v2 = if (0x2::table::length<address, u64>(&v1.whitelist) == 0) {
            v1.max_deposit
        } else {
            *0x2::table::borrow<address, u64>(&v1.whitelist, v0)
        };
        let v3 = 0x2::coin::value<T1>(&arg2);
        let v4 = increase_deposit(v1, v0, v3);
        assert!(v4 >= v1.min_deposit, 5);
        assert!(v4 <= v2, 6);
        0x2::balance::join<T1>(0x2::dynamic_field::borrow_mut<0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::utils::Marker<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::utils::marker<T1>()), 0x2::coin::into_balance<T1>(arg2));
        let v5 = Deposit{
            sender      : v0,
            phase_index : arg1,
            amount      : v3,
        };
        0x2::event::emit<Deposit>(v5);
    }

    public entry fun release<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0, T1>(arg0);
        check_phase_exists<T0, T1>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::distributor::release<T0>(&mut 0x1::vector::borrow_mut<Phase>(&mut arg0.phases, arg1).vesting_schedule, arg2, arg3);
        let v2 = Release{
            sender      : v0,
            phase_index : arg1,
            amount      : 0x2::balance::value<T0>(&v1),
        };
        0x2::event::emit<Release>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v1, arg3), v0);
    }

    public entry fun add_phase<T0, T1>(arg0: &LaunchCap, arg1: &mut Launchpad<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: bool, arg13: &0x2::clock::Clock, arg14: &mut 0x2::tx_context::TxContext) {
        let v0 = if (0x1::vector::length<Phase>(&arg1.phases) == 0) {
            0x2::clock::timestamp_ms(arg13)
        } else {
            0x1::vector::borrow<Phase>(&arg1.phases, 0x1::vector::length<Phase>(&arg1.phases) - 1).ended_at_ms
        };
        assert!(arg4 > v0 && arg5 > arg4 && arg2 > 0 && arg3 > arg2 && arg6 > 0 && arg7 > arg6 && arg8 > 0, 12);
        let v1 = Phase{
            min_deposit          : arg2,
            max_deposit          : arg3,
            started_at_ms        : arg4,
            ended_at_ms          : arg5,
            soft_cap             : arg6,
            hard_cap             : arg7,
            min_sale_amount      : 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::math::unsafe_div(arg6, arg8),
            max_sale_amount      : 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::math::unsafe_div(arg7, arg8),
            fixed_price          : arg8,
            total_deposit_amount : 0,
            witdrawable          : arg12,
            claimable            : false,
            deposits             : 0x2::table::new<address, u64>(arg14),
            whitelist            : 0x2::table::new<address, u64>(arg14),
            claimed              : 0x2::table::new<address, bool>(arg14),
            vesting_schedule     : 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::distributor::new<T0>(arg9, arg10, arg11, 0x2::coin::zero<T0>(arg14), arg13, arg14),
        };
        0x1::vector::push_back<Phase>(&mut arg1.phases, v1);
    }

    public fun check_phase_exists<T0, T1>(arg0: &Launchpad<T0, T1>, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<Phase>(&arg0.phases), 1);
    }

    public fun check_version<T0, T1>(arg0: &Launchpad<T0, T1>) {
        assert!(arg0.version == 1, 999);
    }

    public entry fun claim<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version<T0, T1>(arg0);
        check_phase_exists<T0, T1>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = 0x1::vector::borrow_mut<Phase>(&mut arg0.phases, arg1);
        assert!(v1.claimable, 15);
        assert!(0x2::table::contains<address, u64>(&v1.deposits, v0), 7);
        assert!(!0x2::table::contains<address, bool>(&v1.claimed, v0), 8);
        let v2 = *0x2::table::borrow<address, u64>(&v1.deposits, v0);
        let (v3, v4) = if (v1.total_deposit_amount <= v1.soft_cap) {
            (0, v2)
        } else if (v1.total_deposit_amount <= v1.hard_cap) {
            (0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::math::unsafe_div(v2, v1.fixed_price), 0)
        } else {
            let v5 = 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::math::mul_div(v2, v1.max_sale_amount, v1.total_deposit_amount);
            let (v6, v7) = 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::math::mul_round(v5, v1.fixed_price);
            let v8 = v7;
            if (v6) {
                v8 = v7 + 1;
            };
            (v5, v2 - v8)
        };
        0x2::table::add<address, bool>(&mut v1.claimed, v0, true);
        if (v3 > 0) {
            0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::distributor::distribute(&mut v1.vesting_schedule, v0, v3);
        };
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::utils::Marker<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::utils::marker<T1>()), v4), arg2), v0);
        };
        let v9 = Claim{
            sender        : v0,
            phase_index   : arg1,
            sale_amount   : v3,
            refund_amount : v4,
        };
        0x2::event::emit<Claim>(v9);
    }

    public entry fun collect_raised_coins<T0, T1>(arg0: &LaunchCap, arg1: &mut Launchpad<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0, T1>(arg1);
        check_phase_exists<T0, T1>(arg1, arg2);
        let v0 = 0x1::vector::borrow_mut<Phase>(&mut arg1.phases, arg2);
        assert!(0x2::clock::timestamp_ms(arg3) >= v0.ended_at_ms && v0.total_deposit_amount > v0.soft_cap, 14);
        let v1 = if (v0.total_deposit_amount <= v0.soft_cap) {
            0
        } else if (v0.total_deposit_amount <= v0.hard_cap) {
            v0.total_deposit_amount
        } else {
            v0.hard_cap
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(0x2::balance::split<T1>(0x2::dynamic_field::borrow_mut<0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::utils::Marker<T1>, 0x2::balance::Balance<T1>>(&mut arg1.id, 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::utils::marker<T1>()), v1), arg4), 0x2::tx_context::sender(arg4));
    }

    fun decrease_deposit(arg0: &mut Phase, arg1: address, arg2: u64) : u64 {
        let v0 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deposits, arg1);
        assert!(*v0 >= arg2, 10);
        *v0 = *v0 - arg2;
        arg0.total_deposit_amount = arg0.total_deposit_amount - arg2;
        *v0
    }

    public entry fun deposit_sale_coins<T0, T1>(arg0: &LaunchCap, arg1: &mut Launchpad<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T0>) {
        check_version<T0, T1>(arg1);
        check_phase_exists<T0, T1>(arg1, arg2);
        let v0 = 0x1::vector::borrow_mut<Phase>(&mut arg1.phases, arg2);
        let v1 = if (v0.total_deposit_amount <= v0.soft_cap) {
            0
        } else if (v0.total_deposit_amount <= v0.hard_cap) {
            0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::math::unsafe_div(v0.total_deposit_amount, v0.fixed_price)
        } else {
            v0.max_sale_amount
        };
        assert!(0x2::coin::value<T0>(&arg3) == v1, 10);
        0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::distributor::deposit<T0>(&mut v0.vesting_schedule, arg3);
    }

    public fun deposited_of<T0, T1>(arg0: &Launchpad<T0, T1>, arg1: u64, arg2: address) : u64 {
        let v0 = 0x1::vector::borrow<Phase>(&arg0.phases, arg1);
        if (!0x2::table::contains<address, u64>(&v0.deposits, arg2)) {
            0
        } else {
            *0x2::table::borrow<address, u64>(&v0.deposits, arg2)
        }
    }

    public entry fun grant_whitelist<T0, T1>(arg0: &LaunchCap, arg1: &mut Launchpad<T0, T1>, arg2: u64, arg3: vector<address>, arg4: vector<u64>) {
        check_version<T0, T1>(arg1);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u64>(&arg4), 13);
        let v0 = 0x1::vector::borrow_mut<Phase>(&mut arg1.phases, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            0x2::table::add<address, u64>(&mut v0.whitelist, *0x1::vector::borrow<address>(&arg3, v1), *0x1::vector::borrow<u64>(&arg4, v1));
            v1 = v1 + 1;
        };
    }

    fun increase_deposit(arg0: &mut Phase, arg1: address, arg2: u64) : u64 {
        let v0 = if (!0x2::table::contains<address, u64>(&arg0.deposits, arg1)) {
            0x2::table::add<address, u64>(&mut arg0.deposits, arg1, arg2);
            arg2
        } else {
            let v1 = 0x2::table::borrow_mut<address, u64>(&mut arg0.deposits, arg1);
            *v1 = *v1 + arg2;
            *v1
        };
        arg0.total_deposit_amount = arg0.total_deposit_amount + arg2;
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LaunchCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun initialize<T0, T1>(arg0: &LaunchCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Launchpad<T0, T1>{
            id      : 0x2::object::new(arg1),
            phases  : 0x1::vector::empty<Phase>(),
            version : 1,
        };
        0x2::dynamic_field::add<0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::utils::Marker<T1>, 0x2::balance::Balance<T1>>(&mut v0.id, 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::utils::marker<T1>(), 0x2::balance::zero<T1>());
        0x2::transfer::share_object<Launchpad<T0, T1>>(v0);
    }

    public entry fun revoke_whitelist<T0, T1>(arg0: &LaunchCap, arg1: &mut Launchpad<T0, T1>, arg2: u64, arg3: vector<address>) {
        check_version<T0, T1>(arg1);
        check_phase_exists<T0, T1>(arg1, arg2);
        let v0 = 0x1::vector::borrow_mut<Phase>(&mut arg1.phases, arg2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg3)) {
            0x2::table::remove<address, u64>(&mut v0.whitelist, *0x1::vector::borrow<address>(&arg3, v1));
            v1 = v1 + 1;
        };
    }

    public entry fun set_claimable<T0, T1>(arg0: &LaunchCap, arg1: &mut Launchpad<T0, T1>, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        check_version<T0, T1>(arg1);
        check_phase_exists<T0, T1>(arg1, arg2);
        let v0 = 0x1::vector::borrow_mut<Phase>(&mut arg1.phases, arg2);
        assert!(0x2::clock::timestamp_ms(arg4) >= v0.ended_at_ms, 9);
        v0.claimable = arg3;
    }

    public fun total_deposit_amount<T0, T1>(arg0: &Launchpad<T0, T1>, arg1: u64) : u64 {
        0x1::vector::borrow<Phase>(&arg0.phases, arg1).total_deposit_amount
    }

    public entry fun upgrade<T0, T1>(arg0: &LaunchCap, arg1: &mut Launchpad<T0, T1>) {
        assert!(arg1.version < 1, 1000);
        arg1.version = 1;
    }

    public entry fun withdraw<T0, T1>(arg0: &mut Launchpad<T0, T1>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0, T1>(arg0);
        check_phase_exists<T0, T1>(arg0, arg1);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x1::vector::borrow_mut<Phase>(&mut arg0.phases, arg1);
        assert!(v1.witdrawable, 11);
        assert!(0x2::clock::timestamp_ms(arg3) < v1.ended_at_ms, 3);
        assert!(0x2::table::contains<address, u64>(&v1.deposits, v0), 7);
        let v2 = decrease_deposit(v1, v0, arg2);
        assert!(v2 >= v1.min_deposit, 5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(0x2::dynamic_field::borrow_mut<0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::utils::Marker<T1>, 0x2::balance::Balance<T1>>(&mut arg0.id, 0x314b48b39ee91eb12858ad88cea38a33239fb080a2c040e5d61844ed64ec36c4::utils::marker<T1>()), arg2, arg4), v0);
        let v3 = Withdraw{
            sender      : v0,
            phase_index : arg1,
            amount      : arg2,
        };
        0x2::event::emit<Withdraw>(v3);
    }

    // decompiled from Move bytecode v6
}

