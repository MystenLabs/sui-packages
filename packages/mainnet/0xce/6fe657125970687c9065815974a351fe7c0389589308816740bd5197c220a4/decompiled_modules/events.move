module 0xd4e097d82d73dc5d152f277bd17ba7980cad4c0b238c3609517cbd0cf686ddd1::events {
    struct PoolStateEvent has copy, drop {
        ramm_id: 0x2::object::ID,
        sender: address,
        asset_types: vector<0x1::type_name::TypeName>,
        asset_balances: vector<u256>,
        asset_lpt_issued: vector<u256>,
    }

    struct TradeIn {
        dummy_field: bool,
    }

    struct TradeOut {
        dummy_field: bool,
    }

    struct TradeEvent<phantom T0> has copy, drop {
        ramm_id: 0x2::object::ID,
        trader: address,
        token_in: 0x1::type_name::TypeName,
        token_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        protocol_fee: u64,
    }

    struct PriceEstimationEvent has copy, drop {
        ramm_id: 0x2::object::ID,
        trader: address,
        token_in: 0x1::type_name::TypeName,
        token_out: 0x1::type_name::TypeName,
        amount_in: u64,
        amount_out: u64,
        protocol_fee: u64,
    }

    struct LiquidityDepositEvent has copy, drop {
        ramm_id: 0x2::object::ID,
        trader: address,
        token_in: 0x1::type_name::TypeName,
        amount_in: u64,
        lpt: u64,
    }

    struct LiquidityWithdrawalEvent has copy, drop {
        ramm_id: 0x2::object::ID,
        trader: address,
        token_out: 0x1::type_name::TypeName,
        lpt: u64,
        amounts_out: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
        fees: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct ImbalanceRatioEvent has copy, drop {
        ramm_id: 0x2::object::ID,
        requester: address,
        imb_ratios: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    struct FeeCollectionEvent has copy, drop {
        ramm_id: 0x2::object::ID,
        admin: address,
        fee_collector: address,
        collected_fees: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>,
    }

    public(friend) fun fee_collection_event(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let v0 = FeeCollectionEvent{
            ramm_id        : arg0,
            admin          : arg1,
            fee_collector  : arg2,
            collected_fees : arg3,
        };
        0x2::event::emit<FeeCollectionEvent>(v0);
    }

    public(friend) fun imbalance_ratios_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let v0 = ImbalanceRatioEvent{
            ramm_id    : arg0,
            requester  : arg1,
            imb_ratios : arg2,
        };
        0x2::event::emit<ImbalanceRatioEvent>(v0);
    }

    public(friend) fun liquidity_deposit_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: u64) {
        let v0 = LiquidityDepositEvent{
            ramm_id   : arg0,
            trader    : arg1,
            token_in  : arg2,
            amount_in : arg3,
            lpt       : arg4,
        };
        0x2::event::emit<LiquidityDepositEvent>(v0);
    }

    public(friend) fun liquidity_withdrawal_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>, arg5: 0x2::vec_map::VecMap<0x1::type_name::TypeName, u64>) {
        let v0 = LiquidityWithdrawalEvent{
            ramm_id     : arg0,
            trader      : arg1,
            token_out   : arg2,
            lpt         : arg3,
            amounts_out : arg4,
            fees        : arg5,
        };
        0x2::event::emit<LiquidityWithdrawalEvent>(v0);
    }

    public(friend) fun pool_state_event(arg0: 0x2::object::ID, arg1: address, arg2: vector<0x1::type_name::TypeName>, arg3: vector<u256>, arg4: vector<u256>) {
        let v0 = PoolStateEvent{
            ramm_id          : arg0,
            sender           : arg1,
            asset_types      : arg2,
            asset_balances   : arg3,
            asset_lpt_issued : arg4,
        };
        0x2::event::emit<PoolStateEvent>(v0);
    }

    public(friend) fun price_estimation_event(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = PriceEstimationEvent{
            ramm_id      : arg0,
            trader       : arg1,
            token_in     : arg2,
            token_out    : arg3,
            amount_in    : arg4,
            amount_out   : arg5,
            protocol_fee : arg6,
        };
        0x2::event::emit<PriceEstimationEvent>(v0);
    }

    public(friend) fun trade_event<T0>(arg0: 0x2::object::ID, arg1: address, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = TradeEvent<T0>{
            ramm_id      : arg0,
            trader       : arg1,
            token_in     : arg2,
            token_out    : arg3,
            amount_in    : arg4,
            amount_out   : arg5,
            protocol_fee : arg6,
        };
        0x2::event::emit<TradeEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

