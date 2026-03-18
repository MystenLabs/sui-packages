module 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::deepbook_adapter {
    struct DeepBookPosition<phantom T0> has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
        supplier_cap: 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap,
        referral_id: 0x2::object::ID,
        margin_pool_id: 0x2::object::ID,
        deposited: u64,
    }

    fun assert_position_match<T0>(arg0: &DeepBookPosition<T0>, arg1: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>) {
        assert!(arg0.vault_id == 0x2::object::id<0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault>(arg1), 605);
        assert!(arg0.margin_pool_id == 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg2), 604);
    }

    public fun deposit<T0>(arg0: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::RebalancerCap, arg1: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::Config, arg2: &mut 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault, arg3: &mut DeepBookPosition<T0>, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_not_paused(arg1);
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_version(arg1);
        assert!(arg6 > 0, 600);
        assert_position_match<T0>(arg3, arg2, arg4);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply<T0>(arg4, arg5, &arg3.supplier_cap, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::borrow_balance_mut<T0>(arg2), arg6), arg8), 0x1::option::some<0x2::object::ID>(arg3.referral_id), arg7);
        arg3.deposited = arg3.deposited + arg6;
        let v0 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg4);
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::events::emit_deposited(0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v0)), 0x2::object::id_address<0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault>(arg2), arg6, 0x2::clock::timestamp_ms(arg7));
    }

    public fun deposited_amount<T0>(arg0: &DeepBookPosition<T0>) : u64 {
        arg0.deposited
    }

    fun id_to_string(arg0: &0x2::object::ID) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::object::id_to_address(arg0)));
        v0
    }

    public fun init_position<T0>(arg0: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::AdminCap, arg1: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::Config, arg2: &mut 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_not_paused(arg1);
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_version(arg1);
        let v0 = DeepBookPosition<T0>{
            id             : 0x2::object::new(arg6),
            vault_id       : 0x2::object::id<0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault>(arg2),
            supplier_cap   : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supplier_cap(arg4, arg5, arg6),
            referral_id    : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supply_referral<T0>(arg3, arg4, arg5, arg6),
            margin_pool_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg3),
            deposited      : 0,
        };
        let v1 = 0x2::object::id<DeepBookPosition<T0>>(&v0);
        let v2 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg3);
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::register_position(arg2, 0x1::string::utf8(b"deepbook"), v1, 0x1::option::some<0x1::string::String>(id_to_string(&v2)));
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::events::emit_position_created(0x1::string::utf8(b"deepbook"), 0x2::object::id<0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault>(arg2), v1, 0x2::tx_context::sender(arg6));
        0x2::transfer::share_object<DeepBookPosition<T0>>(v0);
    }

    public fun is_healthy<T0>(arg0: &DeepBookPosition<T0>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x2::clock::Clock) : bool {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_amount<T0>(arg1, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(&arg0.supplier_cap), arg2) >= arg0.deposited
    }

    public fun position_vault_id<T0>(arg0: &DeepBookPosition<T0>) : 0x2::object::ID {
        arg0.vault_id
    }

    public fun supply_amount<T0>(arg0: &DeepBookPosition<T0>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x2::clock::Clock) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_amount<T0>(arg1, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(&arg0.supplier_cap), arg2)
    }

    public fun withdraw<T0>(arg0: &0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::RebalancerCap, arg1: &mut 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::Config, arg2: &mut 0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault, arg3: &mut DeepBookPosition<T0>, arg4: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg5: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_not_paused(arg1);
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::assert_version(arg1);
        assert!(arg6 > 0, 600);
        assert_position_match<T0>(arg3, arg2, arg4);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_amount<T0>(arg4, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(&arg3.supplier_cap), arg7);
        assert!(arg6 <= v0, 606);
        let v1 = (((arg3.deposited as u128) * (arg6 as u128) / (v0 as u128)) as u64);
        let v2 = if (arg6 > v1) {
            arg6 - v1
        } else {
            0
        };
        let v3 = 0x2::coin::into_balance<T0>(0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw<T0>(arg4, arg5, &arg3.supplier_cap, 0x1::option::some<u64>(arg6), arg7, arg8));
        let v4 = if (v2 > 0) {
            0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::config::deduct_fee_on_yield<T0>(arg1, &mut v3, v2)
        } else {
            0
        };
        if (v2 > v4) {
            0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::add_yield<T0>(arg2, 0x2::balance::split<T0>(&mut v3, v2 - v4));
        };
        0x2::balance::join<T0>(0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::borrow_balance_mut<T0>(arg2), v3);
        arg3.deposited = arg3.deposited - v1;
        let v5 = 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg4);
        0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::events::emit_withdrawn(0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v5)), 0x2::object::id_address<0x522415d0715e8557dea9f5fa9c6eb09536428a8eb23c7c3be04b48fdd8337cb0::vault::StrategyVault>(arg2), arg6, v4, 0x2::clock::timestamp_ms(arg7));
    }

    // decompiled from Move bytecode v6
}

