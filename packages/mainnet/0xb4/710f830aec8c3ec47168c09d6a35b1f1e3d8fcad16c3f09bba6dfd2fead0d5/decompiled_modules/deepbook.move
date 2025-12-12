module 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::deepbook {
    struct DEEPBOOK has drop {
        dummy_field: bool,
    }

    struct SponsoredDeepAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DeepPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
    }

    struct DeepbookSwapEvent has copy, drop, store {
        base_asset: 0x1::type_name::TypeName,
        quote_asset: 0x1::type_name::TypeName,
        base_in_amount: u64,
        quote_in_amount: u64,
    }

    public fun swap_exact_quantity<T0, T1, T2, T3>(arg0: &mut 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::Payload<T2, T3>, arg1: &mut DeepPool, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        let v2 = 0x2::balance::zero<T0>();
        let v3 = 0x2::balance::zero<T1>();
        if (arg3) {
            0x2::balance::join<T0>(&mut v0, 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::take_next<T2, T3, T0>(arg0));
        } else {
            0x2::balance::join<T1>(&mut v1, 0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::take_next<T2, T3, T1>(arg0));
        };
        let v4 = 0x2::balance::value<T0>(&v0);
        let v5 = 0x2::balance::value<T1>(&v1);
        let (_, _, v8) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg2, v4, v5, arg4);
        let v9 = if (0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1.balance) >= v8) {
            0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, v8), arg5)
        } else {
            0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5)
        };
        let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg2, 0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::from_balance<T1>(v1, arg5), v9, 0, arg4, arg5);
        let v13 = v12;
        let v14 = v11;
        let v15 = v10;
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v13) > 0) {
            0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v13));
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v13);
        };
        if (arg3) {
            0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::place_next<T2, T3, T1>(arg0, 0x2::coin::into_balance<T1>(v14));
            if (0x2::coin::value<T0>(&v15) == 0) {
                0x2::coin::destroy_zero<T0>(v15);
            } else {
                0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(v15));
            };
        } else {
            0xbe0365cd0d19561da05ab5cc70d6b974d8b43e0163e6898353afd8f6efc45e81::checkpoint::place_next<T2, T3, T0>(arg0, 0x2::coin::into_balance<T0>(v15));
            if (0x2::coin::value<T1>(&v14) == 0) {
                0x2::coin::destroy_zero<T1>(v14);
            } else {
                0x2::balance::join<T1>(&mut v3, 0x2::coin::into_balance<T1>(v14));
            };
        };
        let v16 = DeepbookSwapEvent{
            base_asset      : 0x1::type_name::get<T0>(),
            quote_asset     : 0x1::type_name::get<T1>(),
            base_in_amount  : v4,
            quote_in_amount : v5,
        };
        0x2::event::emit<DeepbookSwapEvent>(v16);
        (v2, v3)
    }

    public fun deposit_deep(arg0: &mut DeepPool, arg1: &SponsoredDeepAdminCap, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2));
    }

    fun init(arg0: DEEPBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepPool{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
        };
        let v1 = SponsoredDeepAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<DeepPool>(v0);
        0x2::transfer::public_transfer<SponsoredDeepAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun withdraw_deep(arg0: &mut DeepPool, arg1: &SponsoredDeepAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

