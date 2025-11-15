module 0x53d11ce1636c878bb19f3df4e493413b8b446fee80879f02090f12aca85a500f::signature {
    struct TylerSignatureEvent has copy, drop {
        amount: u64,
        min_amount: u64,
        slippage_ok: bool,
    }

    public entry fun tyler_is_quant<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    public entry fun tyler_is_quant_no_check<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
    }

    public entry fun tyler_is_quant_with_event<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        assert!(v0 >= arg1, 1);
        let v1 = TylerSignatureEvent{
            amount      : v0,
            min_amount  : arg1,
            slippage_ok : true,
        };
        0x2::event::emit<TylerSignatureEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg2);
    }

    // decompiled from Move bytecode v6
}

