module 0x5987537e185820095aecbded73f651e9ac076b72f7bdf40e659305a96ebd685c::objects_management {
    public fun receive_batch_and_transfer<T0>(arg0: &mut 0x5987537e185820095aecbded73f651e9ac076b72f7bdf40e659305a96ebd685c::smart_wallet::SmartWallet, arg1: &mut vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x5987537e185820095aecbded73f651e9ac076b72f7bdf40e659305a96ebd685c::smart_wallet::is_executor(arg0, 0x2::tx_context::sender(arg4)), 1);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(0x5987537e185820095aecbded73f651e9ac076b72f7bdf40e659305a96ebd685c::smart_wallet::get_wallet_uid_mut(arg0), 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg1));
        while (!0x1::vector::is_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg1)) {
            0x2::coin::join<T0>(&mut v0, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(0x5987537e185820095aecbded73f651e9ac076b72f7bdf40e659305a96ebd685c::smart_wallet::get_wallet_uid_mut(arg0), 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg1)));
        };
        let v1 = 0x2::coin::value<T0>(&v0);
        if (arg2 == 0 || arg2 == v1) {
            if (arg2 == 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::object::id_address<0x5987537e185820095aecbded73f651e9ac076b72f7bdf40e659305a96ebd685c::smart_wallet::SmartWallet>(arg0));
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
            };
        } else {
            assert!(v1 >= arg2, 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, arg2, arg4), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::object::id_address<0x5987537e185820095aecbded73f651e9ac076b72f7bdf40e659305a96ebd685c::smart_wallet::SmartWallet>(arg0));
        };
        assert!(0x1::vector::is_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg1), 3);
    }

    public entry fun receive_single_and_transfer<T0>(arg0: &mut 0x5987537e185820095aecbded73f651e9ac076b72f7bdf40e659305a96ebd685c::smart_wallet::SmartWallet, arg1: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x5987537e185820095aecbded73f651e9ac076b72f7bdf40e659305a96ebd685c::smart_wallet::is_executor(arg0, 0x2::tx_context::sender(arg4)), 1);
        let v0 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(0x5987537e185820095aecbded73f651e9ac076b72f7bdf40e659305a96ebd685c::smart_wallet::get_wallet_uid_mut(arg0), arg1);
        let v1 = 0x2::coin::value<T0>(&v0);
        if (arg2 == 0 || arg2 == v1) {
            if (arg2 == 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::object::id_address<0x5987537e185820095aecbded73f651e9ac076b72f7bdf40e659305a96ebd685c::smart_wallet::SmartWallet>(arg0));
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
            };
        } else {
            assert!(v1 >= arg2, 2);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(&mut v0, arg2, arg4), arg3);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::object::id_address<0x5987537e185820095aecbded73f651e9ac076b72f7bdf40e659305a96ebd685c::smart_wallet::SmartWallet>(arg0));
        };
    }

    // decompiled from Move bytecode v6
}

