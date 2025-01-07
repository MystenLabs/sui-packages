module 0xcbb557e5bea3a3d0403eae8dbcfd8791d6e989eb91e1a5519b395c68e38f4317::calculate_swift_fee {
    struct SwiftInitParams has drop {
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
        penalty_period: u64,
        addr_ref: address,
        fee_rate_ref: u8,
        fee_rate_mayan: u8,
        auction_mode: u8,
        base_bond: u64,
        per_bps_bond: u64,
    }

    public fun calculate_swift_fee(arg0: &0xcbb557e5bea3a3d0403eae8dbcfd8791d6e989eb91e1a5519b395c68e38f4317::state::FeeManagerState, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: address, arg5: u16, arg6: address, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64, arg13: address, arg14: u8, arg15: u8, arg16: u64, arg17: u64, arg18: &mut 0x2::tx_context::TxContext) : SwiftInitParams {
        0xcbb557e5bea3a3d0403eae8dbcfd8791d6e989eb91e1a5519b395c68e38f4317::state::assert_valid_version(arg0);
        SwiftInitParams{
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
            fee_rate_mayan   : 3,
            auction_mode     : arg15,
            base_bond        : arg16,
            per_bps_bond     : arg17,
        }
    }

    public fun unpack_swift_init_params(arg0: SwiftInitParams) : (address, 0x2::object::ID, u64, address, u16, address, u64, u64, u64, u64, u64, u64, address, u8, u8, u8, u64, u64) {
        (arg0.trader, arg0.coin_metadata_id, arg0.amount_in_min, arg0.addr_dest, arg0.chain_dest, arg0.token_out, arg0.amount_out_min, arg0.gas_drop, arg0.fee_cancel, arg0.fee_refund, arg0.deadline, arg0.penalty_period, arg0.addr_ref, arg0.fee_rate_ref, arg0.fee_rate_mayan, arg0.auction_mode, arg0.base_bond, arg0.per_bps_bond)
    }

    // decompiled from Move bytecode v6
}

