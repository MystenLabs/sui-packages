module 0xf72f04aa8d04b63b3c4674f31ef72735da507e80aab070797943de75ce35e7ec::metastable {
    struct MetastableSwapEvent has copy, drop, store {
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::DepositCap<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::deposit<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = MetastableSwapEvent{
            amount_in    : 0x2::coin::value<T1>(&arg3),
            amount_out   : 0x2::coin::value<T0>(&v0),
            a2b          : true,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T1>(),
            coin_b       : 0x1::type_name::get<T0>(),
        };
        0x2::event::emit<MetastableSwapEvent>(v1);
        v0
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::Vault<T0>, arg1: &0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::version::Version, arg2: 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::WithdrawCap<T0, T1>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0xca653d2fac70a49549c7ff8792027fa4fa418fd6619954ea0f45d6fd0d081b8e::vault::withdraw<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v1 = MetastableSwapEvent{
            amount_in    : 0x2::coin::value<T0>(&arg3),
            amount_out   : 0x2::coin::value<T1>(&v0),
            a2b          : false,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<MetastableSwapEvent>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

