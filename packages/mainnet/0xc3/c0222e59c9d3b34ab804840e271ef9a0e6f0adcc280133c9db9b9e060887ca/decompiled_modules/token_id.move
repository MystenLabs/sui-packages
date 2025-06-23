module 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::token_id {
    struct TokenId has copy, drop, store {
        id: address,
    }

    struct UnregisteredTokenId has copy, drop, store {
        id: address,
    }

    public fun from_u256(arg0: u256) : TokenId {
        TokenId{id: 0x2::address::from_u256(arg0)}
    }

    public fun to_u256(arg0: &TokenId) : u256 {
        0x2::address::to_u256(arg0.id)
    }

    public fun from_address(arg0: address) : TokenId {
        TokenId{id: arg0}
    }

    public(friend) fun from_coin_data<T0>(arg0: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, arg1: &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::CoinInfo<T0>, arg2: &0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::CoinManagement<T0>) : TokenId {
        let v0 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::name<T0>(arg1);
        let v1 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::symbol<T0>(arg1);
        let v2 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::decimals<T0>(arg1);
        let v3 = 0x1::option::is_some<0x2::coin::CoinMetadata<T0>>(0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_info::metadata<T0>(arg1));
        let v4 = 0xc3c0222e59c9d3b34ab804840e271ef9a0e6f0adcc280133c9db9b9e060887ca::coin_management::has_treasury_cap<T0>(arg2);
        from_info<T0>(arg0, &v0, &v1, &v2, &v3, &v4)
    }

    public fun from_info<T0>(arg0: &0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32, arg1: &0x1::string::String, arg2: &0x1::ascii::String, arg3: &u8, arg4: &bool, arg5: &bool) : TokenId {
        let v0 = 0x2::address::to_bytes(0x2::address::from_u256(51987410952749076494360794653925130127106954452592680304183314258196508032931));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0xeb055ffc3237c24e305a2bb760fe6551f6ff7c5fdb68735169c0f528fccab373::bytes32::Bytes32>(arg0));
        let v1 = 0x1::type_name::get<T0>();
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::type_name::TypeName>(&v1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::ascii::String>(arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(arg5));
        TokenId{id: 0x2::address::from_bytes(0x2::hash::keccak256(&v0))}
    }

    public fun unregistered_token_id(arg0: &0x1::ascii::String, arg1: u8) : UnregisteredTokenId {
        let v0 = 105553402596830473628172449293994124616347210581711246324852109075375379716688;
        let v1 = 0x2::bcs::to_bytes<u256>(&v0);
        0x1::vector::push_back<u8>(&mut v1, arg1);
        0x1::vector::append<u8>(&mut v1, *0x1::ascii::as_bytes(arg0));
        UnregisteredTokenId{id: 0x2::address::from_bytes(0x2::hash::keccak256(&v1))}
    }

    // decompiled from Move bytecode v6
}

