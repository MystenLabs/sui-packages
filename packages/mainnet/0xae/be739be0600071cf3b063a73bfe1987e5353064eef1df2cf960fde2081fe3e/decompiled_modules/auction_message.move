module 0x9272d9d9585d081fe25318c24ca7f80916c6e19c7ec50840063764a751f234de::auction_message {
    struct AuctionMessage has drop {
        token_burned: address,
        amount_in: u64,
        addr_dest: address,
        chain_dest: u16,
        token_out: address,
        amount_promised: u64,
        gas_drop: u64,
        fee_redeem: u64,
        deadline: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        cctp_nonce: u64,
        cctp_domain: u32,
        foreign_driver: address,
    }

    public(friend) fun auction_message_payload_type() : u8 {
        1
    }

    public(friend) fun new(arg0: address, arg1: u64, arg2: address, arg3: u16, arg4: address, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: address, arg10: u8, arg11: u8, arg12: u64, arg13: u32, arg14: address) : AuctionMessage {
        AuctionMessage{
            token_burned    : arg0,
            amount_in       : arg1,
            addr_dest       : arg2,
            chain_dest      : arg3,
            token_out       : arg4,
            amount_promised : arg5,
            gas_drop        : arg6,
            fee_redeem      : arg7,
            deadline        : arg8,
            addr_ref        : arg9,
            fee_rate_ref    : arg10,
            fee_rate_mayan  : arg11,
            cctp_nonce      : arg12,
            cctp_domain     : arg13,
            foreign_driver  : arg14,
        }
    }

    public(friend) fun to_hash(arg0: &AuctionMessage) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 2);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 1);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.token_burned));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.amount_in);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.addr_dest));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u16_be(&mut v0, arg0.chain_dest);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.token_out));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.amount_promised);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.gas_drop);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.fee_redeem);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.deadline);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.addr_ref));
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.fee_rate_ref);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, arg0.fee_rate_mayan);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u64_be(&mut v0, arg0.cctp_nonce);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u32_be(&mut v0, arg0.cctp_domain);
        0x1::vector::append<u8>(&mut v0, 0x2::address::to_bytes(arg0.foreign_driver));
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public(friend) fun unpack(arg0: AuctionMessage) : (address, u64, address, u16, address, u64, u64, u64, u64, address, u8, u8, u64, u32, address) {
        let AuctionMessage {
            token_burned    : v0,
            amount_in       : v1,
            addr_dest       : v2,
            chain_dest      : v3,
            token_out       : v4,
            amount_promised : v5,
            gas_drop        : v6,
            fee_redeem      : v7,
            deadline        : v8,
            addr_ref        : v9,
            fee_rate_ref    : v10,
            fee_rate_mayan  : v11,
            cctp_nonce      : v12,
            cctp_domain     : v13,
            foreign_driver  : v14,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14)
    }

    // decompiled from Move bytecode v6
}

