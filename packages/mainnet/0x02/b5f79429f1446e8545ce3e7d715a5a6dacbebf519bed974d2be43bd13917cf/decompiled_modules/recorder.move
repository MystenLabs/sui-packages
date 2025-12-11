module 0x2b5f79429f1446e8545ce3e7d715a5a6dacbebf519bed974d2be43bd13917cf::recorder {
    struct RecorderCap has store, key {
        id: 0x2::object::UID,
    }

    struct DailyTradingPairDataEvent has copy, drop {
        trading_token: 0x1::ascii::String,
        trading_volume_value: u256,
        open_interest_value: u256,
        value_decimals: u8,
        date: 0x1::ascii::String,
        ref_id: u64,
        trading_pair_id: u64,
    }

    struct DailySummaryDataEvent has copy, drop {
        daily_active_users_count: u256,
        daily_open_interest: u256,
        daily_maker_trade_fee: u256,
        daily_taker_trade_fee: u256,
        daily_total_trade_fee: u256,
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
        let v1 = DailySummaryDataEvent{
            daily_active_users_count : arg0,
            daily_open_interest      : arg1,
            daily_maker_trade_fee    : arg2,
            daily_taker_trade_fee    : arg3,
            daily_total_trade_fee    : arg4,
            value_decimals           : arg5,
            date                     : 0x1::string::to_ascii(v0),
            ref_id                   : arg9,
        };
        0x2::event::emit<DailySummaryDataEvent>(v1);
    }

    public fun emit_daily_trading_pair_data_event<T0>(arg0: u256, arg1: u256, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = 0x1::u64::to_string(arg3);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg4));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg5));
        let v1 = DailyTradingPairDataEvent{
            trading_token        : 0x1::type_name::into_string(0x1::type_name::with_defining_ids<T0>()),
            trading_volume_value : arg0,
            open_interest_value  : arg1,
            value_decimals       : arg2,
            date                 : 0x1::string::to_ascii(v0),
            ref_id               : arg6,
            trading_pair_id      : arg7,
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

