module 0x5b4dd326d191ad5ff9d7dfd3f135c676e26cb9ed4f96827e4bfaa680f4394163::d {
    struct Vault has key {
        id: 0x2::object::UID,
        deep: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        operators: vector<address>,
    }

    struct Loan {
        vault: 0x2::object::ID,
        amount: u64,
    }

    public fun borrow(arg0: &mut Vault, arg1: u64, arg2: &0x2::tx_context::TxContext) : (0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, Loan) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.operators, &v0), 3);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep) >= arg1, 2);
        let v1 = Loan{
            vault  : 0x2::object::id<Vault>(arg0),
            amount : arg1,
        };
        (0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, arg1), v1)
    }

    public fun new(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, arg0);
        let v1 = Vault{
            id        : 0x2::object::new(arg1),
            deep      : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            operators : v0,
        };
        0x2::transfer::share_object<Vault>(v1);
    }

    public fun add_operator(arg0: &mut Vault, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x1::vector::contains<address>(&arg0.operators, &v0), 3);
        if (!0x1::vector::contains<address>(&arg0.operators, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.operators, arg1);
        };
    }

    public fun available(arg0: &Vault) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.deep)
    }

    public fun deposit(arg0: &mut Vault, arg1: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, arg1);
    }

    public fun repay(arg0: &mut Vault, arg1: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: Loan) {
        let Loan {
            vault  : v0,
            amount : v1,
        } = arg2;
        assert!(0x2::object::id<Vault>(arg0) == v0, 1);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1) >= v1, 1);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.deep, arg1);
    }

    public fun sba<T0, T1>(arg0: &mut Vault, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1) = borrow(arg0, arg3, arg6);
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg1, 0x2::coin::from_balance<T0>(arg2, arg6), 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0, arg6), arg4, arg5, arg6);
        0x2::coin::destroy_zero<T0>(v2);
        repay(arg0, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4), v1);
        0x2::coin::into_balance<T1>(v3)
    }

    public fun sqb<T0, T1>(arg0: &mut Vault, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1) = borrow(arg0, arg3, arg6);
        let (v2, v3, v4) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg1, 0x2::coin::from_balance<T1>(arg2, arg6), 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v0, arg6), arg4, arg5, arg6);
        0x2::coin::destroy_zero<T1>(v3);
        repay(arg0, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v4), v1);
        0x2::coin::into_balance<T0>(v2)
    }

    // decompiled from Move bytecode v7
}

