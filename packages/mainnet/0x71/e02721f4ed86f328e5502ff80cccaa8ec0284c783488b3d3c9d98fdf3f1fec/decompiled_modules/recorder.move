module 0x71e02721f4ed86f328e5502ff80cccaa8ec0284c783488b3d3c9d98fdf3f1fec::recorder {
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

    struct AssetInfo has copy, drop, store {
        name: 0x1::ascii::String,
        quantity: 0x1::ascii::String,
    }

    struct PositionInfo has copy, drop, store {
        average_entry_price: 0x1::ascii::String,
        is_isolated: bool,
        is_long: bool,
        leverage: 0x1::ascii::String,
        margin: 0x1::ascii::String,
        pending_funding_payment: 0x1::ascii::String,
        perpetual: 0x1::ascii::String,
        size: 0x1::ascii::String,
    }

    struct MakerInfo has copy, drop, store {
        user_address: 0x1::ascii::String,
        assets: vector<AssetInfo>,
        fee_asset: 0x1::ascii::String,
        fee_token_qty: 0x1::ascii::String,
        fee_usd_qty: 0x1::ascii::String,
        order_hash: vector<u64>,
        position: PositionInfo,
    }

    struct TakerInfo has copy, drop, store {
        user_address: 0x1::ascii::String,
        assets: vector<AssetInfo>,
        fee_asset: 0x1::ascii::String,
        fee_token_qty: 0x1::ascii::String,
        fee_usd_qty: 0x1::ascii::String,
        order_hash: vector<u64>,
        position: PositionInfo,
    }

    struct TradeExecutedEvent has copy, drop {
        fill_price: 0x1::ascii::String,
        fill_quantity: 0x1::ascii::String,
        market: 0x1::ascii::String,
        taker_side: 0x1::ascii::String,
        taker_gas_fee: 0x1::ascii::String,
        ref_id: u64,
        maker: MakerInfo,
        taker: TakerInfo,
    }

    public fun create_asset_info_vector(arg0: vector<0x1::ascii::String>, arg1: vector<0x1::ascii::String>) : vector<AssetInfo> {
        let v0 = 0x1::vector::empty<AssetInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg0)) {
            let v2 = AssetInfo{
                name     : *0x1::vector::borrow<0x1::ascii::String>(&arg0, v1),
                quantity : *0x1::vector::borrow<0x1::ascii::String>(&arg1, v1),
            };
            0x1::vector::push_back<AssetInfo>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun create_maker_info(arg0: 0x1::ascii::String, arg1: vector<AssetInfo>, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: vector<u64>, arg6: PositionInfo) : MakerInfo {
        MakerInfo{
            user_address  : arg0,
            assets        : arg1,
            fee_asset     : arg2,
            fee_token_qty : arg3,
            fee_usd_qty   : arg4,
            order_hash    : arg5,
            position      : arg6,
        }
    }

    public fun create_position_info(arg0: 0x1::ascii::String, arg1: bool, arg2: bool, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: 0x1::ascii::String, arg7: 0x1::ascii::String) : PositionInfo {
        PositionInfo{
            average_entry_price     : arg0,
            is_isolated             : arg1,
            is_long                 : arg2,
            leverage                : arg3,
            margin                  : arg4,
            pending_funding_payment : arg5,
            perpetual               : arg6,
            size                    : arg7,
        }
    }

    public fun create_taker_info(arg0: 0x1::ascii::String, arg1: vector<AssetInfo>, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: vector<u64>, arg6: PositionInfo) : TakerInfo {
        TakerInfo{
            user_address  : arg0,
            assets        : arg1,
            fee_asset     : arg2,
            fee_token_qty : arg3,
            fee_usd_qty   : arg4,
            order_hash    : arg5,
            position      : arg6,
        }
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
            daily_maker_trade_fee    : arg3,
            daily_taker_trade_fee    : arg4,
            daily_total_trade_fee    : arg5,
            value_decimals           : arg6,
            date                     : 0x1::string::to_ascii(v0),
            ref_id                   : arg10,
        };
        0x2::event::emit<DailySummaryDataEvent>(v1);
    }

    public fun emit_daily_trading_pair_data_event(arg0: &RecorderCap, arg1: 0x1::ascii::String, arg2: u256, arg3: u256, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = 0x1::u64::to_string(arg5);
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg6));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"/"));
        0x1::string::append(&mut v0, 0x1::u64::to_string(arg7));
        let v1 = DailyTradingPairDataEvent{
            trading_token        : arg1,
            trading_volume_value : arg2,
            open_interest_value  : arg3,
            value_decimals       : arg4,
            date                 : 0x1::string::to_ascii(v0),
            ref_id               : arg8,
            trading_pair_id      : arg9,
        };
        0x2::event::emit<DailyTradingPairDataEvent>(v1);
    }

    public fun emit_trade_executed_event(arg0: &RecorderCap, arg1: 0x1::ascii::String, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: 0x1::ascii::String, arg6: u64, arg7: MakerInfo, arg8: TakerInfo) {
        let v0 = TradeExecutedEvent{
            fill_price    : arg1,
            fill_quantity : arg2,
            market        : arg3,
            taker_side    : arg4,
            taker_gas_fee : arg5,
            ref_id        : arg6,
            maker         : arg7,
            taker         : arg8,
        };
        0x2::event::emit<TradeExecutedEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RecorderCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RecorderCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = RecorderCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<RecorderCap>(v1, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

