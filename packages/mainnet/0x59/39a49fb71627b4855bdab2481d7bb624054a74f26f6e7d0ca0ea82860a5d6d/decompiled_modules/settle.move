module 0x5939a49fb71627b4855bdab2481d7bb624054a74f26f6e7d0ca0ea82860a5d6d::settle {
    struct Swap has copy, drop {
        sender: address,
        partner: 0x1::option::Option<address>,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        amount_out_min: u64,
        amount_out_expected: u64,
        fee_amount: u64,
    }

    public fun settle<T0, T1>(arg0: u64, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: u64, arg4: 0x1::option::Option<address>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        if (0x1::option::is_some<address>(&arg4)) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::split<T1>(arg1, v0, arg5), 0x1::option::destroy_some<address>(arg4));
        };
        let v1 = 0x2::coin::value<T1>(arg1);
        assert!(v1 >= arg2, 1);
        let v2 = Swap{
            sender              : 0x2::tx_context::sender(arg5),
            partner             : arg4,
            coin_in             : 0x1::type_name::get<T0>(),
            coin_out            : 0x1::type_name::get<T1>(),
            amount_in           : arg0,
            amount_out          : v1,
            amount_out_min      : arg2,
            amount_out_expected : arg3,
            fee_amount          : v0,
        };
        0x2::event::emit<Swap>(v2);
    }

    public fun check_slippage<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun check_slippage_and_type<T0>(arg0: &0x2::coin::Coin<T0>, arg1: 0x1::ascii::String, arg2: u64) {
        assert!(arg1 == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0);
        assert!(0x2::coin::value<T0>(arg0) >= arg2, 1);
    }

    // decompiled from Move bytecode v6
}

