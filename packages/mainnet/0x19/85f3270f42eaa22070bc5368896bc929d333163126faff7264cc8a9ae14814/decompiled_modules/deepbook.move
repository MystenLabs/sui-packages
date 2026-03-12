module 0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::deepbook {
    struct DeepBookPosition has store, key {
        id: 0x2::object::UID,
        deposited: u64,
        position_cap: 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap,
        owner: address,
    }

    struct DeepBookPool<phantom T0> has key {
        id: 0x2::object::UID,
        margin_pool_id: 0x2::object::ID,
        referral_id: 0x2::object::ID,
    }

    fun assert_pool_match<T0>(arg0: &DeepBookPool<T0>, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>) {
        assert!(0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg1) == arg0.margin_pool_id, 6);
    }

    public fun claim_referral_fees<T0>(arg0: &0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::config::AdminCap, arg1: &DeepBookPool<T0>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::protocol_fees::SupplyReferral, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_pool_match<T0>(arg1, arg2);
        assert!(0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::protocol_fees::SupplyReferral>(arg4) == arg1.referral_id, 6);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw_referral_fees<T0>(arg2, arg3, arg4, arg6);
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::events::emit_referral_fees_collected(0x1::string::utf8(b"deepbook"), 0x2::object::id<DeepBookPool<T0>>(arg1), 0x2::coin::value<T0>(&v0), 0x2::clock::timestamp_ms(arg5));
        v0
    }

    public fun create_pool<T0>(arg0: &0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::config::AdminCap, arg1: &0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::config::Config, arg2: &mut 0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::pool_registry::PoolRegistry, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::config::assert_not_paused(arg1);
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::config::assert_version(arg1);
        let v0 = DeepBookPool<T0>{
            id             : 0x2::object::new(arg6),
            margin_pool_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg3),
            referral_id    : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supply_referral<T0>(arg3, arg4, arg5, arg6),
        };
        let v1 = 0x2::object::id<DeepBookPool<T0>>(&v0);
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::pool_registry::register_pool<T0>(arg0, arg2, 0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(0x2::address::to_string(0x2::object::id_to_address(&v1))));
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::events::emit_pool_created(0x1::string::utf8(b"deepbook"), 0x2::object::id<DeepBookPool<T0>>(&v0), 0x1::type_name::get<T0>());
        0x2::transfer::share_object<DeepBookPool<T0>>(v0);
    }

    public fun create_position<T0>(arg0: &mut 0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::position_registry::PositionRegistry, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &DeepBookPool<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : DeepBookPosition {
        assert_pool_match<T0>(arg3, arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = DeepBookPosition{
            id           : 0x2::object::new(arg5),
            deposited    : 0,
            position_cap : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supplier_cap(arg2, arg4, arg5),
            owner        : v0,
        };
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::events::emit_position_created(0x1::string::utf8(b"deepbook"), 0x2::object::id<DeepBookPosition>(&v1), 0x2::object::id<DeepBookPosition>(&v1), v0);
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::position_registry::register_position(arg0, 0x1::string::utf8(b"deepbook"), v0, 0x2::object::id<DeepBookPosition>(&v1));
        v1
    }

    public fun deposit<T0>(arg0: &0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::config::Config, arg1: &0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::pool_registry::PoolRegistry, arg2: &mut DeepBookPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &mut DeepBookPosition, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::config::assert_not_paused(arg0);
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::config::assert_version(arg0);
        let v0 = 0x2::object::id<DeepBookPool<T0>>(arg2);
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(0x2::address::to_string(0x2::object::id_to_address(&v0))));
        assert_pool_match<T0>(arg2, arg3);
        let v1 = 0x2::coin::value<T0>(&arg6);
        assert!(v1 > 0, 1);
        let v2 = 0x2::tx_context::sender(arg8);
        assert!(v2 == arg5.owner, 4);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply<T0>(arg3, arg4, &arg5.position_cap, arg6, 0x1::option::some<0x2::object::ID>(arg2.referral_id), arg7);
        arg5.deposited = arg5.deposited + v1;
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::events::emit_deposited(0x1::string::utf8(b"deepbook"), 0x2::object::id<DeepBookPool<T0>>(arg2), v2, v1, 0x2::clock::timestamp_ms(arg7));
    }

    public fun margin_pool_id<T0>(arg0: &DeepBookPool<T0>) : 0x2::object::ID {
        arg0.margin_pool_id
    }

    public fun pool_id<T0>(arg0: &DeepBookPool<T0>) : 0x2::object::ID {
        0x2::object::id<DeepBookPool<T0>>(arg0)
    }

    public fun referral_id<T0>(arg0: &DeepBookPool<T0>) : 0x2::object::ID {
        arg0.referral_id
    }

    public fun user_supply_amount<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &DeepBookPosition, arg2: &0x2::clock::Clock) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_amount<T0>(arg0, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(&arg1.position_cap), arg2)
    }

    public fun user_supply_shares<T0>(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg1: &DeepBookPosition) : u64 {
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::user_supply_shares<T0>(arg0, 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap>(&arg1.position_cap))
    }

    public fun withdraw<T0>(arg0: &mut 0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::config::Config, arg1: &0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::pool_registry::PoolRegistry, arg2: &mut DeepBookPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &mut DeepBookPosition, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::config::assert_not_paused(arg0);
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::config::assert_version(arg0);
        let v0 = 0x2::object::id<DeepBookPool<T0>>(arg2);
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(0x2::address::to_string(0x2::object::id_to_address(&v0))));
        assert_pool_match<T0>(arg2, arg3);
        assert!(arg6 > 0, 1);
        let v1 = user_supply_amount<T0>(arg3, arg5, arg8);
        assert!(v1 >= arg6, 2);
        let v2 = (((arg5.deposited as u128) * (arg6 as u128) / (v1 as u128)) as u64);
        let v3 = if (arg6 > v2) {
            arg6 - v2
        } else {
            0
        };
        let v4 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw<T0>(arg3, arg4, &arg5.position_cap, 0x1::option::some<u64>(arg6), arg8, arg9);
        let v5 = 0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::config::deduct_fee_on_yield<T0>(arg0, 0x2::coin::balance_mut<T0>(&mut v4), v3);
        let v6 = arg6 - v5;
        assert!(v6 >= arg7, 5);
        arg5.deposited = arg5.deposited - v2;
        if (v5 > 0) {
            0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::events::emit_protocol_fees_collected(0x1::string::utf8(b"deepbook"), 0x2::object::id<DeepBookPool<T0>>(arg2), v5, 0x2::clock::timestamp_ms(arg8));
        };
        0x1985f3270f42eaa22070bc5368896bc929d333163126faff7264cc8a9ae14814::events::emit_withdrawn(0x1::string::utf8(b"deepbook"), 0x2::object::id<DeepBookPool<T0>>(arg2), 0x2::tx_context::sender(arg9), v6, v5, 0x2::clock::timestamp_ms(arg8));
        v4
    }

    // decompiled from Move bytecode v6
}

