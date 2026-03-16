module 0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::deepbook {
    struct DeepBookPosition has store, key {
        id: 0x2::object::UID,
        tokens_deposited: 0x2::table::Table<0x1::type_name::TypeName, u64>,
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

    public fun claim_referral_fees<T0>(arg0: &0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::config::AdminCap, arg1: &DeepBookPool<T0>, arg2: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg3: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::protocol_fees::SupplyReferral, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_pool_match<T0>(arg1, arg2);
        assert!(0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::protocol_fees::SupplyReferral>(arg4) == arg1.referral_id, 6);
        let v0 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw_referral_fees<T0>(arg2, arg3, arg4, arg6);
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::events::emit_referral_fees_collected(0x1::string::utf8(b"deepbook"), 0x2::object::id<DeepBookPool<T0>>(arg1), 0x2::coin::value<T0>(&v0), 0x2::clock::timestamp_ms(arg5));
        v0
    }

    public fun create_pool<T0>(arg0: &0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::config::AdminCap, arg1: &0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::config::Config, arg2: &mut 0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::pool_registry::PoolRegistry, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::config::assert_not_paused(arg1);
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::config::assert_version(arg1);
        let v0 = DeepBookPool<T0>{
            id             : 0x2::object::new(arg6),
            margin_pool_id : 0x2::object::id<0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>>(arg3),
            referral_id    : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supply_referral<T0>(arg3, arg4, arg5, arg6),
        };
        let v1 = 0x2::object::id<DeepBookPool<T0>>(&v0);
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::pool_registry::register_pool<T0>(arg0, arg2, 0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v1)));
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::events::emit_pool_created(0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v1)), 0x1::type_name::with_defining_ids<T0>());
        0x2::transfer::share_object<DeepBookPool<T0>>(v0);
    }

    public fun create_position<T0>(arg0: &mut 0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::position_registry::PositionRegistry, arg1: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg2: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg3: &DeepBookPool<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : DeepBookPosition {
        assert_pool_match<T0>(arg3, arg1);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = DeepBookPosition{
            id               : 0x2::object::new(arg5),
            tokens_deposited : 0x2::table::new<0x1::type_name::TypeName, u64>(arg5),
            position_cap     : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supplier_cap(arg2, arg4, arg5),
            owner            : v0,
        };
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::events::emit_position_created(0x1::string::utf8(b"deepbook"), 0x2::object::id<DeepBookPosition>(&v1), 0x2::object::id<DeepBookPosition>(&v1), v0);
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::position_registry::register_position(arg0, 0x1::string::utf8(b"deepbook"), v0, 0x2::object::id<DeepBookPosition>(&v1));
        v1
    }

    public fun deposit<T0>(arg0: &0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::config::Config, arg1: &0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::pool_registry::PoolRegistry, arg2: &mut DeepBookPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &mut DeepBookPosition, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::config::assert_not_paused(arg0);
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::config::assert_version(arg0);
        let v0 = 0x2::object::id<DeepBookPool<T0>>(arg2);
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v0)));
        assert_pool_match<T0>(arg2, arg3);
        let v1 = 0x2::coin::value<T0>(&arg6);
        assert!(v1 > 0, 1);
        let v2 = 0x2::tx_context::sender(arg8);
        assert!(v2 == arg5.owner, 4);
        0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::supply<T0>(arg3, arg4, &arg5.position_cap, arg6, 0x1::option::some<0x2::object::ID>(arg2.referral_id), arg7);
        if (!0x2::table::contains<0x1::type_name::TypeName, u64>(&arg5.tokens_deposited, 0x1::type_name::with_defining_ids<T0>())) {
            0x2::table::add<0x1::type_name::TypeName, u64>(&mut arg5.tokens_deposited, 0x1::type_name::with_defining_ids<T0>(), v1);
        } else {
            let v3 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg5.tokens_deposited, 0x1::type_name::with_defining_ids<T0>());
            *v3 = *v3 + v1;
        };
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::events::emit_deposited(0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v0)), v2, v1, 0x2::clock::timestamp_ms(arg7));
    }

    fun id_to_string(arg0: &0x2::object::ID) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"0x");
        0x1::string::append(&mut v0, 0x2::address::to_string(0x2::object::id_to_address(arg0)));
        v0
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

    public fun withdraw<T0>(arg0: &mut 0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::config::Config, arg1: &0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::pool_registry::PoolRegistry, arg2: &mut DeepBookPool<T0>, arg3: &mut 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::MarginPool<T0>, arg4: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg5: &mut DeepBookPosition, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::config::assert_not_paused(arg0);
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::config::assert_version(arg0);
        let v0 = 0x2::object::id<DeepBookPool<T0>>(arg2);
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::pool_registry::assert_pool_enabled<T0>(arg1, 0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v0)));
        assert_pool_match<T0>(arg2, arg3);
        assert!(arg6 > 0, 1);
        let v1 = user_supply_amount<T0>(arg3, arg5, arg8);
        assert!(v1 >= arg6, 2);
        assert!(0x2::table::contains<0x1::type_name::TypeName, u64>(&arg5.tokens_deposited, 0x1::type_name::with_defining_ids<T0>()), 7);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, u64>(&mut arg5.tokens_deposited, 0x1::type_name::with_defining_ids<T0>());
        let v3 = (((*v2 as u128) * (arg6 as u128) / (v1 as u128)) as u64);
        let v4 = if (arg6 > v3) {
            arg6 - v3
        } else {
            0
        };
        let v5 = 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::withdraw<T0>(arg3, arg4, &arg5.position_cap, 0x1::option::some<u64>(arg6), arg8, arg9);
        let v6 = 0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::config::deduct_fee_on_yield<T0>(arg0, 0x2::coin::balance_mut<T0>(&mut v5), v4);
        let v7 = arg6 - v6;
        assert!(v7 >= arg7, 5);
        *v2 = *v2 - v3;
        if (*v2 == 0) {
            0x2::table::remove<0x1::type_name::TypeName, u64>(&mut arg5.tokens_deposited, 0x1::type_name::with_defining_ids<T0>());
        };
        if (v6 > 0) {
            0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::events::emit_protocol_fees_collected(0x1::string::utf8(b"deepbook"), 0x2::object::id<DeepBookPool<T0>>(arg2), v6, 0x2::clock::timestamp_ms(arg8));
        };
        0xf7f4ea676e33983ca49c5c5a90d8c7d3b040170fc8487f4972b6952c003e052::events::emit_withdrawn(0x1::string::utf8(b"deepbook"), 0x1::option::some<0x1::string::String>(id_to_string(&v0)), 0x2::tx_context::sender(arg9), v7, v6, 0x2::clock::timestamp_ms(arg8));
        v5
    }

    // decompiled from Move bytecode v6
}

