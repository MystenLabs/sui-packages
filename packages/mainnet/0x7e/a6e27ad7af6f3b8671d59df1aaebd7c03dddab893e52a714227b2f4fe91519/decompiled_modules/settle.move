module 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::settle {
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

    public fun settle<T0, T1>(arg0: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::Config, arg1: &mut 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault::Vault, arg2: u64, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: 0x1::option::Option<address>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::check_version(arg0);
        let v0 = 0;
        let v1 = 0;
        if (0x2::coin::value<T1>(arg3) > arg5 && !0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::allow_positive_slippage(arg0)) {
            0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault::collect<T1>(arg1, 0x2::coin::split<T1>(arg3, 0x2::coin::value<T1>(arg3) - arg5, arg8), 1);
        };
        if (0x1::option::is_some<address>(&arg6)) {
            let (v2, v3) = take_commision<T1>(arg3, arg0, arg1, 0x1::option::destroy_some<address>(arg6), arg7, arg8);
            v1 = v3;
            v0 = v2;
        };
        let v4 = 0x2::coin::value<T1>(arg3);
        assert!(v4 >= arg4, 0);
        let v5 = Swap{
            sender              : 0x2::tx_context::sender(arg8),
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

    fun take_commision<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: &0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::Config, arg2: &mut 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault::Vault, arg3: address, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        if (arg4 == 0) {
            return (0, 0)
        };
        assert!(arg4 <= 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::max_commission_bps(arg1), 1);
        let v0 = 0x2::coin::value<T0>(arg0) * arg4 / 10000;
        let v1 = v0 * 0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::config::protocol_fee_bps(arg1) / 10000;
        let v2 = v0 - v1;
        0x7ea6e27ad7af6f3b8671d59df1aaebd7c03dddab893e52a714227b2f4fe91519::vault::collect<T0>(arg2, 0x2::coin::split<T0>(arg0, v1, arg5), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, v2, arg5), arg3);
        (v1, v2)
    }

    // decompiled from Move bytecode v6
}

