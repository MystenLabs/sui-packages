module 0xfb6ac6598a57d2936a154f34a75788c59d58da186200376f73dd9d3ce420bc48::farming {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun deposit<T0>(arg0: &mut AdminCap, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == @0xe9bc3759219f18e2a18e8d4f524ec8727a588e1d843635dc9262fd1070390c13, 13906834264537694207);
        let v0 = 0x1::type_name::into_string(0x1::type_name::get<T0>());
        if (0x2::dynamic_field::exists_with_type<0x1::ascii::String, 0x2::coin::Coin<T0>>(&arg0.id, v0)) {
            0x2::coin::join<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v0), arg1);
        } else {
            0x2::dynamic_field::add<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, v0, arg1);
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0xe9bc3759219f18e2a18e8d4f524ec8727a588e1d843635dc9262fd1070390c13, 13906834234472923135);
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<AdminCap>(v0);
    }

    public fun optimise_rebalance<T0>(arg0: &mut AdminCap, arg1: &mut 0xca441b44943c16be0e6e23c5a955bb971537ea3289ae8016fbf33fffe1fd210f::oracle::PriceOracle, arg2: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg4: u8, arg5: address, arg6: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg7: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::Incentive, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg10) == @0xe9bc3759219f18e2a18e8d4f524ec8727a588e1d843635dc9262fd1070390c13, 13906834440631353343);
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v3::entry_repay_on_behalf_of_user<T0>(arg9, arg1, arg2, arg3, arg4, 0x2::coin::split<T0>(0x2::dynamic_field::borrow_mut<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>())), arg8, arg10), arg8, arg5, arg6, arg7, arg10);
    }

    public fun withdraw<T0>(arg0: &mut AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == @0xe9bc3759219f18e2a18e8d4f524ec8727a588e1d843635dc9262fd1070390c13, 13906834316077301759);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::dynamic_field::remove<0x1::ascii::String, 0x2::coin::Coin<T0>>(&mut arg0.id, 0x1::type_name::into_string(0x1::type_name::get<T0>())), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

