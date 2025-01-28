module 0xc6c1c12715051ddb959f431555def40dad7d2949b96e8dc44ce616aa06485b3c::calculate_mctp_fee {
    struct MctpInitOrderParams has drop {
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
        fee_rate_mayan: u8,
    }

    public fun calculate_mctp_fee(arg0: &0xc6c1c12715051ddb959f431555def40dad7d2949b96e8dc44ce616aa06485b3c::state::FeeManagerState, arg1: 0xc6c1c12715051ddb959f431555def40dad7d2949b96e8dc44ce616aa06485b3c::mctp_init_order_params_ticket::MctpInitOrderParamsTicket, arg2: &mut 0x2::tx_context::TxContext) : MctpInitOrderParams {
        0xc6c1c12715051ddb959f431555def40dad7d2949b96e8dc44ce616aa06485b3c::state::assert_valid_version(arg0);
        let (v0, v1, v2, v3, v4, v5, v6, v7, v8, v9, v10, v11, v12) = 0xc6c1c12715051ddb959f431555def40dad7d2949b96e8dc44ce616aa06485b3c::mctp_init_order_params_ticket::unpack(arg1);
        MctpInitOrderParams{
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
            fee_rate_mayan   : 3,
        }
    }

    public fun addr_dest(arg0: &MctpInitOrderParams) : address {
        arg0.addr_dest
    }

    public fun addr_ref(arg0: &MctpInitOrderParams) : address {
        arg0.addr_ref
    }

    public fun amount_in(arg0: &MctpInitOrderParams) : u64 {
        arg0.amount_in
    }

    public fun amount_out_min(arg0: &MctpInitOrderParams) : u64 {
        arg0.amount_out_min
    }

    public fun chain_dest(arg0: &MctpInitOrderParams) : u16 {
        arg0.chain_dest
    }

    public fun coin_metadata_id(arg0: &MctpInitOrderParams) : 0x2::object::ID {
        arg0.coin_metadata_id
    }

    public fun deadline(arg0: &MctpInitOrderParams) : u64 {
        arg0.deadline
    }

    public fun fee_rate_mayan(arg0: &MctpInitOrderParams) : u8 {
        arg0.fee_rate_mayan
    }

    public fun fee_rate_ref(arg0: &MctpInitOrderParams) : u8 {
        arg0.fee_rate_ref
    }

    public fun fee_redeem(arg0: &MctpInitOrderParams) : u64 {
        arg0.fee_redeem
    }

    public fun gas_drop(arg0: &MctpInitOrderParams) : u64 {
        arg0.gas_drop
    }

    public fun payload_type(arg0: &MctpInitOrderParams) : u8 {
        arg0.payload_type
    }

    public fun prepare_calc_mctp_fee<T0>(arg0: &0x2::coin::CoinMetadata<T0>, arg1: u8, arg2: address, arg3: &0x2::coin::Coin<T0>, arg4: address, arg5: u16, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: address, arg12: u8) : 0xc6c1c12715051ddb959f431555def40dad7d2949b96e8dc44ce616aa06485b3c::mctp_init_order_params_ticket::MctpInitOrderParamsTicket {
        0xc6c1c12715051ddb959f431555def40dad7d2949b96e8dc44ce616aa06485b3c::mctp_init_order_params_ticket::new(arg1, arg2, 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg0), 0x2::coin::value<T0>(arg3), arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
    }

    public fun token_out(arg0: &MctpInitOrderParams) : address {
        arg0.token_out
    }

    public fun trader(arg0: &MctpInitOrderParams) : address {
        arg0.trader
    }

    // decompiled from Move bytecode v6
}

