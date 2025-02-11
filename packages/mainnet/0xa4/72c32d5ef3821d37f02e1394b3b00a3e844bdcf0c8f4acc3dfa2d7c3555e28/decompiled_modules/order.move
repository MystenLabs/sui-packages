module 0xa472c32d5ef3821d37f02e1394b3b00a3e844bdcf0c8f4acc3dfa2d7c3555e28::order {
    struct Order has drop {
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
        penalty_period: u16,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        auction_mode: u8,
        base_bond: u64,
        per_bps_bond: u64,
        key_rnd: address,
        custom_payload: address,
    }

    public(friend) fun addr_dest(arg0: &Order) : address {
        arg0.addr_dest
    }

    public(friend) fun addr_ref(arg0: &Order) : address {
        arg0.addr_ref
    }

    public(friend) fun amount_out_min(arg0: &Order) : u64 {
        arg0.amount_out_min
    }

    public(friend) fun auction_mode(arg0: &Order) : u8 {
        arg0.auction_mode
    }

    public fun auction_mode_dont_care() : u8 {
        1
    }

    public fun auction_mode_english() : u8 {
        2
    }

    public(friend) fun base_bond(arg0: &Order) : u64 {
        arg0.base_bond
    }

    public(friend) fun chain_dest(arg0: &Order) : u16 {
        arg0.chain_dest
    }

    public(friend) fun chain_source(arg0: &Order) : u16 {
        arg0.chain_source
    }

    public(friend) fun custom_payload(arg0: &Order) : address {
        arg0.custom_payload
    }

    public(friend) fun deadline(arg0: &Order) : u64 {
        arg0.deadline
    }

    public(friend) fun fee_cancel(arg0: &Order) : u64 {
        arg0.fee_cancel
    }

    public(friend) fun fee_rate_mayan(arg0: &Order) : u8 {
        arg0.fee_rate_mayan
    }

    public(friend) fun fee_rate_ref(arg0: &Order) : u8 {
        arg0.fee_rate_ref
    }

    public(friend) fun fee_refund(arg0: &Order) : u64 {
        arg0.fee_refund
    }

    public(friend) fun gas_drop(arg0: &Order) : u64 {
        arg0.gas_drop
    }

    public(friend) fun key_rnd(arg0: &Order) : address {
        arg0.key_rnd
    }

    public(friend) fun new(arg0: u8, arg1: address, arg2: u16, arg3: address, arg4: address, arg5: u16, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u16, arg13: address, arg14: u8, arg15: u8, arg16: u8, arg17: u64, arg18: u64, arg19: address, arg20: address) : Order {
        assert!(arg0 == 1 || arg0 == 2, 1);
        if (arg0 == 1) {
            assert!(arg20 == @0x0, 1);
        };
        Order{
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
            penalty_period : arg12,
            addr_ref       : arg13,
            fee_rate_ref   : arg14,
            fee_rate_mayan : arg15,
            auction_mode   : arg16,
            base_bond      : arg17,
            per_bps_bond   : arg18,
            key_rnd        : arg19,
            custom_payload : arg20,
        }
    }

    public(friend) fun payload_type(arg0: &Order) : u8 {
        arg0.payload_type
    }

    public fun payload_type_custom_payload() : u8 {
        2
    }

    public fun payload_type_default() : u8 {
        1
    }

    public(friend) fun penalty_period(arg0: &Order) : u16 {
        arg0.penalty_period
    }

    public(friend) fun per_bps_bond(arg0: &Order) : u64 {
        arg0.per_bps_bond
    }

    public(friend) fun to_hash(arg0: &Order) : address {
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
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, arg0.penalty_period);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.addr_ref));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.fee_rate_ref);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.fee_rate_mayan);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.auction_mode);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.base_bond);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.per_bps_bond);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.key_rnd));
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.custom_payload));
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public(friend) fun token_in(arg0: &Order) : address {
        arg0.token_in
    }

    public(friend) fun token_out(arg0: &Order) : address {
        arg0.token_out
    }

    public(friend) fun trader(arg0: &Order) : address {
        arg0.trader
    }

    public(friend) fun validate_order_hash(arg0: &Order, arg1: address) {
        assert!(to_hash(arg0) == arg1, 0);
    }

    // decompiled from Move bytecode v6
}

