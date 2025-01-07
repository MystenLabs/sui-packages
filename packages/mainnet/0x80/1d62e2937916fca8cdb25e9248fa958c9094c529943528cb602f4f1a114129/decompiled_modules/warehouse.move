module 0x801d62e2937916fca8cdb25e9248fa958c9094c529943528cb602f4f1a114129::warehouse {
    struct Warehouse<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        inner: 0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::DynamicVec<0x2::object::ID>,
    }

    public fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : Warehouse<T0> {
        Warehouse<T0>{
            id    : 0x2::object::new(arg0),
            inner : 0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::empty<0x2::object::ID>(7900, arg0),
        }
    }

    public fun size<T0: store + key>(arg0: &Warehouse<T0>) : u64 {
        0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::size<0x2::object::ID>(&arg0.inner)
    }

    public entry fun deposit<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: T0) : 0x2::object::ID {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::push<0x2::object::ID>(&mut arg0.inner, v0);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
        v0
    }

    public fun redeem<T0: store + key>(arg0: &mut Warehouse<T0>) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        redeem_inner<T0, Warehouse<T0>>(arg0, 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::pop<0x2::object::ID>(&mut arg0.inner)))
    }

    public fun redeem_at_index<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: u64) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        redeem_inner<T0, Warehouse<T0>>(arg0, 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, 0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::remove<0x2::object::ID>(&mut arg0.inner, arg1)))
    }

    public(friend) fun redeem_inner<T0: store + key, T1: key>(arg0: &T1, arg1: T0) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        (arg1, 0x2::transfer_policy::new_request<T0>(0x2::object::id<T0>(&arg1), 0, 0x2::object::id<T1>(arg0)))
    }

    public fun redeem_with_id<T0: store + key>(arg0: &mut Warehouse<T0>, arg1: 0x2::object::ID) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::remove_value<0x2::object::ID>(&mut arg0.inner, arg1);
        redeem_inner<T0, Warehouse<T0>>(arg0, 0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg0.id, arg1))
    }

    // decompiled from Move bytecode v6
}

