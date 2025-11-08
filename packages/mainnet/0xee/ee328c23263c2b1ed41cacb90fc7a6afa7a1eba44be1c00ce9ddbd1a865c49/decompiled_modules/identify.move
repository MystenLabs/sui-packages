module 0xeeee328c23263c2b1ed41cacb90fc7a6afa7a1eba44be1c00ce9ddbd1a865c49::identify {
    public fun as_address<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : address {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, address>(&mut v0, true)
    }

    public fun as_bool<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, bool>(&mut v0, true)
    }

    public fun as_type<T0: store, T1: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : T1 {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, T1>(&mut v0, true)
    }

    public fun as_u128<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : u128 {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, u128>(&mut v0, true)
    }

    public fun as_u16<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : u16 {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, u16>(&mut v0, true)
    }

    public fun as_u256<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : u256 {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, u256>(&mut v0, true)
    }

    public fun as_u32<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : u32 {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, u32>(&mut v0, true)
    }

    public fun as_u64<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, u64>(&mut v0, true)
    }

    public fun as_u8<T0: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : u8 {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, u8>(&mut v0, true)
    }

    public fun as_vector<T0: store, T1: store>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : vector<T1> {
        let v0 = 0x2::object::new(arg1);
        0x2::dynamic_field::add<bool, T0>(&mut v0, true, arg0);
        0x2::object::delete(v0);
        0x2::dynamic_field::remove<bool, vector<T1>>(&mut v0, true)
    }

    public fun is_address<T0>() : bool {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == b"address"
    }

    public fun is_bool<T0>() : bool {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == b"bool"
    }

    public fun is_type<T0, T1>() : bool {
        0x1::type_name::with_original_ids<T0>() == 0x1::type_name::with_original_ids<T1>()
    }

    public fun is_u128<T0>() : bool {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == b"u128"
    }

    public fun is_u16<T0>() : bool {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == b"u16"
    }

    public fun is_u256<T0>() : bool {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == b"u256"
    }

    public fun is_u32<T0>() : bool {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == b"u32"
    }

    public fun is_u64<T0>() : bool {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == b"u64"
    }

    public fun is_u8<T0>() : bool {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == b"u8"
    }

    public fun is_vector<T0>() : bool {
        let v0 = 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>()));
        if (0x1::vector::length<u8>(&v0) > 5) {
            let v2 = 0x1::vector::empty<u8>();
            let v3 = &mut v2;
            0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&v0, 0));
            0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&v0, 1));
            0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&v0, 2));
            0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&v0, 3));
            0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&v0, 4));
            0x1::vector::push_back<u8>(v3, *0x1::vector::borrow<u8>(&v0, 5));
            v2 == b"vector"
        } else {
            false
        }
    }

    // decompiled from Move bytecode v6
}

