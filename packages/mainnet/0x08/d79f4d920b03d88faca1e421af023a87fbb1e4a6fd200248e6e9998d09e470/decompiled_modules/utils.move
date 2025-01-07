module 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::utils {
    public fun escrow_balance<T0>(arg0: &0x2::bag::Bag, arg1: address) : u64 {
        if (!0x2::bag::contains_with_type<address, 0x2::balance::Balance<T0>>(arg0, arg1)) {
            0
        } else {
            0x2::balance::value<T0>(0x2::bag::borrow<address, 0x2::balance::Balance<T0>>(arg0, arg1))
        }
    }

    public fun escrow_deposit<T0>(arg0: &mut 0x2::bag::Bag, arg1: address, arg2: 0x2::coin::Coin<T0>) {
        if (!0x2::bag::contains_with_type<address, 0x2::balance::Balance<T0>>(arg0, arg1)) {
            let v0 = 0x2::balance::zero<T0>();
            0x2::coin::put<T0>(&mut v0, arg2);
            0x2::bag::add<address, 0x2::balance::Balance<T0>>(arg0, arg1, v0);
        } else {
            0x2::coin::put<T0>(0x2::bag::borrow_mut<address, 0x2::balance::Balance<T0>>(arg0, arg1), arg2);
        };
    }

    public fun escrow_withdraw<T0>(arg0: &mut 0x2::bag::Bag, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(0x2::bag::borrow_mut<address, 0x2::balance::Balance<T0>>(arg0, arg1), arg2, arg3)
    }

    public fun parse_sgx_quote(arg0: &vector<u8>) : (vector<u8>, vector<u8>) {
        (slice(arg0, 112, 144), slice(arg0, 368, 432))
    }

    public fun slice(arg0: &vector<u8>, arg1: u64, arg2: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0x1::vector::length<u8>(arg0);
        let v2 = if (arg2 > v1) {
            v1
        } else {
            arg2
        };
        while (arg1 < v2) {
            0x1::vector::push_back<u8>(&mut v0, *0x1::vector::borrow<u8>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        v0
    }

    public fun swap_remove<T0: drop + store>(arg0: &mut 0x2::table_vec::TableVec<T0>, arg1: u64) {
        *0x2::table_vec::borrow_mut<T0>(arg0, arg1) = 0x2::table_vec::pop_back<T0>(arg0);
    }

    public fun type_of<T0>() : vector<u8> {
        0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>()))
    }

    public fun u16_from_le_bytes(arg0: &vector<u8>) : u16 {
        ((*0x1::vector::borrow<u8>(arg0, 0) as u16) << 0) + ((*0x1::vector::borrow<u8>(arg0, 1) as u16) << 8)
    }

    public fun u32_from_le_bytes(arg0: &vector<u8>) : u32 {
        ((*0x1::vector::borrow<u8>(arg0, 0) as u32) << 0) + ((*0x1::vector::borrow<u8>(arg0, 1) as u32) << 8) + ((*0x1::vector::borrow<u8>(arg0, 2) as u32) << 16) + ((*0x1::vector::borrow<u8>(arg0, 3) as u32) << 24)
    }

    // decompiled from Move bytecode v6
}

