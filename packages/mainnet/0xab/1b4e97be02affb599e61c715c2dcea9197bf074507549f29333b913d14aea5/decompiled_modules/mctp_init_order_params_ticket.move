module 0xab1b4e97be02affb599e61c715c2dcea9197bf074507549f29333b913d14aea5::mctp_init_order_params_ticket {
    struct MctpInitOrderParamsTicket {
        payload_type: u8,
        trader: address,
        coin_metadata_id: 0x2::object::ID,
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
    }

    public fun addr_dest(arg0: &MctpInitOrderParamsTicket) : address {
        arg0.addr_dest
    }

    public fun addr_ref(arg0: &MctpInitOrderParamsTicket) : address {
        arg0.addr_ref
    }

    public fun amount_in(arg0: &MctpInitOrderParamsTicket) : u64 {
        arg0.amount_in
    }

    public fun amount_out_min(arg0: &MctpInitOrderParamsTicket) : u64 {
        arg0.amount_out_min
    }

    public fun chain_dest(arg0: &MctpInitOrderParamsTicket) : u16 {
        arg0.chain_dest
    }

    public fun coin_metadata_id(arg0: &MctpInitOrderParamsTicket) : 0x2::object::ID {
        arg0.coin_metadata_id
    }

    public fun deadline(arg0: &MctpInitOrderParamsTicket) : u64 {
        arg0.deadline
    }

    public fun fee_rate_ref(arg0: &MctpInitOrderParamsTicket) : u8 {
        arg0.fee_rate_ref
    }

    public fun fee_redeem(arg0: &MctpInitOrderParamsTicket) : u64 {
        arg0.fee_redeem
    }

    public fun gas_drop(arg0: &MctpInitOrderParamsTicket) : u64 {
        arg0.gas_drop
    }

    public(friend) fun new(arg0: u8, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: u16, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: address, arg12: u8) : MctpInitOrderParamsTicket {
        MctpInitOrderParamsTicket{
            payload_type     : arg0,
            trader           : arg1,
            coin_metadata_id : arg2,
            amount_in        : arg3,
            addr_dest        : arg4,
            chain_dest       : arg5,
            token_out        : arg6,
            amount_out_min   : arg7,
            gas_drop         : arg8,
            fee_redeem       : arg9,
            deadline         : arg10,
            addr_ref         : arg11,
            fee_rate_ref     : arg12,
        }
    }

    public fun payload_type(arg0: &MctpInitOrderParamsTicket) : u8 {
        arg0.payload_type
    }

    public fun token_out(arg0: &MctpInitOrderParamsTicket) : address {
        arg0.token_out
    }

    public fun trader(arg0: &MctpInitOrderParamsTicket) : address {
        arg0.trader
    }

    public(friend) fun unpack(arg0: MctpInitOrderParamsTicket) : (u8, address, 0x2::object::ID, u64, address, u16, address, u64, u64, u64, u64, address, u8) {
        let MctpInitOrderParamsTicket {
            payload_type     : v0,
            trader           : v1,
            coin_metadata_id : v2,
            amount_in        : v3,
            addr_dest        : v4,
            chain_dest       : v5,
            token_out        : v6,
            amount_out_min   : v7,
            gas_drop         : v8,
            fee_redeem       : v9,
            deadline         : v10,
            addr_ref         : v11,
            fee_rate_ref     : v12,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12)
    }

    // decompiled from Move bytecode v6
}

