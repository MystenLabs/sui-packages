module 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::yt_object {
    struct YTObject has store, key {
        id: 0x2::object::UID,
        market_core_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        adapter_auth_type: 0x1::type_name::TypeName,
        notional: u64,
        maturity_ms: u64,
        yield_debt: u128,
    }

    public fun id(arg0: &YTObject) : 0x2::object::ID {
        0x2::object::id<YTObject>(arg0)
    }

    public fun new<T0, T1: drop>(arg0: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg1: &T1, arg2: 0x2::object::ID, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : YTObject {
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::auth::assert_auth<T1>(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::adapter_auth_type_ref<T0>(arg0));
        YTObject{
            id                : 0x2::object::new(arg5),
            market_core_id    : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::id<T0>(arg0),
            escrow_id         : arg2,
            adapter_auth_type : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::adapter_auth_type<T0>(arg0),
            notional          : arg3,
            maturity_ms       : 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::maturity_ms<T0>(arg0),
            yield_debt        : arg4,
        }
    }

    public fun adapter_auth_type_ref(arg0: &YTObject) : &0x1::type_name::TypeName {
        &arg0.adapter_auth_type
    }

    public fun maturity_ms(arg0: &YTObject) : u64 {
        arg0.maturity_ms
    }

    public fun destroy<T0: drop>(arg0: YTObject, arg1: &T0) {
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::auth::assert_auth<T0>(&arg0.adapter_auth_type);
        destroy_inner(arg0);
    }

    public(friend) fun destroy_for_base(arg0: YTObject) {
        destroy_inner(arg0);
    }

    fun destroy_inner(arg0: YTObject) {
        let YTObject {
            id                : v0,
            market_core_id    : _,
            escrow_id         : _,
            adapter_auth_type : _,
            notional          : _,
            maturity_ms       : _,
            yield_debt        : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun escrow_id(arg0: &YTObject) : 0x2::object::ID {
        arg0.escrow_id
    }

    public fun market_core_id(arg0: &YTObject) : 0x2::object::ID {
        arg0.market_core_id
    }

    public fun notional(arg0: &YTObject) : u64 {
        arg0.notional
    }

    public fun set_yield_debt<T0, T1: drop>(arg0: &mut YTObject, arg1: &0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::MarketCore<T0>, arg2: &T1, arg3: u128) {
        assert!(arg0.market_core_id == 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::id<T0>(arg1), 0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::errors::e_wrong_market());
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::auth::assert_auth<T1>(0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::market_core::adapter_auth_type_ref<T0>(arg1));
        0xb48a91a37ec5cdb45241db23132b9715aff06595f8d89d0e5e7a28501a143b2b::auth::assert_auth<T1>(&arg0.adapter_auth_type);
        if (arg3 > arg0.yield_debt) {
            arg0.yield_debt = arg3;
        };
    }

    public fun yield_debt(arg0: &YTObject) : u128 {
        arg0.yield_debt
    }

    // decompiled from Move bytecode v7
}

