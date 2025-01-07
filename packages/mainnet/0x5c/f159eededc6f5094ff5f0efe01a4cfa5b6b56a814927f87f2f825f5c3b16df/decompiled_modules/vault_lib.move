module 0x5cf159eededc6f5094ff5f0efe01a4cfa5b6b56a814927f87f2f825f5c3b16df::vault_lib {
    public fun calculate_pt_debt_from_epoch(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        ((((arg2 - arg1) as u128) * (arg0 as u128) * (arg3 as u128) / 365000000000) as u64)
    }

    public fun sort_items(arg0: &mut vector<0x3::staking_pool::StakedSui>) {
        let v0 = 1;
        while (v0 < 0x1::vector::length<0x3::staking_pool::StakedSui>(arg0)) {
            let v1 = v0;
            while (v1 > 0) {
                v1 = v1 - 1;
                if (0x3::staking_pool::staked_sui_amount(0x1::vector::borrow<0x3::staking_pool::StakedSui>(arg0, v1)) > 0x3::staking_pool::staked_sui_amount(0x1::vector::borrow<0x3::staking_pool::StakedSui>(arg0, v0))) {
                    0x1::vector::swap<0x3::staking_pool::StakedSui>(arg0, v1, v1 + 1);
                } else {
                    break
                };
            };
            v0 = v0 + 1;
        };
    }

    public fun token_to_name<T0>() : 0x1::string::String {
        0x1::string::utf8(0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())))
    }

    public fun token_to_name_with_prefix<T0>(arg0: vector<u8>) : 0x1::string::String {
        let v0 = 0x1::string::utf8(b"");
        0x1::string::append_utf8(&mut v0, arg0);
        0x1::string::append_utf8(&mut v0, b"-");
        0x1::string::append_utf8(&mut v0, 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())));
        v0
    }

    // decompiled from Move bytecode v6
}

