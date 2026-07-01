module 0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha_vesting {
    struct VestingSchedule has key {
        id: 0x2::object::UID,
        owner: address,
        total_amount: u64,
        claimed_amount: u64,
        start_time: u64,
        cliff_ms: u64,
        duration_ms: u64,
        locked: 0x2::balance::Balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>,
    }

    struct VestingCreated has copy, drop {
        owner: address,
        amount: u64,
    }

    struct TokensClaimed has copy, drop {
        owner: address,
        amount: u64,
    }

    fun calc_vested(arg0: &VestingSchedule, arg1: u64) : u64 {
        let v0 = arg1 - arg0.start_time;
        if (v0 >= arg0.duration_ms) {
            arg0.total_amount
        } else {
            arg0.total_amount * v0 / arg0.duration_ms
        }
    }

    public entry fun claim(arg0: &mut VestingSchedule, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.owner == v0, 0);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        assert!(v1 >= arg0.start_time + arg0.cliff_ms, 1);
        let v2 = calc_vested(arg0, v1) - arg0.claimed_amount;
        assert!(v2 > 0, 2);
        arg0.claimed_amount = arg0.claimed_amount + v2;
        let v3 = TokensClaimed{
            owner  : v0,
            amount : v2,
        };
        0x2::event::emit<TokensClaimed>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>>(0x2::coin::from_balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(0x2::balance::split<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&mut arg0.locked, v2), arg2), v0);
    }

    public fun claimable_amount(arg0: &VestingSchedule, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        if (v0 < arg0.start_time + arg0.cliff_ms) {
            return 0
        };
        calc_vested(arg0, v0) - arg0.claimed_amount
    }

    public entry fun create_vesting(arg0: 0x2::coin::Coin<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(&arg0);
        assert!(v0 > 0, 2);
        let v1 = VestingSchedule{
            id             : 0x2::object::new(arg3),
            owner          : arg1,
            total_amount   : v0,
            claimed_amount : 0,
            start_time     : 0x2::clock::timestamp_ms(arg2),
            cliff_ms       : 15552000000,
            duration_ms    : 126144000000,
            locked         : 0x2::coin::into_balance<0xee7132e35e1ffae6a130cf36b90255407021f94a43f8578d77c299c1ca70369b::artha::ARTHA>(arg0),
        };
        let v2 = VestingCreated{
            owner  : arg1,
            amount : v0,
        };
        0x2::event::emit<VestingCreated>(v2);
        0x2::transfer::share_object<VestingSchedule>(v1);
    }

    // decompiled from Move bytecode v7
}

