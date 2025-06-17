module 0xb6c53c9d7d6948c12ed9b0b62e6c937e206cc508fbb076f356769d20ff580ea9::deep_vault {
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

    struct SponsoredFeeRecord has copy, drop {
        pool_id: 0x2::object::ID,
        fee_amount: u64,
    }

    struct WhitelistPoolRecord has copy, drop {
        pool_id: 0x2::object::ID,
        whitelist: bool,
    }

    public fun add_whitelist(arg0: &0xb6c53c9d7d6948c12ed9b0b62e6c937e206cc508fbb076f356769d20ff580ea9::admin_cap::AdminCap, arg1: &mut DeepVault, arg2: 0x2::object::ID) {
        0x2::table::add<0x2::object::ID, bool>(&mut arg1.whitelist, arg2, true);
        let v0 = WhitelistPoolRecord{
            pool_id   : arg2,
            whitelist : true,
        };
        0x2::event::emit<WhitelistPoolRecord>(v0);
    }

    public fun deepbook_swap_base_to_quote_sponsored_with_return<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut DeepVault, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, u64) {
        assert!(arg3 > 0, 2);
        let v0 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0);
        assert!(is_whitelisted(arg1, v0), 0);
        let (_, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quote_quantity_out<T0, T1>(arg0, 0x2::coin::value<T0>(&arg2), arg5);
        assert!(v3 <= arg4, 4);
        assert!(v2 >= arg3, 3);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1.balance) >= v3, 1);
        let v4 = SponsoredFeeRecord{
            pool_id    : v0,
            fee_amount : v3,
        };
        0x2::event::emit<SponsoredFeeRecord>(v4);
        let (v5, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_base_for_quote<T0, T1>(arg0, arg2, 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, v3), arg6), arg3, arg5, arg6);
        let v8 = v6;
        let v9 = 0x2::coin::value<T1>(&v8);
        destroy_or_transfer<T0>(v5, arg6);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
        let v10 = HopRecord{out_amount: v9};
        0x2::event::emit<HopRecord>(v10);
        (v8, v9)
    }

    public fun deepbook_swap_quote_to_base_sponsored_with_return<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: &mut DeepVault, arg2: 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, u64) {
        assert!(arg3 > 0, 2);
        let v0 = 0x2::object::id<0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>>(arg0);
        assert!(is_whitelisted(arg1, v0), 0);
        let (v1, _, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out<T0, T1>(arg0, 0x2::coin::value<T1>(&arg2), arg5);
        assert!(v3 <= arg4, 4);
        assert!(0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1.balance) >= v3, 1);
        assert!(v1 >= arg3, 3);
        let v4 = SponsoredFeeRecord{
            pool_id    : v0,
            fee_amount : v3,
        };
        0x2::event::emit<SponsoredFeeRecord>(v4);
        let (v5, v6, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quote_for_base<T0, T1>(arg0, arg2, 0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, v3), arg6), arg3, arg5, arg6);
        let v8 = v5;
        let v9 = 0x2::coin::value<T0>(&v8);
        destroy_or_transfer<T1>(v6, arg6);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v7);
        let v10 = HopRecord{out_amount: v9};
        0x2::event::emit<HopRecord>(v10);
        (v8, v9)
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

    public fun remove_whitelist(arg0: &0xb6c53c9d7d6948c12ed9b0b62e6c937e206cc508fbb076f356769d20ff580ea9::admin_cap::AdminCap, arg1: &mut DeepVault, arg2: 0x2::object::ID) {
        if (!is_whitelisted(arg1, arg2)) {
            return
        };
        0x2::table::remove<0x2::object::ID, bool>(&mut arg1.whitelist, arg2);
        let v0 = WhitelistPoolRecord{
            pool_id   : arg2,
            whitelist : false,
        };
        0x2::event::emit<WhitelistPoolRecord>(v0);
    }

    public fun withdraw_deep(arg0: &SponsoredDeepAdminCap, arg1: &mut DeepVault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

