module 0x4b0eaa3a6bf37c55ee2733f5b6f78683a52b867367133c1f5d830314c147fbdd::event {
    struct PauseEvent has copy, drop {
        dummy_field: bool,
    }

    struct ResumeEvent has copy, drop {
        dummy_field: bool,
    }

    struct CollectFeeEvent has copy, drop {
        pool_name: 0x1::string::String,
        coin_a_fee: u64,
        coin_b_fee: u64,
    }

    struct CreateAdminCapEvent has copy, drop {
        sender: address,
        receiver: address,
    }

    struct ChangeBeneficiaryEvent has copy, drop {
        old_beneficiary: address,
        new_beneficiary: address,
    }

    struct ChangeSwapFeeEvent has copy, drop {
        old_swap_fee: u64,
        new_swap_fee: u64,
    }

    struct ChangeBeneficiaryProfitEvent has copy, drop {
        old_beneficiary_profit: u64,
        new_beneficiary_profit: u64,
    }

    struct RegisterPoolEvent has copy, drop {
        sender: address,
        pool_name: 0x1::string::String,
    }

    struct AddLiquidityEvent has copy, drop {
        sender: address,
        pool_name: 0x1::string::String,
        coin_a_amount: u64,
        coin_b_amount: u64,
        lp_amount: u64,
    }

    struct RemoveLiquidityEvent has copy, drop {
        sender: address,
        pool_name: 0x1::string::String,
        coin_a_amount: u64,
        coin_b_amount: u64,
        lp_amount: u64,
    }

    struct SwapEvent has copy, drop {
        sender: address,
        pool_name: 0x1::string::String,
        coin_a_in_amount: u64,
        coin_a_out_amount: u64,
        coin_b_in_amount: u64,
        coin_b_out_amount: u64,
    }

    struct RegisterFarmPoolEvent has copy, drop {
        pool_name: 0x1::string::String,
        reward_token: 0x1::string::String,
        reward_amount: u64,
        duration: u64,
        decimalS: u8,
        decimalR: u8,
        duration_unstake_time_ms: u64,
        max_stake_value: u64,
    }

    struct StakeLPEvent has copy, drop {
        sender: address,
        pool_name: 0x1::string::String,
        reward_token: 0x1::string::String,
        amount: u64,
    }

    struct UnstakeLPEvent has copy, drop {
        sender: address,
        pool_name: 0x1::string::String,
        reward_token: 0x1::string::String,
        amount: u64,
    }

    struct HarvestLPEvent has copy, drop {
        sender: address,
        pool_name: 0x1::string::String,
        reward_token: 0x1::string::String,
        amount: u64,
    }

    public(friend) fun emit_add_liquidity_event(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = AddLiquidityEvent{
            sender        : arg0,
            pool_name     : arg1,
            coin_a_amount : arg2,
            coin_b_amount : arg3,
            lp_amount     : arg4,
        };
        0x2::event::emit<AddLiquidityEvent>(v0);
    }

    public(friend) fun emit_change_beneficiary_event(arg0: address, arg1: address) {
        let v0 = ChangeBeneficiaryEvent{
            old_beneficiary : arg0,
            new_beneficiary : arg1,
        };
        0x2::event::emit<ChangeBeneficiaryEvent>(v0);
    }

    public(friend) fun emit_change_beneficiary_profit_event(arg0: u64, arg1: u64) {
        let v0 = ChangeBeneficiaryProfitEvent{
            old_beneficiary_profit : arg0,
            new_beneficiary_profit : arg1,
        };
        0x2::event::emit<ChangeBeneficiaryProfitEvent>(v0);
    }

    public(friend) fun emit_change_swap_fee_event(arg0: u64, arg1: u64) {
        let v0 = ChangeSwapFeeEvent{
            old_swap_fee : arg0,
            new_swap_fee : arg1,
        };
        0x2::event::emit<ChangeSwapFeeEvent>(v0);
    }

    public(friend) fun emit_collect_fee_event(arg0: 0x1::string::String, arg1: u64, arg2: u64) {
        let v0 = CollectFeeEvent{
            pool_name  : arg0,
            coin_a_fee : arg1,
            coin_b_fee : arg2,
        };
        0x2::event::emit<CollectFeeEvent>(v0);
    }

    public(friend) fun emit_create_admin_cap_event(arg0: address, arg1: address) {
        let v0 = CreateAdminCapEvent{
            sender   : arg0,
            receiver : arg1,
        };
        0x2::event::emit<CreateAdminCapEvent>(v0);
    }

    public(friend) fun emit_harvest_lp_event(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64) {
        let v0 = HarvestLPEvent{
            sender       : arg0,
            pool_name    : arg1,
            reward_token : arg2,
            amount       : arg3,
        };
        0x2::event::emit<HarvestLPEvent>(v0);
    }

    public(friend) fun emit_pause_event() {
        let v0 = PauseEvent{dummy_field: false};
        0x2::event::emit<PauseEvent>(v0);
    }

    public(friend) fun emit_register_farm_pool_event(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u8, arg5: u8, arg6: u64, arg7: u64) {
        let v0 = RegisterFarmPoolEvent{
            pool_name                : arg0,
            reward_token             : arg1,
            reward_amount            : arg2,
            duration                 : arg3,
            decimalS                 : arg4,
            decimalR                 : arg5,
            duration_unstake_time_ms : arg6,
            max_stake_value          : arg7,
        };
        0x2::event::emit<RegisterFarmPoolEvent>(v0);
    }

    public(friend) fun emit_register_pool_event(arg0: address, arg1: 0x1::string::String) {
        let v0 = RegisterPoolEvent{
            sender    : arg0,
            pool_name : arg1,
        };
        0x2::event::emit<RegisterPoolEvent>(v0);
    }

    public(friend) fun emit_remove_liquidity_event(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = RemoveLiquidityEvent{
            sender        : arg0,
            pool_name     : arg1,
            coin_a_amount : arg2,
            coin_b_amount : arg3,
            lp_amount     : arg4,
        };
        0x2::event::emit<RemoveLiquidityEvent>(v0);
    }

    public(friend) fun emit_resume_event() {
        let v0 = ResumeEvent{dummy_field: false};
        0x2::event::emit<ResumeEvent>(v0);
    }

    public(friend) fun emit_stake_lp_event(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64) {
        let v0 = StakeLPEvent{
            sender       : arg0,
            pool_name    : arg1,
            reward_token : arg2,
            amount       : arg3,
        };
        0x2::event::emit<StakeLPEvent>(v0);
    }

    public(friend) fun emit_swap_event(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = SwapEvent{
            sender            : arg0,
            pool_name         : arg1,
            coin_a_in_amount  : arg2,
            coin_a_out_amount : arg3,
            coin_b_in_amount  : arg4,
            coin_b_out_amount : arg5,
        };
        0x2::event::emit<SwapEvent>(v0);
    }

    public(friend) fun emit_unstake_lp_event(arg0: address, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64) {
        let v0 = UnstakeLPEvent{
            sender       : arg0,
            pool_name    : arg1,
            reward_token : arg2,
            amount       : arg3,
        };
        0x2::event::emit<UnstakeLPEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

