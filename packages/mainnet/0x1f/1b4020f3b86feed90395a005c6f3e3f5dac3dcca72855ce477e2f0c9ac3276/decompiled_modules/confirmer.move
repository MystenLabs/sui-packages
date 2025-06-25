module 0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::confirmer {
    struct SwapCert<phantom T0, phantom T1> {
        quote_id: 0x1::string::String,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
        recipient: address,
        input: 0x1::option::Option<0x2::coin::Coin<T0>>,
    }

    struct SwapEvent has copy, drop {
        quote_id: 0x1::string::String,
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        fee_amount: u64,
    }

    public fun destroy_swap_cert<T0, T1>(arg0: SwapCert<T0, T1>, arg1: &mut 0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::fee_tier::FeeTier, arg2: 0x2::balance::Balance<T1>, arg3: &0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::versioned::Versioned, arg4: &mut 0x2::tx_context::TxContext) {
        0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::versioned::check_version(arg3);
        let SwapCert {
            quote_id   : v0,
            amount_in  : v1,
            amount_out : v2,
            fee_amount : v3,
            recipient  : v4,
            input      : v5,
        } = arg0;
        0x1::option::destroy_none<0x2::coin::Coin<T0>>(v5);
        assert!(0x2::balance::value<T1>(&arg2) == v2 + v3, 0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::errors::err_incorrect_amount_out());
        if (v3 > 0) {
            0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::fee_tier::receive_fee<T1>(arg1, 0x2::balance::split<T1>(&mut arg2, v3));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(arg2, arg4), v4);
        let v6 = SwapEvent{
            quote_id   : v0,
            from       : 0x1::type_name::get<T0>(),
            target     : 0x1::type_name::get<T1>(),
            amount_in  : v1,
            amount_out : v2,
            fee_amount : v3,
        };
        0x2::event::emit<SwapEvent>(v6);
    }

    public fun get_quote_id<T0, T1>(arg0: &SwapCert<T0, T1>) : 0x1::string::String {
        arg0.quote_id
    }

    public fun new_swap_cert<T0, T1>(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::fee_tier::FeeTier, arg5: &0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::versioned::Versioned, arg6: &0x2::tx_context::TxContext) : SwapCert<T0, T1> {
        0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::versioned::check_version(arg5);
        assert!(arg1 > 0, 0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::errors::err_incorrect_amount_in());
        assert!(arg2 > 0, 0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::errors::err_incorrect_amount_out());
        assert!(0x2::coin::value<T0>(&arg3) == arg1, 0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::errors::err_incorrect_amount_in());
        let v0 = 0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::fee_tier::fee_amount<T0, T1>(arg4, arg2);
        SwapCert<T0, T1>{
            quote_id   : arg0,
            amount_in  : arg1,
            amount_out : arg2 - v0,
            fee_amount : v0,
            recipient  : 0x2::tx_context::sender(arg6),
            input      : 0x1::option::some<0x2::coin::Coin<T0>>(arg3),
        }
    }

    public fun take_input_coin<T0, T1>(arg0: &mut SwapCert<T0, T1>, arg1: &0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::versioned::Versioned) : 0x2::coin::Coin<T0> {
        0x1f1b4020f3b86feed90395a005c6f3e3f5dac3dcca72855ce477e2f0c9ac3276::versioned::check_version(arg1);
        0x1::option::extract<0x2::coin::Coin<T0>>(&mut arg0.input)
    }

    // decompiled from Move bytecode v6
}

