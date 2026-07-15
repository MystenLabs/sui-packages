module 0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::treasury {
    struct BridgeTreasury has store {
        treasuries: 0x2::object_bag::ObjectBag,
    }

    public(friend) fun burn<T0>(arg0: &mut BridgeTreasury, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        create_treasury_if_not_exist<T0>(arg0, arg2);
        0x2::coin::burn<T0>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasuries, 0x1::type_name::get<T0>()), arg1);
    }

    public(friend) fun mint<T0>(arg0: &mut BridgeTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        create_treasury_if_not_exist<T0>(arg0, arg2);
        0x2::coin::mint<T0>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasuries, 0x1::type_name::get<T0>()), arg1, arg2)
    }

    public(friend) fun add_treasury_cap<T0>(arg0: &mut BridgeTreasury, arg1: 0x2::coin::TreasuryCap<T0>) {
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasuries, 0x1::type_name::get<T0>(), arg1);
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : BridgeTreasury {
        BridgeTreasury{treasuries: 0x2::object_bag::new(arg0)}
    }

    fun create_treasury_if_not_exist<T0>(arg0: &BridgeTreasury, arg1: &0x2::tx_context::TxContext) {
        if (!0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.treasuries, 0x1::type_name::get<T0>())) {
            abort 0
        };
    }

    public fun token_id<T0>() : u8 {
        let v0 = 0x1::type_name::get<T0>();
        if (v0 == 0x1::type_name::get<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::btc::BTC>()) {
            1
        } else if (v0 == 0x1::type_name::get<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::eth::ETH>()) {
            2
        } else if (v0 == 0x1::type_name::get<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::usdc::USDC>()) {
            3
        } else {
            assert!(v0 == 0x1::type_name::get<0xb4effeabe520cdba51af2d22193ae4ea42e5971b4962ba127cabb1e20ce3daa3::usdt::USDT>(), 0);
            4
        }
    }

    // decompiled from Move bytecode v7
}

