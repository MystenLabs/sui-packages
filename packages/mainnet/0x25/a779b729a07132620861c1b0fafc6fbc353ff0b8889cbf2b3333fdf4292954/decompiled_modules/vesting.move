module 0x25a779b729a07132620861c1b0fafc6fbc353ff0b8889cbf2b3333fdf4292954::vesting {
    struct VestingSchedule has key {
        id: 0x2::object::UID,
        beneficiary: address,
        start_time: u64,
        final_time: u64,
        original_balance: u64,
        current_balance: 0x2::balance::Balance<0x25a779b729a07132620861c1b0fafc6fbc353ff0b8889cbf2b3333fdf4292954::swhit::SWHIT>,
    }

    public entry fun create_vesting(arg0: 0x2::coin::Coin<0x25a779b729a07132620861c1b0fafc6fbc353ff0b8889cbf2b3333fdf4292954::swhit::SWHIT>, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::into_balance<0x25a779b729a07132620861c1b0fafc6fbc353ff0b8889cbf2b3333fdf4292954::swhit::SWHIT>(arg0);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        let v2 = VestingSchedule{
            id               : 0x2::object::new(arg3),
            beneficiary      : arg1,
            start_time       : v1,
            final_time       : v1 + 12960000000,
            original_balance : 0x2::balance::value<0x25a779b729a07132620861c1b0fafc6fbc353ff0b8889cbf2b3333fdf4292954::swhit::SWHIT>(&v0),
            current_balance  : v0,
        };
        0x2::transfer::share_object<VestingSchedule>(v2);
    }

    public fun get_vested_amount(arg0: &VestingSchedule, arg1: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::clock::timestamp_ms(arg1) - arg0.start_time;
        let v1 = arg0.final_time - arg0.start_time;
        if (v0 > v1) {
            arg0.original_balance
        } else {
            arg0.original_balance * v0 / v1
        }
    }

    public entry fun withdraw_vested(arg0: &mut VestingSchedule, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.beneficiary, 0);
        let v1 = arg0.final_time - arg0.start_time;
        let v2 = 0x2::clock::timestamp_ms(arg1) - arg0.start_time;
        let v3 = if (v2 > v1) {
            arg0.original_balance
        } else {
            arg0.original_balance * v2 / v1
        };
        let v4 = v3 - arg0.original_balance - 0x2::balance::value<0x25a779b729a07132620861c1b0fafc6fbc353ff0b8889cbf2b3333fdf4292954::swhit::SWHIT>(&arg0.current_balance);
        assert!(v4 > 0, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x25a779b729a07132620861c1b0fafc6fbc353ff0b8889cbf2b3333fdf4292954::swhit::SWHIT>>(0x2::coin::from_balance<0x25a779b729a07132620861c1b0fafc6fbc353ff0b8889cbf2b3333fdf4292954::swhit::SWHIT>(0x2::balance::split<0x25a779b729a07132620861c1b0fafc6fbc353ff0b8889cbf2b3333fdf4292954::swhit::SWHIT>(&mut arg0.current_balance, v4), arg2), v0);
    }

    // decompiled from Move bytecode v6
}

