module 0xee8b6ba4fa5c524d1c060fa2c0d9fd7c781d9cfca0ab2a11476a42dff1654590::settlement {
    struct Receipt<phantom T0> {
        principal: u64,
        minimum_gain: u64,
        sender: address,
        deadline_ms: u64,
    }

    public fun sender<T0>(arg0: &Receipt<T0>) : address {
        arg0.sender
    }

    public fun add_capital<T0>(arg0: &mut Receipt<T0>, arg1: 0x2::coin::Coin<T0>) : 0x2::coin::Coin<T0> {
        let v0 = (arg0.principal as u128) + (0x2::coin::value<T0>(&arg1) as u128);
        assert!(v0 + (arg0.minimum_gain as u128) <= 18446744073709551615, 5);
        arg0.principal = (v0 as u64);
        arg1
    }

    public fun assert_deadline(arg0: &0x2::clock::Clock, arg1: u64) {
        assert!(0x2::clock::timestamp_ms(arg0) <= arg1, 4);
    }

    public fun begin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, Receipt<T0>) {
        assert_deadline(arg3, arg2);
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 > 0, 1);
        assert!((v0 as u128) + (arg1 as u128) <= 18446744073709551615, 5);
        let v1 = Receipt<T0>{
            principal    : v0,
            minimum_gain : arg1,
            sender       : 0x2::tx_context::sender(arg4),
            deadline_ms  : arg2,
        };
        (arg0, v1)
    }

    public fun check_output<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(arg1 > 0, 6);
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 2);
    }

    public fun deadline_ms<T0>(arg0: &Receipt<T0>) : u64 {
        arg0.deadline_ms
    }

    public fun finish<T0>(arg0: Receipt<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let Receipt {
            principal    : v0,
            minimum_gain : v1,
            sender       : v2,
            deadline_ms  : v3,
        } = arg0;
        assert!(0x2::tx_context::sender(arg3) == v2, 3);
        assert_deadline(arg2, v3);
        assert!((0x2::coin::value<T0>(&arg1) as u128) >= (v0 as u128) + (v1 as u128), 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, v2);
    }

    public fun minimum_gain<T0>(arg0: &Receipt<T0>) : u64 {
        arg0.minimum_gain
    }

    public fun principal<T0>(arg0: &Receipt<T0>) : u64 {
        arg0.principal
    }

    // decompiled from Move bytecode v7
}

