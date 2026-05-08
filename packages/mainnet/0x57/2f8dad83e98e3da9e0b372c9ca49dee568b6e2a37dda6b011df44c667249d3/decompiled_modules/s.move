module 0xcfe5da3a39b605d6b14de5c0456dc9ab30440643af0f6fdddf4b90c6a0a57a0b::s {
    struct F has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        whitelist: vector<address>,
        version: u32,
    }

    struct P has copy, drop, store {
        p: u64,
    }

    struct G has copy, drop, store {
        g: u64,
    }

    fun swap<T0, T1>(arg0: &mut F, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check_version(arg0);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg1, 0x2::coin::value<T0>(&arg2), 0x2::coin::value<T1>(&arg3), arg5);
        let v3 = if (0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance) >= v2) {
            0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, v2), arg6)
        } else {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6)
        };
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, arg2, arg3, v3, arg4, arg5, arg6);
        let v7 = v6;
        let v8 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v7);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7));
        check_whitelist(arg0, 0x2::tx_context::sender(arg6));
        if (v2 > 0) {
            let v9 = P{p: v2};
            0x2::event::emit<P>(v9);
        };
        if (v8 > 0) {
            let v10 = G{g: v8};
            0x2::event::emit<G>(v10);
        };
        (v4, v5)
    }

    public fun add_to_whitelist(arg0: &mut F, arg1: &0xcfe5da3a39b605d6b14de5c0456dc9ab30440643af0f6fdddf4b90c6a0a57a0b::admin::AdminCap, arg2: address) {
        0x1::vector::push_back<address>(&mut arg0.whitelist, arg2);
    }

    public fun bq<T0, T1>(arg0: &mut F, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T1>(arg5);
        swap<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public fun bump_version(arg0: &mut F, arg1: &0xcfe5da3a39b605d6b14de5c0456dc9ab30440643af0f6fdddf4b90c6a0a57a0b::admin::AdminCap) {
        arg0.version = arg0.version + 1;
        assert!(arg0.version <= 3, 130);
    }

    fun check_version(arg0: &F) {
        assert!(arg0.version <= 2, 130);
    }

    fun check_whitelist(arg0: &F, arg1: address) {
        assert!(0x1::vector::contains<address>(&arg0.whitelist, &arg1), 129);
    }

    public fun deposit(arg0: &mut F, arg1: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg1));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg0));
        let v1 = F{
            id        : 0x2::object::new(arg0),
            balance   : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            whitelist : v0,
            version   : 1,
        };
        0x2::transfer::share_object<F>(v1);
    }

    public fun last(arg0: &F) : u64 {
        0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance)
    }

    public fun nbq<T0, T1>(arg0: &mut F, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T1>(arg5);
        swap_n<T0, T1>(arg0, arg1, arg2, v0, arg3, arg4, arg5)
    }

    public fun nqb<T0, T1>(arg0: &mut F, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T0>(arg5);
        swap_n<T0, T1>(arg0, arg1, v0, arg2, arg3, arg4, arg5)
    }

    public fun qb<T0, T1>(arg0: &mut F, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::zero<T0>(arg5);
        swap<T0, T1>(arg0, arg1, v0, arg2, arg3, arg4, arg5)
    }

    public fun remove_from_whitelist(arg0: &mut F, arg1: &0xcfe5da3a39b605d6b14de5c0456dc9ab30440643af0f6fdddf4b90c6a0a57a0b::admin::AdminCap, arg2: address) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg0.whitelist, &arg2);
        assert!(v0, 129);
        0x1::vector::remove<address>(&mut arg0.whitelist, v1);
    }

    fun swap_n<T0, T1>(arg0: &mut F, arg1: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        check_version(arg0);
        let (v0, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg1, arg2, arg3, 0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6), arg4, arg5, arg6);
        let v3 = v2;
        let v4 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v3);
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v3));
        check_whitelist(arg0, 0x2::tx_context::sender(arg6));
        if (v4 > 0) {
            let v5 = G{g: v4};
            0x2::event::emit<G>(v5);
        };
        (v0, v1)
    }

    public fun withdraw(arg0: &mut F, arg1: &0xcfe5da3a39b605d6b14de5c0456dc9ab30440643af0f6fdddf4b90c6a0a57a0b::admin::AdminCap, arg2: 0x1::option::Option<u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, 0x1::option::destroy_with_default<u64>(arg2, 0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg0.balance))), arg3)
    }

    // decompiled from Move bytecode v7
}

