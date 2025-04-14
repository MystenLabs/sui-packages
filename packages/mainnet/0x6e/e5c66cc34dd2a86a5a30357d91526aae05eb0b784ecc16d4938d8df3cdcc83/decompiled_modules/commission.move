module 0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::commission {
    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        refel_address: address,
    }

    public fun calculate_and_distribute_commission<T0>(arg0: &0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init::Version, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x6ee5c66cc34dd2a86a5a30357d91526aae05eb0b784ecc16d4938d8df3cdcc83::init::check_xbridge_version(arg0);
        let v0 = if (arg2 > 0) {
            if (arg2 <= 300) {
                arg3 != @0x0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
        let v1 = arg4 * arg2 / (10000 - arg2);
        assert!(0x2::coin::value<T0>(arg1) >= v1 + arg4, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v1, arg5), arg3);
        let v2 = CommissionRecord{
            commission_amount : v1,
            refel_address     : arg3,
        };
        0x2::event::emit<CommissionRecord>(v2);
        0x2::coin::split<T0>(arg1, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

