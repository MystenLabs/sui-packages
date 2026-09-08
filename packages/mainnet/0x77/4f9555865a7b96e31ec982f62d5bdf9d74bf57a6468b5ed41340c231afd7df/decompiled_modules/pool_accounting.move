module 0x774f9555865a7b96e31ec982f62d5bdf9d74bf57a6468b5ed41340c231afd7df::pool_accounting {
    struct Ledger has store {
        idle_balance: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        active_expiry_markets: vector<ActiveExpiry>,
        registered_expiries: 0x2::table::Table<0x2::object::ID, RegisteredExpiry>,
        profit_basis_debits: u64,
        profit_basis_credits: u64,
        net_losses_to_fill: u64,
        pending_protocol_profit: u64,
    }

    struct ActiveExpiry has copy, drop, store {
        expiry_market_id: 0x2::object::ID,
        expiry_ms: u64,
    }

    struct RegisteredExpiry has store {
        max_expiry_allocation: u64,
        initial_expiry_cash: u64,
        sent_to_expiry: u64,
        received_from_expiry: u64,
        fee_incentive_lifetime_cap: u64,
        fee_incentives_allocated: u64,
        terminal_accounting_started: bool,
        terminal_received_watermark: u64,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : Ledger {
        Ledger{
            idle_balance            : 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(),
            active_expiry_markets   : 0x1::vector::empty<ActiveExpiry>(),
            registered_expiries     : 0x2::table::new<0x2::object::ID, RegisteredExpiry>(arg0),
            profit_basis_debits     : 0,
            profit_basis_credits    : 0,
            net_losses_to_fill      : 0,
            pending_protocol_profit : 0,
        }
    }

    public(friend) fun active_expiry_markets(arg0: &Ledger) : vector<0x2::object::ID> {
        let v0 = &arg0.active_expiry_markets;
        let v1 = 0x1::vector::empty<0x2::object::ID>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<ActiveExpiry>(v0)) {
            0x1::vector::push_back<0x2::object::ID>(&mut v1, 0x1::vector::borrow<ActiveExpiry>(v0, v2).expiry_market_id);
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun active_live_expiry_count(arg0: &Ledger, arg1: u64) : u64 {
        let v0 = &arg0.active_expiry_markets;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<ActiveExpiry>(v0)) {
            if (0x1::vector::borrow<ActiveExpiry>(v0, v2).expiry_ms > arg1) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        v1
    }

    public(friend) fun assert_registered_expiry(arg0: &Ledger, arg1: 0x2::object::ID) {
        assert!(0x2::table::contains<0x2::object::ID, RegisteredExpiry>(&arg0.registered_expiries, arg1), 0);
    }

    public(friend) fun available_expiry_funding(arg0: &Ledger, arg1: 0x2::object::ID) : u64 {
        assert_registered_expiry(arg0, arg1);
        let v0 = 0x2::table::borrow<0x2::object::ID, RegisteredExpiry>(&arg0.registered_expiries, arg1);
        0x1::u64::saturating_sub(v0.max_expiry_allocation, flow_net_funding(v0))
    }

    public(friend) fun deactivate_expiry_if_present(arg0: &mut Ledger, arg1: 0x2::object::ID) : bool {
        assert_registered_expiry(arg0, arg1);
        let v0 = &arg0.active_expiry_markets;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<ActiveExpiry>(v0)) {
            if (0x1::vector::borrow<ActiveExpiry>(v0, v1).expiry_market_id == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                if (0x1::option::is_none<u64>(&v2)) {
                    return false
                };
                0x1::vector::swap_remove<ActiveExpiry>(&mut arg0.active_expiry_markets, 0x1::option::destroy_some<u64>(v2));
                return true
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    fun flow_net_funding(arg0: &RegisteredExpiry) : u64 {
        0x1::u64::saturating_sub(arg0.sent_to_expiry, arg0.received_from_expiry)
    }

    public(friend) fun idle_balance(arg0: &Ledger) : u64 {
        0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.idle_balance)
    }

    public(friend) fun initial_expiry_cash(arg0: &Ledger, arg1: 0x2::object::ID) : u64 {
        assert_registered_expiry(arg0, arg1);
        0x2::table::borrow<0x2::object::ID, RegisteredExpiry>(&arg0.registered_expiries, arg1).initial_expiry_cash
    }

    public(friend) fun materialize_expiry_profit(arg0: &mut Ledger, arg1: 0x2::object::ID) : u64 {
        assert_registered_expiry(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, RegisteredExpiry>(&mut arg0.registered_expiries, arg1);
        let v1 = start_terminal_accounting_if_needed(v0);
        let v2 = v0.received_from_expiry;
        let v3 = if (v2 > v0.terminal_received_watermark) {
            v0.terminal_received_watermark = v2;
            v2 - v0.terminal_received_watermark
        } else {
            0
        };
        arg0.net_losses_to_fill = arg0.net_losses_to_fill + v1;
        if (v3 == 0) {
            return 0
        };
        if (v3 <= arg0.net_losses_to_fill) {
            arg0.net_losses_to_fill = arg0.net_losses_to_fill - v3;
            0
        } else {
            let v5 = v3 - arg0.net_losses_to_fill;
            arg0.net_losses_to_fill = 0;
            arg0.profit_basis_debits = arg0.profit_basis_debits + v5;
            v5
        }
    }

    public(friend) fun max_expiry_allocation(arg0: &Ledger, arg1: 0x2::object::ID) : u64 {
        assert_registered_expiry(arg0, arg1);
        0x2::table::borrow<0x2::object::ID, RegisteredExpiry>(&arg0.registered_expiries, arg1).max_expiry_allocation
    }

    public(friend) fun pending_protocol_profit(arg0: &Ledger) : u64 {
        arg0.pending_protocol_profit
    }

    public(friend) fun profit_basis_credits(arg0: &Ledger) : u64 {
        arg0.profit_basis_credits
    }

    public(friend) fun profit_basis_debits(arg0: &Ledger) : u64 {
        arg0.profit_basis_debits
    }

    public(friend) fun realize_pending_protocol_profit(arg0: &mut Ledger) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        let v0 = 0x1::u64::min(arg0.pending_protocol_profit, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.idle_balance));
        arg0.pending_protocol_profit = arg0.pending_protocol_profit - v0;
        0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.idle_balance, v0)
    }

    public(friend) fun realize_protocol_profit(arg0: &mut Ledger, arg1: u64) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        arg0.pending_protocol_profit = arg0.pending_protocol_profit + arg1;
        realize_pending_protocol_profit(arg0)
    }

    public(friend) fun receive_expiry_cash(arg0: &mut Ledger, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: 0x2::object::ID) : u64 {
        let v0 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
            return 0
        };
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.idle_balance, arg1);
        record_received_from_expiry(arg0, arg2, v0);
        v0
    }

    public(friend) fun receive_idle(arg0: &mut Ledger, arg1: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.idle_balance, arg1);
    }

    public(friend) fun record_fee_incentives_allocated_up_to(arg0: &mut Ledger, arg1: 0x2::object::ID, arg2: u64) : (u64, u64) {
        assert_registered_expiry(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, RegisteredExpiry>(&mut arg0.registered_expiries, arg1);
        assert!(!v0.terminal_accounting_started, 3);
        let v1 = 0x1::u64::min(arg2, v0.fee_incentive_lifetime_cap - v0.fee_incentives_allocated);
        v0.fee_incentives_allocated = v0.fee_incentives_allocated + v1;
        (v1, v0.fee_incentives_allocated)
    }

    fun record_received_from_expiry(arg0: &mut Ledger, arg1: 0x2::object::ID, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        assert_registered_expiry(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, RegisteredExpiry>(&mut arg0.registered_expiries, arg1);
        v0.received_from_expiry = v0.received_from_expiry + arg2;
        arg0.profit_basis_credits = arg0.profit_basis_credits + arg2;
    }

    fun record_sent_to_expiry(arg0: &mut Ledger, arg1: 0x2::object::ID, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        assert_registered_expiry(arg0, arg1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, RegisteredExpiry>(&mut arg0.registered_expiries, arg1);
        assert!(!v0.terminal_accounting_started, 3);
        assert!(flow_net_funding(v0) + arg2 <= v0.max_expiry_allocation, 2);
        v0.sent_to_expiry = v0.sent_to_expiry + arg2;
        arg0.profit_basis_debits = arg0.profit_basis_debits + arg2;
    }

    public(friend) fun register_expiry(arg0: &mut Ledger, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64) {
        assert!(!0x2::table::contains<0x2::object::ID, RegisteredExpiry>(&arg0.registered_expiries, arg1), 1);
        let v0 = ActiveExpiry{
            expiry_market_id : arg1,
            expiry_ms        : arg2,
        };
        0x1::vector::push_back<ActiveExpiry>(&mut arg0.active_expiry_markets, v0);
        let v1 = RegisteredExpiry{
            max_expiry_allocation       : arg3,
            initial_expiry_cash         : arg4,
            sent_to_expiry              : 0,
            received_from_expiry        : 0,
            fee_incentive_lifetime_cap  : 0xeb8212402af172cac87ef533a61a899334a75a745489432aaa31872fdc5ecb42::math::mul_down(arg3, 100000000),
            fee_incentives_allocated    : 0,
            terminal_accounting_started : false,
            terminal_received_watermark : 0,
        };
        0x2::table::add<0x2::object::ID, RegisteredExpiry>(&mut arg0.registered_expiries, arg1, v1);
    }

    public(friend) fun send_expiry_cash(arg0: &mut Ledger, arg1: 0x2::object::ID, arg2: u64) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        if (arg2 == 0) {
            return 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>()
        };
        record_sent_to_expiry(arg0, arg1, arg2);
        0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.idle_balance, arg2)
    }

    fun start_terminal_accounting_if_needed(arg0: &mut RegisteredExpiry) : u64 {
        if (arg0.terminal_accounting_started) {
            return 0
        };
        arg0.terminal_accounting_started = true;
        if (arg0.sent_to_expiry > arg0.received_from_expiry) {
            arg0.terminal_received_watermark = arg0.received_from_expiry;
            arg0.sent_to_expiry - arg0.received_from_expiry
        } else {
            arg0.terminal_received_watermark = arg0.sent_to_expiry;
            0
        }
    }

    public(friend) fun withdraw_idle(arg0: &mut Ledger, arg1: u64) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut arg0.idle_balance, arg1)
    }

    // decompiled from Move bytecode v7
}

