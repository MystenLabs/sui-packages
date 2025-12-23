module 0x8d389fa25cb08ebc5e520bc520ed394eed9e62b56b7868acb398bf298b8a76f3::utils {
    public fun add_balance_to_bag<T0>(arg0: &mut 0x2::bag::Bag, arg1: 0x2::balance::Balance<T0>) : u64 {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        if (0x2::bag::contains<0x1::string::String>(arg0, v0)) {
            0x2::balance::join<T0>(0x2::bag::borrow_mut<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0), arg1);
        } else {
            0x2::bag::add<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0, arg1);
        };
        0x2::balance::value<T0>(0x2::bag::borrow<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0))
    }

    public fun find_active_id_idx(arg0: u32, arg1: vector<u32>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u32>(&arg1)) {
            if (*0x1::vector::borrow<u32>(&arg1, v0) == arg0) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 13906834311782334465
    }

    public fun remove_balance_from_bag<T0>(arg0: &mut 0x2::bag::Bag) : 0x2::balance::Balance<T0> {
        let v0 = 0x1::string::from_ascii(0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()));
        if (!0x2::bag::contains<0x1::string::String>(arg0, v0)) {
            return 0x2::balance::zero<T0>()
        };
        0x2::bag::remove<0x1::string::String, 0x2::balance::Balance<T0>>(arg0, v0)
    }

    public fun validate_active_id_slippage<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: u32, arg2: u32) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg1)))) <= arg2, 13906834264537694209);
    }

    // decompiled from Move bytecode v6
}

