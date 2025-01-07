module 0x801d62e2937916fca8cdb25e9248fa958c9094c529943528cb602f4f1a114129::warehouse_pseudorandom {
    struct WarehousePseudorandom<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        inner: 0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::DynamicVec<0x2::object::ID>,
    }

    public fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : WarehousePseudorandom<T0> {
        WarehousePseudorandom<T0>{
            id    : 0x2::object::new(arg0),
            inner : 0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::empty<0x2::object::ID>(7900, arg0),
        }
    }

    public fun size<T0: store + key>(arg0: &WarehousePseudorandom<T0>) : u64 {
        0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::size<0x2::object::ID>(&arg0.inner)
    }

    public entry fun deposit<T0: store + key>(arg0: &mut WarehousePseudorandom<T0>, arg1: T0) : 0x2::object::ID {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::push<0x2::object::ID>(&mut arg0.inner, v0);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
        v0
    }

    fun rand(arg0: &mut 0x2::tx_context::TxContext) : vector<u8> {
        0x1::hash::sha3_256(0x261efa5cb450d9ab8d690b3afd07a73fcbd7eaf9fadec7aa2c276c91d8b654c4::pseudorandom::nonce_primitives(arg0))
    }

    public fun redeem<T0: store + key>(arg0: &0x2::clock::Clock, arg1: &mut 0x261efa5cb450d9ab8d690b3afd07a73fcbd7eaf9fadec7aa2c276c91d8b654c4::pseudorandom::Counter, arg2: &mut WarehousePseudorandom<T0>, arg3: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = rand(arg3);
        let v1 = 0x78970312579d6ed8fdb7d840e0c1e29087b263e3488514e708b8459db3c719ba::dynamic_vector::remove<0x2::object::ID>(&mut arg2.inner, 0x261efa5cb450d9ab8d690b3afd07a73fcbd7eaf9fadec7aa2c276c91d8b654c4::pseudorandom_math::select_u64(size<T0>(arg2), &v0));
        (0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg2.id, v1), 0x2::transfer_policy::new_request<T0>(v1, 0, 0x2::object::id<WarehousePseudorandom<T0>>(arg2)))
    }

    // decompiled from Move bytecode v6
}

