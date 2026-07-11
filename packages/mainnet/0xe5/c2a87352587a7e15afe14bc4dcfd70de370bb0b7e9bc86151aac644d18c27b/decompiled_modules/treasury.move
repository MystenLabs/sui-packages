module 0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::treasury {
    struct Treasury has key {
        id: 0x2::object::UID,
        kind_to_type: 0x2::vec_map::VecMap<u16, 0x1::type_name::TypeName>,
        type_to_kind: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u16>,
    }

    struct CapKey has copy, drop, store {
        pos0: u16,
    }

    public(friend) fun burn<T0>(arg0: &mut Treasury, arg1: 0x2::coin::Coin<T0>) : (u16, u64) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, u16>(&arg0.type_to_kind, &v0), 13906834509350961155);
        let v1 = *0x2::vec_map::get<0x1::type_name::TypeName, u16>(&arg0.type_to_kind, &v0);
        let v2 = CapKey{pos0: v1};
        0x2::coin::burn<T0>(0x2::dynamic_object_field::borrow_mut<CapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v2), arg1);
        (v1, 0x2::coin::value<T0>(&arg1))
    }

    public(friend) fun mint<T0>(arg0: &mut Treasury, arg1: u16, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(0x2::vec_map::contains<u16, 0x1::type_name::TypeName>(&arg0.kind_to_type, &arg1), 13906834466401288195);
        assert!(*0x2::vec_map::get<u16, 0x1::type_name::TypeName>(&arg0.kind_to_type, &arg1) == 0x1::type_name::get<T0>(), 13906834470696386565);
        let v0 = CapKey{pos0: arg1};
        0x2::coin::mint<T0>(0x2::dynamic_object_field::borrow_mut<CapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg0.id, v0), arg2, arg3)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id           : 0x2::object::new(arg0),
            kind_to_type : 0x2::vec_map::empty<u16, 0x1::type_name::TypeName>(),
            type_to_kind : 0x2::vec_map::empty<0x1::type_name::TypeName, u16>(),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun is_registered(arg0: &Treasury, arg1: u16) : bool {
        0x2::vec_map::contains<u16, 0x1::type_name::TypeName>(&arg0.kind_to_type, &arg1)
    }

    public fun register_coin<T0>(arg0: &0xe5c2a87352587a7e15afe14bc4dcfd70de370bb0b7e9bc86151aac644d18c27b::registry::AdminCap, arg1: &mut Treasury, arg2: u16, arg3: 0x2::coin::TreasuryCap<T0>) {
        let v0 = 0x1::type_name::get<T0>();
        assert!(!0x2::vec_map::contains<u16, 0x1::type_name::TypeName>(&arg1.kind_to_type, &arg2) && !0x2::vec_map::contains<0x1::type_name::TypeName, u16>(&arg1.type_to_kind, &v0), 13906834406271614977);
        0x2::vec_map::insert<u16, 0x1::type_name::TypeName>(&mut arg1.kind_to_type, arg2, v0);
        0x2::vec_map::insert<0x1::type_name::TypeName, u16>(&mut arg1.type_to_kind, v0, arg2);
        let v1 = CapKey{pos0: arg2};
        0x2::dynamic_object_field::add<CapKey, 0x2::coin::TreasuryCap<T0>>(&mut arg1.id, v1, arg3);
    }

    // decompiled from Move bytecode v7
}

