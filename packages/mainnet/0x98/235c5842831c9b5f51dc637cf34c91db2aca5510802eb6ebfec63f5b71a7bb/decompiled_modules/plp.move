module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::plp {
    struct PLP has drop {
        dummy_field: bool,
    }

    struct PoolValuationProof {
        dummy_field: bool,
    }

    struct SnapshotStage {
        dummy_field: bool,
    }

    struct PoolVault has key {
        id: 0x2::object::UID,
        protocol_reserve_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        fee_incentive_reserve: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        lp: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::LpBook<PLP>,
        expiry_accounting: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::Ledger,
        valuation: 0x1::option::Option<PoolValuation>,
    }

    struct PoolValuation has drop, store {
        expected_expiry_markets: vector<0x2::object::ID>,
        valued_expiry_markets: vector<0x2::object::ID>,
        total_nav: u64,
        frozen_pricers: 0x2::vec_map::VecMap<0x2::object::ID, 0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer>>,
        sealed: bool,
        started_at_ms: u64,
        supply_budget: 0x1::option::Option<u64>,
        withdraw_budget: 0x1::option::Option<u64>,
        supply_request_cutoff: u64,
        withdraw_request_cutoff: u64,
        frozen_idle_balance: u64,
        frozen_profit_basis_credits: u64,
        frozen_profit_basis_debits: u64,
        frozen_pending_protocol_profit: u64,
    }

    public fun id(arg0: &PoolVault) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun cancel_supply_request(arg0: &mut PoolVault, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: u64, arg5: &0x2::accumulator::AccumulatorRoot, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg3);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_no_val(arg3);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::settle<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg5, arg6);
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg1, arg2);
        let v1 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::receive_address(v0);
        let (v2, v3, v4) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::cancel_supply_request<PLP>(&mut arg0.lp, v1, arg4);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::deposit<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v4, arg7));
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::req_cancel(id(arg0), v2, v1, arg4, v3, true, 0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::supply_requests_pending<PLP>(&arg0.lp));
    }

    public fun cancel_withdraw_request(arg0: &mut PoolVault, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: u64, arg5: &0x2::accumulator::AccumulatorRoot, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg3);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_no_val(arg3);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::settle<PLP>(arg1, arg5, arg6);
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg1, arg2);
        let v1 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::receive_address(v0);
        let (v2, v3, v4) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::cancel_withdraw_request<PLP>(&mut arg0.lp, v1, arg4);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::deposit<PLP>(v0, 0x2::coin::from_balance<PLP>(v4, arg7));
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::req_cancel(id(arg0), v2, v1, arg4, v3, false, 0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::withdraw_requests_pending<PLP>(&arg0.lp));
    }

    public fun request_supply(arg0: &mut PoolVault, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: u64, arg5: u64, arg6: &0x2::accumulator::AccumulatorRoot, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg3);
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::total_supply<PLP>(&arg0.lp) > 0, 1);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::settle<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg6, arg7);
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg1, arg2);
        let v1 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(v0);
        let v2 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::receive_address(v0);
        let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::request_supply<PLP>(&mut arg0.lp, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::withdraw<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg4, arg8), v1, v2, arg5);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::supply_req(id(arg0), v1, v2, v3, arg4, arg5, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::supply_requests_pending<PLP>(&arg0.lp));
        v3
    }

    public fun request_withdraw(arg0: &mut PoolVault, arg1: &mut 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::AccountWrapper, arg2: 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::Auth, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: u64, arg5: u64, arg6: &0x2::accumulator::AccumulatorRoot, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg3);
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::total_supply<PLP>(&arg0.lp) > 0, 1);
        0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::settle<PLP>(arg1, arg6, arg7);
        let v0 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::load_account_mut(arg1, arg2);
        let v1 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::account_id(v0);
        let v2 = 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::receive_address(v0);
        let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::request_withdraw<PLP>(&mut arg0.lp, 0x4e1dd01465713c9d832313fed5f45c222a4d5c62a533d6da96764c8b2a245d58::account::withdraw<PLP>(v0, arg4, arg8), v1, v2, arg5);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::wd_req(id(arg0), v1, v2, v3, arg4, arg5, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::withdraw_requests_pending<PLP>(&arg0.lp));
        v3
    }

    public fun supply_requests_pending(arg0: &PoolVault) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::supply_requests_pending<PLP>(&arg0.lp)
    }

    public fun withdraw_requests_pending(arg0: &PoolVault) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::withdraw_requests_pending<PLP>(&arg0.lp)
    }

    public fun active_expiry_markets(arg0: &PoolVault) : vector<0x2::object::ID> {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::active_expiry_markets(&arg0.expiry_accounting)
    }

    public fun active_live_expiry_count(arg0: &PoolVault, arg1: &0x2::clock::Clock) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::active_live_expiry_count(&arg0.expiry_accounting, 0x2::clock::timestamp_ms(arg1))
    }

    public fun add_usdc_to_plp(arg0: &mut PoolVault, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &0x2::tx_context::TxContext) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_no_val(arg1);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::total_supply<PLP>(&arg0.lp);
        assert!(v0 > 0, 1);
        let v1 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2);
        assert!(v1 >= 10000000, 12);
        assert!(0x1::u64::div_ceil(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::idle_balance(&arg0.expiry_accounting) + 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::deployed(&arg0.expiry_accounting) + v1, 10) <= v0, 13);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::receive_idle(&mut arg0.expiry_accounting, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::usdc_added(id(arg0), 0x2::tx_context::sender(arg3), v1);
    }

    fun cash_terms(arg0: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg1: u64) : (u64, u64) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::required_cash(arg0);
        let v1 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v0, 100000000);
        let v2 = 0x1::u64::max(0x1::u64::max(v0 + v1, arg1), v0 + 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::wait_need(arg0));
        (v2, 0x1::u64::max(0x1::u64::max(v0 + v1 + v1, arg1), v2))
    }

    fun chk_no_stage(arg0: &PoolVault) {
        if (0x1::option::is_some<PoolValuation>(&arg0.valuation)) {
            assert!(0x1::option::borrow<PoolValuation>(&arg0.valuation).sealed, 11);
        };
    }

    fun chk_valued(arg0: &vector<0x2::object::ID>, arg1: &vector<0x2::object::ID>) {
        assert!(0x1::vector::length<0x2::object::ID>(arg1) == 0x1::vector::length<0x2::object::ID>(arg0), 0);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            assert!(0x1::vector::contains<0x2::object::ID>(arg1, 0x1::vector::borrow<0x2::object::ID>(arg0, v0)), 0);
            v0 = v0 + 1;
        };
    }

    fun discard_val(arg0: &mut PoolVault, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig) {
        let v0 = 0x1::option::extract<PoolValuation>(&mut arg0.valuation);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::end_val(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::flush_redo(id(arg0), 0x1::vector::length<0x2::object::ID>(&v0.expected_expiry_markets), 0x1::vector::length<0x2::object::ID>(&v0.valued_expiry_markets));
    }

    public fun fee_incentive_reserve(arg0: &PoolVault) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee_incentive_reserve)
    }

    public fun finish_flush(arg0: &mut PoolVault, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_operator(arg1, arg3);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_val(arg1);
        assert!(0x2::clock::timestamp_ms(arg2) < 0x1::option::borrow<PoolValuation>(&arg0.valuation).started_at_ms + 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::val_window(arg1), 10);
        let v0 = 0x1::option::extract<PoolValuation>(&mut arg0.valuation);
        chk_valued(&v0.expected_expiry_markets, &v0.valued_expiry_markets);
        let PoolValuation {
            expected_expiry_markets        : _,
            valued_expiry_markets          : v2,
            total_nav                      : v3,
            frozen_pricers                 : _,
            sealed                         : _,
            started_at_ms                  : v6,
            supply_budget                  : v7,
            withdraw_budget                : v8,
            supply_request_cutoff          : v9,
            withdraw_request_cutoff        : v10,
            frozen_idle_balance            : v11,
            frozen_profit_basis_credits    : v12,
            frozen_profit_basis_debits     : v13,
            frozen_pending_protocol_profit : v14,
        } = v0;
        let v15 = v2;
        let v16 = pool_value(v11, v12, v13, v14, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::rsv_share(arg1), v3);
        let v17 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::total_supply<PLP>(&arg0.lp);
        let v18 = id(arg0);
        let v19 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::new_fees(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::sup_fee(arg1), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::wd_fee(arg1));
        let v20 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::drain<PLP>(&mut arg0.lp, &mut arg0.expiry_accounting, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::new_mark(v16, v17), v19, v18, v9, v10, v7, v8, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::req_attempts(arg1), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::max_pool(arg1), arg3);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::end_val(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::flush_done(v18, 0x2::tx_context::epoch(arg3), v16, v17, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::sup_fee_rate(&v19), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::wd_fee_rate(&v19), v3, 0x1::vector::length<0x2::object::ID>(&v15), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::idle_balance(&arg0.expiry_accounting), v11, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::sups_filled(&v20), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::wds_filled(&v20), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::processed(&v20), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::idle_balance(&arg0.expiry_accounting), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::total_supply<PLP>(&arg0.lp), v9, v10, v6);
        v16
    }

    public fun idle_balance(arg0: &PoolVault) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::idle_balance(&arg0.expiry_accounting)
    }

    fun init(arg0: PLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (_, v1) = init_plp(arg0, arg1);
        xfer_metacap(v1, arg1);
    }

    fun init_plp(arg0: PLP, arg1: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, 0x2::coin_registry::MetadataCap<PLP>) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PLP>(arg0, 6, 0x1::string::utf8(b"PLP"), 0x1::string::utf8(b"Predict LP"), 0x1::string::utf8(b"LP token representing shares in the Predict pool vault"), 0x1::string::utf8(b""), arg1);
        let v2 = 0x2::coin_registry::finalize<PLP>(v0, arg1);
        (share_vault(v1, arg1), v2)
    }

    public fun lock_capital(arg0: &mut PoolVault, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg3: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::total_supply<PLP>(&arg0.lp) == 0, 2);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        assert!(v0 >= 10000000, 3);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::receive_idle(&mut arg0.expiry_accounting, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3));
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::mint_locked<PLP>(&mut arg0.lp, v0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::cap_locked(id(arg0), v0);
    }

    fun materialize(arg0: &mut PoolVault, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: 0x2::object::ID) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::materialize(&mut arg0.expiry_accounting, arg2);
        if (v0 == 0) {
            return
        };
        let v1 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(v0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::rsv_share(arg1));
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.protocol_reserve_balance, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::realize_prof(&mut arg0.expiry_accounting, v1));
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::profit_made(id(arg0), arg2, v0 - v1, v1, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.protocol_reserve_balance), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::profit_basis_debits(&arg0.expiry_accounting), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::pending_protocol_profit(&arg0.expiry_accounting));
    }

    public(friend) fun new_proof() : PoolValuationProof {
        PoolValuationProof{dummy_field: false}
    }

    public fun pending_protocol_profit(arg0: &PoolVault) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::pending_protocol_profit(&arg0.expiry_accounting)
    }

    public fun plp_total_supply(arg0: &PoolVault) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::total_supply<PLP>(&arg0.lp)
    }

    fun pool_value(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : u64 {
        0x1::u64::saturating_sub(arg0 + arg5, 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x1::u64::saturating_sub(arg1 + arg5, arg2), arg4) + arg3)
    }

    public fun profit_basis_credits(arg0: &PoolVault) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::profit_basis_credits(&arg0.expiry_accounting)
    }

    public fun profit_basis_debits(arg0: &PoolVault) : u64 {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::profit_basis_debits(&arg0.expiry_accounting)
    }

    public fun protocol_reserve_balance(arg0: &PoolVault) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.protocol_reserve_balance)
    }

    fun rebal_live(arg0: &mut PoolVault, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: 0x2::object::ID) {
        sync_incent(arg0, arg1, arg2, arg3);
        let (v0, v1) = cash_terms(arg1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::init_cash(&arg0.expiry_accounting, arg3));
        let v2 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::cash_balance(arg1);
        if (v2 < v0) {
            top_up_live(arg0, arg1, arg3, v2, v0);
        } else if (v2 > v1) {
            sweep_live(arg0, arg1, arg3, v2, v0);
        };
    }

    public fun rebalance_expiry_cash(arg0: &mut PoolVault, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &0x2::clock::Clock) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg2);
        chk_no_stage(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::chk_expiry(&arg0.expiry_accounting, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::id(arg1));
        sweep_or_bal(arg0, arg1, arg2, arg3);
    }

    public(friend) fun register_exp(arg0: &mut PoolVault, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        if (arg2 > v0) {
            assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::active_live_expiry_count(&arg0.expiry_accounting, v0) < 24, 5);
        };
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::cap_snapshot(id(arg0), arg1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::register_exp(&mut arg0.expiry_accounting, arg1, arg2, arg3, arg4, arg5));
    }

    public fun seal_valuation_snapshot(arg0: &mut PoolVault, arg1: SnapshotStage, arg2: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_val(arg2);
        let SnapshotStage {  } = arg1;
        let v0 = 0x1::option::borrow_mut<PoolValuation>(&mut arg0.valuation);
        assert!(0x2::vec_map::length<0x2::object::ID, 0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer>>(&v0.frozen_pricers) == 0x1::vector::length<0x2::object::ID>(&v0.expected_expiry_markets), 8);
        v0.sealed = true;
        v0.frozen_idle_balance = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::idle_balance(&arg0.expiry_accounting);
        v0.frozen_profit_basis_credits = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::profit_basis_credits(&arg0.expiry_accounting);
        v0.frozen_profit_basis_debits = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::profit_basis_debits(&arg0.expiry_accounting);
        v0.frozen_pending_protocol_profit = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::pending_protocol_profit(&arg0.expiry_accounting);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::end_snapshot(arg2);
    }

    fun share_vault(arg0: 0x2::coin::TreasuryCap<PLP>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = PoolVault{
            id                       : 0x2::object::new(arg1),
            protocol_reserve_balance : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            fee_incentive_reserve    : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            lp                       : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::new<PLP>(arg0, arg1),
            expiry_accounting        : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::new(arg1),
            valuation                : 0x1::option::none<PoolValuation>(),
        };
        0x2::transfer::share_object<PoolVault>(v0);
        id(&v0)
    }

    public fun snapshot_expiry_pricer(arg0: &mut PoolVault, arg1: &SnapshotStage, arg2: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg3: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg4: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::registry::OracleRegistry, arg5: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::pyth_feed::PythFeed, arg6: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesValueStore, arg7: &0xa6c8f32015b5b41d34ee09995a2e9d7a21cdecf0e1910a50b264fd252cd33831::block_scholes_store::BlockScholesSVIStore, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg3);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_val(arg3);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::id(arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::chk_expiry(&arg0.expiry_accounting, v0);
        let v1 = 0x1::option::borrow<PoolValuation>(&arg0.valuation);
        if (!0x1::vector::contains<0x2::object::ID>(&v1.expected_expiry_markets, &v0)) {
            return
        };
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer>>(&v1.frozen_pricers, &v0), 7);
        let v2 = if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::is_settled(arg2)) {
            sweep_done(arg0, arg2, arg3);
            0x1::option::none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer>()
        } else {
            assert!(0x2::clock::timestamp_ms(arg8) < 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::expiry(arg2), 9);
            0x1::option::some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer>(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::into_frozen(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::load_live_pricer(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)))
        };
        let v3 = v2;
        0x2::vec_map::insert<0x2::object::ID, 0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer>>(&mut 0x1::option::borrow_mut<PoolValuation>(&mut arg0.valuation).frozen_pricers, v0, v3);
        if (0x1::option::is_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer>(&v3)) {
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::stamp_val(arg2, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::flush_seq(arg3));
        };
    }

    public fun sponsor_fee_incentives(arg0: &mut PoolVault, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg2: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x2::tx_context::TxContext) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_no_val(arg1);
        let v0 = 0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg2);
        assert!(v0 >= 10000000, 4);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_incentive_reserve, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2));
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::incent_given(id(arg0), 0x2::tx_context::sender(arg3), v0, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee_incentive_reserve));
    }

    public fun start_pool_valuation(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg1: &mut PoolVault, arg2: PoolValuationProof, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<u64>, arg5: &0x2::clock::Clock) : SnapshotStage {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_no_snap(arg0);
        let PoolValuationProof {  } = arg2;
        start_val(arg0, arg1, arg3, arg4, arg5);
        SnapshotStage{dummy_field: false}
    }

    fun start_val(arg0: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg1: &mut PoolVault, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: &0x2::clock::Clock) {
        assert!(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::total_supply<PLP>(&arg1.lp) > 0, 1);
        if (0x1::option::is_some<PoolValuation>(&arg1.valuation)) {
            discard_val(arg1, arg0);
        };
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::begin_val(arg0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::open_snap(arg0);
        let v0 = PoolValuation{
            expected_expiry_markets        : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::active_expiry_markets(&arg1.expiry_accounting),
            valued_expiry_markets          : 0x1::vector::empty<0x2::object::ID>(),
            total_nav                      : 0,
            frozen_pricers                 : 0x2::vec_map::empty<0x2::object::ID, 0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer>>(),
            sealed                         : false,
            started_at_ms                  : 0x2::clock::timestamp_ms(arg4),
            supply_budget                  : arg2,
            withdraw_budget                : arg3,
            supply_request_cutoff          : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::next_sup_idx<PLP>(&arg1.lp),
            withdraw_request_cutoff        : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book::next_wd_idx<PLP>(&arg1.lp),
            frozen_idle_balance            : 0,
            frozen_profit_basis_credits    : 0,
            frozen_profit_basis_debits     : 0,
            frozen_pending_protocol_profit : 0,
        };
        arg1.valuation = 0x1::option::some<PoolValuation>(v0);
    }

    fun sweep_done(arg0: &mut PoolVault, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::id(arg1);
        let v1 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::deactivate(&mut arg0.expiry_accounting, v0);
        let v2 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::recv_expiry(&mut arg0.expiry_accounting, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::free_settled(arg1), v0);
        if (v1 || v2 > 0) {
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::cash_recv(id(arg0), v0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::settlement_price(arg1), v2);
            let v3 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::sent_cash(&arg0.expiry_accounting, v0);
            let v4 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::received(&arg0.expiry_accounting, v0);
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::expiry_pnl(id(arg0), v0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::propbook_underlying_id(arg1), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::reference_tick_source_timestamp_ms(arg1), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::expiry(arg1), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::settlement_price(arg1), v3, v4);
            let (v5, v6) = if (v1) {
                (v4 >= v3, 0x1::u64::diff(v4, v3))
            } else {
                (true, v2)
            };
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::pnl_realized(id(arg0), v0, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::propbook_underlying_id(arg1), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::expiry(arg1), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::settlement_price(arg1), v5, v6);
        };
        materialize(arg0, arg2, v0);
        let v7 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::free_incent(arg1);
        let v8 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v7);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_incentive_reserve, v7);
        if (v8 > 0) {
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::incent_back(id(arg0), v0, v8, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee_incentive_reserve));
        };
    }

    fun sweep_live(arg0: &mut PoolVault, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::realize_pend(&mut arg0.expiry_accounting);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.protocol_reserve_balance, v0);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::rebalanced(id(arg0), arg2, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::recv_expiry(&mut arg0.expiry_accounting, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::release_cash(arg1, arg3 - arg4), arg2), false, arg4, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0));
    }

    fun sweep_or_bal(arg0: &mut PoolVault, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: &0x2::clock::Clock) : bool {
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::id(arg1);
        if (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::is_settled(arg1)) {
            sweep_done(arg0, arg1, arg2);
            true
        } else if (0x2::clock::timestamp_ms(arg3) >= 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::expiry(arg1)) {
            false
        } else {
            rebal_live(arg0, arg1, arg2, v0);
            false
        }
    }

    fun sync_incent(arg0: &mut PoolVault, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: 0x2::object::ID) {
        let v0 = 0x1::u64::min(0x1::u64::saturating_sub(0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_down(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::max_alloc(&arg0.expiry_accounting, arg3), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::fee_incentive_live_target_rate(arg2)), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::fee_incentive_balance(arg1)), 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee_incentive_reserve));
        if (v0 == 0) {
            return
        };
        let (v1, v2) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::note_alloc(&mut arg0.expiry_accounting, arg3, v0);
        if (v1 == 0) {
            return
        };
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::recv_incent(arg1, 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_incentive_reserve, v1));
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::incent_alloc(id(arg0), arg3, v1, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee_incentive_reserve), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::fee_incentive_balance(arg1), v2);
    }

    fun top_up_live(arg0: &mut PoolVault, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        let v0 = 0x1::u64::min(0x1::u64::min(arg4 - arg3, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::idle_balance(&arg0.expiry_accounting)), 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::avail_fund(&arg0.expiry_accounting, arg2));
        if (v0 == 0) {
            return
        };
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::recv_cash(arg1, 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::send_expiry(&mut arg0.expiry_accounting, arg2, v0));
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::rebalanced(id(arg0), arg2, v0, true, arg4, 0);
    }

    public fun value_expiry(arg0: &mut PoolVault, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::ExpiryMarket, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg2);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_val(arg2);
        let v0 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::id(arg1);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::chk_expiry(&arg0.expiry_accounting, v0);
        let v1 = 0x1::option::borrow<PoolValuation>(&arg0.valuation);
        assert!(v1.sealed, 6);
        if (!0x1::vector::contains<0x2::object::ID>(&v1.expected_expiry_markets, &v0)) {
            return
        };
        if (0x1::vector::contains<0x2::object::ID>(&v1.valued_expiry_markets, &v0)) {
            return
        };
        let v2 = *0x2::vec_map::get<0x2::object::ID, 0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer>>(&v1.frozen_pricers, &v0);
        let v3 = if (0x1::option::is_none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer>(&v2)) {
            0
        } else {
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::clear_stamp(arg1);
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::snapshot_nav(arg1, 0x1::option::borrow<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pricing::FrozenPricer>(&v2))
        };
        let v4 = 0x1::option::borrow_mut<PoolValuation>(&mut arg0.valuation);
        0x1::vector::push_back<0x2::object::ID>(&mut v4.valued_expiry_markets, v0);
        v4.total_nav = v4.total_nav + v3;
    }

    public fun withdraw_fee_incentives(arg0: &mut PoolVault, arg1: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::admin::AdminCap, arg2: &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::ProtocolConfig, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::protocol_config::chk_version(arg2);
        assert!(arg3 <= 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee_incentive_reserve), 14);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::incent_out(id(arg0), arg3, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.fee_incentive_reserve));
        0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.fee_incentive_reserve, arg3), arg4)
    }

    fun xfer_metacap(arg0: 0x2::coin_registry::MetadataCap<PLP>, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PLP>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

