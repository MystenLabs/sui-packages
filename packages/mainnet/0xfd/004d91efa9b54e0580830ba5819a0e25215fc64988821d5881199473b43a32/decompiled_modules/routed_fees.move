module 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::routed_fees {
    struct RoutedFeePaid has copy, drop {
        curve_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        gross_sui: u64,
        protocol_fee_sui: u64,
        creator_fee_sui: u64,
    }

    public fun check_output<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 1);
        arg0
    }

    public(friend) fun settle(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: &mut 0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::rewards::Policy, arg3: address, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<0x2::sui::SUI>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert!(arg4 <= 500 && arg5 <= 500, 0);
        assert!(arg4 + arg5 <= 500, 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg6);
        assert!(v0 > 0, 2);
        let v1 = (((v0 as u128) * (arg4 as u128) / 10000) as u64);
        let v2 = (((v0 as u128) * (arg5 as u128) / 10000) as u64);
        assert!(v0 - v1 - v2 >= arg7, 1);
        let v3 = 0x2::coin::into_balance<0x2::sui::SUI>(arg6);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v1), arg8), arg3);
        };
        0xfd004d91efa9b54e0580830ba5819a0e25215fc64988821d5881199473b43a32::rewards::distribute(arg2, arg0, 0x2::balance::split<0x2::sui::SUI>(&mut v3, v2), arg8);
        let v4 = RoutedFeePaid{
            curve_id         : arg0,
            pool_id          : arg1,
            gross_sui        : v0,
            protocol_fee_sui : v1,
            creator_fee_sui  : v2,
        };
        0x2::event::emit<RoutedFeePaid>(v4);
        0x2::coin::from_balance<0x2::sui::SUI>(v3, arg8)
    }

    // decompiled from Move bytecode v7
}

