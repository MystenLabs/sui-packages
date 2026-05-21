module 0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::order_info {
    struct OrderInfo has copy, drop {
        payload_type: u8,
        trader: address,
        chain_source: u16,
        token_in: address,
        addr_dest: address,
        chain_dest: u16,
        token_out: address,
        amount_out_min: u64,
        gas_drop: u64,
        fee_cancel: u64,
        fee_refund: u64,
        deadline: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        auction_mode: u8,
        key_rnd: address,
        custom_payload: address,
    }

    public fun chain_source(arg0: &OrderInfo) : u16 {
        arg0.chain_source
    }

    public fun compute_hash(arg0: &OrderInfo) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.payload_type);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.trader));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, arg0.chain_source);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.token_in));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.addr_dest));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, arg0.chain_dest);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.token_out));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.amount_out_min);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.gas_drop);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.fee_cancel);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.fee_refund);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.deadline);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.addr_ref));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.fee_rate_ref);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.fee_rate_mayan);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.auction_mode);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.key_rnd));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.custom_payload));
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public fun fee_cancel(arg0: &OrderInfo) : u64 {
        arg0.fee_cancel
    }

    public fun fee_refund(arg0: &OrderInfo) : u64 {
        arg0.fee_refund
    }

    public fun new(arg0: u8, arg1: address, arg2: u16, arg3: address, arg4: address, arg5: u16, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: address, arg13: u8, arg14: u8, arg15: u8, arg16: address, arg17: address) : OrderInfo {
        OrderInfo{
            payload_type   : arg0,
            trader         : arg1,
            chain_source   : arg2,
            token_in       : arg3,
            addr_dest      : arg4,
            chain_dest     : arg5,
            token_out      : arg6,
            amount_out_min : arg7,
            gas_drop       : arg8,
            fee_cancel     : arg9,
            fee_refund     : arg10,
            deadline       : arg11,
            addr_ref       : arg12,
            fee_rate_ref   : arg13,
            fee_rate_mayan : arg14,
            auction_mode   : arg15,
            key_rnd        : arg16,
            custom_payload : arg17,
        }
    }

    public fun token_in(arg0: &OrderInfo) : address {
        arg0.token_in
    }

    public fun trader(arg0: &OrderInfo) : address {
        arg0.trader
    }

    // decompiled from Move bytecode v6
}

