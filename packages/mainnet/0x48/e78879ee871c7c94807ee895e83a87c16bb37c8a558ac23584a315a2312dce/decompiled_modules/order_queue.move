module 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::order_queue {
    struct OrderBook has store {
        orders: 0x2::table::Table<u64, QueuedOrder>,
        next_id: u64,
        resolve_head: u64,
        payout_cursor: u64,
        cohorts: vector<CohortSpan>,
        last_tau_ms: u64,
        last_committed_tau_ms: u64,
        last_deadline_ms: u64,
        last_channel: u8,
        per_account: 0x2::table::Table<0x2::object::ID, u64>,
        pending_mints: u64,
        pending_sells: u64,
    }

    struct CohortSpan has copy, drop, store {
        tau_ms: u64,
        deadline_ms: u64,
        first_id: u64,
        end_id: u64,
        pyth_channel: u8,
        committed: bool,
        unfinished: u64,
    }

    struct QueuedOrder has store {
        status: u8,
        kind: u8,
        request: OrderRequest,
        account_id: 0x2::object::ID,
        receive_address: address,
        timing: OrderTiming,
        escrow: OrderEscrow,
        position: HeldPosition,
        price: CommittedPrice,
        result: OrderResult,
        receipt: 0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>,
        funds: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>,
    }

    struct OrderView has copy, drop {
        status: u8,
        kind: u8,
        request: OrderRequest,
        account_id: 0x2::object::ID,
        receive_address: address,
        timing: OrderTiming,
        escrow: OrderEscrow,
        position: HeldPosition,
        price: CommittedPrice,
        result: OrderResult,
        receipt_stage: u8,
        funds: u64,
    }

    struct OrderRequest has copy, drop, store {
        lower_tick: u64,
        higher_tick: u64,
        quantity: u64,
        max_premium: u64,
        min_quantity: u64,
        max_cost: u64,
        max_probability: u64,
        min_probability: u64,
        min_proceeds: u64,
    }

    struct OrderTiming has copy, drop, store {
        placed_at_ms: u64,
        earliest_price_ms: u64,
        tau_ms: u64,
        deadline_ms: u64,
        cutoff_ms: u64,
        pyth_channel: u8,
    }

    struct OrderEscrow has copy, drop, store {
        budget: u64,
        order_fee: u64,
        subsidy_bound: u64,
        subsidy_reserved: u64,
        cash_need: u64,
    }

    struct HeldPosition has copy, drop, store {
        order_id: u256,
        root_id: u256,
        opened_at_ms: u64,
    }

    struct CommittedPrice has copy, drop, store {
        spot: u64,
        tick_ms: u64,
        generation_us: u64,
    }

    struct OrderResult has copy, drop, store {
        reason: u8,
        quantity: u64,
        amount: u64,
        finished_at_ms: u64,
    }

    public fun pyth_channel(arg0: &OrderTiming) : u8 {
        arg0.pyth_channel
    }

    public fun account_id(arg0: &OrderView) : 0x2::object::ID {
        arg0.account_id
    }

    public(friend) fun account_waiting(arg0: &OrderBook, arg1: 0x2::object::ID) : u64 {
        if (!0x2::table::contains<0x2::object::ID, u64>(&arg0.per_account, arg1)) {
            return 0
        };
        *0x2::table::borrow<0x2::object::ID, u64>(&arg0.per_account, arg1)
    }

    public(friend) fun advance_heads(arg0: &mut OrderBook) {
        let v0 = &arg0.cohorts;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<CohortSpan>(v0)) {
            if (0x1::vector::borrow<CohortSpan>(v0, v1).unfinished == 0) {
                v2 = true;
                /* label 6 */
                if (v2) {
                    let v3 = 0x1::vector::empty<CohortSpan>();
                    let v4 = arg0.cohorts;
                    0x1::vector::reverse<CohortSpan>(&mut v4);
                    let v5 = 0;
                    while (v5 < 0x1::vector::length<CohortSpan>(&v4)) {
                        let v6 = 0x1::vector::pop_back<CohortSpan>(&mut v4);
                        if (v6.unfinished > 0) {
                            0x1::vector::push_back<CohortSpan>(&mut v3, v6);
                        };
                        v5 = v5 + 1;
                    };
                    0x1::vector::destroy_empty<CohortSpan>(v4);
                    arg0.cohorts = v3;
                };
                let v7 = if (0x1::vector::is_empty<CohortSpan>(&arg0.cohorts)) {
                    arg0.next_id
                } else {
                    0x1::vector::borrow<CohortSpan>(&arg0.cohorts, 0).first_id
                };
                arg0.resolve_head = v7;
                return
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 6 */
    }

    public(friend) fun append(arg0: &mut OrderBook, arg1: QueuedOrder) : u64 {
        let v0 = arg0.next_id;
        arg0.next_id = v0 + 1;
        let v1 = arg1.timing;
        let v2 = 0x1::vector::length<CohortSpan>(&arg0.cohorts);
        if (v2 > 0 && 0x1::vector::borrow<CohortSpan>(&arg0.cohorts, v2 - 1).tau_ms == v1.tau_ms) {
            let v3 = 0x1::vector::borrow_mut<CohortSpan>(&mut arg0.cohorts, v2 - 1);
            v3.end_id = v0 + 1;
            v3.unfinished = v3.unfinished + 1;
        } else {
            let v4 = CohortSpan{
                tau_ms       : v1.tau_ms,
                deadline_ms  : v1.deadline_ms,
                first_id     : v0,
                end_id       : v0 + 1,
                pyth_channel : v1.pyth_channel,
                committed    : false,
                unfinished   : 1,
            };
            0x1::vector::push_back<CohortSpan>(&mut arg0.cohorts, v4);
        };
        if (is_mint(arg1.kind)) {
            arg0.pending_mints = arg0.pending_mints + 1;
        } else {
            arg0.pending_sells = arg0.pending_sells + 1;
        };
        let v5 = arg1.account_id;
        if (0x2::table::contains<0x2::object::ID, u64>(&arg0.per_account, v5)) {
            let v6 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.per_account, v5);
            *v6 = *v6 + 1;
        } else {
            0x2::table::add<0x2::object::ID, u64>(&mut arg0.per_account, v5, 1);
        };
        arg0.last_tau_ms = 0x1::u64::max(arg0.last_tau_ms, v1.tau_ms);
        arg0.last_deadline_ms = 0x1::u64::max(arg0.last_deadline_ms, v1.deadline_ms);
        arg0.last_channel = v1.pyth_channel;
        0x2::table::add<u64, QueuedOrder>(&mut arg0.orders, v0, arg1);
        v0
    }

    public fun budget(arg0: &OrderEscrow) : u64 {
        arg0.budget
    }

    public fun cash_need(arg0: &OrderEscrow) : u64 {
        arg0.cash_need
    }

    public(friend) fun close_open_record(arg0: &mut OrderBook, arg1: u64) : (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt, HeldPosition) {
        assert!(0x2::table::contains<u64, QueuedOrder>(&arg0.orders, arg1) && 0x2::table::borrow<u64, QueuedOrder>(&arg0.orders, arg1).status == 2, 0);
        let v0 = 0x2::table::borrow_mut<u64, QueuedOrder>(&mut arg0.orders, arg1);
        v0.position = empty_position();
        v0.status = 4;
        (0x1::option::extract<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&mut v0.receipt), v0.position)
    }

    public(friend) fun cohort(arg0: &OrderBook, arg1: u64) : CohortSpan {
        *0x1::vector::borrow<CohortSpan>(&arg0.cohorts, arg1)
    }

    public(friend) fun cohort_count(arg0: &OrderBook) : u64 {
        0x1::vector::length<CohortSpan>(&arg0.cohorts)
    }

    public(friend) fun commit_order(arg0: &mut OrderBook, arg1: u64, arg2: CommittedPrice, arg3: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        let v0 = 0x2::table::borrow_mut<u64, QueuedOrder>(&mut arg0.orders, arg1);
        v0.status = 1;
        v0.price = arg2;
        v0.escrow.subsidy_reserved = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&arg3);
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0.funds, arg3);
    }

    public fun cutoff_ms(arg0: &OrderTiming) : u64 {
        arg0.cutoff_ms
    }

    public fun deadline_ms(arg0: &OrderTiming) : u64 {
        arg0.deadline_ms
    }

    public fun earliest_price_ms(arg0: &OrderTiming) : u64 {
        arg0.earliest_price_ms
    }

    public(friend) fun empty_position() : HeldPosition {
        HeldPosition{
            order_id     : 0,
            root_id      : 0,
            opened_at_ms : 0,
        }
    }

    public fun escrow(arg0: &OrderView) : OrderEscrow {
        arg0.escrow
    }

    public(friend) fun finish_order(arg0: &mut OrderBook, arg1: u64, arg2: u8, arg3: 0x1::option::Option<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>, arg4: HeldPosition, arg5: u8, arg6: u64, arg7: u64, arg8: bool, arg9: u64) {
        if (is_mint(0x2::table::borrow<u64, QueuedOrder>(&arg0.orders, arg1).kind)) {
            arg0.pending_mints = arg0.pending_mints - 1;
        } else {
            arg0.pending_sells = arg0.pending_sells - 1;
        };
        if (arg8) {
            let v0 = 0x2::table::borrow_mut<0x2::object::ID, u64>(&mut arg0.per_account, 0x2::table::borrow<u64, QueuedOrder>(&arg0.orders, arg1).account_id);
            *v0 = *v0 - 1;
        };
        let v1 = &arg0.cohorts;
        let v2 = 0;
        let v3;
        while (v2 < 0x1::vector::length<CohortSpan>(v1)) {
            if (arg1 < 0x1::vector::borrow<CohortSpan>(v1, v2).end_id) {
                v3 = 0x1::option::some<u64>(v2);
                /* label 11 */
                if (0x1::option::is_some<u64>(&v3)) {
                    let v4 = 0x1::vector::borrow_mut<CohortSpan>(&mut arg0.cohorts, 0x1::option::destroy_some<u64>(v3));
                    v4.unfinished = v4.unfinished - 1;
                };
                let v5 = 0x2::table::borrow_mut<u64, QueuedOrder>(&mut arg0.orders, arg1);
                v5.status = arg2;
                v5.position = arg4;
                let v6 = OrderResult{
                    reason         : arg5,
                    quantity       : arg6,
                    amount         : arg7,
                    finished_at_ms : arg9,
                };
                v5.result = v6;
                if (0x1::option::is_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&arg3)) {
                    0x1::option::fill<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&mut v5.receipt, 0x1::option::destroy_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(arg3));
                } else {
                    0x1::option::destroy_none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(arg3);
                };
                return
            };
            v2 = v2 + 1;
        };
        v3 = 0x1::option::none<u64>();
        /* goto 11 */
    }

    public(friend) fun finish_payout(arg0: &mut OrderBook, arg1: u64) {
        let v0 = 0x2::table::borrow_mut<u64, QueuedOrder>(&mut arg0.orders, arg1);
        v0.status = 4;
        v0.position = empty_position();
    }

    public fun finished_at_ms(arg0: &OrderResult) : u64 {
        arg0.finished_at_ms
    }

    public fun funds(arg0: &OrderView) : u64 {
        arg0.funds
    }

    public fun generation_us(arg0: &CommittedPrice) : u64 {
        arg0.generation_us
    }

    public fun higher_tick(arg0: &OrderRequest) : u64 {
        arg0.higher_tick
    }

    public(friend) fun is_mint(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 2
        }
    }

    public(friend) fun is_stuck(arg0: &OrderBook, arg1: u64, arg2: u64) : bool {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<CohortSpan>(&arg0.cohorts)) {
            let v2 = 0x1::vector::borrow<CohortSpan>(&arg0.cohorts, v1);
            if (v2.tau_ms + arg1 > arg2) {
                break
            };
            if (v2.unfinished > 0 && !v2.committed) {
                if (v2.tau_ms > arg0.last_committed_tau_ms) {
                    return true
                };
                let v3 = v0 + 1;
                v0 = v3;
                if (v3 >= 2) {
                    return true
                };
            };
            v1 = v1 + 1;
        };
        false
    }

    public(friend) fun is_unfinished(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else {
            arg0 == 5
        }
    }

    public fun kind(arg0: &OrderView) : u8 {
        arg0.kind
    }

    public fun kind_exact_amount() : u8 {
        1
    }

    public fun kind_exact_cost() : u8 {
        2
    }

    public fun kind_exact_quantity() : u8 {
        0
    }

    public fun kind_redeem_live() : u8 {
        3
    }

    public fun kind_redeem_open() : u8 {
        4
    }

    public(friend) fun last_committed_tau_ms(arg0: &OrderBook) : u64 {
        arg0.last_committed_tau_ms
    }

    public(friend) fun last_tau_ms(arg0: &OrderBook) : u64 {
        arg0.last_tau_ms
    }

    public fun lower_tick(arg0: &OrderRequest) : u64 {
        arg0.lower_tick
    }

    public(friend) fun mark_cohort_committed(arg0: &mut OrderBook, arg1: u64) {
        let v0 = 0x1::vector::borrow_mut<CohortSpan>(&mut arg0.cohorts, arg1);
        v0.committed = true;
        arg0.last_committed_tau_ms = 0x1::u64::max(arg0.last_committed_tau_ms, v0.tau_ms);
    }

    public fun max_cost(arg0: &OrderRequest) : u64 {
        arg0.max_cost
    }

    public fun max_premium(arg0: &OrderRequest) : u64 {
        arg0.max_premium
    }

    public fun max_probability(arg0: &OrderRequest) : u64 {
        arg0.max_probability
    }

    public fun min_probability(arg0: &OrderRequest) : u64 {
        arg0.min_probability
    }

    public fun min_proceeds(arg0: &OrderRequest) : u64 {
        arg0.min_proceeds
    }

    public fun min_quantity(arg0: &OrderRequest) : u64 {
        arg0.min_quantity
    }

    public(friend) fun new_book(arg0: &mut 0x2::tx_context::TxContext) : OrderBook {
        OrderBook{
            orders                : 0x2::table::new<u64, QueuedOrder>(arg0),
            next_id               : 0,
            resolve_head          : 0,
            payout_cursor         : 0,
            cohorts               : 0x1::vector::empty<CohortSpan>(),
            last_tau_ms           : 0,
            last_committed_tau_ms : 0,
            last_deadline_ms      : 0,
            last_channel          : 0,
            per_account           : 0x2::table::new<0x2::object::ID, u64>(arg0),
            pending_mints         : 0,
            pending_sells         : 0,
        }
    }

    public(friend) fun new_committed_price(arg0: u64, arg1: u64, arg2: u64) : CommittedPrice {
        CommittedPrice{
            spot          : arg0,
            tick_ms       : arg1,
            generation_us : arg2,
        }
    }

    public(friend) fun new_escrow(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : OrderEscrow {
        OrderEscrow{
            budget           : arg0,
            order_fee        : arg1,
            subsidy_bound    : arg2,
            subsidy_reserved : 0,
            cash_need        : arg3,
        }
    }

    public(friend) fun new_held_position(arg0: u256, arg1: u256, arg2: u64) : HeldPosition {
        HeldPosition{
            order_id     : arg0,
            root_id      : arg1,
            opened_at_ms : arg2,
        }
    }

    public(friend) fun new_order(arg0: u8, arg1: OrderRequest, arg2: 0x2::object::ID, arg3: address, arg4: OrderTiming, arg5: OrderEscrow, arg6: HeldPosition, arg7: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt, arg8: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) : QueuedOrder {
        let v0 = CommittedPrice{
            spot          : 0,
            tick_ms       : 0,
            generation_us : 0,
        };
        let v1 = OrderResult{
            reason         : 0,
            quantity       : 0,
            amount         : 0,
            finished_at_ms : 0,
        };
        QueuedOrder{
            status          : 0,
            kind            : arg0,
            request         : arg1,
            account_id      : arg2,
            receive_address : arg3,
            timing          : arg4,
            escrow          : arg5,
            position        : arg6,
            price           : v0,
            result          : v1,
            receipt         : 0x1::option::some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(arg7),
            funds           : arg8,
        }
    }

    public(friend) fun new_request(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64) : OrderRequest {
        OrderRequest{
            lower_tick      : arg0,
            higher_tick     : arg1,
            quantity        : arg2,
            max_premium     : arg3,
            min_quantity    : arg4,
            max_cost        : arg5,
            max_probability : arg6,
            min_probability : arg7,
            min_proceeds    : arg8,
        }
    }

    public(friend) fun next_id(arg0: &OrderBook) : u64 {
        arg0.next_id
    }

    fun next_tick_after(arg0: u64, arg1: u64) : u64 {
        (arg0 / arg1 + 1) * arg1
    }

    public(friend) fun oldest_uncommitted_tau(arg0: &OrderBook) : 0x1::option::Option<u64> {
        let v0 = &arg0.cohorts;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<CohortSpan>(v0)) {
            let v3 = 0x1::vector::borrow<CohortSpan>(v0, v1);
            if (v3.unfinished > 0 && !v3.committed) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 10 */
                return if (0x1::option::is_some<u64>(&v2)) {
                    0x1::option::some<u64>(0x1::vector::borrow<CohortSpan>(&arg0.cohorts, 0x1::option::destroy_some<u64>(v2)).tau_ms)
                } else {
                    0x1::option::destroy_none<u64>(v2);
                    0x1::option::none<u64>()
                }
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 10 */
    }

    public(friend) fun oldest_uncommitted_tau_above_committed(arg0: &OrderBook) : 0x1::option::Option<u64> {
        let v0 = &arg0.cohorts;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<CohortSpan>(v0)) {
            let v3 = 0x1::vector::borrow<CohortSpan>(v0, v1);
            let v4 = if (v3.unfinished > 0) {
                if (!v3.committed) {
                    v3.tau_ms > arg0.last_committed_tau_ms
                } else {
                    false
                }
            } else {
                false
            };
            if (v4) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 13 */
                return if (0x1::option::is_some<u64>(&v2)) {
                    0x1::option::some<u64>(0x1::vector::borrow<CohortSpan>(&arg0.cohorts, 0x1::option::destroy_some<u64>(v2)).tau_ms)
                } else {
                    0x1::option::destroy_none<u64>(v2);
                    0x1::option::none<u64>()
                }
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 13 */
    }

    public(friend) fun oldest_unfinished_tau(arg0: &OrderBook) : 0x1::option::Option<u64> {
        let v0 = &arg0.cohorts;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<CohortSpan>(v0)) {
            if (0x1::vector::borrow<CohortSpan>(v0, v1).unfinished > 0) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                return if (0x1::option::is_some<u64>(&v2)) {
                    0x1::option::some<u64>(0x1::vector::borrow<CohortSpan>(&arg0.cohorts, 0x1::option::destroy_some<u64>(v2)).tau_ms)
                } else {
                    0x1::option::destroy_none<u64>(v2);
                    0x1::option::none<u64>()
                }
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun opened_at_ms(arg0: &HeldPosition) : u64 {
        arg0.opened_at_ms
    }

    public fun order_fee(arg0: &OrderEscrow) : u64 {
        arg0.order_fee
    }

    public fun order_id(arg0: &HeldPosition) : u256 {
        arg0.order_id
    }

    public(friend) fun park_funds(arg0: &mut OrderBook, arg1: u64, arg2: 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut 0x2::table::borrow_mut<u64, QueuedOrder>(&mut arg0.orders, arg1).funds, arg2);
    }

    public(friend) fun payout_cursor(arg0: &OrderBook) : u64 {
        arg0.payout_cursor
    }

    public(friend) fun pending_feed(arg0: &OrderBook, arg1: u64) : 0x1::option::Option<u32> {
        if (!0x2::table::contains<u64, QueuedOrder>(&arg0.orders, arg1)) {
            return 0x1::option::none<u32>()
        };
        let v0 = 0x2::table::borrow<u64, QueuedOrder>(&arg0.orders, arg1);
        if (v0.status != 0) {
            return 0x1::option::none<u32>()
        };
        let (_, _, _, _, v5, _, _, _) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::receipt_info(0x1::option::borrow<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&v0.receipt));
        0x1::option::some<u32>(v5)
    }

    public(friend) fun pending_mints(arg0: &OrderBook) : u64 {
        arg0.pending_mints
    }

    public(friend) fun pending_sells(arg0: &OrderBook) : u64 {
        arg0.pending_sells
    }

    public fun placed_at_ms(arg0: &OrderTiming) : u64 {
        arg0.placed_at_ms
    }

    public(friend) fun plan_timing(arg0: &OrderBook, arg1: &0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::DelayedExecutionPolicy, arg2: u64, arg3: u64, arg4: u64) : OrderTiming {
        let v0 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::pyth_channel(arg1);
        let v1 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::channel_tick_ms(v0);
        let v2 = 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::stall_timeout_ms(arg1);
        let v3 = (arg4 + 0x7cd41de311f8f3efb2c239b38773a4010fce3bef0120cd55f479843077c98903::delayed_execution_config::delay_ms(arg1)) / v1 * v1;
        let v4 = 0x1::u64::max(v3, arg0.last_tau_ms);
        if (arg0.next_id > 0 && arg0.last_channel != v0) {
            v4 = 0x1::u64::max(v3, next_tick_after(arg0.last_tau_ms, v1));
        };
        if (v4 <= arg0.last_committed_tau_ms) {
            v4 = next_tick_after(arg0.last_committed_tau_ms, v1);
        };
        let v5 = 0x1::vector::length<CohortSpan>(&arg0.cohorts);
        let v6 = if (v5 > 0 && 0x1::vector::borrow<CohortSpan>(&arg0.cohorts, v5 - 1).tau_ms == v4) {
            0x1::vector::borrow<CohortSpan>(&arg0.cohorts, v5 - 1).deadline_ms
        } else {
            0x1::u64::max(0x1::u64::min(v4 + v2, arg2), arg0.last_deadline_ms)
        };
        OrderTiming{
            placed_at_ms      : arg4,
            earliest_price_ms : v4,
            tau_ms            : v4,
            deadline_ms       : v6,
            cutoff_ms         : 0x1::u64::saturating_sub(arg2, 0x1::u64::max(arg3, v2 + 5000)),
            pyth_channel      : v0,
        }
    }

    public fun position(arg0: &OrderView) : HeldPosition {
        arg0.position
    }

    public fun price(arg0: &OrderView) : CommittedPrice {
        arg0.price
    }

    public fun quantity(arg0: &OrderRequest) : u64 {
        arg0.quantity
    }

    public fun reason(arg0: &OrderResult) : u8 {
        arg0.reason
    }

    public fun reason_admin() : u8 {
        7
    }

    public fun reason_admission() : u8 {
        2
    }

    public fun reason_deadline() : u8 {
        5
    }

    public fun reason_freeze() : u8 {
        6
    }

    public fun reason_limits() : u8 {
        1
    }

    public fun reason_missing_node() : u8 {
        4
    }

    public fun reason_no_cash() : u8 {
        8
    }

    public fun reason_no_price() : u8 {
        3
    }

    public fun reason_recipient_denied() : u8 {
        9
    }

    public(friend) fun receipt(arg0: &OrderBook, arg1: u64) : &0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt {
        0x1::option::borrow<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&0x2::table::borrow<u64, QueuedOrder>(&arg0.orders, arg1).receipt)
    }

    public(friend) fun receipt_mut(arg0: &mut OrderBook, arg1: u64) : &mut 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt {
        0x1::option::borrow_mut<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&mut 0x2::table::borrow_mut<u64, QueuedOrder>(&mut arg0.orders, arg1).receipt)
    }

    public fun receipt_stage(arg0: &OrderView) : u8 {
        arg0.receipt_stage
    }

    public fun receive_address(arg0: &OrderView) : address {
        arg0.receive_address
    }

    public(friend) fun remove_finished_record(arg0: &mut OrderBook, arg1: u64) : bool {
        if (!0x2::table::contains<u64, QueuedOrder>(&arg0.orders, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<u64, QueuedOrder>(&arg0.orders, arg1);
        let v1 = if (v0.status != 3 && v0.status != 4) {
            true
        } else if (0x1::option::is_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&v0.receipt)) {
            true
        } else {
            0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0.funds) > 0
        };
        if (v1) {
            return false
        };
        let QueuedOrder {
            status          : _,
            kind            : _,
            request         : _,
            account_id      : _,
            receive_address : _,
            timing          : _,
            escrow          : _,
            position        : _,
            price           : _,
            result          : _,
            receipt         : v12,
            funds           : v13,
        } = 0x2::table::remove<u64, QueuedOrder>(&mut arg0.orders, arg1);
        0x1::option::destroy_none<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(v12);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v13);
        true
    }

    public fun request(arg0: &OrderView) : OrderRequest {
        arg0.request
    }

    public(friend) fun resolve_head(arg0: &OrderBook) : u64 {
        arg0.resolve_head
    }

    public(friend) fun restore_receipt(arg0: &mut OrderBook, arg1: u64, arg2: 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt) {
        0x1::option::fill<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&mut 0x2::table::borrow_mut<u64, QueuedOrder>(&mut arg0.orders, arg1).receipt, arg2);
    }

    public fun result(arg0: &OrderView) : OrderResult {
        arg0.result
    }

    public fun result_amount(arg0: &OrderResult) : u64 {
        arg0.amount
    }

    public fun result_quantity(arg0: &OrderResult) : u64 {
        arg0.quantity
    }

    public fun root_id(arg0: &HeldPosition) : u256 {
        arg0.root_id
    }

    public(friend) fun set_cohort_first_id(arg0: &mut OrderBook, arg1: u64, arg2: u64) {
        let v0 = 0x1::vector::borrow_mut<CohortSpan>(&mut arg0.cohorts, arg1);
        v0.first_id = 0x1::u64::max(v0.first_id, 0x1::u64::min(arg2, v0.end_id));
    }

    public(friend) fun set_payout_cursor(arg0: &mut OrderBook, arg1: u64) {
        arg0.payout_cursor = 0x1::u64::max(arg0.payout_cursor, 0x1::u64::min(arg1, arg0.next_id));
    }

    public(friend) fun settle_queue(arg0: &mut OrderBook) {
        arg0.resolve_head = arg0.next_id;
        arg0.cohorts = 0x1::vector::empty<CohortSpan>();
    }

    public(friend) fun span_committed(arg0: &CohortSpan) : bool {
        arg0.committed
    }

    public(friend) fun span_deadline_ms(arg0: &CohortSpan) : u64 {
        arg0.deadline_ms
    }

    public(friend) fun span_end_id(arg0: &CohortSpan) : u64 {
        arg0.end_id
    }

    public(friend) fun span_first_id(arg0: &CohortSpan) : u64 {
        arg0.first_id
    }

    public(friend) fun span_pyth_channel(arg0: &CohortSpan) : u8 {
        arg0.pyth_channel
    }

    public(friend) fun span_tau_ms(arg0: &CohortSpan) : u64 {
        arg0.tau_ms
    }

    public(friend) fun span_unfinished(arg0: &CohortSpan) : u64 {
        arg0.unfinished
    }

    public fun spot(arg0: &CommittedPrice) : u64 {
        arg0.spot
    }

    public fun status(arg0: &OrderView) : u8 {
        arg0.status
    }

    public fun status_closed() : u8 {
        4
    }

    public fun status_committed() : u8 {
        1
    }

    public fun status_open() : u8 {
        2
    }

    public fun status_pending() : u8 {
        0
    }

    public fun status_refund_due() : u8 {
        5
    }

    public fun status_refunded() : u8 {
        3
    }

    public fun subsidy_bound(arg0: &OrderEscrow) : u64 {
        arg0.subsidy_bound
    }

    public fun subsidy_reserved(arg0: &OrderEscrow) : u64 {
        arg0.subsidy_reserved
    }

    public(friend) fun take_open_receipt(arg0: &mut OrderBook, arg1: u64) : 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt {
        0x1::option::extract<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&mut 0x2::table::borrow_mut<u64, QueuedOrder>(&mut arg0.orders, arg1).receipt)
    }

    public(friend) fun take_order(arg0: &mut OrderBook, arg1: u64) : (0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt, 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>) {
        let v0 = 0x2::table::borrow_mut<u64, QueuedOrder>(&mut arg0.orders, arg1);
        (0x1::option::extract<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&mut v0.receipt), 0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v0.funds))
    }

    public(friend) fun take_parked(arg0: &mut OrderBook, arg1: u64) : 0x2::balance::Balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC> {
        0x2::balance::withdraw_all<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut 0x2::table::borrow_mut<u64, QueuedOrder>(&mut arg0.orders, arg1).funds)
    }

    public fun tau_ms(arg0: &OrderTiming) : u64 {
        arg0.tau_ms
    }

    public fun tick_ms(arg0: &CommittedPrice) : u64 {
        arg0.tick_ms
    }

    public fun timing(arg0: &OrderView) : OrderTiming {
        arg0.timing
    }

    public(friend) fun view(arg0: &OrderBook, arg1: u64) : 0x1::option::Option<OrderView> {
        if (!0x2::table::contains<u64, QueuedOrder>(&arg0.orders, arg1)) {
            return 0x1::option::none<OrderView>()
        };
        let v0 = 0x2::table::borrow<u64, QueuedOrder>(&arg0.orders, arg1);
        let v1 = if (0x1::option::is_some<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&v0.receipt)) {
            let (_, v3, _, _, _, _, _, _) = 0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::receipt_info(0x1::option::borrow<0x89aea622e7bb3bdd598bde87dde40ee31c9eed4971b9546e23ec83de3c48bbba::expiry_market::OrderReceipt>(&v0.receipt));
            v3
        } else {
            0
        };
        let v10 = OrderView{
            status          : v0.status,
            kind            : v0.kind,
            request         : v0.request,
            account_id      : v0.account_id,
            receive_address : v0.receive_address,
            timing          : v0.timing,
            escrow          : v0.escrow,
            position        : v0.position,
            price           : v0.price,
            result          : v0.result,
            receipt_stage   : v1,
            funds           : 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v0.funds),
        };
        0x1::option::some<OrderView>(v10)
    }

    // decompiled from Move bytecode v7
}

