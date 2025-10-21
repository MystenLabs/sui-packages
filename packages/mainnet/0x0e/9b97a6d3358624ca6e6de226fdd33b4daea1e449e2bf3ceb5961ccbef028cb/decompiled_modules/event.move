module 0xe9b97a6d3358624ca6e6de226fdd33b4daea1e449e2bf3ceb5961ccbef028cb::event {
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

    public fun emit_event(arg0: u64, arg1: u64, arg2: bool, arg3: u128, arg4: u128, arg5: u128, arg6: u128, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = SwapEvent{
            oracle_timestamp        : arg0,
            txn_timestamp           : arg1,
            version                 : arg2,
            vault_sqrt_price        : arg3,
            vault_liquidity         : arg4,
            vault_sqrt_fee_factor   : arg5,
            dex_sqrt_price_adjusted : arg6,
            remainder               : arg7,
            supply_before           : arg8,
            supply_after            : arg9,
            debt_before             : arg10,
            debt_after              : arg11,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

