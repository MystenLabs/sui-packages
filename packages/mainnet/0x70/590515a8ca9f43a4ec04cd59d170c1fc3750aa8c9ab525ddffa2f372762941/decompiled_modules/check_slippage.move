module 0x70590515a8ca9f43a4ec04cd59d170c1fc3750aa8c9ab525ddffa2f372762941::check_slippage {
    struct CheckSlippage has copy, drop {
        sender: address,
        token_in: 0x1::ascii::String,
        amount_in: u64,
        token_out: 0x1::ascii::String,
        amount_out_min: u64,
        expect_amount_out: u64,
        actually_amount_out: u64,
        token_fee: 0x1::ascii::String,
        fee_amount: u64,
    }

    public fun check_slippage<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) {
        assert!(0x2::coin::value<T0>(arg0) >= arg1, 1);
    }

    public fun check_slippage_and_type<T0>(arg0: &0x2::coin::Coin<T0>, arg1: 0x1::ascii::String, arg2: u64) {
        assert!(arg1 == 0x1::type_name::into_string(0x1::type_name::get<T0>()), 0);
        assert!(0x2::coin::value<T0>(arg0) >= arg2, 1);
    }

    public fun check_slippage_v2<T0>(arg0: 0x1::ascii::String, arg1: u64, arg2: &0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: 0x1::ascii::String, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(arg2) >= arg3, 1);
        let v0 = CheckSlippage{
            sender              : 0x2::tx_context::sender(arg7),
            token_in            : arg0,
            amount_in           : arg1,
            token_out           : 0x1::type_name::into_string(0x1::type_name::get<T0>()),
            amount_out_min      : arg3,
            expect_amount_out   : arg4,
            actually_amount_out : 0x2::coin::value<T0>(arg2),
            token_fee           : arg5,
            fee_amount          : arg6,
        };
        0x2::event::emit<CheckSlippage>(v0);
    }

    public fun cut_remainder(arg0: u64, arg1: u64) : u64 {
        arg1 - arg1 % arg0
    }

    // decompiled from Move bytecode v6
}

