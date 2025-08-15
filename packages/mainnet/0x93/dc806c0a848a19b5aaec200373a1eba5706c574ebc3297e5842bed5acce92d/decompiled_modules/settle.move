module 0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::settle {
    struct Swap has copy, drop {
        sender: address,
        partner: 0x1::option::Option<address>,
        coin_in: 0x1::type_name::TypeName,
        coin_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        amount_out_min: u64,
        amount_out_expected: u64,
        fee_amount_protocol: u64,
        fee_amount_partner: u64,
    }

    public fun settle<T0, T1>(arg0: &0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::config::Config, arg1: &mut 0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::vault::Vault, arg2: u64, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::config::check_version(arg0);
        assert!(arg5 >= arg4, 1);
        let v0 = 0;
        let v1 = 0;
        if (0x1::option::is_some<address>(&arg6)) {
            let (v2, v3) = 0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::vault::take_commision<T1>(arg1, arg0, arg3, *0x1::option::borrow<address>(&arg6), arg7, arg9);
            v0 = v2;
            v1 = v3;
        };
        0x93dc806c0a848a19b5aaec200373a1eba5706c574ebc3297e5842bed5acce92d::vault::collect_slippage<T1>(arg1, arg0, arg3, arg5, arg8, arg9);
        let v4 = 0x2::coin::value<T1>(arg3);
        assert!(v4 >= arg4, 0);
        let v5 = Swap{
            sender              : 0x2::tx_context::sender(arg9),
            partner             : arg6,
            coin_in             : 0x1::type_name::get<T0>(),
            coin_out            : 0x1::type_name::get<T1>(),
            amount_in           : arg2,
            amount_out          : v4,
            amount_out_min      : arg4,
            amount_out_expected : arg5,
            fee_amount_protocol : v0,
            fee_amount_partner  : v1,
        };
        0x2::event::emit<Swap>(v5);
    }

    // decompiled from Move bytecode v6
}

