module 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::pt_object {
    struct PTObject has store, key {
        id: 0x2::object::UID,
        market_core_id: 0x2::object::ID,
        escrow_id: 0x2::object::ID,
        adapter_auth_type: 0x1::type_name::TypeName,
        notional: u64,
        maturity_ms: u64,
        initial_index: u128,
    }

    public fun id(arg0: &PTObject) : 0x2::object::ID {
        0x2::object::id<PTObject>(arg0)
    }

    public fun new<T0, T1: drop>(arg0: &0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::MarketCore<T0>, arg1: &T1, arg2: 0x2::object::ID, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : PTObject {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T1>(0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::adapter_auth_type_ref<T0>(arg0));
        PTObject{
            id                : 0x2::object::new(arg5),
            market_core_id    : 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::id<T0>(arg0),
            escrow_id         : arg2,
            adapter_auth_type : 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::adapter_auth_type<T0>(arg0),
            notional          : arg3,
            maturity_ms       : 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::market_core::maturity_ms<T0>(arg0),
            initial_index     : arg4,
        }
    }

    public fun adapter_auth_type_ref(arg0: &PTObject) : &0x1::type_name::TypeName {
        &arg0.adapter_auth_type
    }

    public fun maturity_ms(arg0: &PTObject) : u64 {
        arg0.maturity_ms
    }

    public(friend) fun decrease_notional(arg0: &mut PTObject, arg1: u64) {
        assert!(arg1 <= arg0.notional, 0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::errors::e_underflow());
        arg0.notional = arg0.notional - arg1;
    }

    public fun destroy<T0: drop>(arg0: PTObject, arg1: &T0) {
        0x1983ea6f186697947acfecce07530a4952cf56bbc96451af48fa8c5cdf10ad2d::auth::assert_auth<T0>(&arg0.adapter_auth_type);
        destroy_inner(arg0);
    }

    public(friend) fun destroy_for_base(arg0: PTObject) {
        destroy_inner(arg0);
    }

    fun destroy_inner(arg0: PTObject) {
        let PTObject {
            id                : v0,
            market_core_id    : _,
            escrow_id         : _,
            adapter_auth_type : _,
            notional          : _,
            maturity_ms       : _,
            initial_index     : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun escrow_id(arg0: &PTObject) : 0x2::object::ID {
        arg0.escrow_id
    }

    public fun initial_index(arg0: &PTObject) : u128 {
        arg0.initial_index
    }

    public fun market_core_id(arg0: &PTObject) : 0x2::object::ID {
        arg0.market_core_id
    }

    public fun notional(arg0: &PTObject) : u64 {
        arg0.notional
    }

    // decompiled from Move bytecode v7
}

