module 0x83a3afdf23a18e024abdbdbd10dc5b1caad415d412ec94e169b8545b421966f4::suilend_reserve {
    struct ReserveAssetDataEventV2<phantom T0> has copy, drop {
        lending_market_id: address,
        coin_type: 0x1::type_name::TypeName,
        reserve_id: address,
        available_amount: u256,
        supply_amount: u256,
        borrowed_amount: u256,
        available_amount_usd_estimate: u256,
        supply_amount_usd_estimate: u256,
        borrowed_amount_usd_estimate: u256,
        borrow_apr: u256,
        supply_apr: u256,
        ctoken_supply: u64,
        cumulative_borrow_rate: u256,
        price: u256,
        smoothed_price: u256,
        price_last_update_timestamp_s: u64,
        conf: u256,
        unclamped_price: u256,
        unclamped_smoothed_price: u256,
    }

    public fun emit_reserve_asset_data_v2<T0: drop>(arg0: T0, arg1: address, arg2: 0x1::type_name::TypeName, arg3: address, arg4: u256, arg5: u256, arg6: u256, arg7: u256, arg8: u256, arg9: u256, arg10: u256, arg11: u256, arg12: u64, arg13: u256, arg14: u256, arg15: u256, arg16: u64, arg17: u256, arg18: u256, arg19: u256) {
        let v0 = ReserveAssetDataEventV2<T0>{
            lending_market_id             : arg1,
            coin_type                     : arg2,
            reserve_id                    : arg3,
            available_amount              : arg4,
            supply_amount                 : arg5,
            borrowed_amount               : arg6,
            available_amount_usd_estimate : arg7,
            supply_amount_usd_estimate    : arg8,
            borrowed_amount_usd_estimate  : arg9,
            borrow_apr                    : arg10,
            supply_apr                    : arg11,
            ctoken_supply                 : arg12,
            cumulative_borrow_rate        : arg13,
            price                         : arg14,
            smoothed_price                : arg15,
            price_last_update_timestamp_s : arg16,
            conf                          : arg17,
            unclamped_price               : arg18,
            unclamped_smoothed_price      : arg19,
        };
        0x2::event::emit<ReserveAssetDataEventV2<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

