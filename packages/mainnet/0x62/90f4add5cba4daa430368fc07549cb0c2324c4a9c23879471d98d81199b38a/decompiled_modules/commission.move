module 0x6290f4add5cba4daa430368fc07549cb0c2324c4a9c23879471d98d81199b38a::commission {
    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        refel_address: address,
    }

    public fun calculate_and_distribute_commission<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 <= 300, 1);
        let v0 = arg3 * arg1 / (10000 - arg1);
        assert!(0x2::coin::value<T0>(arg0) >= v0 + arg3, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v0, arg4), arg2);
        let v1 = CommissionRecord{
            commission_amount : v0,
            refel_address     : arg2,
        };
        0x2::event::emit<CommissionRecord>(v1);
        0x2::coin::split<T0>(arg0, arg3, arg4)
    }

    // decompiled from Move bytecode v6
}

