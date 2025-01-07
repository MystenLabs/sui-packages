module 0xc6de65cb7112704c90649798c14f4c94b05f8bde0b63db690819b3349a02e7fe::commission {
    struct CommissionRecord has copy, drop {
        commission_amount: u64,
        refel_address: address,
    }

    public fun split_with_percentage_for_commission<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 <= 300, 1);
        let v0 = 0x2::coin::value<T0>(arg0);
        let v1 = v0 * arg1 / 10000;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v1, arg3), arg2);
        let v2 = CommissionRecord{
            commission_amount : v1,
            refel_address     : arg2,
        };
        0x2::event::emit<CommissionRecord>(v2);
        0x2::coin::split<T0>(arg0, v0 - v1, arg3)
    }

    // decompiled from Move bytecode v6
}

