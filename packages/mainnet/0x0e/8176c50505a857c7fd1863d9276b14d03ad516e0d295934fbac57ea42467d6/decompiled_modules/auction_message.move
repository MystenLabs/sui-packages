module 0xe8176c50505a857c7fd1863d9276b14d03ad516e0d295934fbac57ea42467d6::auction_message {
    struct AuctionMessage has drop {
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

    public(friend) fun new(arg0: address, arg1: u16, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: u8, arg9: u8, arg10: u64, arg11: u32, arg12: address) : AuctionMessage {
        AuctionMessage{
            addr_dest       : arg0,
            chain_dest      : arg1,
            token_out       : arg2,
            amount_promised : arg3,
            gas_drop        : arg4,
            fee_redeem      : arg5,
            deadline        : arg6,
            addr_ref        : arg7,
            fee_rate_ref    : arg8,
            fee_rate_mayan  : arg9,
            cctp_nonce      : arg10,
            cctp_domain     : arg11,
            foreign_driver  : arg12,
        }
    }

    public(friend) fun to_hash(arg0: &AuctionMessage) : address {
        let v0 = 0x1::vector::empty<u8>();
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 2);
        0x5306f64e312b581766351c07af79c72fcb1cd25147157fdc2f8ad76de9a3fb6a::bytes::push_u8(&mut v0, 1);
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
        0x2::address::from_bytes(0x2::hash::keccak256(&v0))
    }

    public(friend) fun unpack(arg0: AuctionMessage) : (address, u16, address, u64, u64, u64, u64, address, u8, u8, u64, u32, address) {
        let AuctionMessage {
            addr_dest       : v0,
            chain_dest      : v1,
            token_out       : v2,
            amount_promised : v3,
            gas_drop        : v4,
            fee_redeem      : v5,
            deadline        : v6,
            addr_ref        : v7,
            fee_rate_ref    : v8,
            fee_rate_mayan  : v9,
            cctp_nonce      : v10,
            cctp_domain     : v11,
            foreign_driver  : v12,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12)
    }

    // decompiled from Move bytecode v6
}

