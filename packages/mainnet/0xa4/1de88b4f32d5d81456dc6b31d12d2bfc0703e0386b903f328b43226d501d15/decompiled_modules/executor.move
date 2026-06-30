module 0xa41de88b4f32d5d81456dc6b31d12d2bfc0703e0386b903f328b43226d501d15::executor {
    struct ArbTicket<phantom T0> {
        min_out: u64,
    }

    public fun assert_nonempty<T0>(arg0: &0x2::coin::Coin<T0>) {
        assert!(0x2::coin::value<T0>(arg0) > 0, 1);
    }

    public fun close<T0>(arg0: ArbTicket<T0>, arg1: 0x2::coin::Coin<T0>) : 0x2::coin::Coin<T0> {
        let ArbTicket { min_out: v0 } = arg0;
        0xa41de88b4f32d5d81456dc6b31d12d2bfc0703e0386b903f328b43226d501d15::guard::assert_min_value<T0>(arg1, v0)
    }

    public fun close_and_sweep<T0>(arg0: ArbTicket<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(close<T0>(arg0, arg1), arg2);
    }

    public fun close_balance<T0>(arg0: ArbTicket<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        close<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2))
    }

    public fun close_with_gas_floor<T0, T1>(arg0: ArbTicket<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: u64) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        0xa41de88b4f32d5d81456dc6b31d12d2bfc0703e0386b903f328b43226d501d15::guard::check_min_value<T1>(&arg2, arg3);
        (close<T0>(arg0, arg1), arg2)
    }

    public fun open<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : (0x2::coin::Coin<T0>, ArbTicket<T0>) {
        let v0 = ArbTicket<T0>{min_out: arg1};
        (arg0, v0)
    }

    // decompiled from Move bytecode v7
}

