module 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::state {
    struct State has store {
        accounts: 0x2::table::Table<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>,
        history: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::History,
        governance: 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::Governance,
    }

    struct StakeEvent has copy, drop {
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        epoch: u64,
        amount: u64,
        stake: bool,
    }

    struct ProposalEvent has copy, drop {
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        epoch: u64,
        taker_fee: u64,
        maker_fee: u64,
        stake_required: u64,
    }

    struct VoteEvent has copy, drop {
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        epoch: u64,
        from_proposal_id: 0x1::option::Option<0x2::object::ID>,
        to_proposal_id: 0x2::object::ID,
        stake: u64,
    }

    struct RebateEvent has copy, drop {
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        epoch: u64,
        claim_amount: u64,
    }

    public(friend) fun empty(arg0: bool, arg1: &mut 0x2::tx_context::TxContext) : State {
        let v0 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::empty(arg0, arg1);
        State{
            accounts   : 0x2::table::new<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(arg1),
            history    : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::empty(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(&v0), 0x2::tx_context::epoch(arg1), arg1),
            governance : v0,
        }
    }

    public(friend) fun account(arg0: &State, arg1: 0x2::object::ID) : &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account {
        0x2::table::borrow<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&arg0.accounts, arg1)
    }

    public(friend) fun governance(arg0: &State) : &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::Governance {
        &arg0.governance
    }

    public(friend) fun history(arg0: &State) : &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::History {
        &arg0.history
    }

    public(friend) fun account_exists(arg0: &State, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&arg0.accounts, arg1)
    }

    public(friend) fun governance_mut(arg0: &mut State, arg1: &0x2::tx_context::TxContext) : &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::Governance {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::update(&mut arg0.governance, arg1);
        &mut arg0.governance
    }

    public(friend) fun history_mut(arg0: &mut State) : &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::History {
        &mut arg0.history
    }

    public(friend) fun process_cancel(arg0: &mut State, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::update(&mut arg0.governance, arg3);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::update(&mut arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(&arg0.governance), arg3);
        update_account(arg0, arg2, arg3);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::set_canceled(arg1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, arg2);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::remove_order(v0, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::order_id(arg1));
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::add_settled_balances(v0, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::calculate_cancel_refund(arg1, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::historic_maker_fee(&arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::epoch(arg1)), 0x1::option::none<u64>()));
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::settle(v0)
    }

    public(friend) fun process_claim_rebates(arg0: &mut State, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::update(&mut arg0.governance, arg3);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::update(&mut arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(&arg0.governance), arg3);
        update_account(arg0, arg2, arg3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, arg2);
        let v1 = RebateEvent{
            pool_id            : arg1,
            balance_manager_id : arg2,
            epoch              : 0x2::tx_context::epoch(arg3),
            claim_amount       : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::claim_rebates(v0),
        };
        0x2::event::emit<RebateEvent>(v1);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::settle(v0)
    }

    public(friend) fun process_create(arg0: &mut State, arg1: &mut 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::OrderInfo, arg2: &0x2::tx_context::TxContext) : (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::update(&mut arg0.governance, arg2);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::update(&mut arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(&arg0.governance), arg2);
        let v0 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::fills_ref(arg1);
        process_fills(arg0, v0, arg2);
        update_account(arg0, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::balance_manager_id(arg1), arg2);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::balance_manager_id(arg1));
        let v2 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::total_volume(v1);
        let v3 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::active_stake(v1);
        let v4 = if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::executed_quantity(arg1) > 0) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::div(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::cumulative_quote_quantity(arg1), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::executed_quantity(arg1))
        } else {
            0
        };
        let v5 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::order_deep_price(arg1);
        let v6 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(&arg0.governance);
        let v7 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(&arg0.governance);
        if (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::order_inserted(arg1)) {
            let v8 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::open_orders(v1);
            assert!(0x2::vec_set::size<u128>(&v8) < 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::constants::max_open_orders(), 2);
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::add_order(v1, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::order_id(arg1));
        };
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::add_taker_volume(v1, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::executed_quantity(arg1));
        let (v9, v10) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::calculate_partial_fill_balances(arg1, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::trade_params::taker_fee_for_user(&v6, v3, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::deep_quantity_u128(&v5, v2, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul_u128(v2, (v4 as u128)))), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::trade_params::maker_fee(&v7));
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::settle(v1);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::add_total_fees_collected(&mut arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::new(0, 0, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order_info::paid_fees(arg1)));
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_balances(&mut v12, v13);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::add_balances(&mut v11, v14);
        (v12, v11)
    }

    fun process_fills(arg0: &mut State, arg1: &mut vector<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::whitelisted(&arg0.governance);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(arg1)) {
            let v2 = 0x1::vector::borrow_mut<0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::Fill>(arg1, v1);
            let v3 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::balance_manager_id(v2);
            update_account(arg0, v3, arg2);
            let v4 = 0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, v3);
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::process_maker_fill(v4, v2);
            let v5 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::base_quantity(v2);
            let v6 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::maker_deep_price(v2);
            let v7 = if (v0) {
                0
            } else {
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::math::mul(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::deep_price::deep_quantity(&v6, v5, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::quote_quantity(v2)), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::historic_maker_fee(&arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::maker_epoch(v2)))
            };
            if (!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::expired(v2)) {
                if (v7 > 0) {
                    0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::fill::set_fill_maker_fee(v2, v7);
                };
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::add_volume(&mut arg0.history, v5, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::active_stake(v4));
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::add_total_fees_collected(&mut arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::new(0, 0, v7));
            } else {
                0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::add_settled_balances(v4, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::new(0, 0, v7));
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun process_modify(arg0: &mut State, arg1: 0x2::object::ID, arg2: u64, arg3: &0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::Order, arg4: &0x2::tx_context::TxContext) : (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::update(&mut arg0.governance, arg4);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::update(&mut arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(&arg0.governance), arg4);
        update_account(arg0, arg1, arg4);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::add_settled_balances(0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, arg1), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::calculate_cancel_refund(arg3, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::historic_maker_fee(&arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::order::epoch(arg3)), 0x1::option::some<u64>(arg2)));
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::settle(0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, arg1))
    }

    public(friend) fun process_proposal(arg0: &mut State, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::update(&mut arg0.governance, arg6);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::update(&mut arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(&arg0.governance), arg6);
        update_account(arg0, arg2, arg6);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, arg2);
        let v1 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::active_stake(v0);
        assert!(v1 > 0, 1);
        assert!(!0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::created_proposal(v0), 3);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::set_created_proposal(v0, true);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::add_proposal(&mut arg0.governance, arg3, arg4, arg5, v1, arg2);
        process_vote(arg0, arg1, arg2, arg2, arg6);
        let v2 = ProposalEvent{
            pool_id            : arg1,
            balance_manager_id : arg2,
            epoch              : 0x2::tx_context::epoch(arg6),
            taker_fee          : arg3,
            maker_fee          : arg4,
            stake_required     : arg5,
        };
        0x2::event::emit<ProposalEvent>(v2);
    }

    public(friend) fun process_stake(arg0: &mut State, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) : (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::update(&mut arg0.governance, arg4);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::update(&mut arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(&arg0.governance), arg4);
        update_account(arg0, arg2, arg4);
        let (v0, v1) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::add_stake(0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, arg2), arg3);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::adjust_voting_power(&mut arg0.governance, v0, v1);
        let v2 = StakeEvent{
            pool_id            : arg1,
            balance_manager_id : arg2,
            epoch              : 0x2::tx_context::epoch(arg4),
            amount             : arg3,
            stake              : true,
        };
        0x2::event::emit<StakeEvent>(v2);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::settle(0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, arg2))
    }

    public(friend) fun process_unstake(arg0: &mut State, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::update(&mut arg0.governance, arg3);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::update(&mut arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(&arg0.governance), arg3);
        update_account(arg0, arg2, arg3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, arg2);
        let v1 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::active_stake(v0);
        let v2 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::inactive_stake(v0);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::remove_stake(v0);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::adjust_voting_power(&mut arg0.governance, v1 + v2, 0);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::adjust_vote(&mut arg0.governance, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::voted_proposal(v0), 0x1::option::none<0x2::object::ID>(), v1);
        let v3 = StakeEvent{
            pool_id            : arg1,
            balance_manager_id : arg2,
            epoch              : 0x2::tx_context::epoch(arg3),
            amount             : v1 + v2,
            stake              : false,
        };
        0x2::event::emit<StakeEvent>(v3);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::settle(v0)
    }

    public(friend) fun process_vote(arg0: &mut State, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::update(&mut arg0.governance, arg4);
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::update(&mut arg0.history, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::trade_params(&arg0.governance), arg4);
        update_account(arg0, arg2, arg4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, arg2);
        assert!(0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::active_stake(v0) > 0, 1);
        let v1 = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::set_voted_proposal(v0, 0x1::option::some<0x2::object::ID>(arg3));
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::governance::adjust_vote(&mut arg0.governance, v1, 0x1::option::some<0x2::object::ID>(arg3), 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::active_stake(v0));
        let v2 = VoteEvent{
            pool_id            : arg1,
            balance_manager_id : arg2,
            epoch              : 0x2::tx_context::epoch(arg4),
            from_proposal_id   : v1,
            to_proposal_id     : arg3,
            stake              : 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::active_stake(v0),
        };
        0x2::event::emit<VoteEvent>(v2);
    }

    fun update_account(arg0: &mut State, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&arg0.accounts, arg1)) {
            0x2::table::add<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, arg1, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::empty(arg2));
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, arg1);
        let (v1, v2, v3) = 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::update(v0, arg2);
        let v4 = if (v1 > 0) {
            if (v2 > 0) {
                v3 > 0
            } else {
                false
            }
        } else {
            false
        };
        if (v4) {
            0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::add_rebates(v0, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::history::calculate_rebate_amount(&mut arg0.history, v1, v2, v3));
        };
    }

    public(friend) fun withdraw_settled_amounts(arg0: &mut State, arg1: 0x2::object::ID) : (0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::balances::Balances) {
        0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::settle(0x2::table::borrow_mut<0x2::object::ID, 0x6f2abaa15ea8f1935968310a196807272b37150878dc4072f2e0cbaa9eca894a::account::Account>(&mut arg0.accounts, arg1))
    }

    // decompiled from Move bytecode v6
}

