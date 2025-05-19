module 0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::event {
    struct AddLiquidityEvent has copy, drop {
        lp_name: 0x1::string::String,
        coin_x_val: u64,
        coin_y_val: u64,
        lp_val: u64,
    }

    struct RemoveLiquidityEvent has copy, drop {
        lp_name: 0x1::string::String,
        coin_x_val: u64,
        coin_y_val: u64,
        lp_val: u64,
    }

    struct SwapEvent has copy, drop {
        lp_name: 0x1::string::String,
        value_x_in: u64,
        value_x_out: u64,
        value_y_in: u64,
        value_y_out: u64,
        fee_x: u64,
        fee_y: u64,
    }

    struct AdminAddOperatorsEvent has copy, drop {
        admin: address,
        add_operators: vector<address>,
    }

    struct AdminRemoveOperatorsEvent has copy, drop {
        admin: address,
        remove_operators: vector<address>,
    }

    struct AdminTransferAdminCapEvent has copy, drop {
        admin: address,
        new_admin: address,
    }

    struct AdminWithdrawEvent has copy, drop {
        admin: address,
        receiver: address,
        pool_address: address,
        lp_name: 0x1::string::String,
        fee_coin_x: u64,
        fee_coin_y: u64,
    }

    struct AdminUpgradeEvent has copy, drop {
        admin: address,
    }

    struct OperatorCreatePoolEvent has copy, drop {
        operator: address,
        pool_address: address,
        lp_name: 0x1::string::String,
        fee_rate: u64,
    }

    struct OperatorPauseEvent has copy, drop {
        operator: address,
    }

    struct OperatorResumeEvent has copy, drop {
        operator: address,
    }

    struct OperatorControlProtocolFeeSwitchEvent has copy, drop {
        operator: address,
        is_open_protocol_fee: bool,
    }

    struct OperatorModifyFeeRateEvent has copy, drop {
        operator: address,
        pool_address: address,
        new_fee_rate: u64,
    }

    struct OperatorModifyMinAddLiquidityLPAmountEvent has copy, drop {
        operator: address,
        pool_address: address,
        new_min_add_liquidity_lp_amount: u64,
    }

    public(friend) fun add_liquidity_event(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = AddLiquidityEvent{
            lp_name    : arg0,
            coin_x_val : arg1,
            coin_y_val : arg2,
            lp_val     : arg3,
        };
        0x2::event::emit<AddLiquidityEvent>(v0);
    }

    public(friend) fun admin_add_operators_event(arg0: address, arg1: vector<address>) {
        let v0 = AdminAddOperatorsEvent{
            admin         : arg0,
            add_operators : arg1,
        };
        0x2::event::emit<AdminAddOperatorsEvent>(v0);
    }

    public(friend) fun admin_remove_operators_event(arg0: address, arg1: vector<address>) {
        let v0 = AdminRemoveOperatorsEvent{
            admin            : arg0,
            remove_operators : arg1,
        };
        0x2::event::emit<AdminRemoveOperatorsEvent>(v0);
    }

    public(friend) fun admin_transfer_admin_cap_event(arg0: address, arg1: address) {
        let v0 = AdminTransferAdminCapEvent{
            admin     : arg0,
            new_admin : arg1,
        };
        0x2::event::emit<AdminTransferAdminCapEvent>(v0);
    }

    public(friend) fun admin_upgrade_event(arg0: address) {
        let v0 = AdminUpgradeEvent{admin: arg0};
        0x2::event::emit<AdminUpgradeEvent>(v0);
    }

    public(friend) fun admin_withdraw_event(arg0: address, arg1: address, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: u64) {
        let v0 = AdminWithdrawEvent{
            admin        : arg0,
            receiver     : arg1,
            pool_address : arg2,
            lp_name      : arg3,
            fee_coin_x   : arg4,
            fee_coin_y   : arg5,
        };
        0x2::event::emit<AdminWithdrawEvent>(v0);
    }

    public(friend) fun operator_control_protocol_fee_switch_event(arg0: address, arg1: bool) {
        let v0 = OperatorControlProtocolFeeSwitchEvent{
            operator             : arg0,
            is_open_protocol_fee : arg1,
        };
        0x2::event::emit<OperatorControlProtocolFeeSwitchEvent>(v0);
    }

    public(friend) fun operator_create_pool_event(arg0: address, arg1: address, arg2: 0x1::string::String, arg3: u64) {
        let v0 = OperatorCreatePoolEvent{
            operator     : arg0,
            pool_address : arg1,
            lp_name      : arg2,
            fee_rate     : arg3,
        };
        0x2::event::emit<OperatorCreatePoolEvent>(v0);
    }

    public(friend) fun operator_modify_fee_rate_event(arg0: address, arg1: address, arg2: u64) {
        let v0 = OperatorModifyFeeRateEvent{
            operator     : arg0,
            pool_address : arg1,
            new_fee_rate : arg2,
        };
        0x2::event::emit<OperatorModifyFeeRateEvent>(v0);
    }

    public(friend) fun operator_modify_min_add_liquidity_lp_amount_event(arg0: address, arg1: address, arg2: u64) {
        let v0 = OperatorModifyMinAddLiquidityLPAmountEvent{
            operator                        : arg0,
            pool_address                    : arg1,
            new_min_add_liquidity_lp_amount : arg2,
        };
        0x2::event::emit<OperatorModifyMinAddLiquidityLPAmountEvent>(v0);
    }

    public(friend) fun operator_pause_event(arg0: address) {
        let v0 = OperatorPauseEvent{operator: arg0};
        0x2::event::emit<OperatorPauseEvent>(v0);
    }

    public(friend) fun operator_resume_event(arg0: address) {
        let v0 = OperatorResumeEvent{operator: arg0};
        0x2::event::emit<OperatorResumeEvent>(v0);
    }

    public(friend) fun removed_liquidity_event(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = RemoveLiquidityEvent{
            lp_name    : arg0,
            coin_x_val : arg1,
            coin_y_val : arg2,
            lp_val     : arg3,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v0);
    }

    public(friend) fun swap_event(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = SwapEvent{
            lp_name     : arg0,
            value_x_in  : arg1,
            value_x_out : arg2,
            value_y_in  : arg3,
            value_y_out : arg4,
            fee_x       : arg5,
            fee_y       : arg6,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

