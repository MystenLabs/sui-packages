module 0x7c6de0b458446aa4afdad7a8659962822a01d3b7902547cf076998728ed0e845::vesting_sale {
    struct Vesting<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        start: u64,
        cliff: u64,
        months_total: u64,
        times_taken: u64,
    }

    struct VestingCreated has copy, drop {
        vesting_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        months: u64,
        cliff_ms: u64,
        start_ms: u64,
    }

    struct VestingClaimed has copy, drop {
        vesting_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        months_claimed: u64,
        remaining_balance: u64,
    }

    struct VestingReassigned has copy, drop {
        vesting_id: 0x2::object::ID,
        from: address,
        to: address,
    }

    public fun value<T0>(arg0: &Vesting<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.balance)
    }

    public fun claim<T0>(arg0: Vesting<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = matured_months<T0>(&arg0, arg1);
        assert!(v0 > arg0.times_taken, 2);
        let v1 = 0x2::balance::zero<T0>();
        while (arg0.times_taken < v0) {
            let v2 = arg0.months_total - arg0.times_taken;
            let v3 = if (v2 == 1) {
                0x2::balance::value<T0>(&arg0.balance)
            } else {
                0x2::balance::value<T0>(&arg0.balance) / v2
            };
            0x2::balance::join<T0>(&mut v1, 0x2::balance::split<T0>(&mut arg0.balance, v3));
            arg0.times_taken = arg0.times_taken + 1;
        };
        let v4 = VestingClaimed{
            vesting_id        : 0x2::object::uid_to_inner(&arg0.id),
            owner             : 0x2::tx_context::sender(arg2),
            amount            : 0x2::balance::value<T0>(&v1),
            months_claimed    : v0,
            remaining_balance : 0x2::balance::value<T0>(&arg0.balance),
        };
        0x2::event::emit<VestingClaimed>(v4);
        if (arg0.times_taken == arg0.months_total) {
            let Vesting {
                id           : v5,
                balance      : v6,
                start        : _,
                cliff        : _,
                months_total : _,
                times_taken  : _,
            } = arg0;
            0x2::object::delete(v5);
            0x2::balance::destroy_zero<T0>(v6);
        } else {
            0x2::transfer::transfer<Vesting<T0>>(arg0, 0x2::tx_context::sender(arg2));
        };
        0x2::coin::from_balance<T0>(v1, arg2)
    }

    public fun cliff<T0>(arg0: &Vesting<T0>) : u64 {
        arg0.cliff
    }

    public fun create<T0>(arg0: address, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 > 0, 0);
        assert!(0x2::coin::value<T0>(&arg3) >= arg1, 1);
        let v0 = Vesting<T0>{
            id           : 0x2::object::new(arg5),
            balance      : 0x2::coin::into_balance<T0>(arg3),
            start        : 0x2::clock::timestamp_ms(arg4),
            cliff        : arg2,
            months_total : arg1,
            times_taken  : 0,
        };
        let v1 = VestingCreated{
            vesting_id : 0x2::object::uid_to_inner(&v0.id),
            recipient  : arg0,
            amount     : 0x2::balance::value<T0>(&v0.balance),
            months     : arg1,
            cliff_ms   : arg2,
            start_ms   : v0.start,
        };
        0x2::event::emit<VestingCreated>(v1);
        0x2::transfer::transfer<Vesting<T0>>(v0, arg0);
    }

    public fun matured_months<T0>(arg0: &Vesting<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        let v1 = arg0.start + arg0.cliff;
        if (v0 <= v1) {
            0
        } else {
            0x1::u64::min((v0 - v1 - 1) / 2592000000 + 1, arg0.months_total)
        }
    }

    public fun months_total<T0>(arg0: &Vesting<T0>) : u64 {
        arg0.months_total
    }

    public fun reassign<T0>(arg0: Vesting<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = VestingReassigned{
            vesting_id : 0x2::object::uid_to_inner(&arg0.id),
            from       : 0x2::tx_context::sender(arg2),
            to         : arg1,
        };
        0x2::event::emit<VestingReassigned>(v0);
        0x2::transfer::transfer<Vesting<T0>>(arg0, arg1);
    }

    public fun start<T0>(arg0: &Vesting<T0>) : u64 {
        arg0.start
    }

    public fun times_taken<T0>(arg0: &Vesting<T0>) : u64 {
        arg0.times_taken
    }

    // decompiled from Move bytecode v6
}

