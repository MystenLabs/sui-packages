module 0xaeec7ea6225366b854e36186136ff209db4c7cd33afdb2ee35a7fcbc46775911::ab {
    public fun cot<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun mdeposit<T0, T1>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x1::type_name::get<T1>();
        let v1 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::balance(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::borrow<T0>(arg0, v0)) - 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit_cap(0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::borrow<T0>(arg0, v0));
        let v2 = if (0x2::coin::value<T1>(&arg3) > v1) {
            0x2::coin::value<T1>(&arg3) - v1
        } else {
            0
        };
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(&mut arg3, v2, arg4), 0x2::tx_context::sender(arg4));
        };
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, T1>(arg0, arg1, arg2, arg3, 0, arg4)
    }

    public fun mswap<T0, T1, T2>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T0, T1>, arg3: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T0, T2>, arg4: 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::swap<T0, T1, T2>(arg0, arg1, arg2, arg3, arg4, 0, arg5)
    }

    public fun mwithdraw<T0, T1>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, T1>(arg0, arg1, arg2, arg3, 0, arg4)
    }

    public fun tod<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

