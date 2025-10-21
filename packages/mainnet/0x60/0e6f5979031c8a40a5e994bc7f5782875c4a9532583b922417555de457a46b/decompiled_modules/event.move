module 0x600e6f5979031c8a40a5e994bc7f5782875c4a9532583b922417555de457a46b::event {
    struct SwapEvent has copy, drop {
        oracle_timestamp: u64,
        txn_timestamp: u64,
        version: bool,
        vault_sqrt_price: u128,
        vault_liquidity: u128,
        vault_sqrt_fee_factor: u128,
        dex_sqrt_price_adjusted: u128,
        remainder: u64,
        supply_before: u64,
        supply_after: u64,
        debt_before: u64,
        debt_after: u64,
    }

    public fun emit_event(arg0: u64, arg1: u64, arg2: bool, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u128, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: u64) {
        let v0 = if (arg2) {
            0x600e6f5979031c8a40a5e994bc7f5782875c4a9532583b922417555de457a46b::arithmetic::div_128(arg6, arg7)
        } else {
            0x600e6f5979031c8a40a5e994bc7f5782875c4a9532583b922417555de457a46b::arithmetic::mul_128(arg6, arg7)
        };
        let v1 = SwapEvent{
            oracle_timestamp        : arg0,
            txn_timestamp           : arg1,
            version                 : arg2,
            vault_sqrt_price        : arg3,
            vault_liquidity         : arg4,
            vault_sqrt_fee_factor   : arg5,
            dex_sqrt_price_adjusted : v0,
            remainder               : arg8,
            supply_before           : arg9,
            supply_after            : arg10,
            debt_before             : arg11,
            debt_after              : arg12,
        };
        0x2::event::emit<SwapEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

