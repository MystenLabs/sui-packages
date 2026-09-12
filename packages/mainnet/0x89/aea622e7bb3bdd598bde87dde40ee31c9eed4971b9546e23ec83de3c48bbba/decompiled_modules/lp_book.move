module 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::lp_book {
    struct LpBook<phantom T0> has store {
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        supply_queue: RequestQueue<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
        withdraw_queue: RequestQueue<T0>,
        locked_lp: 0x2::balance::Balance<T0>,
    }

    struct RequestEntry has copy, drop, store {
        index: u64,
        account_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
        min_output: u64,
        missed_flushes: u64,
    }

    struct RequestPage has store {
        prev: 0x1::option::Option<u64>,
        next: 0x1::option::Option<u64>,
        entries: vector<RequestEntry>,
    }

    struct RequestQueue<phantom T0> has store {
        pages: 0x2::table::Table<u64, RequestPage>,
        head_page_id: 0x1::option::Option<u64>,
        tail_page_id: 0x1::option::Option<u64>,
        next_index: u64,
        pending: u64,
        escrow: 0x2::balance::Balance<T0>,
    }

    struct FlushMark has drop {
        pool_value: u64,
        total_supply: u64,
        executable: bool,
    }

    struct FeeRates has copy, drop {
        supply: u64,
        withdraw: u64,
    }

    struct FillQuote has copy, drop {
        output: u64,
        fee: u64,
    }

    struct DrainSummary has copy, drop {
        supplies_filled: u64,
        withdrawals_filled: u64,
        requests_processed: u64,
    }

    fun remove<T0>(arg0: &mut RequestQueue<T0>, arg1: u64) : (RequestEntry, 0x2::balance::Balance<T0>) {
        let v0 = page_id_for_index(arg1);
        assert!(0x2::table::contains<u64, RequestPage>(&arg0.pages, v0), 0);
        let v1 = 0x2::table::borrow_mut<u64, RequestPage>(&mut arg0.pages, v0);
        let v2 = 0x1::vector::remove<RequestEntry>(&mut v1.entries, entry_offset(&v1.entries, arg1));
        if (0x1::vector::length<RequestEntry>(&v1.entries) == 0) {
            unlink_empty_page<T0>(arg0, v0);
        };
        arg0.pending = arg0.pending - 1;
        (v2, 0x2::balance::split<T0>(&mut arg0.escrow, v2.amount))
    }

    public(friend) fun total_supply<T0>(arg0: &LpBook<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury_cap)
    }

    public(friend) fun new<T0>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) : LpBook<T0> {
        let v0 = queue_new<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1);
        LpBook<T0>{
            treasury_cap   : arg0,
            supply_queue   : v0,
            withdraw_queue : queue_new<T0>(arg1),
            locked_lp      : 0x2::balance::zero<T0>(),
        }
    }

    public(friend) fun cancel_supply_request<T0>(arg0: &mut LpBook<T0>, arg1: address, arg2: u64) : (0x2::object::ID, u64, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        let v0 = &mut arg0.supply_queue;
        let (v1, v2) = remove_for_recipient<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg2, arg1);
        let v3 = v1;
        (v3.account_id, v3.amount, v2)
    }

    public(friend) fun cancel_withdraw_request<T0>(arg0: &mut LpBook<T0>, arg1: address, arg2: u64) : (0x2::object::ID, u64, 0x2::balance::Balance<T0>) {
        let v0 = &mut arg0.withdraw_queue;
        let (v1, v2) = remove_for_recipient<T0>(v0, arg2, arg1);
        let v3 = v1;
        (v3.account_id, v3.amount, v2)
    }

    public(friend) fun drain<T0>(arg0: &mut LpBook<T0>, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::Ledger, arg2: FlushMark, arg3: FeeRates, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u64>, arg8: 0x1::option::Option<u64>, arg9: u64, arg10: u64, arg11: &mut 0x2::tx_context::TxContext) : DrainSummary {
        let (v0, v1) = drain_supply_queue<T0>(arg0, arg1, &arg2, &arg3, arg4, arg5, &arg7, arg9, arg10);
        let (v2, v3) = drain_withdraw_queue<T0>(arg0, arg1, &arg2, &arg3, arg4, arg6, &arg8, arg9, arg11);
        DrainSummary{
            supplies_filled    : v0,
            withdrawals_filled : v2,
            requests_processed : v1 + v3,
        }
    }

    fun drain_supply_queue<T0>(arg0: &mut LpBook<T0>, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::Ledger, arg2: &FlushMark, arg3: &FeeRates, arg4: 0x2::object::ID, arg5: u64, arg6: &0x1::option::Option<u64>, arg7: u64, arg8: u64) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = arg2.pool_value;
        while (under_budget(arg6, v1) && !is_empty<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.supply_queue)) {
            let v3 = front_request<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg0.supply_queue);
            if (v3.index >= arg5) {
                break
            };
            let v4 = quote_supply_shares(arg2, arg3, v3.amount);
            if (0x1::option::is_none<FillQuote>(&v4)) {
                v1 = v1 + 1;
                0x1::option::destroy_none<FillQuote>(v4);
                let v5 = &mut arg0.supply_queue;
                let (v6, v7) = pop_front<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v5);
                refund_supply_request(arg4, v6, v7, 1, arg0.supply_queue.pending);
                continue
            };
            let FillQuote {
                output : v8,
                fee    : _,
            } = 0x1::option::destroy_some<FillQuote>(v4);
            if (v8 < v3.min_output) {
                v1 = v1 + 1;
                let v10 = v3.missed_flushes + 1;
                if (v10 >= arg7) {
                    let v11 = &mut arg0.supply_queue;
                    let (v12, v13) = pop_front<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v11);
                    refund_supply_request(arg4, v12, v13, 2, arg0.supply_queue.pending);
                    continue
                } else {
                    let v14 = &mut arg0.supply_queue;
                    record_front_limit_miss<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v14);
                    emit_request_limit_missed(arg4, &v3, true, v8, v10, arg7);
                    break
                };
            };
            let v15 = 0x1::u64::min(v3.amount, 0x1::u64::saturating_sub(arg8, v2));
            let v16 = v15 < v3.amount;
            let v17 = quote_supply_shares(arg2, arg3, v15);
            if (0x1::option::is_none<FillQuote>(&v17)) {
                break
            };
            let FillQuote {
                output : v18,
                fee    : v19,
            } = 0x1::option::destroy_some<FillQuote>(v17);
            if (v18 > 18446744073709551615 - 0x2::coin::total_supply<T0>(&arg0.treasury_cap)) {
                if (!v16) {
                    v1 = v1 + 1;
                    let v20 = &mut arg0.supply_queue;
                    let (v21, v22) = pop_front<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v20);
                    refund_supply_request(arg4, v21, v22, 1, arg0.supply_queue.pending);
                    break
                } else {
                    break
                };
            };
            if (v18 < 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_up(v3.min_output, v15, v3.amount)) {
                break
            };
            v1 = v1 + 1;
            let v23 = if (v16) {
                let v24 = &mut arg0.supply_queue;
                fill_front_partially<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v24, v15)
            } else {
                let v25 = &mut arg0.supply_queue;
                let (_, v27) = pop_front<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v25);
                v27
            };
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::receive_idle(arg1, v23);
            v2 = v2 + v15;
            0x2::balance::send_funds<T0>(0x2::coin::mint_balance<T0>(&mut arg0.treasury_cap, v18), v3.recipient);
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::emit_supply_filled(arg4, v3.account_id, v3.recipient, v3.index, v15, v18, v19, v3.amount - v15, arg0.supply_queue.pending);
            v0 = v0 + 1;
            if (v16) {
                break
            };
        };
        (v0, v1)
    }

    fun drain_withdraw_queue<T0>(arg0: &mut LpBook<T0>, arg1: &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::Ledger, arg2: &FlushMark, arg3: &FeeRates, arg4: 0x2::object::ID, arg5: u64, arg6: &0x1::option::Option<u64>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0;
        let v1 = 0;
        while (under_budget(arg6, v1) && !is_empty<T0>(&arg0.withdraw_queue)) {
            let v2 = front_request<T0>(&arg0.withdraw_queue);
            if (v2.index >= arg5) {
                break
            };
            let v3 = quote_withdraw_usdc(arg2, arg3, v2.amount);
            if (0x1::option::is_none<FillQuote>(&v3)) {
                0x1::option::destroy_none<FillQuote>(v3);
                let v4 = &mut arg0.withdraw_queue;
                let (v5, v6) = pop_front<T0>(v4);
                v1 = v1 + 1;
                refund_withdraw_request<T0>(arg4, v5, v6, 1, arg0.withdraw_queue.pending);
                continue
            };
            let FillQuote {
                output : v7,
                fee    : v8,
            } = 0x1::option::destroy_some<FillQuote>(v3);
            if (v7 < v2.min_output) {
                v1 = v1 + 1;
                let v9 = v2.missed_flushes + 1;
                if (v9 >= arg7) {
                    let v10 = &mut arg0.withdraw_queue;
                    let (v11, v12) = pop_front<T0>(v10);
                    refund_withdraw_request<T0>(arg4, v11, v12, 2, arg0.withdraw_queue.pending);
                    continue
                } else {
                    let v13 = &mut arg0.withdraw_queue;
                    record_front_limit_miss<T0>(v13);
                    emit_request_limit_missed(arg4, &v2, false, v7, v9, arg7);
                    break
                };
            };
            let v14 = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::idle_balance(arg1);
            let (v15, v16, v17) = if (v14 >= v7) {
                (v2.amount, v7, v8)
            } else {
                let v18 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::try_mul_div_down(v14, arg2.total_supply, arg2.pool_value);
                if (0x1::option::is_none<u64>(&v18)) {
                    break
                };
                let v19 = 0x1::option::destroy_some<u64>(v18);
                let v20 = quote_withdraw_usdc(arg2, arg3, v19);
                if (0x1::option::is_none<FillQuote>(&v20) || 0x1::option::borrow<FillQuote>(&v20).output < 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_up(v2.min_output, v19, v2.amount)) {
                    break
                };
                let FillQuote {
                    output : v21,
                    fee    : v22,
                } = 0x1::option::destroy_some<FillQuote>(v20);
                (v19, v21, v22)
            };
            let v23 = v15 < v2.amount;
            let v24 = if (v23) {
                let v25 = &mut arg0.withdraw_queue;
                fill_front_partially<T0>(v25, v15)
            } else {
                let v26 = &mut arg0.withdraw_queue;
                let (_, v28) = pop_front<T0>(v26);
                v28
            };
            0x2::coin::burn<T0>(&mut arg0.treasury_cap, 0x2::coin::from_balance<T0>(v24, arg8));
            0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::pool_accounting::withdraw_idle(arg1, v16), v2.recipient);
            0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::emit_withdraw_filled(arg4, v2.account_id, v2.recipient, v2.index, v15, v16, v17, v2.amount - v15, arg0.withdraw_queue.pending);
            v1 = v1 + 1;
            v0 = v0 + 1;
            if (v23) {
                break
            };
        };
        (v0, v1)
    }

    fun emit_request_limit_missed(arg0: 0x2::object::ID, arg1: &RequestEntry, arg2: bool, arg3: u64, arg4: u64, arg5: u64) {
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::emit_request_limit_missed(arg0, arg1.account_id, arg1.recipient, arg1.index, arg1.amount, arg2, arg3, arg1.min_output, arg4, arg5);
    }

    fun enqueue<T0>(arg0: &mut RequestQueue<T0>, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: u64) : u64 {
        let v0 = arg0.next_index;
        arg0.next_index = v0 + 1;
        let v1 = ensure_tail_page_for_index<T0>(arg0, v0);
        let v2 = RequestEntry{
            index          : v0,
            account_id     : arg1,
            recipient      : arg2,
            amount         : 0x2::balance::value<T0>(&arg3),
            min_output     : arg4,
            missed_flushes : 0,
        };
        0x1::vector::push_back<RequestEntry>(&mut 0x2::table::borrow_mut<u64, RequestPage>(&mut arg0.pages, v1).entries, v2);
        0x2::balance::join<T0>(&mut arg0.escrow, arg3);
        arg0.pending = arg0.pending + 1;
        v0
    }

    fun ensure_tail_page_for_index<T0>(arg0: &mut RequestQueue<T0>, arg1: u64) : u64 {
        let v0 = page_id_for_index(arg1);
        if (0x1::option::is_none<u64>(&arg0.tail_page_id)) {
            0x2::table::add<u64, RequestPage>(&mut arg0.pages, v0, new_page(0x1::option::none<u64>(), 0x1::option::none<u64>()));
            arg0.head_page_id = 0x1::option::some<u64>(v0);
            arg0.tail_page_id = 0x1::option::some<u64>(v0);
            return v0
        };
        let v1 = *0x1::option::borrow<u64>(&arg0.tail_page_id);
        if (v1 == v0) {
            return v1
        };
        0x2::table::borrow_mut<u64, RequestPage>(&mut arg0.pages, v1).next = 0x1::option::some<u64>(v0);
        0x2::table::add<u64, RequestPage>(&mut arg0.pages, v0, new_page(0x1::option::some<u64>(v1), 0x1::option::none<u64>()));
        arg0.tail_page_id = 0x1::option::some<u64>(v0);
        v0
    }

    fun entry_offset(arg0: &vector<RequestEntry>, arg1: u64) : u64 {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<RequestEntry>(arg0)) {
            if (0x1::vector::borrow<RequestEntry>(arg0, v0).index == arg1) {
                v1 = 0x1::option::some<u64>(v0);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v1), 0);
                return 0x1::option::destroy_some<u64>(v1)
            };
            v0 = v0 + 1;
        };
        v1 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    fun fee_on(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return 0
        };
        0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_up(arg0, arg1, 1000000000)
    }

    fun fill_front_partially<T0>(arg0: &mut RequestQueue<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        assert!(arg0.pending > 0, 0);
        let v0 = 0x1::vector::borrow_mut<RequestEntry>(&mut 0x2::table::borrow_mut<u64, RequestPage>(&mut arg0.pages, *0x1::option::borrow<u64>(&arg0.head_page_id)).entries, 0);
        assert!(arg1 < v0.amount, 0);
        let v1 = v0.amount - arg1;
        v0.min_output = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::mul_div_up(v0.min_output, v1, v0.amount);
        v0.amount = v1;
        0x2::balance::split<T0>(&mut arg0.escrow, arg1)
    }

    fun front_request<T0>(arg0: &RequestQueue<T0>) : RequestEntry {
        assert!(arg0.pending > 0, 0);
        *0x1::vector::borrow<RequestEntry>(&0x2::table::borrow<u64, RequestPage>(&arg0.pages, *0x1::option::borrow<u64>(&arg0.head_page_id)).entries, 0)
    }

    fun is_empty<T0>(arg0: &RequestQueue<T0>) : bool {
        arg0.pending == 0
    }

    fun is_executable_mark(arg0: u64, arg1: u64) : bool {
        if (arg1 == 0) {
            return false
        };
        let v0 = 100;
        0x1::u64::div_ceil(arg0, v0) <= arg1 && 0x1::u64::div_ceil(arg1, v0) <= arg0
    }

    public(friend) fun mint_locked_liquidity<T0>(arg0: &mut LpBook<T0>, arg1: u64) {
        0x2::balance::join<T0>(&mut arg0.locked_lp, 0x2::coin::mint_balance<T0>(&mut arg0.treasury_cap, arg1));
    }

    public(friend) fun new_fee_rates(arg0: u64, arg1: u64) : FeeRates {
        FeeRates{
            supply   : arg0,
            withdraw : arg1,
        }
    }

    public(friend) fun new_flush_mark(arg0: u64, arg1: u64) : FlushMark {
        FlushMark{
            pool_value   : arg0,
            total_supply : arg1,
            executable   : is_executable_mark(arg0, arg1),
        }
    }

    fun new_page(arg0: 0x1::option::Option<u64>, arg1: 0x1::option::Option<u64>) : RequestPage {
        RequestPage{
            prev    : arg0,
            next    : arg1,
            entries : 0x1::vector::empty<RequestEntry>(),
        }
    }

    public(friend) fun next_supply_request_index<T0>(arg0: &LpBook<T0>) : u64 {
        arg0.supply_queue.next_index
    }

    public(friend) fun next_withdraw_request_index<T0>(arg0: &LpBook<T0>) : u64 {
        arg0.withdraw_queue.next_index
    }

    fun page_id_for_index(arg0: u64) : u64 {
        arg0 / 64
    }

    fun pop_front<T0>(arg0: &mut RequestQueue<T0>) : (RequestEntry, 0x2::balance::Balance<T0>) {
        let v0 = front_request<T0>(arg0);
        remove<T0>(arg0, v0.index)
    }

    fun queue_new<T0>(arg0: &mut 0x2::tx_context::TxContext) : RequestQueue<T0> {
        RequestQueue<T0>{
            pages        : 0x2::table::new<u64, RequestPage>(arg0),
            head_page_id : 0x1::option::none<u64>(),
            tail_page_id : 0x1::option::none<u64>(),
            next_index   : 0,
            pending      : 0,
            escrow       : 0x2::balance::zero<T0>(),
        }
    }

    fun quote_supply_shares(arg0: &FlushMark, arg1: &FeeRates, arg2: u64) : 0x1::option::Option<FillQuote> {
        if (!arg0.executable) {
            return 0x1::option::none<FillQuote>()
        };
        let v0 = fee_on(arg2, arg1.supply);
        let v1 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::try_mul_div_down(arg2 - v0, arg0.total_supply, arg0.pool_value);
        if (0x1::option::is_some<u64>(&v1)) {
            let v3 = 0x1::option::destroy_some<u64>(v1);
            if (v3 == 0) {
                0x1::option::none<FillQuote>()
            } else {
                let v4 = FillQuote{
                    output : v3,
                    fee    : v0,
                };
                0x1::option::some<FillQuote>(v4)
            }
        } else {
            0x1::option::destroy_none<u64>(v1);
            0x1::option::none<FillQuote>()
        }
    }

    fun quote_withdraw_usdc(arg0: &FlushMark, arg1: &FeeRates, arg2: u64) : 0x1::option::Option<FillQuote> {
        if (!arg0.executable) {
            return 0x1::option::none<FillQuote>()
        };
        let v0 = 0x52ec2d263bb9ad545d1be1c00f6779cc577ed7c0408cdea8d589c2664adc22db::math::try_mul_div_down(arg2, arg0.pool_value, arg0.total_supply);
        if (0x1::option::is_some<u64>(&v0)) {
            let v2 = 0x1::option::destroy_some<u64>(v0);
            let v3 = fee_on(v2, arg1.withdraw);
            let v4 = v2 - v3;
            if (v4 == 0) {
                0x1::option::none<FillQuote>()
            } else {
                let v5 = FillQuote{
                    output : v4,
                    fee    : v3,
                };
                0x1::option::some<FillQuote>(v5)
            }
        } else {
            0x1::option::destroy_none<u64>(v0);
            0x1::option::none<FillQuote>()
        }
    }

    fun record_front_limit_miss<T0>(arg0: &mut RequestQueue<T0>) {
        assert!(arg0.pending > 0, 0);
        let v0 = 0x1::vector::borrow_mut<RequestEntry>(&mut 0x2::table::borrow_mut<u64, RequestPage>(&mut arg0.pages, *0x1::option::borrow<u64>(&arg0.head_page_id)).entries, 0);
        v0.missed_flushes = v0.missed_flushes + 1;
    }

    fun refund_supply_request(arg0: 0x2::object::ID, arg1: RequestEntry, arg2: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: u8, arg4: u64) {
        0x2::balance::send_funds<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, arg1.recipient);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::emit_request_cancelled(arg0, arg1.account_id, arg1.recipient, arg1.index, arg1.amount, true, arg3, arg4);
    }

    fun refund_withdraw_request<T0>(arg0: 0x2::object::ID, arg1: RequestEntry, arg2: 0x2::balance::Balance<T0>, arg3: u8, arg4: u64) {
        0x2::balance::send_funds<T0>(arg2, arg1.recipient);
        0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::vault_events::emit_request_cancelled(arg0, arg1.account_id, arg1.recipient, arg1.index, arg1.amount, false, arg3, arg4);
    }

    fun remove_for_recipient<T0>(arg0: &mut RequestQueue<T0>, arg1: u64, arg2: address) : (RequestEntry, 0x2::balance::Balance<T0>) {
        let v0 = page_id_for_index(arg1);
        assert!(0x2::table::contains<u64, RequestPage>(&arg0.pages, v0), 0);
        let v1 = 0x2::table::borrow<u64, RequestPage>(&arg0.pages, v0);
        assert!(0x1::vector::borrow<RequestEntry>(&v1.entries, entry_offset(&v1.entries, arg1)).recipient == arg2, 3);
        remove<T0>(arg0, arg1)
    }

    public(friend) fun request_supply<T0>(arg0: &mut LpBook<T0>, arg1: 0x2::coin::Coin<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg2: 0x2::object::ID, arg3: address, arg4: u64) : u64 {
        assert!(0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg1) >= 10000000, 1);
        let v0 = &mut arg0.supply_queue;
        enqueue<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v0, arg2, arg3, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1), arg4)
    }

    public(friend) fun request_withdraw<T0>(arg0: &mut LpBook<T0>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::object::ID, arg3: address, arg4: u64) : u64 {
        assert!(0x2::coin::value<T0>(&arg1) >= 1000000, 2);
        let v0 = &mut arg0.withdraw_queue;
        enqueue<T0>(v0, arg2, arg3, 0x2::coin::into_balance<T0>(arg1), arg4)
    }

    public(friend) fun requests_processed(arg0: &DrainSummary) : u64 {
        arg0.requests_processed
    }

    public(friend) fun supplies_filled(arg0: &DrainSummary) : u64 {
        arg0.supplies_filled
    }

    public(friend) fun supply_fee_rate(arg0: &FeeRates) : u64 {
        arg0.supply
    }

    public(friend) fun supply_requests_pending<T0>(arg0: &LpBook<T0>) : u64 {
        arg0.supply_queue.pending
    }

    fun under_budget(arg0: &0x1::option::Option<u64>, arg1: u64) : bool {
        0x1::option::is_none<u64>(arg0) || arg1 < *0x1::option::borrow<u64>(arg0)
    }

    fun unlink_empty_page<T0>(arg0: &mut RequestQueue<T0>, arg1: u64) {
        let RequestPage {
            prev    : v0,
            next    : v1,
            entries : v2,
        } = 0x2::table::remove<u64, RequestPage>(&mut arg0.pages, arg1);
        let v3 = v1;
        let v4 = v0;
        0x1::vector::destroy_empty<RequestEntry>(v2);
        if (0x1::option::is_some<u64>(&v4)) {
            0x2::table::borrow_mut<u64, RequestPage>(&mut arg0.pages, *0x1::option::borrow<u64>(&v4)).next = v3;
        } else {
            arg0.head_page_id = v3;
        };
        if (0x1::option::is_some<u64>(&v3)) {
            0x2::table::borrow_mut<u64, RequestPage>(&mut arg0.pages, *0x1::option::borrow<u64>(&v3)).prev = v4;
        } else {
            arg0.tail_page_id = v4;
        };
    }

    public(friend) fun withdraw_fee_rate(arg0: &FeeRates) : u64 {
        arg0.withdraw
    }

    public(friend) fun withdraw_requests_pending<T0>(arg0: &LpBook<T0>) : u64 {
        arg0.withdraw_queue.pending
    }

    public(friend) fun withdrawals_filled(arg0: &DrainSummary) : u64 {
        arg0.withdrawals_filled
    }

    // decompiled from Move bytecode v7
}

