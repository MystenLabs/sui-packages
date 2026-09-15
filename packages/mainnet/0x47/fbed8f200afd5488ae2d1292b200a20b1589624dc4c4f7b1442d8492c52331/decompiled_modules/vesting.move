module 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::vesting {
    struct VestingSchedule<phantom T0> has key {
        id: 0x2::object::UID,
        launch_id: 0x2::object::ID,
        beneficiary: address,
        total: u64,
        claimed: u64,
        locked: 0x2::balance::Balance<T0>,
        start_ms: u64,
        cliff_ms: u64,
        duration_ms: u64,
    }

    public fun beneficiary<T0>(arg0: &VestingSchedule<T0>) : address {
        arg0.beneficiary
    }

    public fun claim<T0>(arg0: &mut VestingSchedule<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg2) == arg0.beneficiary, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::not_beneficiary());
        let v0 = claimable<T0>(arg0, arg1);
        assert!(v0 > 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::nothing_to_claim());
        arg0.claimed = arg0.claimed + v0;
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_vesting_claimed(0x2::object::id<VestingSchedule<T0>>(arg0), arg0.beneficiary, v0, arg0.claimed);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.locked, v0), arg2)
    }

    public fun claimable<T0>(arg0: &VestingSchedule<T0>, arg1: &0x2::clock::Clock) : u64 {
        unlocked_at<T0>(arg0, 0x2::clock::timestamp_ms(arg1)) - arg0.claimed
    }

    public fun claimed<T0>(arg0: &VestingSchedule<T0>) : u64 {
        arg0.claimed
    }

    public(friend) fun create_and_share<T0>(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(0x2::balance::value<T0>(&arg2) > 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_vesting());
        assert!(arg4 <= arg5 || arg5 == 0, 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::errors::invalid_vesting());
        let v0 = 0x2::balance::value<T0>(&arg2);
        let v1 = VestingSchedule<T0>{
            id          : 0x2::object::new(arg6),
            launch_id   : arg0,
            beneficiary : arg1,
            total       : v0,
            claimed     : 0,
            locked      : arg2,
            start_ms    : arg3,
            cliff_ms    : arg4,
            duration_ms : arg5,
        };
        let v2 = 0x2::object::id<VestingSchedule<T0>>(&v1);
        0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events::emit_vesting_created(v2, arg0, arg1, v0, arg3, arg4, arg5);
        0x2::transfer::share_object<VestingSchedule<T0>>(v1);
        v2
    }

    public fun launch_id<T0>(arg0: &VestingSchedule<T0>) : 0x2::object::ID {
        arg0.launch_id
    }

    public fun locked_balance<T0>(arg0: &VestingSchedule<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.locked)
    }

    public fun total<T0>(arg0: &VestingSchedule<T0>) : u64 {
        arg0.total
    }

    public fun unlocked_at<T0>(arg0: &VestingSchedule<T0>, arg1: u64) : u64 {
        if (arg1 < arg0.start_ms + arg0.cliff_ms) {
            return 0
        };
        if (arg0.duration_ms == 0 || arg1 >= arg0.start_ms + arg0.duration_ms) {
            return arg0.total
        };
        0x1::u64::mul_div(arg0.total, arg1 - arg0.start_ms, arg0.duration_ms)
    }

    // decompiled from Move bytecode v7
}

