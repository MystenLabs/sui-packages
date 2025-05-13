module 0x648521c65ab60d3e2f33fa3e461d3ffc6084f228d9f926a338d13b25c0b714f1::deep_vault {
    struct SponsoredDeepAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DeepVault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
        whitelist: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct HopRecord has copy, drop {
        out_amount: u64,
    }

    struct ActualFeeUsedRecord has copy, drop {
        pool_id: 0x2::object::ID,
        estimated_fee: u64,
        actual_fee: u64,
    }

    struct SponsoredFeeRecord has copy, drop {
        pool_id: 0x2::object::ID,
        fee_amount: u64,
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut DeepVault, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        let v0 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0);
        assert!(is_whitelisted(arg1, v0), 1);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, 0x2::coin::value<T0>(&arg2), arg4);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1.balance) >= v3, 2);
        let (v4, v5, v6) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, arg2, 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, v3), arg5), arg3, arg4, arg5);
        let v7 = v6;
        let v8 = v5;
        let v9 = 0x2::coin::value<T1>(&v8);
        destroy_or_transfer<T0>(v4, arg5);
        let v10 = 0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v7);
        if (v10 > 0) {
            0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7));
            let v11 = ActualFeeUsedRecord{
                pool_id       : v0,
                estimated_fee : v3,
                actual_fee    : v3 - v10,
            };
            0x2::event::emit<ActualFeeUsedRecord>(v11);
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
            let v12 = ActualFeeUsedRecord{
                pool_id       : v0,
                estimated_fee : v3,
                actual_fee    : v3,
            };
            0x2::event::emit<ActualFeeUsedRecord>(v12);
        };
        let v13 = HopRecord{out_amount: v9};
        0x2::event::emit<HopRecord>(v13);
        (v8, v9)
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut DeepVault, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        let v0 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0);
        assert!(is_whitelisted(arg1, v0), 1);
        let (_, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, 0x2::coin::value<T1>(&arg2), arg4);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1.balance) >= v3, 2);
        let v4 = SponsoredFeeRecord{
            pool_id    : v0,
            fee_amount : v3,
        };
        0x2::event::emit<SponsoredFeeRecord>(v4);
        let (v5, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, arg2, 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, v3), arg5), arg3, arg4, arg5);
        let v8 = v7;
        let v9 = v5;
        let v10 = 0x2::coin::value<T0>(&v9);
        destroy_or_transfer<T1>(v6, arg5);
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v8) == 0, 0);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v8);
        let v11 = HopRecord{out_amount: v10};
        0x2::event::emit<HopRecord>(v11);
        (v9, v10)
    }

    public fun add_whitelist(arg0: &0x648521c65ab60d3e2f33fa3e461d3ffc6084f228d9f926a338d13b25c0b714f1::admin_cap::AdminCap, arg1: &mut DeepVault, arg2: 0x2::object::ID, arg3: bool) {
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.whitelist, arg2, arg3);
    }

    public fun deposit_deep(arg0: &SponsoredDeepAdminCap, arg1: &mut DeepVault, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2));
    }

    fun destroy_or_transfer<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        };
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

    public fun remove_whitelist(arg0: &0x648521c65ab60d3e2f33fa3e461d3ffc6084f228d9f926a338d13b25c0b714f1::admin_cap::AdminCap, arg1: &mut DeepVault, arg2: 0x2::object::ID) {
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

