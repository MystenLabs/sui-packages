module 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::app {
    struct APP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        interest_model_cap: 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::ac_table::AcTableCap<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::interest_model::InterestModels>,
        interest_model_change_delay: u64,
        risk_model_cap: 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::ac_table::AcTableCap<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::risk_model::RiskModels>,
        risk_model_change_delay: u64,
        limiter_change_delay: u64,
        reward_address: address,
    }

    struct RewardAddressUpdatedEvent has copy, drop {
        old_address: address,
        new_address: address,
        sender: address,
    }

    struct TakeRevenueEvent has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        sender: address,
        recipient: address,
    }

    struct TakeBorrowFeeEvent has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        sender: address,
        recipient: address,
    }

    struct TakeStakingFeeEvent has copy, drop {
        manager: 0x2::object::ID,
        amount: u64,
        coin_type: 0x1::type_name::TypeName,
        sender: address,
        recipient: address,
    }

    struct OwnerWithdrawXAUMEvent has copy, drop {
        manager: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    struct OwnerDepositXAUMEvent has copy, drop {
        manager: 0x2::object::ID,
        amount: u64,
        sender: address,
    }

    public fun add_interest_model<T0>(arg0: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg1: &AdminCap, arg2: 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::one_time_lock_value::OneTimeLockValue<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::interest_model::InterestModel>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::interest_model::add_interest_model<T0>(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::interest_models_mut(arg0), &arg1.interest_model_cap, arg2, arg4);
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::register_coin<T0>(arg0, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    public fun add_limiter<T0>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: u64, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::limiter::add_limiter<T0>(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::rate_limiter_mut(arg1), arg2, arg3, arg4);
    }

    public fun add_lock_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation_access::ObligationAccessStore) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation_access::add_lock_key<T0>(arg1);
    }

    public fun add_reward_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation_access::ObligationAccessStore) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation_access::add_reward_key<T0>(arg1);
    }

    public fun add_risk_model<T0>(arg0: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg1: &AdminCap, arg2: 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::one_time_lock_value::OneTimeLockValue<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::risk_model::RiskModel>, arg3: &mut 0x2::tx_context::TxContext) {
        update_risk_model<T0>(arg0, arg1, arg2, arg3);
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::register_collateral<T0>(arg0);
    }

    public fun apply_limiter_limit_change<T0>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::one_time_lock_value::OneTimeLockValue<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::limiter::LimiterUpdateLimitChange>, arg3: &mut 0x2::tx_context::TxContext) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::limiter::apply_limiter_limit_change(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::rate_limiter_mut(arg1), arg2, arg3);
    }

    public fun apply_limiter_params_change<T0>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::one_time_lock_value::OneTimeLockValue<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::limiter::LimiterUpdateParamsChange>, arg3: &mut 0x2::tx_context::TxContext) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::limiter::apply_limiter_params_change(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::rate_limiter_mut(arg1), arg2, arg3);
    }

    public fun check_and_pause_if_gusd_depeg(arg0: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg1: &0xe46a4a7ba1cdb785de2ebac5fa36a336bb560230fbccc023b26f0469dd4392c::x_oracle::XOracle, arg2: &0x2::clock::Clock) {
        if (0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::is_paused(arg0)) {
            return
        };
        if (!0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::auto_pause_enabled(arg0)) {
            return
        };
        let v0 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::price::get_price(arg1, 0x1::type_name::get<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>(), arg2);
        let v1 = 0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::from_u64(1);
        let v2 = if (0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::gt(v0, v1)) {
            0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::sub(v0, v1)
        } else {
            0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::sub(v1, v0)
        };
        if (0x7a2b7bd2ae94b09560fb22b9ff4137c66ebce098e8c76660c6635027f3c6a34f::fixed_point32_empower::gte(v2, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::auto_pause_threshold(arg0))) {
            0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::set_paused(arg0, true);
        };
    }

    public fun create_interest_model_change<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::one_time_lock_value::OneTimeLockValue<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::interest_model::InterestModel> {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::interest_model::create_interest_model_change<T0>(&arg0.interest_model_cap, arg1, arg2, arg3, arg4, arg5, arg0.interest_model_change_delay, arg6)
    }

    public fun create_limiter_limit_change<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::one_time_lock_value::OneTimeLockValue<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::limiter::LimiterUpdateLimitChange> {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::limiter::create_limiter_limit_change<T0>(arg1, arg0.limiter_change_delay, arg2)
    }

    public fun create_limiter_params_change<T0>(arg0: &AdminCap, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::one_time_lock_value::OneTimeLockValue<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::limiter::LimiterUpdateParamsChange> {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::limiter::create_limiter_params_change<T0>(arg1, arg2, arg0.limiter_change_delay, arg3)
    }

    public fun create_risk_model_change<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::one_time_lock_value::OneTimeLockValue<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::risk_model::RiskModel> {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::risk_model::create_risk_model_change<T0>(&arg0.risk_model_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg0.risk_model_change_delay, arg7)
    }

    public fun ext(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market) : &mut 0x2::object::UID {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::uid_mut(arg1)
    }

    public fun extend_interest_model_change_delay(arg0: &mut AdminCap, arg1: u64) {
        assert!(arg1 <= 1, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::invalid_params_error());
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
        let (v0, v1, v2) = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::new(arg1);
        let v3 = AdminCap{
            id                          : 0x2::object::new(arg1),
            interest_model_cap          : v1,
            interest_model_change_delay : 0,
            risk_model_cap              : v2,
            risk_model_change_delay     : 0,
            limiter_change_delay        : 0,
            reward_address              : @0x0,
        };
        0x2::package::claim_and_keep<APP>(arg0, arg1);
        0x2::transfer::public_share_object<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market>(v0);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun owner_deposit_xaum(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::StakingManager, arg2: 0x2::coin::Coin<0x452e84594745f6053381e2b630331ae852b8014bdc52fc8517fae4c0d03bb5cb::xaum::XAUM>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x452e84594745f6053381e2b630331ae852b8014bdc52fc8517fae4c0d03bb5cb::xaum::XAUM>(&arg2);
        assert!(v0 > 0, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::zero_amount_error());
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::owner_deposit_xaum(arg1, arg2);
        let v1 = OwnerDepositXAUMEvent{
            manager : 0x2::object::id<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::StakingManager>(arg1),
            amount  : v0,
            sender  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<OwnerDepositXAUMEvent>(v1);
    }

    public fun owner_withdraw_xaum(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::StakingManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::zero_amount_error());
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x452e84594745f6053381e2b630331ae852b8014bdc52fc8517fae4c0d03bb5cb::xaum::XAUM>>(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::owner_withdraw_xaum(arg1, arg2, arg3), v0);
        let v1 = OwnerWithdrawXAUMEvent{
            manager : 0x2::object::id<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::StakingManager>(arg1),
            amount  : arg2,
            sender  : v0,
        };
        0x2::event::emit<OwnerWithdrawXAUMEvent>(v1);
    }

    public fun pause_protocol(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::set_paused(arg1, true);
    }

    public fun remove_lock_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation_access::ObligationAccessStore) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation_access::remove_lock_key<T0>(arg1);
    }

    public fun remove_reward_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation_access::ObligationAccessStore) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::obligation_access::remove_reward_key<T0>(arg1);
    }

    public fun resume_protocol(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::set_paused(arg1, false);
    }

    public fun set_auto_pause_enabled(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: bool) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::set_auto_pause_enabled(arg1, arg2);
    }

    public fun set_auto_pause_threshold(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: u64, arg3: u64) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::set_auto_pause_threshold(arg1, 0x1::fixed_point32::create_from_rational(arg2, arg3));
    }

    public fun set_base_asset_active_state<T0>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: bool) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::set_base_asset_active_state<T0>(arg1, arg2);
    }

    public fun set_collateral_active_state<T0>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: bool) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::set_collateral_active_state<T0>(arg1, arg2);
    }

    public fun set_flash_loan_single_cap(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: u64) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::set_flash_loan_single_cap(arg1, arg2);
    }

    public fun set_gusd_cap(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: 0x2::coin::TreasuryCap<0xa1fe266d04a850a7af07e55a432596cfaa3849f43042b5eb6efe31d74118a0cf::coin_gusd::COIN_GUSD>) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::set_gusd_cap(arg1, arg2);
    }

    public fun take_borrow_fee<T0>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::zero_amount_error());
        assert!(arg0.reward_address != @0x0, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::invalid_reward_address_error());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::take_borrow_fee<T0>(arg1, arg2, arg3), arg0.reward_address);
        let v0 = TakeBorrowFeeEvent{
            market    : 0x2::object::id<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market>(arg1),
            amount    : arg2,
            coin_type : 0x1::type_name::get<T0>(),
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg0.reward_address,
        };
        0x2::event::emit<TakeBorrowFeeEvent>(v0);
    }

    public fun take_revenue<T0>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.reward_address != @0x0, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::invalid_reward_address_error());
        let v0 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::take_revenue<T0>(arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.reward_address);
        let v1 = TakeRevenueEvent{
            market    : 0x2::object::id<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market>(arg1),
            amount    : 0x2::coin::value<T0>(&v0),
            coin_type : 0x1::type_name::get<T0>(),
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg0.reward_address,
        };
        0x2::event::emit<TakeRevenueEvent>(v1);
    }

    public fun take_staking_fee(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::StakingManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::zero_amount_error());
        assert!(arg0.reward_address != @0x0, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::invalid_reward_address_error());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x452e84594745f6053381e2b630331ae852b8014bdc52fc8517fae4c0d03bb5cb::xaum::XAUM>>(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::take_stake_fee_coin(arg1, arg2, arg3), arg0.reward_address);
        let v0 = TakeStakingFeeEvent{
            manager   : 0x2::object::id<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::StakingManager>(arg1),
            amount    : arg2,
            coin_type : 0x1::type_name::get<0x452e84594745f6053381e2b630331ae852b8014bdc52fc8517fae4c0d03bb5cb::xaum::XAUM>(),
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg0.reward_address,
        };
        0x2::event::emit<TakeStakingFeeEvent>(v0);
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun update_borrow_fee<T0: drop>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: u64, arg3: u64) {
        assert!(arg2 <= arg3, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::invalid_params_error());
        let v0 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::uid_mut(arg1);
        let v1 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market_dynamic_keys::borrow_fee_key(0x1::type_name::get<T0>());
        0x2::dynamic_field::remove_if_exists<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(v0, v1);
        0x2::dynamic_field::add<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(v0, v1, 0x1::fixed_point32::create_from_rational(arg2, arg3));
    }

    public fun update_borrow_limit<T0: drop>(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg2: u128) {
        let v0 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::uid_mut(arg1);
        let v1 = 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market_dynamic_keys::borrow_limit_key(0x1::type_name::get<T0>());
        0x2::dynamic_field::remove_if_exists<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market_dynamic_keys::BorrowLimitKey, u128>(v0, v1);
        0x2::dynamic_field::add<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market_dynamic_keys::BorrowLimitKey, u128>(v0, v1, arg2);
    }

    public fun update_interest_model<T0>(arg0: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg1: &AdminCap, arg2: 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::one_time_lock_value::OneTimeLockValue<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::interest_model::InterestModel>, arg3: &mut 0x2::tx_context::TxContext) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::interest_model::add_interest_model<T0>(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::interest_models_mut(arg0), &arg1.interest_model_cap, arg2, arg3);
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::update_interest_rates<T0>(arg0);
    }

    public fun update_reward_address(arg0: &mut AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        arg0.reward_address = arg1;
        let v0 = RewardAddressUpdatedEvent{
            old_address : arg0.reward_address,
            new_address : arg1,
            sender      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<RewardAddressUpdatedEvent>(v0);
    }

    public fun update_risk_model<T0>(arg0: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::Market, arg1: &AdminCap, arg2: 0xb4a4492537e2beb1af2ccae125b64cfff76bc7418cda240066a11f864093ee92::one_time_lock_value::OneTimeLockValue<0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::risk_model::RiskModel>, arg3: &mut 0x2::tx_context::TxContext) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::risk_model::add_risk_model<T0>(0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::market::risk_models_mut(arg0), &arg1.risk_model_cap, arg2, arg3);
    }

    public fun update_staking_cap(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::StakingManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::update_stake_cap(arg1, arg2, arg3);
    }

    public fun update_staking_fee(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::StakingManager, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg3, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::invalid_params_error());
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::update_stake_fee(arg1, arg2, arg3, arg4);
    }

    public fun update_unstaking_fee(arg0: &AdminCap, arg1: &mut 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::StakingManager, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg3, 0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::error::invalid_params_error());
        0x11b3bf9b49885da6763fd18325a6676f9ef04ed57ab51712d4b462576b89c374::staking_manager::update_unstake_fee(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

