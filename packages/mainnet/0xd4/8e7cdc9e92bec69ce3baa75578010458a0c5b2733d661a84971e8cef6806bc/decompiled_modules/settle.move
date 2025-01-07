module 0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::settle {
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

    public fun settle<T0, T1>(arg0: &0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::config::Config, arg1: u64, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: 0x1::option::Option<0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::commission::Commission>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0x1::option::none<address>();
        if (0x1::option::is_some<0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::commission::Commission>(&arg5)) {
            let v3 = 0x1::option::destroy_some<0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::commission::Commission>(arg5);
            let (v4, v5, v6) = 0xd48e7cdc9e92bec69ce3baa75578010458a0c5b2733d661a84971e8cef6806bc::commission::take_commision<T1>(arg2, arg0, &v3, arg6);
            v2 = 0x1::option::some<address>(v4);
            v0 = v5;
            v1 = v6;
        };
        let v7 = 0x2::coin::value<T1>(arg2);
        assert!(v7 >= arg3, 0);
        let v8 = Swap{
            sender              : 0x2::tx_context::sender(arg6),
            partner             : v2,
            coin_in             : 0x1::type_name::get<T0>(),
            coin_out            : 0x1::type_name::get<T1>(),
            amount_in           : arg1,
            amount_out          : v7,
            amount_out_min      : arg3,
            amount_out_expected : arg4,
            fee_amount_protocol : v0,
            fee_amount_partner  : v1,
        };
        0x2::event::emit<Swap>(v8);
    }

    // decompiled from Move bytecode v6
}

