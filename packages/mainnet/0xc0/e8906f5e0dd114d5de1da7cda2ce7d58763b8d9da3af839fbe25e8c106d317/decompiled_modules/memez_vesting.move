module 0x1a184ecf7d0652f8f1285a3b0b2e644bf86ae1742317fcdaa9b11a7f3a30bd70::memez_vesting {
    struct MemezVesting<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        start: u64,
        released: u64,
        duration: u64,
    }

    public fun destroy_zero<T0>(arg0: MemezVesting<T0>) {
        let MemezVesting {
            id       : v0,
            balance  : v1,
            start    : _,
            released : _,
            duration : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public fun new<T0>(arg0: &0x2::clock::Clock, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : MemezVesting<T0> {
        assert!(arg2 >= 0x2::clock::timestamp_ms(arg0), 13906834324667498501);
        assert!(arg3 != 0, 13906834328962334723);
        assert!(0x2::coin::value<T0>(&arg1) != 0, 13906834333257170945);
        MemezVesting<T0>{
            id       : 0x2::object::new(arg4),
            balance  : 0x2::coin::into_balance<T0>(arg1),
            start    : arg2,
            released : 0,
            duration : arg3,
        }
    }

    public fun claim<T0>(arg0: &mut MemezVesting<T0>, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = vesting_status<T0>(arg0, arg1);
        arg0.released = arg0.released + v0;
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance, v0), arg2)
    }

    public fun vesting_status<T0>(arg0: &MemezVesting<T0>, arg1: &0x2::clock::Clock) : u64 {
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

