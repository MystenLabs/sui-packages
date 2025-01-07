module 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::queue {
    struct Queue<phantom T0> has store {
        incoming: 0x2::linked_table::LinkedTable<address, 0x2::balance::Balance<T0>>,
        reserve: 0x2::balance::Balance<T0>,
        outgoing: 0x2::linked_table::LinkedTable<address, 0x2::balance::Balance<T0>>,
    }

    public fun destroy_empty<T0>(arg0: Queue<T0>) {
        let Queue {
            incoming : v0,
            reserve  : v1,
            outgoing : v2,
        } = arg0;
        0x2::linked_table::destroy_empty<address, 0x2::balance::Balance<T0>>(v0);
        0x2::balance::destroy_zero<T0>(v1);
        0x2::linked_table::destroy_empty<address, 0x2::balance::Balance<T0>>(v2);
    }

    public fun new<T0>(arg0: &mut 0x2::tx_context::TxContext) : Queue<T0> {
        Queue<T0>{
            incoming : 0x2::linked_table::new<address, 0x2::balance::Balance<T0>>(arg0),
            reserve  : 0x2::balance::zero<T0>(),
            outgoing : 0x2::linked_table::new<address, 0x2::balance::Balance<T0>>(arg0),
        }
    }

    public fun burn_input_withdraw_output<T0, T1>(arg0: &mut Queue<T1>, arg1: &mut Queue<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::balance::Supply<T0>) : (bool, u64) {
        let v0 = 0;
        while (!0x2::linked_table::is_empty<address, 0x2::balance::Balance<T0>>(&arg1.incoming)) {
            let (v1, v2) = 0x2::linked_table::pop_front<address, 0x2::balance::Balance<T0>>(&mut arg1.incoming);
            let v3 = v2;
            let v4 = ratio_conversion(0x2::balance::value<T0>(&v3), arg2, arg3);
            if (0x2::balance::value<T1>(&arg0.reserve) < v4) {
                0x2::linked_table::push_front<address, 0x2::balance::Balance<T0>>(&mut arg1.incoming, v1, v3);
                return (false, v0)
            };
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::linked_table2::merge_balance<address, T1>(&mut arg0.outgoing, v1, 0x2::balance::split<T1>(&mut arg0.reserve, v4));
            v0 = v0 + v4;
            0x2::balance::decrease_supply<T0>(arg4, v3);
        };
        (true, v0)
    }

    public fun cancel_deposit<T0>(arg0: &mut Queue<T0>, arg1: address) : 0x2::balance::Balance<T0> {
        if (0x2::linked_table::contains<address, 0x2::balance::Balance<T0>>(&arg0.incoming, arg1)) {
            0x2::linked_table::remove<address, 0x2::balance::Balance<T0>>(&mut arg0.incoming, arg1)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    public fun deposit<T0>(arg0: &mut Queue<T0>, arg1: address, arg2: 0x2::balance::Balance<T0>) {
        0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::linked_table2::merge_balance<address, T0>(&mut arg0.incoming, arg1, arg2);
    }

    public fun deposit_input_mint_output<T0, T1>(arg0: &mut Queue<T1>, arg1: &mut Queue<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::balance::Supply<T0>) : u64 {
        let v0 = 0;
        while (!0x2::linked_table::is_empty<address, 0x2::balance::Balance<T1>>(&arg0.incoming)) {
            let (v1, v2) = 0x2::linked_table::pop_front<address, 0x2::balance::Balance<T1>>(&mut arg0.incoming);
            let v3 = v2;
            let v4 = 0x2::balance::value<T1>(&v3);
            0x2::balance::join<T1>(&mut arg0.reserve, v3);
            v0 = v0 + v4;
            0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::linked_table2::merge_balance<address, T0>(&mut arg1.outgoing, v1, 0x2::balance::increase_supply<T0>(arg4, ratio_conversion(v4, arg3, arg2)));
        };
        v0
    }

    public fun destroy<T0>(arg0: Queue<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::zero<T0>();
        let Queue {
            incoming : v1,
            reserve  : v2,
            outgoing : v3,
        } = arg0;
        0x2::balance::join<T0>(&mut v0, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::linked_table2::collapse_balance<address, T0>(v1));
        0x2::balance::join<T0>(&mut v0, v2);
        0x2::balance::join<T0>(&mut v0, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::linked_table2::collapse_balance<address, T0>(v3));
        v0
    }

    public fun direct_deposit<T0>(arg0: &mut Queue<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.reserve, arg1);
    }

    public fun direct_withdraw<T0>(arg0: &mut Queue<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.reserve, arg1)
    }

    public fun ratio_conversion(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun reserves_available<T0>(arg0: &Queue<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.reserve)
    }

    public fun withdraw<T0>(arg0: &mut Queue<T0>, arg1: address) : 0x2::balance::Balance<T0> {
        if (0x2::linked_table::contains<address, 0x2::balance::Balance<T0>>(&arg0.outgoing, arg1)) {
            0x2::linked_table::remove<address, 0x2::balance::Balance<T0>>(&mut arg0.outgoing, arg1)
        } else {
            0x2::balance::zero<T0>()
        }
    }

    // decompiled from Move bytecode v6
}

