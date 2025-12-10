module 0x61e364efbad6491995efda065526c874cac10d951b70c4d9b6b3d13492b8a0aa::test_recorder {
    struct TestDailyTradingPairDataEvent has copy, drop {
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

    struct TestDailySummaryDataEvent has copy, drop {
        daily_active_users_count: u256,
        daily_open_interest: u256,
        daily_maker_fee: u256,
        daily_taker_fee: u256,
        daily_total_fee: u256,
        value_decimals: u8,
        date: 0x1::ascii::String,
        ref_id: u64,
    }

    public fun emit_daily_summary_data_event(arg0: u256, arg1: u256, arg2: u256, arg3: u256, arg4: u256, arg5: u8, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = 0x1::u64::to_string(arg6);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg7));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg8));
        let v1 = TestDailySummaryDataEvent{
            daily_active_users_count : arg0,
            daily_open_interest      : arg1,
            daily_maker_fee          : arg2,
            daily_taker_fee          : arg3,
            daily_total_fee          : arg4,
            value_decimals           : arg5,
            date                     : 0x1::string::to_ascii(v0),
            ref_id                   : arg9,
        };
        0x2::event::emit<TestDailySummaryDataEvent>(v1);
    }

    public fun emit_daily_trading_pair_data_event<T0, T1>(arg0: u256, arg1: u256, arg2: u256, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = 0x1::u64::to_string(arg4);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg5));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg6));
        let v1 = TestDailyTradingPairDataEvent{
            trading_token_A         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            trading_token_B         : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T1>()),
            trading_volume_amount_A : arg0,
            trading_volume_amount_B : arg1,
            open_interest_value     : arg2,
            value_decimals          : arg3,
            date                    : 0x1::string::to_ascii(v0),
            ref_id                  : arg7,
            trading_pair_id         : arg8,
        };
        0x2::event::emit<TestDailyTradingPairDataEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

