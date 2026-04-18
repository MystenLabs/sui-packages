module 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::events {
    struct PositionOpened has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        position_id: u64,
        base_type: 0x1::type_name::TypeName,
        wlp_type: 0x1::type_name::TypeName,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral_amount: u64,
        collateral_type: 0x1::type_name::TypeName,
        leverage_bps: u64,
        entry_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        open_fee_amount: u64,
        timestamp: u64,
        sender: address,
    }

    struct PositionClosed has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        position_id: u64,
        base_type: 0x1::type_name::TypeName,
        wlp_type: 0x1::type_name::TypeName,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral_type: 0x1::type_name::TypeName,
        exit_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        pnl_amount: u64,
        pnl_is_profit: bool,
        close_fee_amount: u64,
        funding_fee_amount: u64,
        borrow_fee_amount: u64,
        timestamp: u64,
        sender: address,
    }

    struct PositionModified has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        position_id: u64,
        base_type: 0x1::type_name::TypeName,
        wlp_type: 0x1::type_name::TypeName,
        is_long: bool,
        is_increase: bool,
        delta_size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        new_size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        new_collateral_amount: u64,
        collateral_type: 0x1::type_name::TypeName,
        execution_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        realized_pnl_amount: u64,
        pnl_is_profit: bool,
        fee_amount: u64,
        timestamp: u64,
        sender: address,
    }

    struct PositionLiquidated has copy, drop {
        account_object_address: address,
        liquidator_address: address,
        market_id: 0x2::object::ID,
        position_id: u64,
        base_type: 0x1::type_name::TypeName,
        wlp_type: 0x1::type_name::TypeName,
        is_long: bool,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral_amount: u64,
        collateral_type: 0x1::type_name::TypeName,
        liquidator_fee_amount: u64,
        insurance_fee_amount: u64,
        lp_pool_amount: u64,
        mark_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        timestamp: u64,
        sender: address,
    }

    struct CollateralModified has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        position_id: u64,
        base_type: 0x1::type_name::TypeName,
        wlp_type: 0x1::type_name::TypeName,
        is_increase: bool,
        delta_amount: u64,
        new_collateral_amount: u64,
        collateral_type: 0x1::type_name::TypeName,
        timestamp: u64,
        sender: address,
    }

    struct OrderCreated has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        order_id: u64,
        base_type: 0x1::type_name::TypeName,
        wlp_type: 0x1::type_name::TypeName,
        order_type: u8,
        is_long: bool,
        reduce_only: bool,
        linked_position_id: 0x1::option::Option<u64>,
        size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        trigger_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral_amount: u64,
        collateral_type: 0x1::type_name::TypeName,
        timestamp: u64,
        sender: address,
    }

    struct OrderCancelled has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        order_id: u64,
        base_type: 0x1::type_name::TypeName,
        wlp_type: 0x1::type_name::TypeName,
        withdrawal_collateral_amount: u64,
        collateral_type: 0x1::type_name::TypeName,
        timestamp: u64,
        sender: address,
    }

    struct OrderFilled has copy, drop {
        account_object_address: address,
        market_id: 0x2::object::ID,
        order_id: u64,
        base_type: 0x1::type_name::TypeName,
        wlp_type: 0x1::type_name::TypeName,
        position_id: u64,
        filled_price: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        filled_size: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        fee_amount: u64,
        volume_usd: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        collateral_type: 0x1::type_name::TypeName,
        timestamp: u64,
        sender: address,
    }

    struct FeeCollected has copy, drop {
        fee_type: u8,
        amount: u64,
        market_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct ProtocolFeeCollected has copy, drop {
        fee_address: address,
        amount: u64,
        market_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct WlpMinted has copy, drop {
        wlp_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        deposit_amount: u64,
        wlp_amount: u64,
        fee_amount: u64,
        timestamp: u64,
    }

    struct WlpRedeemRequested has copy, drop {
        user_address: address,
        wlp_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        wlp_amount: u64,
        request_id: u64,
        timestamp: u64,
    }

    struct WlpRedeemCancelled has copy, drop {
        user_address: address,
        wlp_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        request_id: u64,
        wlp_amount: u64,
        timestamp: u64,
    }

    struct WlpRedeemSettled has copy, drop {
        user_address: address,
        wlp_type: 0x1::type_name::TypeName,
        token_type: 0x1::type_name::TypeName,
        request_id: u64,
        redeem_amount: u64,
        fee_amount: u64,
        timestamp: u64,
    }

    struct FundingRateUpdated has copy, drop {
        market_id: 0x2::object::ID,
        funding_rate: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        cumulative_index: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double,
        long_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        short_oi: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float,
        timestamp: u64,
    }

    struct BorrowRateUpdated has copy, drop {
        token_type: 0x1::type_name::TypeName,
        borrow_rate: u64,
        cumulative_rate: u64,
        utilization_bps: u64,
        timestamp: u64,
    }

    struct AccountCreated has copy, drop {
        user_address: address,
        account_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct Deposited has copy, drop {
        account_object_address: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp: u64,
        sender: address,
    }

    struct Withdrawn has copy, drop {
        account_object_address: address,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        timestamp: u64,
        sender: address,
    }

    struct ReferralBound has copy, drop {
        user_address: address,
        referrer_address: address,
        code: u64,
        timestamp: u64,
    }

    struct ReferralVolumeRecorded has copy, drop {
        referrer_address: address,
        trader_address: address,
        volume_amount: u64,
        timestamp: u64,
    }

    struct SubAccountCreated has copy, drop {
        user_address: address,
        sub_account_id: 0x2::object::ID,
        name: 0x1::string::String,
        timestamp: u64,
    }

    struct SubAccountTransfer has copy, drop {
        user_address: address,
        sub_account_id: 0x2::object::ID,
        token_type: 0x1::type_name::TypeName,
        amount: u64,
        is_deposit: bool,
        timestamp: u64,
    }

    public(friend) fun emit_account_created(arg0: address, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = AccountCreated{
            user_address : arg0,
            account_id   : arg1,
            timestamp    : arg2,
        };
        0x2::event::emit<AccountCreated>(v0);
    }

    public(friend) fun emit_borrow_rate_updated(arg0: 0x1::type_name::TypeName, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = BorrowRateUpdated{
            token_type      : arg0,
            borrow_rate     : arg1,
            cumulative_rate : arg2,
            utilization_bps : arg3,
            timestamp       : arg4,
        };
        0x2::event::emit<BorrowRateUpdated>(v0);
    }

    public(friend) fun emit_collateral_modified(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: bool, arg6: u64, arg7: u64, arg8: 0x1::type_name::TypeName, arg9: u64, arg10: address) {
        let v0 = CollateralModified{
            account_object_address : arg0,
            market_id              : arg1,
            position_id            : arg2,
            base_type              : arg3,
            wlp_type               : arg4,
            is_increase            : arg5,
            delta_amount           : arg6,
            new_collateral_amount  : arg7,
            collateral_type        : arg8,
            timestamp              : arg9,
            sender                 : arg10,
        };
        0x2::event::emit<CollateralModified>(v0);
    }

    public(friend) fun emit_deposited(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: address) {
        let v0 = Deposited{
            account_object_address : arg0,
            token_type             : arg1,
            amount                 : arg2,
            timestamp              : arg3,
            sender                 : arg4,
        };
        0x2::event::emit<Deposited>(v0);
    }

    public(friend) fun emit_fee_collected(arg0: u8, arg1: u64, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = FeeCollected{
            fee_type  : arg0,
            amount    : arg1,
            market_id : arg2,
            timestamp : arg3,
        };
        0x2::event::emit<FeeCollected>(v0);
    }

    public(friend) fun emit_funding_rate_updated(arg0: 0x2::object::ID, arg1: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg2: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::double::Double, arg3: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg4: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg5: u64) {
        let v0 = FundingRateUpdated{
            market_id        : arg0,
            funding_rate     : arg1,
            cumulative_index : arg2,
            long_oi          : arg3,
            short_oi         : arg4,
            timestamp        : arg5,
        };
        0x2::event::emit<FundingRateUpdated>(v0);
    }

    public(friend) fun emit_order_cancelled(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: 0x1::type_name::TypeName, arg7: u64, arg8: address) {
        let v0 = OrderCancelled{
            account_object_address       : arg0,
            market_id                    : arg1,
            order_id                     : arg2,
            base_type                    : arg3,
            wlp_type                     : arg4,
            withdrawal_collateral_amount : arg5,
            collateral_type              : arg6,
            timestamp                    : arg7,
            sender                       : arg8,
        };
        0x2::event::emit<OrderCancelled>(v0);
    }

    public(friend) fun emit_order_created(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: u8, arg6: bool, arg7: bool, arg8: 0x1::option::Option<u64>, arg9: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg10: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg11: u64, arg12: 0x1::type_name::TypeName, arg13: u64, arg14: address) {
        let v0 = OrderCreated{
            account_object_address : arg0,
            market_id              : arg1,
            order_id               : arg2,
            base_type              : arg3,
            wlp_type               : arg4,
            order_type             : arg5,
            is_long                : arg6,
            reduce_only            : arg7,
            linked_position_id     : arg8,
            size                   : arg9,
            trigger_price          : arg10,
            collateral_amount      : arg11,
            collateral_type        : arg12,
            timestamp              : arg13,
            sender                 : arg14,
        };
        0x2::event::emit<OrderCreated>(v0);
    }

    public(friend) fun emit_order_filled(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: u64, arg6: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg7: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg8: u64, arg9: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg10: 0x1::type_name::TypeName, arg11: u64, arg12: address) {
        let v0 = OrderFilled{
            account_object_address : arg0,
            market_id              : arg1,
            order_id               : arg2,
            base_type              : arg3,
            wlp_type               : arg4,
            position_id            : arg5,
            filled_price           : arg6,
            filled_size            : arg7,
            fee_amount             : arg8,
            volume_usd             : arg9,
            collateral_type        : arg10,
            timestamp              : arg11,
            sender                 : arg12,
        };
        0x2::event::emit<OrderFilled>(v0);
    }

    public(friend) fun emit_position_closed(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: bool, arg6: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg7: 0x1::type_name::TypeName, arg8: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg9: u64, arg10: bool, arg11: u64, arg12: u64, arg13: u64, arg14: u64, arg15: address) {
        let v0 = PositionClosed{
            account_object_address : arg0,
            market_id              : arg1,
            position_id            : arg2,
            base_type              : arg3,
            wlp_type               : arg4,
            is_long                : arg5,
            size                   : arg6,
            collateral_type        : arg7,
            exit_price             : arg8,
            pnl_amount             : arg9,
            pnl_is_profit          : arg10,
            close_fee_amount       : arg11,
            funding_fee_amount     : arg12,
            borrow_fee_amount      : arg13,
            timestamp              : arg14,
            sender                 : arg15,
        };
        0x2::event::emit<PositionClosed>(v0);
    }

    public(friend) fun emit_position_liquidated(arg0: address, arg1: address, arg2: 0x2::object::ID, arg3: u64, arg4: 0x1::type_name::TypeName, arg5: 0x1::type_name::TypeName, arg6: bool, arg7: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg8: u64, arg9: 0x1::type_name::TypeName, arg10: u64, arg11: u64, arg12: u64, arg13: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg14: u64, arg15: address) {
        let v0 = PositionLiquidated{
            account_object_address : arg0,
            liquidator_address     : arg1,
            market_id              : arg2,
            position_id            : arg3,
            base_type              : arg4,
            wlp_type               : arg5,
            is_long                : arg6,
            size                   : arg7,
            collateral_amount      : arg8,
            collateral_type        : arg9,
            liquidator_fee_amount  : arg10,
            insurance_fee_amount   : arg11,
            lp_pool_amount         : arg12,
            mark_price             : arg13,
            timestamp              : arg14,
            sender                 : arg15,
        };
        0x2::event::emit<PositionLiquidated>(v0);
    }

    public(friend) fun emit_position_modified(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: bool, arg6: bool, arg7: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg8: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg9: u64, arg10: 0x1::type_name::TypeName, arg11: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg12: u64, arg13: bool, arg14: u64, arg15: u64, arg16: address) {
        let v0 = PositionModified{
            account_object_address : arg0,
            market_id              : arg1,
            position_id            : arg2,
            base_type              : arg3,
            wlp_type               : arg4,
            is_long                : arg5,
            is_increase            : arg6,
            delta_size             : arg7,
            new_size               : arg8,
            new_collateral_amount  : arg9,
            collateral_type        : arg10,
            execution_price        : arg11,
            realized_pnl_amount    : arg12,
            pnl_is_profit          : arg13,
            fee_amount             : arg14,
            timestamp              : arg15,
            sender                 : arg16,
        };
        0x2::event::emit<PositionModified>(v0);
    }

    public(friend) fun emit_position_opened(arg0: address, arg1: 0x2::object::ID, arg2: u64, arg3: 0x1::type_name::TypeName, arg4: 0x1::type_name::TypeName, arg5: bool, arg6: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg7: u64, arg8: 0x1::type_name::TypeName, arg9: u64, arg10: 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::float::Float, arg11: u64, arg12: u64, arg13: address) {
        let v0 = PositionOpened{
            account_object_address : arg0,
            market_id              : arg1,
            position_id            : arg2,
            base_type              : arg3,
            wlp_type               : arg4,
            is_long                : arg5,
            size                   : arg6,
            collateral_amount      : arg7,
            collateral_type        : arg8,
            leverage_bps           : arg9,
            entry_price            : arg10,
            open_fee_amount        : arg11,
            timestamp              : arg12,
            sender                 : arg13,
        };
        0x2::event::emit<PositionOpened>(v0);
    }

    public(friend) fun emit_protocol_fee_collected(arg0: address, arg1: u64, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = ProtocolFeeCollected{
            fee_address : arg0,
            amount      : arg1,
            market_id   : arg2,
            timestamp   : arg3,
        };
        0x2::event::emit<ProtocolFeeCollected>(v0);
    }

    public(friend) fun emit_referral_bound(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = ReferralBound{
            user_address     : arg0,
            referrer_address : arg1,
            code             : arg2,
            timestamp        : arg3,
        };
        0x2::event::emit<ReferralBound>(v0);
    }

    public(friend) fun emit_referral_volume_recorded(arg0: address, arg1: address, arg2: u64, arg3: u64) {
        let v0 = ReferralVolumeRecorded{
            referrer_address : arg0,
            trader_address   : arg1,
            volume_amount    : arg2,
            timestamp        : arg3,
        };
        0x2::event::emit<ReferralVolumeRecorded>(v0);
    }

    public(friend) fun emit_sub_account_created(arg0: address, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: u64) {
        let v0 = SubAccountCreated{
            user_address   : arg0,
            sub_account_id : arg1,
            name           : arg2,
            timestamp      : arg3,
        };
        0x2::event::emit<SubAccountCreated>(v0);
    }

    public(friend) fun emit_sub_account_transfer(arg0: address, arg1: 0x2::object::ID, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: bool, arg5: u64) {
        let v0 = SubAccountTransfer{
            user_address   : arg0,
            sub_account_id : arg1,
            token_type     : arg2,
            amount         : arg3,
            is_deposit     : arg4,
            timestamp      : arg5,
        };
        0x2::event::emit<SubAccountTransfer>(v0);
    }

    public(friend) fun emit_withdrawn(arg0: address, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: address) {
        let v0 = Withdrawn{
            account_object_address : arg0,
            token_type             : arg1,
            amount                 : arg2,
            timestamp              : arg3,
            sender                 : arg4,
        };
        0x2::event::emit<Withdrawn>(v0);
    }

    public(friend) fun emit_wlp_minted(arg0: 0x1::type_name::TypeName, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = WlpMinted{
            wlp_type       : arg0,
            token_type     : arg1,
            deposit_amount : arg2,
            wlp_amount     : arg3,
            fee_amount     : arg4,
            timestamp      : arg5,
        };
        0x2::event::emit<WlpMinted>(v0);
    }

    public(friend) fun emit_wlp_redeem_cancelled(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = WlpRedeemCancelled{
            user_address : arg0,
            wlp_type     : arg1,
            token_type   : arg2,
            request_id   : arg3,
            wlp_amount   : arg4,
            timestamp    : arg5,
        };
        0x2::event::emit<WlpRedeemCancelled>(v0);
    }

    public(friend) fun emit_wlp_redeem_requested(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = WlpRedeemRequested{
            user_address : arg0,
            wlp_type     : arg1,
            token_type   : arg2,
            wlp_amount   : arg3,
            request_id   : arg4,
            timestamp    : arg5,
        };
        0x2::event::emit<WlpRedeemRequested>(v0);
    }

    public(friend) fun emit_wlp_redeem_settled(arg0: address, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = WlpRedeemSettled{
            user_address  : arg0,
            wlp_type      : arg1,
            token_type    : arg2,
            request_id    : arg3,
            redeem_amount : arg4,
            fee_amount    : arg5,
            timestamp     : arg6,
        };
        0x2::event::emit<WlpRedeemSettled>(v0);
    }

    // decompiled from Move bytecode v7
}

