module 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::interface {
    public entry fun add_deposit<T0>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg3: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Deposit<T0>, arg4: &0x2::clock::Clock) {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg0);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::add_deposit<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun deposit<T0>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg0);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::deposit<T0>(arg0, arg1, arg2, arg3, arg4);
    }

    public entry fun get_deposit<T0>(arg0: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg1: &mut 0x2::tx_context::TxContext) : address {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::get_deposit<T0>(arg0, arg1)
    }

    public entry fun harvest<T0, T1>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg1: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Deposit<T0>, arg3: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Bank<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = raw_harvest<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg5));
    }

    public entry fun remaining<T0>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg1: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Deposit<T0>, arg2: &0x2::clock::Clock) : 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64> {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::remaining<T0>(arg0, arg1, arg2)
    }

    public entry fun settle<T0>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg1: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Deposit<T0>, arg3: &0x2::clock::Clock) {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg0);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::settle<T0>(arg0, arg1, arg2, arg3);
    }

    public entry fun withdraw<T0>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg1: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Deposit<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = raw_withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg5));
    }

    public fun raw_harvest<T0, T1>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg1: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Deposit<T0>, arg3: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Bank<T0, T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg0);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::harvest<T0, T1>(arg1, arg2, arg3, arg4, arg5)
    }

    public fun raw_withdraw<T0>(arg0: &0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Setting, arg1: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Pool<T0>, arg2: &mut 0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::Deposit<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::assert_version(arg0);
        0x2cb0b99942ceccbffa67a991a01b0ddc78a96fb1895f426868699c6da27c424::core::withdraw<T0>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

