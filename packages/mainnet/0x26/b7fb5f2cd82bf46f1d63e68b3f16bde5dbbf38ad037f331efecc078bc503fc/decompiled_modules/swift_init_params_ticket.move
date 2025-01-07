module 0x26b7fb5f2cd82bf46f1d63e68b3f16bde5dbbf38ad037f331efecc078bc503fc::swift_init_params_ticket {
    struct SwiftInitParamsTicket {
        payload_type: u8,
        trader: address,
        coin_metadata_id: 0x2::object::ID,
        amount_in_min: u64,
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
        auction_mode: u8,
        base_bond: u64,
        per_bps_bond: u64,
    }

    public fun addr_dest(arg0: &SwiftInitParamsTicket) : address {
        arg0.addr_dest
    }

    public fun addr_ref(arg0: &SwiftInitParamsTicket) : address {
        arg0.addr_ref
    }

    public fun amount_in_min(arg0: &SwiftInitParamsTicket) : u64 {
        arg0.amount_in_min
    }

    public fun amount_out_min(arg0: &SwiftInitParamsTicket) : u64 {
        arg0.amount_out_min
    }

    public fun auction_mode(arg0: &SwiftInitParamsTicket) : u8 {
        arg0.auction_mode
    }

    public fun base_bond(arg0: &SwiftInitParamsTicket) : u64 {
        arg0.base_bond
    }

    public fun chain_dest(arg0: &SwiftInitParamsTicket) : u16 {
        arg0.chain_dest
    }

    public fun coin_metadata_id(arg0: &SwiftInitParamsTicket) : 0x2::object::ID {
        arg0.coin_metadata_id
    }

    public fun deadline(arg0: &SwiftInitParamsTicket) : u64 {
        arg0.deadline
    }

    public fun fee_cancel(arg0: &SwiftInitParamsTicket) : u64 {
        arg0.fee_cancel
    }

    public fun fee_rate_ref(arg0: &SwiftInitParamsTicket) : u8 {
        arg0.fee_rate_ref
    }

    public fun fee_refund(arg0: &SwiftInitParamsTicket) : u64 {
        arg0.fee_refund
    }

    public fun gas_drop(arg0: &SwiftInitParamsTicket) : u64 {
        arg0.gas_drop
    }

    public(friend) fun new(arg0: u8, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: u16, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u16, arg13: address, arg14: u8, arg15: u8, arg16: u64, arg17: u64) : SwiftInitParamsTicket {
        SwiftInitParamsTicket{
            payload_type     : arg0,
            trader           : arg1,
            coin_metadata_id : arg2,
            amount_in_min    : arg3,
            addr_dest        : arg4,
            chain_dest       : arg5,
            token_out        : arg6,
            amount_out_min   : arg7,
            gas_drop         : arg8,
            fee_cancel       : arg9,
            fee_refund       : arg10,
            deadline         : arg11,
            penalty_period   : arg12,
            addr_ref         : arg13,
            fee_rate_ref     : arg14,
            auction_mode     : arg15,
            base_bond        : arg16,
            per_bps_bond     : arg17,
        }
    }

    public fun payload_type(arg0: &SwiftInitParamsTicket) : u8 {
        arg0.payload_type
    }

    public fun penalty_period(arg0: &SwiftInitParamsTicket) : u16 {
        arg0.penalty_period
    }

    public fun per_bps_bond(arg0: &SwiftInitParamsTicket) : u64 {
        arg0.per_bps_bond
    }

    public fun token_out(arg0: &SwiftInitParamsTicket) : address {
        arg0.token_out
    }

    public fun trader(arg0: &SwiftInitParamsTicket) : address {
        arg0.trader
    }

    public(friend) fun unpack(arg0: SwiftInitParamsTicket) : (u8, address, 0x2::object::ID, u64, address, u16, address, u64, u64, u64, u64, u64, u16, address, u8, u8, u64, u64) {
        let SwiftInitParamsTicket {
            payload_type     : v0,
            trader           : v1,
            coin_metadata_id : v2,
            amount_in_min    : v3,
            addr_dest        : v4,
            chain_dest       : v5,
            token_out        : v6,
            amount_out_min   : v7,
            gas_drop         : v8,
            fee_cancel       : v9,
            fee_refund       : v10,
            deadline         : v11,
            penalty_period   : v12,
            addr_ref         : v13,
            fee_rate_ref     : v14,
            auction_mode     : v15,
            base_bond        : v16,
            per_bps_bond     : v17,
        } = arg0;
        (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17)
    }

    // decompiled from Move bytecode v6
}

