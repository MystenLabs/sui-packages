module 0x39db09ef649207a4bf5048a6f805ad55666a2049d77c6a6a51f3884bade1dc6::settle {
    struct Profit<phantom T0> has copy, drop {
        amount: u64,
        tag: u64,
    }

    public fun settle<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        assert!(v0 >= arg1, 0);
        let v1 = Profit<T0>{
            amount : v0,
            tag    : arg2,
        };
        0x2::event::emit<Profit<T0>>(v1);
        0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg3));
    }

    public fun repay_and_settle<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        settle<T0>(arg0, arg2, arg3, arg4);
        0x2::balance::split<T0>(&mut arg0, arg1)
    }

    public fun settle_quiet<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 0);
        0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

