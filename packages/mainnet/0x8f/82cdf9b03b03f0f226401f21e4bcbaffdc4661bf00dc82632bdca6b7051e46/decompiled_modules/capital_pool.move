module 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::capital_pool {
    struct Treasury has store {
        balance: 0x2::balance::Balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>,
    }

    struct TreasuryKey has copy, drop, store {
        dummy_field: bool,
    }

    struct DepositEvent has copy, drop {
        sender: address,
        amount_sui: u64,
        eva_out: u64,
    }

    struct WithdrawEvent has copy, drop {
        sender: address,
        eva_amount: u64,
        sui_out: u64,
    }

    struct CapitalPool has key {
        id: 0x2::object::UID,
        reserve: 0x2::balance::Balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>,
        supply: 0x2::balance::Supply<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>,
        ramm: 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::RammState,
    }

    public(friend) fun add_protocol_fee(arg0: &mut CapitalPool, arg1: 0x2::balance::Balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>) {
        if (0x2::balance::value<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&arg1) == 0) {
            0x2::balance::destroy_zero<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(arg1);
            return
        };
        let v0 = TreasuryKey{dummy_field: false};
        if (!0x2::dynamic_field::exists_<TreasuryKey>(&arg0.id, v0)) {
            let v1 = Treasury{balance: 0x2::balance::zero<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>()};
            let v2 = TreasuryKey{dummy_field: false};
            0x2::dynamic_field::add<TreasuryKey, Treasury>(&mut arg0.id, v2, v1);
        };
        let v3 = TreasuryKey{dummy_field: false};
        0x2::balance::join<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&mut 0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury>(&mut arg0.id, v3).balance, arg1);
    }

    public(friend) fun add_reserve(arg0: &mut CapitalPool, arg1: 0x2::balance::Balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>) {
        0x2::balance::join<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&mut arg0.reserve, arg1);
    }

    public(friend) fun burn_eva_balance(arg0: &mut CapitalPool, arg1: 0x2::balance::Balance<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>) {
        0x2::balance::decrease_supply<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&mut arg0.supply, arg1);
    }

    public fun deposit(arg0: &mut CapitalPool, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg3: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg4: 0x2::coin::Coin<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA> {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::pool_paused(arg2)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_pool_paused();
        };
        let v0 = deposit_(arg0, arg2, arg3, 0x2::coin::into_balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(arg4), arg5);
        let v1 = DepositEvent{
            sender     : 0x2::tx_context::sender(arg6),
            amount_sui : 0x2::coin::value<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&arg4),
            eva_out    : 0x2::balance::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&v0),
        };
        0x2::event::emit<DepositEvent>(v1);
        0x2::coin::from_balance<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(v0, arg6)
    }

    public(friend) fun deposit_(arg0: &mut CapitalPool, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg2: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg3: 0x2::balance::Balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA> {
        let v0 = 0x2::balance::value<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&arg3);
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::calculate_and_update_mcr(arg2);
        let v1 = 0x2::balance::value<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&arg0.reserve);
        let v2 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::floor(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::current_mcr(arg2));
        let v3 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::mcr_floor(arg1);
        let v4 = if (v2 < v3) {
            v3
        } else {
            v2
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::apply_liquidity_rebalance(&mut arg0.ramm, arg1, v1, v4, arg4);
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::apply_ratchet(&mut arg0.ramm, arg1, v1, 0x2::balance::supply_value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&arg0.supply), arg4, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::liq(&arg0.ramm));
        let (v5, v6, v7, v8) = if (!0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::is_bootstrapped(&arg0.ramm)) {
            let (v9, v10, v11, v12) = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::bootstrap_and_calc_buy(v0, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::ramm_oracle_buffer_bps(arg1));
            if (v9 == 0) {
                0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_amount();
            };
            (v9, v10, v11, v12)
        } else {
            let v13 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::liq(&arg0.ramm);
            let v14 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::calc_buy_eva_out(v13, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::eva_above(&arg0.ramm), v0);
            if (v14 == 0) {
                0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_amount();
            };
            let v15 = v13 + v0;
            (v14, v15, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::eva_above(&arg0.ramm) - v14, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::apply_buy_eva_below(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::eva_below(&arg0.ramm), v13, v15))
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::set_ramm_state(&mut arg0.ramm, v6, v7, v8, arg4);
        0x2::balance::join<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&mut arg0.reserve, arg3);
        0x2::balance::increase_supply<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&mut arg0.supply, v5)
    }

    entry fun new_pool(arg0: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::AdminCap, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: 0x2::coin::TreasuryCap<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>, arg3: &mut 0x2::tx_context::TxContext) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        let v0 = CapitalPool{
            id      : 0x2::object::new(arg3),
            reserve : 0x2::balance::zero<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(),
            supply  : 0x2::coin::treasury_into_supply<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(arg2),
            ramm    : 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::new_ramm_state(),
        };
        let v1 = Treasury{balance: 0x2::balance::zero<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>()};
        let v2 = TreasuryKey{dummy_field: false};
        0x2::dynamic_field::add<TreasuryKey, Treasury>(&mut v0.id, v2, v1);
        0x2::transfer::share_object<CapitalPool>(v0);
    }

    public(friend) fun send_claim_payout(arg0: &mut CapitalPool, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) : 0x2::balance::Balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI> {
        let v0 = arg1 + arg2;
        if (v0 == 0) {
            return 0x2::balance::zero<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>()
        };
        if (0x2::balance::value<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&arg0.reserve) < v0) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_insufficient_capital();
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::apply_reserve_payout(&mut arg0.ramm, v0, arg3);
        0x2::balance::split<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&mut arg0.reserve, v0)
    }

    entry fun set_ramm_budget(arg0: &mut CapitalPool, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: u64) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::set_ramm_budget(&mut arg0.ramm, arg3);
    }

    public fun treasury_balance(arg0: &CapitalPool) : u64 {
        let v0 = TreasuryKey{dummy_field: false};
        0x2::balance::value<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&0x2::dynamic_field::borrow<TreasuryKey, Treasury>(&arg0.id, v0).balance)
    }

    public fun withdraw(arg0: &mut CapitalPool, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg3: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg4: 0x2::coin::Coin<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI> {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::pool_paused(arg2)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_pool_paused();
        };
        let v0 = withdraw_(arg0, arg2, arg3, 0x2::coin::into_balance<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(arg4), arg5);
        let v1 = WithdrawEvent{
            sender     : 0x2::tx_context::sender(arg6),
            eva_amount : 0x2::coin::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&arg4),
            sui_out    : 0x2::balance::value<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&v0),
        };
        0x2::event::emit<WithdrawEvent>(v1);
        0x2::coin::from_balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(v0, arg6)
    }

    public fun withdraw_(arg0: &mut CapitalPool, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::Config, arg2: &mut 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::RiskRegistry, arg3: 0x2::balance::Balance<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>, arg4: &0x2::clock::Clock) : 0x2::balance::Balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI> {
        let v0 = 0x2::balance::value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&arg3);
        let v1 = 0x2::balance::value<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&arg0.reserve);
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::calculate_and_update_mcr(arg2);
        let v2 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::floor(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::risk_manager::current_mcr(arg2));
        let v3 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::mcr_floor(arg1);
        let v4 = if (v2 < v3) {
            v3
        } else {
            v2
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::apply_liquidity_rebalance(&mut arg0.ramm, arg1, v1, v4, arg4);
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::apply_ratchet(&mut arg0.ramm, arg1, v1, 0x2::balance::supply_value<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&arg0.supply), arg4, 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::liq(&arg0.ramm));
        if (!0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::is_bootstrapped(&arg0.ramm)) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_ramm_not_bootstrapped();
        };
        let v5 = 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::calc_redeem_sui_out(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::liq(&arg0.ramm), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::eva_below(&arg0.ramm), v0);
        if (v1 < v5) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_invalid_amount();
        };
        if (0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::lt(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(v1 - v5), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(v4), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::min_capital_ratio_bps(arg1))))) {
            0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::error::err_insufficient_capital();
        };
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::ramm::apply_redeem(&mut arg0.ramm, v0, v5);
        0x2::balance::decrease_supply<0x3f5c1434a66269e29523a0158895be37670e83f6c41741cf5df3f9c494cbb052::eva::EVA>(&mut arg0.supply, arg3);
        0x2::balance::split<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&mut arg0.reserve, v5 - 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::floor(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::mul(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from(v5), 0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::decimal::from_bps(0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::config::exit_fee_bps(arg1)))))
    }

    entry fun withdraw_treasury(arg0: &mut CapitalPool, arg1: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::Version, arg2: &0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::admin::GovernanceCap, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        0x8f82cdf9b03b03f0f226401f21e4bcbaffdc4661bf00dc82632bdca6b7051e46::version::check_version(arg1);
        if (arg3 == 0) {
            return
        };
        let v0 = TreasuryKey{dummy_field: false};
        0x2::transfer::public_transfer<0x2::coin::Coin<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>>(0x2::coin::from_balance<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(0x2::balance::split<0xab1daf7c2a12177345d6bf9379756b849d4ed53b95c41fb896bf357ba037d5ed::fsui::FSUI>(&mut 0x2::dynamic_field::borrow_mut<TreasuryKey, Treasury>(&mut arg0.id, v0).balance, arg3), arg4), 0x2::tx_context::sender(arg4));
    }

    // decompiled from Move bytecode v6
}

