module 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::r {
    struct Fx has copy, drop {
        amount_in: u64,
        predicted_out: u64,
        profit: u64,
        hinted_in: u64,
        probes: u8,
        deadline_ms: u64,
        version: u64,
        fee_spent: u64,
    }

    public(friend) fun close<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::g::mn(v0, arg6);
        let v1 = Fx{
            amount_in     : arg1,
            predicted_out : arg2,
            profit        : v0,
            hinted_in     : arg3,
            probes        : arg4,
            deadline_ms   : arg5,
            version       : arg8,
            fee_spent     : arg7,
        };
        0x2::event::emit<Fx>(v1);
        0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg9));
    }

    public(friend) fun fee_spent<T0>(arg0: &0x2::balance::Balance<T0>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x2::balance::value<T0>(arg0);
        assert!(v0 + arg2 >= arg1, 40);
        if (arg1 > v0) {
            arg1 - v0
        } else {
            0
        }
    }

    public fun sf<T0, T1>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::balance::Balance<T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::tx_context::TxContext) {
        close<T0>(arg0, arg4, arg5, arg6, arg7, arg8, arg9, fee_spent<T1>(arg1, arg2, arg3), arg10, arg11);
    }

    public fun st<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::tx_context::TxContext) {
        close<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, 0, arg7, arg8);
    }

    public fun wf(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = 0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::n::pf(arg0, arg1);
        assert!(v0 > 0, 20);
        0x5647f4d694be025ff8465b2f98794b45ca4734b6f7b6c09972bbe9a6ac8e719c::g::mn(v0, arg2);
    }

    // decompiled from Move bytecode v7
}

