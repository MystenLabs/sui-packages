module 0xfd9a69094eb35f04e28641c7d4f562cd57f2b58106bd632517adc0ffb0a1932e::treasury {
    struct BridgeTreasury has store {
        typs: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        treasuries: 0x2::object_bag::ObjectBag,
    }

    public(friend) fun burn<T0>(arg0: &mut BridgeTreasury, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(is_treasury_exist<T0>(arg0), 1);
        0x2::coin::burn<T0>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasuries, 0x1::type_name::get<T0>()), arg1);
    }

    public(friend) fun mint<T0>(arg0: &mut BridgeTreasury, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(is_treasury_exist<T0>(arg0), 1);
        0x2::coin::mint<T0>(0x2::object_bag::borrow_mut<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasuries, 0x1::type_name::get<T0>()), arg1, arg2)
    }

    public(friend) fun add_treasury_cap<T0>(arg0: &mut BridgeTreasury, arg1: 0x2::coin::TreasuryCap<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        if (!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.typs, &v0)) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.typs, v0);
        };
        0x2::object_bag::add<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasuries, v0, arg1);
    }

    public(friend) fun all_treasury_cap(arg0: &BridgeTreasury) : vector<0x1::type_name::TypeName> {
        *0x2::vec_set::keys<0x1::type_name::TypeName>(&arg0.typs)
    }

    public(friend) fun claim_treasury_cap<T0>(arg0: &mut BridgeTreasury) : 0x2::coin::TreasuryCap<T0> {
        assert!(is_treasury_exist<T0>(arg0), 1);
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.typs, &v0)) {
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.typs, &v0);
        };
        0x2::object_bag::remove<0x1::type_name::TypeName, 0x2::coin::TreasuryCap<T0>>(&mut arg0.treasuries, 0x1::type_name::get<T0>())
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : BridgeTreasury {
        BridgeTreasury{
            typs       : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            treasuries : 0x2::object_bag::new(arg0),
        }
    }

    public(friend) fun is_treasury_exist<T0>(arg0: &BridgeTreasury) : bool {
        0x2::object_bag::contains<0x1::type_name::TypeName>(&arg0.treasuries, 0x1::type_name::get<T0>())
    }

    // decompiled from Move bytecode v6
}

