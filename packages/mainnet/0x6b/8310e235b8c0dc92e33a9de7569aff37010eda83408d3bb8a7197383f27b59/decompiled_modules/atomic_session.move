module 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::atomic_session {
    struct TrackedBalance<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        amount: u64,
    }

    struct Session {
        tag: u128,
        sender: address,
        principals: vector<u64>,
        flash_fee_at_max: u64,
        min_profit: u64,
        hops: u8,
        tolerance_bps: u64,
        deadline_ms: u64,
        trace: vector<u64>,
        quote_cursor: u8,
        selected_slot: u8,
        selected_principal: u64,
        selected_fee: u64,
        phase: u8,
        armed: bool,
        execution_hop: u8,
        pending_take: bool,
        pending_input: u64,
        final_taken: bool,
        repaid: bool,
        vault: 0x2::bag::Bag,
    }

    struct QuoteRecorded has copy, drop {
        tag: u128,
        sender: address,
        slot: u8,
        hop: u8,
        amount_in: u64,
        amount_out: u64,
    }

    struct SearchDecision has copy, drop {
        tag: u128,
        sender: address,
        armed: bool,
        slot: u8,
        principal: u64,
        expected_out: u64,
        required_out: u64,
        hops: u8,
    }

    struct ExecutionRecorded has copy, drop {
        tag: u128,
        sender: address,
        hop: u8,
        amount_in: u64,
        amount_out: u64,
        min_output: u64,
        max_input: u64,
    }

    struct ProfitEvent<phantom T0> has copy, drop {
        tag: u128,
        sender: address,
        slot: u8,
        principal: u64,
        expected_out: u64,
        profit: u64,
    }

    public fun sender(arg0: &Session) : address {
        arg0.sender
    }

    public fun armed(arg0: &Session) : bool {
        arg0.armed
    }

    fun checked_sum(arg0: u64, arg1: u64, arg2: u64) : u64 {
        checked_u128_to_u64((arg0 as u128) + (arg1 as u128) + (arg2 as u128))
    }

    fun checked_u128_to_u64(arg0: u128) : u64 {
        assert!(arg0 <= 18446744073709551615, 1011);
        (arg0 as u64)
    }

    public fun execution_bounds(arg0: &Session, arg1: u8) : (u64, u64) {
        let (v0, v1) = selected_quote(arg0, arg1);
        (mul_div_ceil(v0, 10000 + arg0.tolerance_bps, 10000), mul_div_floor(v1, 10000 - arg0.tolerance_bps, 10000))
    }

    public fun execution_principal(arg0: &Session, arg1: &0x2::clock::Clock) : u64 {
        assert!(arg0.phase == 1 && arg0.armed, 1009);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.deadline_ms, 1008);
        assert!(arg0.selected_principal > 0, 1010);
        arg0.selected_principal
    }

    fun fee_at(arg0: &Session, arg1: u64) : u64 {
        mul_div_ceil(arg0.flash_fee_at_max, arg1, principal_at(arg0, 3 - 1))
    }

    public fun finish<T0>(arg0: Session, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let Session {
            tag                : v0,
            sender             : v1,
            principals         : _,
            flash_fee_at_max   : _,
            min_profit         : _,
            hops               : v5,
            tolerance_bps      : _,
            deadline_ms        : _,
            trace              : v8,
            quote_cursor       : v9,
            selected_slot      : v10,
            selected_principal : v11,
            selected_fee       : _,
            phase              : v13,
            armed              : v14,
            execution_hop      : v15,
            pending_take       : v16,
            pending_input      : _,
            final_taken        : v18,
            repaid             : v19,
            vault              : v20,
        } = arg0;
        let v21 = v20;
        let v22 = v8;
        assert!(v13 == 1, 1003);
        let (v23, v24) = unwrap<T0>(0x2::bag::remove<u8, TrackedBalance<T0>>(&mut v21, 255));
        if (v14) {
            assert!(v9 == 3 * v5, 1005);
            let v25 = if (v15 == v5) {
                if (!v16) {
                    if (v18) {
                        v19
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v25, 1016);
            let v26 = ProfitEvent<T0>{
                tag          : v0,
                sender       : v1,
                slot         : v10,
                principal    : v11,
                expected_out : *0x1::vector::borrow<u64>(&v22, (v10 as u64) * (v5 as u64) + ((v5 - 1) as u64)),
                profit       : v24,
            };
            0x2::event::emit<ProfitEvent<T0>>(v26);
        } else {
            let v27 = if (v15 == 0) {
                if (!v16) {
                    if (!v18) {
                        !v19
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            assert!(v27, 1016);
            assert!(v24 == 0, 1019);
        };
        0x2::bag::destroy_empty(v21);
        0x2::coin::from_balance<T0>(v23, arg1)
    }

    public fun grid_len() : u8 {
        3
    }

    public fun grid_principal(arg0: &Session, arg1: u8) : u64 {
        principal_at(arg0, arg1)
    }

    public fun hops(arg0: &Session) : u8 {
        arg0.hops
    }

    fun mul_div_ceil(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg0 == 0 || arg1 == 0) {
            0
        } else {
            checked_u128_to_u64(((arg0 as u128) * (arg1 as u128) + (arg2 as u128) - 1) / (arg2 as u128))
        }
    }

    fun mul_div_floor(arg0: u64, arg1: u64, arg2: u64) : u64 {
        checked_u128_to_u64((arg0 as u128) * (arg1 as u128) / (arg2 as u128))
    }

    fun new_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) : 0x2::bag::Bag {
        let v0 = 0x2::bag::new(arg0);
        0x2::bag::add<u8, TrackedBalance<T0>>(&mut v0, 255, wrap<T0>(0x2::balance::zero<T0>()));
        v0
    }

    fun output_at(arg0: &Session, arg1: u8, arg2: u8) : u64 {
        *0x1::vector::borrow<u64>(&arg0.trace, trace_index(arg0, arg1, arg2))
    }

    fun principal_at(arg0: &Session, arg1: u8) : u64 {
        assert!(arg1 < 3, 1006);
        *0x1::vector::borrow<u64>(&arg0.principals, (arg1 as u64))
    }

    public fun put_quoted<T0>(arg0: &mut Session, arg1: u8, arg2: 0x2::balance::Balance<T0>) {
        assert!(arg0.phase == 1 && arg0.armed, 1009);
        assert!(arg0.pending_take && arg1 == arg0.execution_hop, 1012);
        let (v0, v1) = execution_bounds(arg0, arg1);
        let v2 = v1;
        if (arg1 + 1 == arg0.hops) {
            let v3 = checked_sum(arg0.selected_principal, arg0.selected_fee, arg0.min_profit);
            if (v3 > v1) {
                v2 = v3;
            };
        };
        let v4 = 0x2::balance::value<T0>(&arg2);
        assert!(v4 >= v2, 1014);
        0x2::bag::add<u8, TrackedBalance<T0>>(&mut arg0.vault, arg1 + 1, wrap<T0>(arg2));
        let v5 = ExecutionRecorded{
            tag        : arg0.tag,
            sender     : arg0.sender,
            hop        : arg1,
            amount_in  : arg0.pending_input,
            amount_out : v4,
            min_output : v2,
            max_input  : v0,
        };
        0x2::event::emit<ExecutionRecorded>(v5);
        arg0.pending_take = false;
        arg0.pending_input = 0;
        arg0.execution_hop = arg1 + 1;
    }

    public fun quote_in(arg0: &Session, arg1: u8) : u64 {
        assert!(arg0.phase == 0, 1003);
        assert!(arg1 < 3, 1006);
        let v0 = arg0.quote_cursor % arg0.hops;
        assert!(arg1 == arg0.quote_cursor / arg0.hops, 1004);
        if (v0 == 0) {
            principal_at(arg0, arg1)
        } else {
            output_at(arg0, arg1, v0 - 1)
        }
    }

    public fun record_quote(arg0: &mut Session, arg1: u8, arg2: u8, arg3: u64) {
        assert!(arg0.phase == 0, 1003);
        assert!(arg0.quote_cursor < 3 * arg0.hops, 1005);
        assert!(arg2 == arg0.quote_cursor / arg0.hops && arg1 == arg0.quote_cursor % arg0.hops, 1004);
        0x1::vector::push_back<u64>(&mut arg0.trace, arg3);
        arg0.quote_cursor = arg0.quote_cursor + 1;
        let v0 = QuoteRecorded{
            tag        : arg0.tag,
            sender     : arg0.sender,
            slot       : arg2,
            hop        : arg1,
            amount_in  : quote_in(arg0, arg2),
            amount_out : arg3,
        };
        0x2::event::emit<QuoteRecorded>(v0);
    }

    public fun search(arg0: &mut Session, arg1: &0x2::clock::Clock) {
        assert!(arg0.phase == 0, 1003);
        assert!(arg0.quote_cursor == 3 * arg0.hops, 1005);
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.deadline_ms, 1008);
        let v0 = false;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < 3) {
            let v7 = principal_at(arg0, v6);
            let v8 = fee_at(arg0, v7);
            let v9 = output_at(arg0, v6, arg0.hops - 1);
            let v10 = checked_sum(v7, v8, arg0.min_profit);
            if (v9 >= v10) {
                if (!v0 || v9 - v7 - v8 > 0) {
                    v0 = true;
                    v2 = v7;
                    v3 = v8;
                    v4 = v9;
                    v5 = v10;
                };
            };
            v6 = v6 + 1;
        };
        arg0.phase = 1;
        arg0.armed = v0;
        arg0.selected_slot = v1;
        arg0.selected_principal = v2;
        arg0.selected_fee = v3;
        let v11 = SearchDecision{
            tag          : arg0.tag,
            sender       : arg0.sender,
            armed        : v0,
            slot         : v1,
            principal    : v2,
            expected_out : v4,
            required_out : v5,
            hops         : arg0.hops,
        };
        0x2::event::emit<SearchDecision>(v11);
    }

    public fun seed<T0>(arg0: &mut Session, arg1: 0x2::balance::Balance<T0>) {
        assert!(arg0.phase == 1 && arg0.armed, 1009);
        assert!(arg0.execution_hop == 0 && !arg0.pending_take, 1012);
        assert!(0x2::balance::value<T0>(&arg1) == arg0.selected_principal, 1013);
        0x2::bag::add<u8, TrackedBalance<T0>>(&mut arg0.vault, 0, wrap<T0>(arg1));
    }

    public fun selected_flash_fee(arg0: &Session) : u64 {
        arg0.selected_fee
    }

    public fun selected_principal(arg0: &Session) : u64 {
        arg0.selected_principal
    }

    public fun selected_quote(arg0: &Session, arg1: u8) : (u64, u64) {
        assert!(arg0.phase == 1 && arg0.armed, 1009);
        assert!(arg1 < arg0.hops, 1007);
        let v0 = if (arg1 == 0) {
            arg0.selected_principal
        } else {
            output_at(arg0, arg0.selected_slot, arg1 - 1)
        };
        (v0, output_at(arg0, arg0.selected_slot, arg1))
    }

    public fun selected_quote_in(arg0: &Session, arg1: u8) : u64 {
        let (v0, _) = selected_quote(arg0, arg1);
        v0
    }

    public fun selected_quote_out(arg0: &Session, arg1: u8) : u64 {
        let (_, v1) = selected_quote(arg0, arg1);
        v1
    }

    public fun selected_slot(arg0: &Session) : u8 {
        arg0.selected_slot
    }

    public fun settle_repaid<T0>(arg0: &mut Session, arg1: 0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::settlement_v3::RepaymentProof<T0>, arg2: 0x2::balance::Balance<T0>) {
        assert!(arg0.phase == 1 && arg0.armed, 1009);
        assert!(arg0.final_taken && arg0.execution_hop == arg0.hops, 1016);
        assert!(!arg0.repaid, 1017);
        assert!(0xc84bc5ea056e8ab4cfce0ba8e87d1e3debc48d09d6b486dbda268f04479a4e03::settlement_v3::consume_repayment_proof<T0>(arg1) == arg0.selected_principal, 1015);
        assert!(0x2::balance::value<T0>(&arg2) >= arg0.min_profit, 1018);
        let (v0, v1) = unwrap<T0>(0x2::bag::remove<u8, TrackedBalance<T0>>(&mut arg0.vault, 255));
        let v2 = v0;
        assert!(v1 == 0, 1020);
        0x2::balance::join<T0>(&mut v2, arg2);
        0x2::bag::add<u8, TrackedBalance<T0>>(&mut arg0.vault, 255, wrap<T0>(v2));
        arg0.repaid = true;
    }

    public fun start<T0>(arg0: u128, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Session {
        assert!(0x1::vector::length<u64>(&arg1) == (3 as u64), 1000);
        let v0 = *0x1::vector::borrow<u64>(&arg1, 0);
        let v1 = *0x1::vector::borrow<u64>(&arg1, 1);
        let v2 = if (v0 > 0) {
            if (v0 < v1) {
                v1 < *0x1::vector::borrow<u64>(&arg1, 2)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 1000);
        assert!(arg4 >= 2 && arg4 <= 6, 1001);
        assert!(arg5 <= 2500, 1002);
        let v3 = 0x2::tx_context::sender(arg7);
        Session{
            tag                : arg0,
            sender             : v3,
            principals         : arg1,
            flash_fee_at_max   : arg2,
            min_profit         : arg3,
            hops               : arg4,
            tolerance_bps      : arg5,
            deadline_ms        : arg6,
            trace              : vector[],
            quote_cursor       : 0,
            selected_slot      : 0,
            selected_principal : 0,
            selected_fee       : 0,
            phase              : 0,
            armed              : false,
            execution_hop      : 0,
            pending_take       : false,
            pending_input      : 0,
            final_taken        : false,
            repaid             : false,
            vault              : new_vault<T0>(arg7),
        }
    }

    public fun start_grid<T0>(arg0: u128, arg1: vector<u64>, arg2: u64, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : Session {
        start<T0>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7)
    }

    public fun tag(arg0: &Session) : u128 {
        arg0.tag
    }

    public fun take<T0>(arg0: &mut Session, arg1: u8) : 0x2::balance::Balance<T0> {
        assert!(arg0.phase == 1 && arg0.armed, 1009);
        assert!(arg1 == arg0.execution_hop && arg1 < arg0.hops, 1012);
        assert!(!arg0.pending_take, 1012);
        let (v0, v1) = unwrap<T0>(0x2::bag::remove<u8, TrackedBalance<T0>>(&mut arg0.vault, arg1));
        let (v2, _) = execution_bounds(arg0, arg1);
        assert!(v1 > 0 && v1 <= v2, 1013);
        if (arg1 == 0) {
            assert!(v1 == arg0.selected_principal, 1013);
        };
        arg0.pending_take = true;
        arg0.pending_input = v1;
        v0
    }

    public fun take_final<T0>(arg0: &mut Session) : 0x2::balance::Balance<T0> {
        assert!(arg0.phase == 1 && arg0.armed, 1009);
        assert!(arg0.execution_hop == arg0.hops && !arg0.pending_take, 1016);
        assert!(!arg0.final_taken, 1012);
        let (v0, _) = unwrap<T0>(0x2::bag::remove<u8, TrackedBalance<T0>>(&mut arg0.vault, arg0.hops));
        arg0.final_taken = true;
        v0
    }

    public fun tolerance_bps(arg0: &Session) : u64 {
        arg0.tolerance_bps
    }

    fun trace_index(arg0: &Session, arg1: u8, arg2: u8) : u64 {
        assert!(arg1 < 3, 1006);
        assert!(arg2 < arg0.hops, 1007);
        (arg1 as u64) * (arg0.hops as u64) + (arg2 as u64)
    }

    fun unwrap<T0>(arg0: TrackedBalance<T0>) : (0x2::balance::Balance<T0>, u64) {
        let TrackedBalance {
            balance : v0,
            amount  : v1,
        } = arg0;
        let v2 = v0;
        assert!(0x2::balance::value<T0>(&v2) == v1, 1020);
        (v2, v1)
    }

    fun wrap<T0>(arg0: 0x2::balance::Balance<T0>) : TrackedBalance<T0> {
        TrackedBalance<T0>{
            balance : arg0,
            amount  : 0x2::balance::value<T0>(&arg0),
        }
    }

    // decompiled from Move bytecode v7
}

