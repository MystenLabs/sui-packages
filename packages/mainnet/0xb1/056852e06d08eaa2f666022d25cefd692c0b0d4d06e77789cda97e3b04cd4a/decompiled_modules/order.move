module 0xb1056852e06d08eaa2f666022d25cefd692c0b0d4d06e77789cda97e3b04cd4a::order {
    struct Order has drop {
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
    }

    public(friend) fun new(arg0: address, arg1: u16, arg2: address, arg3: address, arg4: u16, arg5: address, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: address, arg12: u8, arg13: u8, arg14: u8, arg15: address) : Order {
        Order{
            trader         : arg0,
            chain_source   : arg1,
            token_in       : arg2,
            addr_dest      : arg3,
            chain_dest     : arg4,
            token_out      : arg5,
            amount_out_min : arg6,
            gas_drop       : arg7,
            fee_cancel     : arg8,
            fee_refund     : arg9,
            deadline       : arg10,
            addr_ref       : arg11,
            fee_rate_ref   : arg12,
            fee_rate_mayan : arg13,
            auction_mode   : arg14,
            key_rnd        : arg15,
        }
    }

    public(friend) fun to_hash(arg0: &Order) : address {
        let v0 = 0x1::vector::empty<u8>();
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
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public(friend) fun validate_order_hash(arg0: &Order, arg1: address) {
        assert!(to_hash(arg0) == arg1, 0);
    }

    // decompiled from Move bytecode v6
}

