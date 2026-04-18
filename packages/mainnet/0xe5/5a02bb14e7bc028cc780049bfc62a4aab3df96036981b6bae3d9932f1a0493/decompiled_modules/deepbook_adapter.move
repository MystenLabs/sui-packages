module 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::deepbook_adapter {
    struct DeepBookPool<phantom T0> has key {
        id: 0x2::object::UID,
        margin_pool_id: 0x2::object::ID,
        referral_id: 0x2::object::ID,
    }

    struct DeepBookPosition<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        supplier_cap: 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap,
        referral_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        deposited: u64,
    }

    public fun user_supply_shares<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &DeepBookPosition<T0>) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_shares<T0>(arg0, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(&arg1.supplier_cap))
    }

    public fun withdraw<T0>(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::RebalancerCap, arg1: &mut 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::Config, arg2: &mut 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::StrategyVault, arg3: &mut 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::pool_registry::PoolRegistry, arg4: &DeepBookPool<T0>, arg5: &mut DeepBookPosition<T0>, arg6: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg7: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::assert_not_paused(arg1);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::assert_version(arg1);
        assert!(arg8 > 0, 600);
        assert_position_match<T0>(arg5, arg2, arg6);
        let v0 = 0x2::object::id<DeepBookPool<T0>>(arg4);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::pool_registry::assert_pool_enabled<T0>(arg3, 0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v0)));
        let v1 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_amount<T0>(arg6, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(&arg5.supplier_cap), arg9);
        assert!(arg8 <= v1, 606);
        let v2 = (((arg5.deposited as u128) * (arg8 as u128) / (v1 as u128)) as u64);
        let v3 = 0x2::coin::into_balance<T0>(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw<T0>(arg6, arg7, &arg5.supplier_cap, 0x1::option::some<u64>(arg8), arg9, arg10));
        let v4 = 0x2::balance::value<T0>(&v3);
        let v5 = if (v4 > v2) {
            v4 - v2
        } else {
            0
        };
        let v6 = if (v5 > 0) {
            0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::deduct_fee_on_yield<T0>(arg1, &mut v3, v5)
        } else {
            0
        };
        if (v5 > v6) {
            0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::add_yield<T0>(arg2, 0x2::balance::split<T0>(&mut v3, v5 - v6));
        };
        0x2::balance::join<T0>(0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::borrow_balance_mut<T0>(arg2), v3);
        arg5.deposited = arg5.deposited - v2;
        let v7 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg6);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::events::emit_withdrawn(0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v7)), 0x2::object::id_address<0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::StrategyVault>(arg2), arg8, v6, 0x2::clock::timestamp_ms(arg9));
    }

    fun assert_position_match<T0>(arg0: &DeepBookPosition<T0>, arg1: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::StrategyVault, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>) {
        assert!(arg0.vault_id == 0x2::object::id<0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::StrategyVault>(arg1), 605);
        assert!(arg0.margin_pool_id == 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg2), 604);
    }

    public fun claim_referral_fees<T0>(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::AdminCap, arg1: &mut 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::Config, arg2: &DeepBookPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::protocol_fees::SupplyReferral, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.margin_pool_id == 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg3), 604);
        assert!(0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::protocol_fees::SupplyReferral>(arg5) == arg2.referral_id, 604);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw_referral_fees<T0>(arg3, arg4, arg5, arg7);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::add_fee<T0>(arg1, 0x2::coin::into_balance<T0>(v0));
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::events::emit_referral_fees_collected(0x1::string::utf8(b"deepbook"), 0x2::object::id<DeepBookPool<T0>>(arg2), 0x2::coin::value<T0>(&v0), 0x2::clock::timestamp_ms(arg6));
    }

    public fun create_pool<T0>(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::AdminCap, arg1: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::Config, arg2: &mut 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::pool_registry::PoolRegistry, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::assert_not_paused(arg1);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::assert_version(arg1);
        let v0 = DeepBookPool<T0>{
            id             : 0x2::object::new(arg6),
            margin_pool_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg3),
            referral_id    : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supply_referral<T0>(arg3, arg4, arg5, arg6),
        };
        let v1 = 0x2::object::id<DeepBookPool<T0>>(&v0);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::pool_registry::register_pool<T0>(arg0, arg2, 0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v1)));
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::events::emit_pool_created(0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v1)), 0x1::type_name::with_defining_ids<T0>());
        0x2::transfer::share_object<DeepBookPool<T0>>(v0);
    }

    public fun deposit<T0>(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::RebalancerCap, arg1: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::Config, arg2: &mut 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::StrategyVault, arg3: &mut 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::pool_registry::PoolRegistry, arg4: &DeepBookPool<T0>, arg5: &mut DeepBookPosition<T0>, arg6: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg7: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::assert_not_paused(arg1);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::assert_version(arg1);
        assert!(arg8 > 0, 600);
        assert_position_match<T0>(arg5, arg2, arg6);
        let v0 = 0x2::object::id<DeepBookPool<T0>>(arg4);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::pool_registry::assert_pool_enabled<T0>(arg3, 0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v0)));
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply<T0>(arg6, arg7, &arg5.supplier_cap, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::borrow_balance_mut<T0>(arg2), arg8), arg10), 0x1::option::some<0x2::object::ID>(arg5.referral_id), arg9);
        arg5.deposited = arg5.deposited + arg8;
        let v1 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg6);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::events::emit_deposited(0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v1)), 0x2::object::id_address<0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::StrategyVault>(arg2), arg8, 0x2::clock::timestamp_ms(arg9));
    }

    public fun deposited_amount<T0>(arg0: &DeepBookPosition<T0>) : u64 {
        arg0.deposited
    }

    fun id_to_string(arg0: &0x2::object::ID) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::object::id_to_address(arg0)));
        v0
    }

    public fun init_position<T0>(arg0: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::AdminCap, arg1: &0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::Config, arg2: &mut 0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::StrategyVault, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::assert_not_paused(arg1);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::config::assert_version(arg1);
        let v0 = DeepBookPosition<T0>{
            id             : 0x2::object::new(arg6),
            vault_id       : 0x2::object::id<0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::StrategyVault>(arg2),
            supplier_cap   : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supplier_cap(arg4, arg5, arg6),
            referral_id    : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supply_referral<T0>(arg3, arg4, arg5, arg6),
            margin_pool_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg3),
            deposited      : 0,
        };
        let v1 = 0x2::object::id<DeepBookPosition<T0>>(&v0);
        let v2 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg3);
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::register_position(arg2, 0x1::string::utf8(b"deepbook"), v1, 0x1::option::some<0x1::string::String>(id_to_string(&v2)));
        0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::events::emit_position_created(0x1::string::utf8(b"deepbook"), 0x2::object::id<0xe55a02bb14e7bc028cc780049bfc62a4aab3df96036981b6bae3d9932f1a0493::vault::StrategyVault>(arg2), v1, 0x2::tx_context::sender(arg6));
        0x2::transfer::share_object<DeepBookPosition<T0>>(v0);
    }

    public fun is_healthy<T0>(arg0: &DeepBookPosition<T0>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x2::clock::Clock) : bool {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_amount<T0>(arg1, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(&arg0.supplier_cap), arg2) >= arg0.deposited
    }

    public fun margin_pool_id<T0>(arg0: &DeepBookPool<T0>) : 0x2::object::ID {
        arg0.margin_pool_id
    }

    public fun pool_id<T0>(arg0: &DeepBookPool<T0>) : 0x2::object::ID {
        0x2::object::id<DeepBookPool<T0>>(arg0)
    }

    public fun position_vault_id<T0>(arg0: &DeepBookPosition<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun referral_id<T0>(arg0: &DeepBookPool<T0>) : 0x2::object::ID {
        arg0.referral_id
    }

    public fun supply_amount<T0>(arg0: &DeepBookPosition<T0>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x2::clock::Clock) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_amount<T0>(arg1, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(&arg0.supplier_cap), arg2)
    }

    // decompiled from Move bytecode v6
}

