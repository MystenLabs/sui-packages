module 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::springsui_adapter {
    public fun spring_sui_router<T0: drop>(arg0: &mut 0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::PermissionedReceipt, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::acl::RouterAcl, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::acl::access(arg3);
        let v1 = 0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::remove_data<vector<u8>, u8, 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::acl::Access>(arg0, v0, b"current_index");
        assert!(v1 <= *0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::borrow_data<vector<u8>, u8, 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::acl::Access>(arg0, v0, b"final_index"), 0);
        let (v2, v3) = 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::bag_value::unwrap(0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::remove_data<u8, 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::bag_value::Value, 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::acl::Access>(arg0, v0, v1));
        assert!(0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg1) == v2, 0);
        if (v3) {
            0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::add_data<vector<u8>, 0x2::coin::Coin<T0>, 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::acl::Access>(arg0, v0, b"funds", 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T0>(arg1, arg2, 0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::remove_data<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>, 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::acl::Access>(arg0, v0, b"funds"), arg4));
        } else {
            0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::add_data<vector<u8>, 0x2::coin::Coin<0x2::sui::SUI>, 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::acl::Access>(arg0, v0, b"funds", 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T0>(arg1, 0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::remove_data<vector<u8>, 0x2::coin::Coin<T0>, 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::acl::Access>(arg0, v0, b"funds"), arg2, arg4));
        };
        0x5dc1daef781ebe45722a4d0f8e01b7ecbf5328c31d6514474a3f491bb4702e21::receipt::add_data<vector<u8>, u8, 0x44316e84ccadcdb69ce0837d10df1510dee91963104dcf304d23fdf31443c218::acl::Access>(arg0, v0, b"current_index", v1 + 1);
    }

    // decompiled from Move bytecode v6
}

