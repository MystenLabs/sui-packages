module 0x9164ad1e4a094a9148a972ef4266a7406f34a0d8d765ddb5c67af51fae1939d0::recorder {
    struct RecorderCap has store, key {
        id: 0x2::object::UID,
    }

    struct DailyTradingPairDataEvent has copy, drop {
        trading_token_A: 0x1::ascii::String,
        trading_token_B: 0x1::ascii::String,
        trading_volume_amount_A: u256,
        trading_volume_amount_B: u256,
        open_interest_value: u256,
        value_decimals: u8,
        date: 0x1::ascii::String,
        ref_id: u64,
        trading_pair_id: u64,
    }

    struct DailySummaryDataEvent has copy, drop {
        daily_active_users_count: u256,
        daily_open_interest: u256,
        daily_maker_fee: u256,
        daily_taker_fee: u256,
        daily_total_fee: u256,
        value_decimals: u8,
        date: 0x1::ascii::String,
        ref_id: u64,
    }

    public fun emit_daily_summary_data_event(arg0: &RecorderCap, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u8, arg7: u64, arg8: u64, arg9: u64, arg10: u64) {
        let v0 = 0x1::u64::to_string(arg7);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg8));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg9));
        let v1 = DailySummaryDataEvent{
            daily_active_users_count : arg1,
            daily_open_interest      : arg2,
            daily_maker_fee          : arg3,
            daily_taker_fee          : arg4,
            daily_total_fee          : arg5,
            value_decimals           : arg6,
            date                     : 0x1::string::to_ascii(v0),
            ref_id                   : arg10,
        };
        0x2::event::emit<DailySummaryDataEvent>(v1);
    }

    public fun emit_daily_trading_pair_data_event<T0, T1>(arg0: &RecorderCap, arg1: u256, arg2: u256, arg3: u256, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = 0x1::u64::to_string(arg5);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg6));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg7));
        let v1 = DailyTradingPairDataEvent{
            trading_token_A         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            trading_token_B         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            trading_volume_amount_A : arg1,
            trading_volume_amount_B : arg2,
            open_interest_value     : arg3,
            value_decimals          : arg4,
            date                    : 0x1::string::to_ascii(v0),
            ref_id                  : arg8,
            trading_pair_id         : arg9,
        };
        0x2::event::emit<DailyTradingPairDataEvent>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RecorderCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RecorderCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = RecorderCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RecorderCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

