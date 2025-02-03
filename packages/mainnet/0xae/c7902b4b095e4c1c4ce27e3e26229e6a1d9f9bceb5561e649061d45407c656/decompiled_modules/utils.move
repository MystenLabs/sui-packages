module 0xaec7902b4b095e4c1c4ce27e3e26229e6a1d9f9bceb5561e649061d45407c656::utils {
    public fun empty_vector(arg0: u256) : vector<u256> {
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0;
        while (arg0 > v1) {
            0x1::vector::push_back<u256>(&mut v0, 0);
            v1 = v1 + 1;
        };
        v0
    }

    public fun head<T0: copy + drop>(arg0: vector<T0>) : T0 {
        *0x1::vector::borrow<T0>(&arg0, 0)
    }

    public fun make_coins_vec_set_from_vector(arg0: vector<0x1::type_name::TypeName>) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        let v0 = 0x2::vec_set::empty<0x1::type_name::TypeName>();
        let v1 = 0;
        while (0x1::vector::length<0x1::type_name::TypeName>(&arg0) > v1) {
            0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0, *0x1::vector::borrow<0x1::type_name::TypeName>(&arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun to_u256(arg0: u64) : u256 {
        (arg0 as u256)
    }

    public fun to_u64(arg0: u256) : u64 {
        (arg0 as u64)
    }

    public fun to_u8(arg0: u64) : u8 {
        (arg0 as u8)
    }

    public fun vector_2_to_tuple(arg0: vector<u256>) : (u256, u256) {
        (*0x1::vector::borrow<u256>(&arg0, 0), *0x1::vector::borrow<u256>(&arg0, 1))
    }

    public fun vector_3_to_tuple(arg0: vector<u256>) : (u256, u256, u256) {
        (*0x1::vector::borrow<u256>(&arg0, 0), *0x1::vector::borrow<u256>(&arg0, 1), *0x1::vector::borrow<u256>(&arg0, 2))
    }

    // decompiled from Move bytecode v6
}

