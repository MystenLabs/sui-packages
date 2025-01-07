module 0xf69aec501891142ea4b970460851f1b45b2f57aee608c69ce0bff163540ec51::warehouse_pseudorandom {
    struct WarehousePseudorandom<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        inner: 0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::DynamicVec<0x2::object::ID>,
    }

    public fun new<T0: store + key>(arg0: &mut 0x2::tx_context::TxContext) : WarehousePseudorandom<T0> {
        WarehousePseudorandom<T0>{
            id    : 0x2::object::new(arg0),
            inner : 0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::empty<0x2::object::ID>(7900, arg0),
        }
    }

    public entry fun deposit<T0: store + key>(arg0: &mut WarehousePseudorandom<T0>, arg1: T0) : 0x2::object::ID {
        let v0 = 0x2::object::id<T0>(&arg1);
        0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::push<0x2::object::ID>(&mut arg0.inner, v0);
        0x2::dynamic_object_field::add<0x2::object::ID, T0>(&mut arg0.id, v0, arg1);
        v0
    }

    public fun redeem<T0: store + key>(arg0: &mut 0x54cd930f19358a6051190df1a547c3a2d590261b345fef1a1aca4074bb1bcf31::pseudorandom::Counter, arg1: &mut WarehousePseudorandom<T0>, arg2: &mut 0x2::tx_context::TxContext) : (T0, 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = 0x54cd930f19358a6051190df1a547c3a2d590261b345fef1a1aca4074bb1bcf31::pseudorandom::rand_without_nonce(arg0, arg2);
        let v1 = 0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::remove<0x2::object::ID>(&mut arg1.inner, 0x54cd930f19358a6051190df1a547c3a2d590261b345fef1a1aca4074bb1bcf31::pseudorandom_math::select_u64(size<T0>(arg1), &v0));
        (0x2::dynamic_object_field::remove<0x2::object::ID, T0>(&mut arg1.id, v1), 0x2::transfer_policy::new_request<T0>(v1, 0, 0x2::object::id<WarehousePseudorandom<T0>>(arg1)))
    }

    public fun size<T0: store + key>(arg0: &WarehousePseudorandom<T0>) : u64 {
        0x8a5880a32cc17d30f7090219ad64a319327ba216869d6eded06b0d0f2471b39d::dynamic_vector::size<0x2::object::ID>(&arg0.inner)
    }

    // decompiled from Move bytecode v6
}

