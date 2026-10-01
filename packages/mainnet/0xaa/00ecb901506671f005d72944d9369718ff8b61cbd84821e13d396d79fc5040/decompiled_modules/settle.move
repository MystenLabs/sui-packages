module 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::settle {
    public(friend) fun assert_recipient(arg0: address) {
        assert!(arg0 != @0x0, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::bad_recipient());
    }

    public(friend) fun kept<T0, T1>(arg0: 0x2::balance::Balance<T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T1>(&arg0) >= arg2, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::net_below_min());
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg0, arg4), arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg4), arg3);
    }

    public(friend) fun sold<T0>(arg0: 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0, arg1);
        assert!(0x2::balance::value<T0>(&arg0) >= arg2, 0xa5c654504d50404edf9e7de7a564abc6a64df45c2ac3fc75d703024c62432e72::errors::net_below_min());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg4), arg3);
    }

    // decompiled from Move bytecode v7
}

