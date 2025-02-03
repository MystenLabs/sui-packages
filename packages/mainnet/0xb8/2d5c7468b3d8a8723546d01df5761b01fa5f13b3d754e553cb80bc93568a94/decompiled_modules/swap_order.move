module 0xb82d5c7468b3d8a8723546d01df5761b01fa5f13b3d754e553cb80bc93568a94::swap_order {
    struct SwapOrder has drop {
        payload_type: u8,
        trader: address,
        chain_source: u16,
        token_burned: address,
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

    public(friend) fun new(arg0: u8, arg1: address, arg2: u16, arg3: address, arg4: u64, arg5: address, arg6: u16, arg7: address, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: address, arg13: u8, arg14: u8, arg15: u64, arg16: u32) : SwapOrder {
        assert!(arg0 == 1, 1);
        SwapOrder{
            payload_type   : arg0,
            trader         : arg1,
            chain_source   : arg2,
            token_burned   : arg3,
            amount_in      : arg4,
            addr_dest      : arg5,
            chain_dest     : arg6,
            token_out      : arg7,
            amount_out_min : arg8,
            gas_drop       : arg9,
            fee_redeem     : arg10,
            deadline       : arg11,
            addr_ref       : arg12,
            fee_rate_ref   : arg13,
            fee_rate_mayan : arg14,
            cctp_nonce     : arg15,
            cctp_domain    : arg16,
        }
    }

    public(friend) fun to_hash(arg0: &SwapOrder) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 1);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.payload_type);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.trader));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, arg0.chain_source);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.token_burned));
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

