module 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::app {
    struct APP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        interest_model_cap: 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::ac_table::AcTableCap<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::interest_model::InterestModels>,
        interest_model_change_delay: u64,
        risk_model_cap: 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::ac_table::AcTableCap<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::risk_model::RiskModels>,
        risk_model_change_delay: u64,
        limiter_change_delay: u64,
    }

    public fun add_interest_model<T0>(arg0: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg1: &AdminCap, arg2: 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::one_time_lock_value::OneTimeLockValue<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::interest_model::InterestModel>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        update_interest_model<T0>(arg0, arg1, arg2, arg4);
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::register_coin<T0>(arg0, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    public entry fun add_limiter<T0>(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg2: u64, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::limiter::add_limiter<T0>(0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::rate_limiter_mut(arg1), arg2, arg3, arg4);
    }

    public entry fun add_lock_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::obligation_access::ObligationAccessStore) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::obligation_access::add_lock_key<T0>(arg1);
    }

    public entry fun add_reward_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::obligation_access::ObligationAccessStore) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::obligation_access::add_reward_key<T0>(arg1);
    }

    public entry fun add_risk_model<T0>(arg0: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg1: &AdminCap, arg2: 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::one_time_lock_value::OneTimeLockValue<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::risk_model::RiskModel>, arg3: &mut 0x2::tx_context::TxContext) {
        update_risk_model<T0>(arg0, arg1, arg2, arg3);
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::register_collateral<T0>(arg0);
    }

    public fun add_whitelist_address(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg2: address) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::whitelist::add_whitelist_address(0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::uid_mut(arg1), arg2);
    }

    public entry fun apply_limiter_limit_change<T0>(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg2: 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::one_time_lock_value::OneTimeLockValue<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::limiter::LimiterUpdateLimitChange>, arg3: &mut 0x2::tx_context::TxContext) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::limiter::apply_limiter_limit_change(0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::rate_limiter_mut(arg1), arg2, arg3);
    }

    public entry fun apply_limiter_params_change<T0>(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg2: 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::one_time_lock_value::OneTimeLockValue<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::limiter::LimiterUpdateParamsChange>, arg3: &mut 0x2::tx_context::TxContext) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::limiter::apply_limiter_params_change(0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::rate_limiter_mut(arg1), arg2, arg3);
    }

    public fun create_interest_model_change<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::one_time_lock_value::OneTimeLockValue<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::interest_model::InterestModel> {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::interest_model::create_interest_model_change<T0>(&arg0.interest_model_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg0.interest_model_change_delay, arg12)
    }

    public fun create_limiter_limit_change<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::one_time_lock_value::OneTimeLockValue<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::limiter::LimiterUpdateLimitChange> {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::limiter::create_limiter_limit_change<T0>(arg1, arg0.limiter_change_delay, arg2)
    }

    public fun create_limiter_params_change<T0>(arg0: &AdminCap, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::one_time_lock_value::OneTimeLockValue<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::limiter::LimiterUpdateParamsChange> {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::limiter::create_limiter_params_change<T0>(arg1, arg2, arg0.limiter_change_delay, arg3)
    }

    public fun create_risk_model_change<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::one_time_lock_value::OneTimeLockValue<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::risk_model::RiskModel> {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::risk_model::create_risk_model_change<T0>(&arg0.risk_model_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg0.risk_model_change_delay, arg7)
    }

    public fun ext(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market) : &mut 0x2::object::UID {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::uid_mut(arg1)
    }

    public fun extend_interest_model_change_delay(arg0: &mut AdminCap, arg1: u64) {
        arg0.interest_model_change_delay = arg0.interest_model_change_delay + arg1;
    }

    public fun extend_limiter_change_delay(arg0: &mut AdminCap, arg1: u64) {
        arg0.limiter_change_delay = arg0.limiter_change_delay + arg1;
    }

    public fun extend_risk_model_change_delay(arg0: &mut AdminCap, arg1: u64) {
        arg0.risk_model_change_delay = arg0.risk_model_change_delay + arg1;
    }

    fun init(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        init_internal(arg0, arg1);
    }

    fun init_internal(arg0: APP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::new(arg1);
        let v3 = AdminCap{
            id                          : 0x2::object::new(arg1),
            interest_model_cap          : v1,
            interest_model_change_delay : 0,
            risk_model_cap              : v2,
            risk_model_change_delay     : 0,
            limiter_change_delay        : 0,
        };
        0x2::package::claim_and_keep<APP>(arg0, arg1);
        0x2::transfer::public_share_object<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market>(v0);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public entry fun remove_lock_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::obligation_access::ObligationAccessStore) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::obligation_access::remove_lock_key<T0>(arg1);
    }

    public entry fun remove_reward_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::obligation_access::ObligationAccessStore) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::obligation_access::remove_reward_key<T0>(arg1);
    }

    public fun remove_whitelist_address(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg2: address) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::whitelist::remove_whitelist_address(0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::uid_mut(arg1), arg2);
    }

    public entry fun set_base_asset_active_state<T0>(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg2: bool) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::set_base_asset_active_state<T0>(arg1, arg2);
    }

    public entry fun set_collateral_active_state<T0>(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg2: bool) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::set_collateral_active_state<T0>(arg1, arg2);
    }

    public entry fun set_flash_loan_fee<T0>(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg2: u64) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::set_flash_loan_fee<T0>(arg1, arg2);
    }

    public entry fun set_incentive_reward_factor<T0>(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::incentive_rewards::set_reward_factor<T0>(0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::reward_factors_mut(arg1), arg2, arg3);
    }

    public entry fun take_revenue<T0>(arg0: &AdminCap, arg1: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::take_revenue<T0>(arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    public fun update_interest_model<T0>(arg0: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg1: &AdminCap, arg2: 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::one_time_lock_value::OneTimeLockValue<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::interest_model::InterestModel>, arg3: &mut 0x2::tx_context::TxContext) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::interest_model::add_interest_model<T0>(0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::interest_models_mut(arg0), &arg1.interest_model_cap, arg2, arg3);
    }

    public entry fun update_risk_model<T0>(arg0: &mut 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::Market, arg1: &AdminCap, arg2: 0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::one_time_lock_value::OneTimeLockValue<0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::risk_model::RiskModel>, arg3: &mut 0x2::tx_context::TxContext) {
        0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::risk_model::add_risk_model<T0>(0x504631f7f31ae88cd60d0dfab1cedd39dd054d2c7885a47266fc1974e6f8a549::market::risk_models_mut(arg0), &arg1.risk_model_cap, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

