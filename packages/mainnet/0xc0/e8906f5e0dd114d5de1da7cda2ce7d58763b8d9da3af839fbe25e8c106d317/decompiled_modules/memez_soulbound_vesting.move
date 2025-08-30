module 0x1a184ecf7d0652f8f1285a3b0b2e644bf86ae1742317fcdaa9b11a7f3a30bd70::memez_soulbound_vesting {
    struct MemezSoulBoundVesting<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        start: u64,
        released: u64,
        duration: u64,
        owner: address,
    }

    public fun destroy_zero<T0>(arg0: MemezSoulBoundVesting<T0>) {
        let MemezSoulBoundVesting {
            id       : v0,
            balance  : v1,
            start    : _,
            released : _,
            duration : _,
            owner    : _,
        } = arg0;
        let v6 = v0;
        0x1a184ecf7d0652f8f1285a3b0b2e644bf86ae1742317fcdaa9b11a7f3a30bd70::memez_vesting_events::destroyed<T0>(0x2::object::uid_to_address(&v6));
        0x2::object::delete(v6);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public fun new<T0>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: address, arg5: &mut 0x2::tx_context::TxContext) : MemezSoulBoundVesting<T0> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg0), 1);
        assert!(arg3 != 0, 2);
        assert!(v0 != 0, 3);
        let v1 = MemezSoulBoundVesting<T0>{
            id       : 0x2::object::new(arg5),
            balance  : 0x2::coin::into_balance<T0>(arg1),
            start    : arg2,
            released : 0,
            duration : arg3,
            owner    : arg4,
        };
        0x1a184ecf7d0652f8f1285a3b0b2e644bf86ae1742317fcdaa9b11a7f3a30bd70::memez_vesting_events::new<T0>(0x2::object::uid_to_address(&v1.id), arg4, v0, arg2, arg3);
        v1
    }

    public fun claim<T0>(arg0: &mut MemezSoulBoundVesting<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = vesting_status<T0>(arg0, arg1);
        arg0.released = arg0.released + v0;
        0x1a184ecf7d0652f8f1285a3b0b2e644bf86ae1742317fcdaa9b11a7f3a30bd70::memez_vesting_events::claimed<T0>(0x2::object::uid_to_address(&arg0.id), v0);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2)
    }

    public fun transfer_to_owner<T0>(arg0: MemezSoulBoundVesting<T0>) {
        0x2::transfer::transfer<MemezSoulBoundVesting<T0>>(arg0, arg0.owner);
    }

    public fun vesting_status<T0>(arg0: &MemezSoulBoundVesting<T0>, arg1: &0x2::clock::Clock) : u64 {
        let v0 = if (0x2::clock::timestamp_ms(arg1) < arg0.start) {
            0
        } else if (0x2::clock::timestamp_ms(arg1) > arg0.start + arg0.duration) {
            0x2::balance::value<T0>(&arg0.balance) + arg0.released
        } else {
            (0x2::balance::value<T0>(&arg0.balance) + arg0.released) * (0x2::clock::timestamp_ms(arg1) - arg0.start) / arg0.duration
        };
        v0 - arg0.released
    }

    // decompiled from Move bytecode v6
}

