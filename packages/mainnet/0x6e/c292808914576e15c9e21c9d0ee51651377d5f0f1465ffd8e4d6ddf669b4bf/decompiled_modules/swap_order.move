module 0x6ec292808914576e15c9e21c9d0ee51651377d5f0f1465ffd8e4d6ddf669b4bf::swap_order {
    struct SwapOrder has drop {
        trader: address,
        chain_source: u16,
        token_in: address,
        amount_in: u64,
        addr_dest: address,
        chain_dest: u16,
        token_out: address,
        amount_out_min: u64,
        gas_drop: u64,
        fee_redeem: u64,
        deadline: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        cctp_nonce: u64,
        cctp_domain: u32,
    }

    public(friend) fun new(arg0: address, arg1: u16, arg2: address, arg3: u64, arg4: address, arg5: u16, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: address, arg12: u8, arg13: u8, arg14: u64, arg15: u32) : SwapOrder {
        SwapOrder{
            trader         : arg0,
            chain_source   : arg1,
            token_in       : arg2,
            amount_in      : arg3,
            addr_dest      : arg4,
            chain_dest     : arg5,
            token_out      : arg6,
            amount_out_min : arg7,
            gas_drop       : arg8,
            fee_redeem     : arg9,
            deadline       : arg10,
            addr_ref       : arg11,
            fee_rate_ref   : arg12,
            fee_rate_mayan : arg13,
            cctp_nonce     : arg14,
            cctp_domain    : arg15,
        }
    }

    public(friend) fun to_hash(arg0: &SwapOrder) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.trader));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, arg0.chain_source);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.token_in));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.amount_in);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.addr_dest));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, arg0.chain_dest);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.token_out));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.amount_out_min);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.gas_drop);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.fee_redeem);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.deadline);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.addr_ref));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.fee_rate_ref);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.fee_rate_mayan);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.cctp_nonce);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u32_be(&mut v0, arg0.cctp_domain);
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public(friend) fun validate_swap_order_hash(arg0: &SwapOrder, arg1: address) {
        assert!(to_hash(arg0) == arg1, 0);
    }

    // decompiled from Move bytecode v6
}

