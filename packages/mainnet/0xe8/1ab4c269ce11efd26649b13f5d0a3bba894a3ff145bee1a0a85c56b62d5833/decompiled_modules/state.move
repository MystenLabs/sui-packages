module 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::state {
    struct State has store {
        accounts: 0x2::table::Table<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>,
        history: 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::History,
        governance: 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::Governance,
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

    struct RebateEventV2 has copy, drop {
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        epoch: u64,
        claim_amount: 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances,
    }

    struct RebateEvent has copy, drop {
        pool_id: 0x2::object::ID,
        balance_manager_id: 0x2::object::ID,
        epoch: u64,
        claim_amount: u64,
    }

    public(friend) fun empty(arg0: bool, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) : State {
        let v0 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::empty(arg0, arg1, arg2);
        State{
            accounts   : 0x2::table::new<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(arg2),
            history    : 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::empty(0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::trade_params(&v0), 0x2::tx_context::epoch(arg2), arg2),
            governance : v0,
        }
    }

    public(friend) fun account(arg0: &State, arg1: 0x2::object::ID) : &0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account {
        0x2::table::borrow<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&arg0.accounts, arg1)
    }

    public(friend) fun governance(arg0: &State) : &0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::Governance {
        &arg0.governance
    }

    public(friend) fun history(arg0: &State) : &0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::History {
        &arg0.history
    }

    public(friend) fun account_exists(arg0: &State, arg1: 0x2::object::ID) : bool {
        0x2::table::contains<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&arg0.accounts, arg1)
    }

    public(friend) fun governance_mut(arg0: &mut State, arg1: &0x2::tx_context::TxContext) : &mut 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::Governance {
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::update(&mut arg0.governance, arg1);
        &mut arg0.governance
    }

    public(friend) fun history_mut(arg0: &mut State) : &mut 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::History {
        &mut arg0.history
    }

    public(friend) fun process_cancel(arg0: &mut State, arg1: &mut 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order::Order, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) : (0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances) {
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::update(&mut arg0.governance, arg4);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::update(&mut arg0.history, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::trade_params(&arg0.governance), arg3, arg4);
        update_account(arg0, arg2, arg4);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order::set_canceled(arg1);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, arg2);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::remove_order(v0, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order::order_id(arg1));
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::add_settled_balances(v0, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order::calculate_cancel_refund(arg1, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::historic_maker_fee(&arg0.history, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order::epoch(arg1)), 0x1::option::none<u64>()));
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::settle(v0)
    }

    public(friend) fun process_claim_rebates<T0, T1>(arg0: &mut State, arg1: 0x2::object::ID, arg2: &0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balance_manager::BalanceManager, arg3: &0x2::tx_context::TxContext) : (0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances) {
        let v0 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balance_manager::id(arg2);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::update(&mut arg0.governance, arg3);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::update(&mut arg0.history, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::trade_params(&arg0.governance), arg1, arg3);
        update_account(arg0, v0, arg3);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, v0);
        let v2 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::claim_rebates(v1);
        let v3 = RebateEventV2{
            pool_id            : arg1,
            balance_manager_id : v0,
            epoch              : 0x2::tx_context::epoch(arg3),
            claim_amount       : v2,
        };
        0x2::event::emit<RebateEventV2>(v3);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balance_manager::emit_balance_event(arg2, 0x1::type_name::get<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(), 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::deep(&v2), true);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balance_manager::emit_balance_event(arg2, 0x1::type_name::get<T0>(), 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::base(&v2), true);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balance_manager::emit_balance_event(arg2, 0x1::type_name::get<T1>(), 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::quote(&v2), true);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::settle(v1)
    }

    public(friend) fun process_create(arg0: &mut State, arg1: &mut 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::OrderInfo, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : (0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances) {
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::update(&mut arg0.governance, arg3);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::update(&mut arg0.history, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::trade_params(&arg0.governance), arg2, arg3);
        let v0 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::fills_ref(arg1);
        process_fills(arg0, v0, arg3);
        update_account(arg0, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::balance_manager_id(arg1), arg3);
        let v1 = 0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::balance_manager_id(arg1));
        let v2 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::total_volume(v1);
        let v3 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::active_stake(v1);
        let v4 = if (0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::executed_quantity(arg1) > 0) {
            0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::math::div(0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::cumulative_quote_quantity(arg1), 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::executed_quantity(arg1))
        } else {
            0
        };
        let v5 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::order_deep_price(arg1);
        let v6 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::trade_params(&arg0.governance);
        let v7 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::trade_params(&arg0.governance);
        if (0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::order_inserted(arg1)) {
            let v8 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::open_orders(v1);
            assert!(0x2::vec_set::size<u128>(&v8) < 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::constants::max_open_orders(), 2);
            0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::add_order(v1, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::order_id(arg1));
        };
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::add_taker_volume(v1, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::executed_quantity(arg1));
        let (v9, v10) = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::calculate_partial_fill_balances(arg1, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::trade_params::taker_fee_for_user(&v6, v3, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::deep_price::deep_quantity_u128(&v5, v2, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::math::mul_u128(v2, (v4 as u128)))), 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::trade_params::maker_fee(&v7));
        let v11 = v10;
        let v12 = v9;
        let (v13, v14) = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::settle(v1);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::add_total_fees_collected(&mut arg0.history, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order_info::paid_fees_balances(arg1));
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::add_balances(&mut v12, v13);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::add_balances(&mut v11, v14);
        (v12, v11)
    }

    fun process_fills(arg0: &mut State, arg1: &mut vector<0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::fill::Fill>, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::fill::Fill>(arg1)) {
            let v1 = 0x1::vector::borrow_mut<0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::fill::Fill>(arg1, v0);
            let v2 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::fill::balance_manager_id(v1);
            update_account(arg0, v2, arg2);
            let v3 = 0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, v2);
            0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::process_maker_fill(v3, v1);
            let v4 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::fill::base_quantity(v1);
            let v5 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::fill::maker_deep_price(v1);
            let v6 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::deep_price::fee_quantity(&v5, v4, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::fill::quote_quantity(v1), !0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::fill::taker_is_bid(v1));
            0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::mul(&mut v6, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::historic_maker_fee(&arg0.history, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::fill::maker_epoch(v1)));
            if (!0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::fill::expired(v1)) {
                0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::fill::set_fill_maker_fee(v1, &v6);
                0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::add_volume(&mut arg0.history, v4, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::active_stake(v3));
                0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::add_total_fees_collected(&mut arg0.history, v6);
            } else {
                0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::add_settled_balances(v3, v6);
            };
            v0 = v0 + 1;
        };
    }

    public(friend) fun process_modify(arg0: &mut State, arg1: 0x2::object::ID, arg2: u64, arg3: &0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order::Order, arg4: 0x2::object::ID, arg5: &0x2::tx_context::TxContext) : (0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances) {
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::update(&mut arg0.governance, arg5);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::update(&mut arg0.history, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::trade_params(&arg0.governance), arg4, arg5);
        update_account(arg0, arg1, arg5);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::add_settled_balances(0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, arg1), 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order::calculate_cancel_refund(arg3, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::historic_maker_fee(&arg0.history, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::order::epoch(arg3)), 0x1::option::some<u64>(arg2)));
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::settle(0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, arg1))
    }

    public(friend) fun process_proposal(arg0: &mut State, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) {
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::update(&mut arg0.governance, arg6);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::update(&mut arg0.history, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::trade_params(&arg0.governance), arg1, arg6);
        update_account(arg0, arg2, arg6);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, arg2);
        let v1 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::active_stake(v0);
        assert!(v1 > 0, 1);
        assert!(!0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::created_proposal(v0), 3);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::set_created_proposal(v0, true);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::add_proposal(&mut arg0.governance, arg3, arg4, arg5, v1, arg2);
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

    public(friend) fun process_stake(arg0: &mut State, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) : (0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances) {
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::update(&mut arg0.governance, arg4);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::update(&mut arg0.history, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::trade_params(&arg0.governance), arg1, arg4);
        update_account(arg0, arg2, arg4);
        let (v0, v1) = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::add_stake(0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, arg2), arg3);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::adjust_voting_power(&mut arg0.governance, v0, v1);
        let v2 = StakeEvent{
            pool_id            : arg1,
            balance_manager_id : arg2,
            epoch              : 0x2::tx_context::epoch(arg4),
            amount             : arg3,
            stake              : true,
        };
        0x2::event::emit<StakeEvent>(v2);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::settle(0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, arg2))
    }

    public(friend) fun process_unstake(arg0: &mut State, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: &0x2::tx_context::TxContext) : (0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances) {
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::update(&mut arg0.governance, arg3);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::update(&mut arg0.history, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::trade_params(&arg0.governance), arg1, arg3);
        update_account(arg0, arg2, arg3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, arg2);
        let v1 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::active_stake(v0);
        let v2 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::inactive_stake(v0);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::remove_stake(v0);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::adjust_voting_power(&mut arg0.governance, v1 + v2, 0);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::adjust_vote(&mut arg0.governance, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::voted_proposal(v0), 0x1::option::none<0x2::object::ID>(), v1);
        let v3 = StakeEvent{
            pool_id            : arg1,
            balance_manager_id : arg2,
            epoch              : 0x2::tx_context::epoch(arg3),
            amount             : v1 + v2,
            stake              : false,
        };
        0x2::event::emit<StakeEvent>(v3);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::settle(v0)
    }

    public(friend) fun process_vote(arg0: &mut State, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::tx_context::TxContext) {
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::update(&mut arg0.governance, arg4);
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::update(&mut arg0.history, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::trade_params(&arg0.governance), arg1, arg4);
        update_account(arg0, arg2, arg4);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, arg2);
        assert!(0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::active_stake(v0) > 0, 1);
        let v1 = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::set_voted_proposal(v0, 0x1::option::some<0x2::object::ID>(arg3));
        0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::governance::adjust_vote(&mut arg0.governance, v1, 0x1::option::some<0x2::object::ID>(arg3), 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::active_stake(v0));
        let v2 = VoteEvent{
            pool_id            : arg1,
            balance_manager_id : arg2,
            epoch              : 0x2::tx_context::epoch(arg4),
            from_proposal_id   : v1,
            to_proposal_id     : arg3,
            stake              : 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::active_stake(v0),
        };
        0x2::event::emit<VoteEvent>(v2);
    }

    fun update_account(arg0: &mut State, arg1: 0x2::object::ID, arg2: &0x2::tx_context::TxContext) {
        if (!0x2::table::contains<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&arg0.accounts, arg1)) {
            0x2::table::add<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, arg1, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::empty(arg2));
        };
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, arg1);
        let (v1, v2, v3) = 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::update(v0, arg2);
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
            0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::add_rebates(v0, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::history::calculate_rebate_amount(&mut arg0.history, v1, v2, v3));
        };
    }

    public(friend) fun withdraw_settled_amounts(arg0: &mut State, arg1: 0x2::object::ID) : (0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::Balances) {
        if (0x2::table::contains<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&arg0.accounts, arg1)) {
            0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::settle(0x2::table::borrow_mut<0x2::object::ID, 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::account::Account>(&mut arg0.accounts, arg1))
        } else {
            (0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::empty(), 0xe81ab4c269ce11efd26649b13f5d0a3bba894a3ff145bee1a0a85c56b62d5833::balances::empty())
        }
    }

    // decompiled from Move bytecode v6
}

