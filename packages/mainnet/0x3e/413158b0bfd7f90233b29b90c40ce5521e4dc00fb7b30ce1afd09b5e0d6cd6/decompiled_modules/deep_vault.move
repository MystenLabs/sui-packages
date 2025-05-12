module 0x3e413158b0bfd7f90233b29b90c40ce5521e4dc00fb7b30ce1afd09b5e0d6cd6::deep_vault {
    struct SponsoredDeepAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DeepVault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        whitelist: 0x2::table::Table<0x2::object::ID, bool>,
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut DeepVault, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(is_whitelisted(arg1, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0)), 1);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, 0x2::coin::value<T0>(&arg2), arg4);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, arg2, 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, v2), arg5), arg3, arg4, arg5);
        let v6 = v5;
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v6) == 0, 0);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
        (v3, v4)
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut DeepVault, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        assert!(is_whitelisted(arg1, 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0)), 1);
        let (_, _, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, 0x2::coin::value<T1>(&arg2), arg4);
        let (v3, v4, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, arg2, 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, v2), arg5), arg3, arg4, arg5);
        let v6 = v5;
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v6) == 0, 0);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v6);
        (v3, v4)
    }

    public fun add_whitelist(arg0: &0x3e413158b0bfd7f90233b29b90c40ce5521e4dc00fb7b30ce1afd09b5e0d6cd6::admin_cap::AdminCap, arg1: &mut DeepVault, arg2: 0x2::object::ID, arg3: bool) {
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.whitelist, arg2, arg3);
    }

    public fun deposit_deep(arg0: &SponsoredDeepAdminCap, arg1: &mut DeepVault, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepVault{
            id        : 0x2::object::new(arg0),
            balance   : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
            whitelist : 0x2::table::new<0x2::object::ID, bool>(arg0),
        };
        let v1 = SponsoredDeepAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<DeepVault>(v0);
        0x2::transfer::public_transfer<SponsoredDeepAdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_whitelisted(arg0: &DeepVault, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, bool>(&arg0.whitelist, arg1)
    }

    public fun remove_whitelist(arg0: &0x3e413158b0bfd7f90233b29b90c40ce5521e4dc00fb7b30ce1afd09b5e0d6cd6::admin_cap::AdminCap, arg1: &mut DeepVault, arg2: 0x2::object::ID) {
        if (!is_whitelisted(arg1, arg2)) {
            return
        };
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.whitelist, arg2);
    }

    public fun withdraw_deep(arg0: &SponsoredDeepAdminCap, arg1: &mut DeepVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

