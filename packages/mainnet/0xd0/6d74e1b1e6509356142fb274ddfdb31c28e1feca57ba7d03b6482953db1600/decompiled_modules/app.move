module 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::app {
    struct APP has drop {
        dummy_field: bool,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
        interest_model_cap: 0x7b3de4dd89fada32ffeb0a4a2c931f6926c20a5460facf2239721c5298e4459b::ac_table::AcTableCap<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::interest_model::InterestModels>,
        interest_model_change_delay: u64,
        risk_model_cap: 0x7b3de4dd89fada32ffeb0a4a2c931f6926c20a5460facf2239721c5298e4459b::ac_table::AcTableCap<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::risk_model::RiskModels>,
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

    public fun add_interest_model<T0>(arg0: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg1: &AdminCap, arg2: 0x7b3de4dd89fada32ffeb0a4a2c931f6926c20a5460facf2239721c5298e4459b::one_time_lock_value::OneTimeLockValue<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::interest_model::InterestModel>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::interest_model::add_interest_model<T0>(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::interest_models_mut(arg0), &arg1.interest_model_cap, arg2, arg4);
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::register_coin<T0>(arg0, 0x2::clock::timestamp_ms(arg3) / 1000);
    }

    public fun add_limiter<T0>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: u64, arg3: u32, arg4: u32, arg5: &mut 0x2::tx_context::TxContext) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::limiter::add_limiter<T0>(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::rate_limiter_mut(arg1), arg2, arg3, arg4);
    }

    public fun add_lock_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation_access::ObligationAccessStore) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation_access::add_lock_key<T0>(arg1);
    }

    public fun add_reward_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation_access::ObligationAccessStore) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation_access::add_reward_key<T0>(arg1);
    }

    public fun add_risk_model<T0>(arg0: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg1: &AdminCap, arg2: 0x7b3de4dd89fada32ffeb0a4a2c931f6926c20a5460facf2239721c5298e4459b::one_time_lock_value::OneTimeLockValue<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::risk_model::RiskModel>, arg3: &mut 0x2::tx_context::TxContext) {
        update_risk_model<T0>(arg0, arg1, arg2, arg3);
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::register_collateral<T0>(arg0);
    }

    public fun apply_limiter_limit_change<T0>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: 0x7b3de4dd89fada32ffeb0a4a2c931f6926c20a5460facf2239721c5298e4459b::one_time_lock_value::OneTimeLockValue<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::limiter::LimiterUpdateLimitChange>, arg3: &mut 0x2::tx_context::TxContext) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::limiter::apply_limiter_limit_change(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::rate_limiter_mut(arg1), arg2, arg3);
    }

    public fun apply_limiter_params_change<T0>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: 0x7b3de4dd89fada32ffeb0a4a2c931f6926c20a5460facf2239721c5298e4459b::one_time_lock_value::OneTimeLockValue<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::limiter::LimiterUpdateParamsChange>, arg3: &mut 0x2::tx_context::TxContext) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::limiter::apply_limiter_params_change(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::rate_limiter_mut(arg1), arg2, arg3);
    }

    public fun check_and_pause_if_gusd_depeg(arg0: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg1: &0x6215446965938eaf3596a420047ed0da61a17c8c683b0941f9e54511ecad2b4b::x_oracle::XOracle, arg2: &0x2::clock::Clock) {
        if (0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::is_paused(arg0)) {
            return
        };
        if (!0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::auto_pause_enabled(arg0)) {
            return
        };
        let v0 = 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::price::get_price(arg1, 0x1::type_name::get<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD>(), arg2);
        let v1 = 0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::from_u64(1);
        let v2 = if (0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::gt(v0, v1)) {
            0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::sub(v0, v1)
        } else {
            0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::sub(v1, v0)
        };
        if (0x7eaac45a28873a47c2de190f87f59e40e140017c6c4cc5e82b3a1baaaf7d20e::fixed_point32_empower::gte(v2, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::auto_pause_threshold(arg0))) {
            0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::set_paused(arg0, true);
        };
    }

    public fun create_interest_model_change<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x7b3de4dd89fada32ffeb0a4a2c931f6926c20a5460facf2239721c5298e4459b::one_time_lock_value::OneTimeLockValue<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::interest_model::InterestModel> {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::interest_model::create_interest_model_change<T0>(&arg0.interest_model_cap, arg1, arg2, arg3, arg4, arg5, arg0.interest_model_change_delay, arg6)
    }

    public fun create_limiter_limit_change<T0>(arg0: &AdminCap, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x7b3de4dd89fada32ffeb0a4a2c931f6926c20a5460facf2239721c5298e4459b::one_time_lock_value::OneTimeLockValue<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::limiter::LimiterUpdateLimitChange> {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::limiter::create_limiter_limit_change<T0>(arg1, arg0.limiter_change_delay, arg2)
    }

    public fun create_limiter_params_change<T0>(arg0: &AdminCap, arg1: u32, arg2: u32, arg3: &mut 0x2::tx_context::TxContext) : 0x7b3de4dd89fada32ffeb0a4a2c931f6926c20a5460facf2239721c5298e4459b::one_time_lock_value::OneTimeLockValue<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::limiter::LimiterUpdateParamsChange> {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::limiter::create_limiter_params_change<T0>(arg1, arg2, arg0.limiter_change_delay, arg3)
    }

    public fun create_risk_model_change<T0>(arg0: &AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : 0x7b3de4dd89fada32ffeb0a4a2c931f6926c20a5460facf2239721c5298e4459b::one_time_lock_value::OneTimeLockValue<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::risk_model::RiskModel> {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::risk_model::create_risk_model_change<T0>(&arg0.risk_model_cap, arg1, arg2, arg3, arg4, arg5, arg6, arg0.risk_model_change_delay, arg7)
    }

    public fun ext(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market) : &mut 0x2::object::UID {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::uid_mut(arg1)
    }

    public fun extend_interest_model_change_delay(arg0: &mut AdminCap, arg1: u64) {
        assert!(arg1 <= 1, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::invalid_params_error());
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
        let (v0, v1, v2) = 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::new(arg1);
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
        0x2::transfer::public_share_object<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market>(v0);
        0x2::transfer::transfer<AdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public fun owner_deposit_xaum(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::StakingManager, arg2: 0x2::coin::Coin<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(&arg2);
        assert!(v0 > 0, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::zero_amount_error());
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::owner_deposit_xaum(arg1, arg2);
        let v1 = OwnerDepositXAUMEvent{
            manager : 0x2::object::id<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::StakingManager>(arg1),
            amount  : v0,
            sender  : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<OwnerDepositXAUMEvent>(v1);
    }

    public fun owner_withdraw_xaum(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::StakingManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::zero_amount_error());
        let v0 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>>(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::owner_withdraw_xaum(arg1, arg2, arg3), v0);
        let v1 = OwnerWithdrawXAUMEvent{
            manager : 0x2::object::id<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::StakingManager>(arg1),
            amount  : arg2,
            sender  : v0,
        };
        0x2::event::emit<OwnerWithdrawXAUMEvent>(v1);
    }

    public fun pause_protocol(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::set_paused(arg1, true);
    }

    public fun remove_lock_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation_access::ObligationAccessStore) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation_access::remove_lock_key<T0>(arg1);
    }

    public fun remove_reward_key<T0: drop>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation_access::ObligationAccessStore) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::obligation_access::remove_reward_key<T0>(arg1);
    }

    public fun resume_protocol(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::set_paused(arg1, false);
    }

    public fun set_auto_pause_enabled(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: bool) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::set_auto_pause_enabled(arg1, arg2);
    }

    public fun set_auto_pause_threshold(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: u64, arg3: u64) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::set_auto_pause_threshold(arg1, 0x1::fixed_point32::create_from_rational(arg2, arg3));
    }

    public fun set_base_asset_active_state<T0>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: bool) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::set_base_asset_active_state<T0>(arg1, arg2);
    }

    public fun set_collateral_active_state<T0>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: bool) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::set_collateral_active_state<T0>(arg1, arg2);
    }

    public fun set_flash_loan_single_cap(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: u64) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::set_flash_loan_single_cap(arg1, arg2);
    }

    public fun set_gusd_cap(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: 0x2::coin::TreasuryCap<0xa62ad50462b658099e18c134a0b59140a04f8e88f2457a00a5287a4e3d068321::coin_gusd::COIN_GUSD>) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::set_gusd_cap(arg1, arg2);
    }

    public fun take_borrow_fee<T0>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::zero_amount_error());
        assert!(arg0.reward_address != @0x0, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::invalid_reward_address_error());
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::take_borrow_fee<T0>(arg1, arg2, arg3), arg0.reward_address);
        let v0 = TakeBorrowFeeEvent{
            market    : 0x2::object::id<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market>(arg1),
            amount    : arg2,
            coin_type : 0x1::type_name::get<T0>(),
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg0.reward_address,
        };
        0x2::event::emit<TakeBorrowFeeEvent>(v0);
    }

    public fun take_revenue<T0>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.reward_address != @0x0, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::invalid_reward_address_error());
        let v0 = 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::take_revenue<T0>(arg1, arg2, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg0.reward_address);
        let v1 = TakeRevenueEvent{
            market    : 0x2::object::id<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market>(arg1),
            amount    : 0x2::coin::value<T0>(&v0),
            coin_type : 0x1::type_name::get<T0>(),
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg0.reward_address,
        };
        0x2::event::emit<TakeRevenueEvent>(v1);
    }

    public fun take_staking_fee(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::StakingManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::zero_amount_error());
        assert!(arg0.reward_address != @0x0, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::invalid_reward_address_error());
        0x2::transfer::public_transfer<0x2::coin::Coin<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>>(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::take_stake_fee_coin(arg1, arg2, arg3), arg0.reward_address);
        let v0 = TakeStakingFeeEvent{
            manager   : 0x2::object::id<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::StakingManager>(arg1),
            amount    : arg2,
            coin_type : 0x1::type_name::get<0x9d297676e7a4b771ab023291377b2adfaa4938fb9080b8d12430e4b108b836a9::xaum::XAUM>(),
            sender    : 0x2::tx_context::sender(arg3),
            recipient : arg0.reward_address,
        };
        0x2::event::emit<TakeStakingFeeEvent>(v0);
    }

    public fun transfer_admin_cap(arg0: AdminCap, arg1: address) {
        0x2::transfer::transfer<AdminCap>(arg0, arg1);
    }

    public fun update_borrow_fee<T0: drop>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: u64, arg3: u64) {
        assert!(arg2 <= arg3, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::invalid_params_error());
        let v0 = 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::uid_mut(arg1);
        let v1 = 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market_dynamic_keys::borrow_fee_key(0x1::type_name::get<T0>());
        0x2::dynamic_field::remove_if_exists<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(v0, v1);
        0x2::dynamic_field::add<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market_dynamic_keys::BorrowFeeKey, 0x1::fixed_point32::FixedPoint32>(v0, v1, 0x1::fixed_point32::create_from_rational(arg2, arg3));
    }

    public fun update_borrow_limit<T0: drop>(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg2: u128) {
        let v0 = 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::uid_mut(arg1);
        let v1 = 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market_dynamic_keys::borrow_limit_key(0x1::type_name::get<T0>());
        0x2::dynamic_field::remove_if_exists<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market_dynamic_keys::BorrowLimitKey, u128>(v0, v1);
        0x2::dynamic_field::add<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market_dynamic_keys::BorrowLimitKey, u128>(v0, v1, arg2);
    }

    public fun update_interest_model<T0>(arg0: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg1: &AdminCap, arg2: 0x7b3de4dd89fada32ffeb0a4a2c931f6926c20a5460facf2239721c5298e4459b::one_time_lock_value::OneTimeLockValue<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::interest_model::InterestModel>, arg3: &mut 0x2::tx_context::TxContext) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::interest_model::add_interest_model<T0>(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::interest_models_mut(arg0), &arg1.interest_model_cap, arg2, arg3);
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::update_interest_rates<T0>(arg0);
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

    public fun update_risk_model<T0>(arg0: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::Market, arg1: &AdminCap, arg2: 0x7b3de4dd89fada32ffeb0a4a2c931f6926c20a5460facf2239721c5298e4459b::one_time_lock_value::OneTimeLockValue<0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::risk_model::RiskModel>, arg3: &mut 0x2::tx_context::TxContext) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::risk_model::add_risk_model<T0>(0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::market::risk_models_mut(arg0), &arg1.risk_model_cap, arg2, arg3);
    }

    public fun update_staking_cap(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::StakingManager, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::update_stake_cap(arg1, arg2, arg3);
    }

    public fun update_staking_fee(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::StakingManager, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg3, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::invalid_params_error());
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::update_stake_fee(arg1, arg2, arg3, arg4);
    }

    public fun update_unstaking_fee(arg0: &AdminCap, arg1: &mut 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::StakingManager, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 <= arg3, 0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::error::invalid_params_error());
        0xd06d74e1b1e6509356142fb274ddfdb31c28e1feca57ba7d03b6482953db1600::staking_manager::update_unstake_fee(arg1, arg2, arg3, arg4);
    }

    // decompiled from Move bytecode v6
}

