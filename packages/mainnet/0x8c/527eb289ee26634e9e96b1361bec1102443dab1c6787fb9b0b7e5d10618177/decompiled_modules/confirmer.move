module 0x8c527eb289ee26634e9e96b1361bec1102443dab1c6787fb9b0b7e5d10618177::confirmer {
    struct ConfirmCert<phantom T0> {
        pay_balance: 0x2::balance::Balance<T0>,
    }

    struct SwapEvent has copy, drop, store {
        from: 0x1::type_name::TypeName,
        target: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
    }

    public fun confirm<T0, T1>(arg0: ConfirmCert<T1>, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let ConfirmCert { pay_balance: v0 } = arg0;
        assert!(0x2::balance::value<T1>(&v0) == arg2, incorrect_amount());
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v0, arg4), arg3);
        let v1 = SwapEvent{
            from       : 0x1::type_name::get<T0>(),
            target     : 0x1::type_name::get<T1>(),
            amount_in  : arg1,
            amount_out : arg2,
        };
        0x2::event::emit<SwapEvent>(v1);
    }

    public fun incorrect_amount() : u64 {
        abort 1
    }

    public fun new_confirm_cert<T0>(arg0: 0x2::balance::Balance<T0>) : ConfirmCert<T0> {
        ConfirmCert<T0>{pay_balance: arg0}
    }

    // decompiled from Move bytecode v6
}

