module 0x73cd40a8c00b7006aaa6bce853042ac84a17c59d02cc3832e1d8d6b6ffc505b9::h {
    struct H has key {
        id: 0x2::object::UID,
        w: address,
    }

    public entry fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = H{
            id : 0x2::object::new(arg0),
            w  : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<H>(v0);
    }

    public entry fun chg(arg0: &mut H, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.w, 202);
        arg0.w = arg1;
    }

    public entry fun new_for(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = H{
            id : 0x2::object::new(arg1),
            w  : arg0,
        };
        0x2::transfer::share_object<H>(v0);
    }

    public fun o(arg0: &H) : address {
        arg0.w
    }

    public fun out<T0>(arg0: &H, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::tx_context::sender(arg3) == arg0.w, 202);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::withdraw<T0>(arg1, arg2, arg3)
    }

    public fun put<T0>(arg0: &H, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.w, 202);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, arg2, arg3);
    }

    public fun put_min<T0>(arg0: &H, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::BalanceManager, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.w, 202);
        assert!(0x2::coin::value<T0>(&arg2) >= arg3, 400);
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::balance_manager::deposit<T0>(arg1, arg2, arg4);
    }

    // decompiled from Move bytecode v7
}

