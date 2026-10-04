module 0x258008c732835442cbc12caca9ddef97b87007ffec07e9e2e98aff74cc054674::cetus_layout {
    struct Snapshot has copy, drop, store {
        pool_id: 0x2::object::ID,
        tick_lower_bits: u32,
        tick_upper_bits: u32,
        liquidity: u128,
    }

    public(friend) fun is_cetus_position<T0>() : bool {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::with_original_ids<T0>())) == b"1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position"
    }

    public fun liquidity(arg0: &Snapshot) : u128 {
        arg0.liquidity
    }

    public(friend) fun parse(arg0: vector<u8>, arg1: 0x2::object::ID) : Snapshot {
        let v0 = 0x2::bcs::new(arg0);
        assert!(0x2::bcs::peel_address(&mut v0) == 0x2::object::id_to_address(&arg1), 100);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_vec_u8(&mut v0);
        0x2::bcs::peel_vec_u8(&mut v0);
        0x2::bcs::peel_vec_u8(&mut v0);
        0x2::bcs::peel_vec_u8(&mut v0);
        0x2::bcs::peel_vec_u8(&mut v0);
        let v1 = 0x2::bcs::into_remainder_bytes(v0);
        assert!(0x1::vector::is_empty<u8>(&v1), 100);
        Snapshot{
            pool_id         : 0x2::object::id_from_address(0x2::bcs::peel_address(&mut v0)),
            tick_lower_bits : 0x2::bcs::peel_u32(&mut v0),
            tick_upper_bits : 0x2::bcs::peel_u32(&mut v0),
            liquidity       : 0x2::bcs::peel_u128(&mut v0),
        }
    }

    public fun pool_id(arg0: &Snapshot) : 0x2::object::ID {
        arg0.pool_id
    }

    public(friend) fun read<T0: store + key>(arg0: &T0) : Snapshot {
        parse(0x2::bcs::to_bytes<T0>(arg0), 0x2::object::id<T0>(arg0))
    }

    public fun tick_lower_bits(arg0: &Snapshot) : u32 {
        arg0.tick_lower_bits
    }

    public fun tick_upper_bits(arg0: &Snapshot) : u32 {
        arg0.tick_upper_bits
    }

    // decompiled from Move bytecode v7
}

