module 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::yield_basket {
    struct AssetPotKey has copy, drop, store {
        asset: 0x1::type_name::TypeName,
    }

    struct AssetPot<phantom T0> has store {
        bal: 0x2::balance::Balance<T0>,
    }

    struct PushDistributeKey has copy, drop, store {
        dummy_field: bool,
    }

    struct YieldBasketVault<phantom T0, phantom T1> has key {
        id: 0x2::object::UID,
        version: u64,
        lock_id: 0x2::object::ID,
        bluefin_pool_id: 0x2::object::ID,
        config: 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::basket_yield::BasketConfig,
        quote_staging: 0x2::balance::Balance<T1>,
    }

    public fun assert_bound_to_lock<T0, T1>(arg0: &YieldBasketVault<T0, T1>, arg1: 0x2::object::ID) {
        check<T0, T1>(arg0);
        assert!(arg0.lock_id == arg1, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::wrong_basket());
    }

    public fun bluefin_pool_id<T0, T1>(arg0: &YieldBasketVault<T0, T1>) : 0x2::object::ID {
        arg0.bluefin_pool_id
    }

    fun check<T0, T1>(arg0: &YieldBasketVault<T0, T1>) {
        assert!(arg0.version == 1, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::retired());
    }

    public(friend) fun create_and_share<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::basket_yield::BasketConfig, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::basket_yield::validate_config(&arg2);
        let v0 = YieldBasketVault<T0, T1>{
            id              : 0x2::object::new(arg3),
            version         : 1,
            lock_id         : arg0,
            bluefin_pool_id : arg1,
            config          : arg2,
            quote_staging   : 0x2::balance::zero<T1>(),
        };
        let v1 = PushDistributeKey{dummy_field: false};
        0x2::dynamic_field::add<PushDistributeKey, bool>(&mut v0.id, v1, true);
        0x2::transfer::share_object<YieldBasketVault<T0, T1>>(v0);
        0x2::object::id<YieldBasketVault<T0, T1>>(&v0)
    }

    public fun deposit_converted_asset<T0, T1, T2>(arg0: &mut YieldBasketVault<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: &0x2::clock::Clock) {
        check<T0, T1>(arg0);
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::basket_yield::assert_asset_in_config(&arg0.config, v0);
        let v1 = 0x2::coin::value<T2>(&arg1);
        assert!(v1 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
        let v2 = AssetPotKey{asset: v0};
        if (!0x2::dynamic_field::exists_with_type<AssetPotKey, AssetPot<T2>>(&arg0.id, v2)) {
            let v3 = AssetPot<T2>{bal: 0x2::balance::zero<T2>()};
            0x2::dynamic_field::add<AssetPotKey, AssetPot<T2>>(&mut arg0.id, v2, v3);
        };
        0x2::balance::join<T2>(&mut 0x2::dynamic_field::borrow_mut<AssetPotKey, AssetPot<T2>>(&mut arg0.id, v2).bal, 0x2::coin::into_balance<T2>(arg1));
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_basket_yield_converted(arg0.lock_id, 0x2::object::id<YieldBasketVault<T0, T1>>(arg0), 0x1::type_name::with_defining_ids<T1>(), arg2, v0, v1, 0x2::clock::timestamp_ms(arg3));
    }

    public fun lock_id<T0, T1>(arg0: &YieldBasketVault<T0, T1>) : 0x2::object::ID {
        arg0.lock_id
    }

    public fun push_payout<T0, T1, T2>(arg0: &mut YieldBasketVault<T0, T1>, arg1: &0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::AdminCap, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        check<T0, T1>(arg0);
        assert!(arg3 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_push());
        let v0 = 0x1::type_name::with_defining_ids<T2>();
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::basket_yield::assert_asset_in_config(&arg0.config, v0);
        let v1 = AssetPotKey{asset: v0};
        assert!(0x2::dynamic_field::exists_with_type<AssetPotKey, AssetPot<T2>>(&arg0.id, v1), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_push());
        let v2 = 0x2::dynamic_field::borrow_mut<AssetPotKey, AssetPot<T2>>(&mut arg0.id, v1);
        assert!(0x2::balance::value<T2>(&v2.bal) >= arg3, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::nothing_to_push());
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_basket_yield_push(arg0.lock_id, 0x2::object::id<YieldBasketVault<T0, T1>>(arg0), arg2, v0, arg3, 0x2::clock::timestamp_ms(arg4));
        0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(0x2::balance::split<T2>(&mut v2.bal, arg3), arg5), arg2);
    }

    public fun quote_staging_value<T0, T1>(arg0: &YieldBasketVault<T0, T1>) : u64 {
        0x2::balance::value<T1>(&arg0.quote_staging)
    }

    public fun take_quote_for_convert<T0, T1>(arg0: &mut YieldBasketVault<T0, T1>, arg1: &0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::config::AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        check<T0, T1>(arg0);
        assert!(arg2 > 0, 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::zero_amount());
        assert!(arg2 <= 0x2::balance::value<T1>(&arg0.quote_staging), 0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::errors::bad_param());
        0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.quote_staging, arg2), arg3)
    }

    public(friend) fun try_fund_quote<T0, T1>(arg0: &mut YieldBasketVault<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        check<T0, T1>(arg0);
        let v0 = 0x2::balance::value<T1>(&arg1);
        if (v0 == 0) {
            return arg1
        };
        0x2::balance::join<T1>(&mut arg0.quote_staging, arg1);
        0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::events::emit_basket_yield_funded(arg0.lock_id, 0x2::object::id<YieldBasketVault<T0, T1>>(arg0), arg0.bluefin_pool_id, 0x1::type_name::with_defining_ids<T1>(), v0, 0x2::clock::timestamp_ms(arg2));
        0x2::balance::zero<T1>()
    }

    public fun vault_config<T0, T1>(arg0: &YieldBasketVault<T0, T1>) : &0x5cfddf8ba23be6835644a8ea22482ff6ebb0081e42cc1bc052b5f770ca8bbdea::basket_yield::BasketConfig {
        &arg0.config
    }

    // decompiled from Move bytecode v7
}

