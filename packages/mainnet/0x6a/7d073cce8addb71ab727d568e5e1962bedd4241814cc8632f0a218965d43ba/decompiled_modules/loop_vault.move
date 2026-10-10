module 0x6a7d073cce8addb71ab727d568e5e1962bedd4241814cc8632f0a218965d43ba::loop_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct Params has copy, drop, store {
        max_ltv_bps: u64,
        tvl_cap: u64,
        entry_fee_bps: u64,
        exit_fee_bps: u64,
        queue_fee_bps: u64,
        perf_fee_bps: u64,
        max_exit_slippage_bps: u64,
    }

    struct LoopVault<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        version: u64,
        shares: 0x2::coin::TreasuryCap<T2>,
        dead_shares: 0x2::balance::Balance<T2>,
        pending: 0x2::balance::Balance<T0>,
        buffer: 0x2::balance::Balance<T0>,
        claim_pool: 0x2::balance::Balance<T0>,
        collateral: u64,
        debt: u64,
        debt_ts_ms: u64,
        borrow_apr_bps: u64,
        redeeming: u64,
        queued_total: u64,
        funded_total: u64,
        last_rate: u64,
        derisk: bool,
        hwm_price: u128,
        fee_recipient: address,
        params: Params,
        paused: bool,
    }

    struct WithdrawTicket has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
        amount: u64,
        cum_end: u64,
    }

    struct Deposited has copy, drop {
        vault: 0x2::object::ID,
        user: address,
        amount: u64,
        shares: u64,
        nav: u64,
    }

    struct Withdrawn has copy, drop {
        vault: 0x2::object::ID,
        user: address,
        shares: u64,
        amount: u64,
        nav: u64,
    }

    struct WithdrawQueued has copy, drop {
        vault: 0x2::object::ID,
        user: address,
        shares: u64,
        amount: u64,
        cum_end: u64,
    }

    struct TicketClaimed has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        cum_end: u64,
    }

    struct QueueFunded has copy, drop {
        vault: 0x2::object::ID,
        amount: u64,
        funded_total: u64,
    }

    struct PositionChanged has copy, drop {
        vault: 0x2::object::ID,
        collateral: u64,
        debt: u64,
        ltv_bps: u64,
        rate: u64,
    }

    struct DebtAttested has copy, drop {
        vault: 0x2::object::ID,
        booked: u64,
        attested: u64,
        borrow_apr_bps: u64,
    }

    struct PerfFeeMinted has copy, drop {
        vault: 0x2::object::ID,
        shares: u64,
        price: u128,
    }

    struct Markdown has copy, drop {
        vault: 0x2::object::ID,
        old_rate: u64,
        new_rate: u64,
    }

    fun accrue(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) + (arg0 as u128) * (arg1 as u128) * (arg2 as u128) / (10000 as u128) * 31536000000) as u64)
    }

    public(friend) fun add_redeeming<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64) {
        arg0.redeeming = arg0.redeeming + arg1;
    }

    public(friend) fun assert_keeper<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: &KeeperCap) {
        assert!(arg1.vault == 0x2::object::id<LoopVault<T0, T1, T2>>(arg0), 6);
        assert!(arg0.version == 1, 15);
    }

    fun assert_live<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) {
        assert!(!arg0.paused, 1);
        assert!(arg0.version == 1, 15);
    }

    public fun attest_debt<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &KeeperCap, arg2: u64, arg3: u64, arg4: u64) {
        assert_keeper<T0, T1, T2>(arg0, arg1);
        assert!(arg3 <= 2000, 9);
        let v0 = arg0.debt;
        assert!(arg2 >= v0 - mul_div(v0, 10, 10000) && arg2 <= accrue(v0, 2000, arg4 - arg0.debt_ts_ms) + 1, 9);
        arg0.debt = arg2;
        arg0.debt_ts_ms = arg4;
        arg0.borrow_apr_bps = arg3;
        let v1 = DebtAttested{
            vault          : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            booked         : v0,
            attested       : arg2,
            borrow_apr_bps : arg3,
        };
        0x2::event::emit<DebtAttested>(v1);
    }

    public fun buffer_value<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.buffer)
    }

    fun burn_for_value<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = 0x2::coin::value<T2>(&arg1);
        assert!(v0 > 0, 2);
        0x2::coin::burn<T2>(&mut arg0.shares, arg1);
        (v0, mul_div(v0, nav<T0, T1, T2>(arg0, arg2, arg3), 0x2::coin::total_supply<T2>(&arg0.shares)))
    }

    fun check_params(arg0: &Params) {
        assert!(arg0.max_ltv_bps <= 8000, 10);
        assert!(arg0.perf_fee_bps <= 2000, 10);
        assert!(arg0.entry_fee_bps <= 100, 10);
        assert!(arg0.exit_fee_bps <= 100, 10);
        assert!(arg0.queue_fee_bps <= 100, 10);
        assert!(arg0.max_exit_slippage_bps <= 500, 10);
    }

    public fun claim<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: WithdrawTicket, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let WithdrawTicket {
            id      : v0,
            vault   : v1,
            amount  : v2,
            cum_end : v3,
        } = arg1;
        assert!(v1 == 0x2::object::id<LoopVault<T0, T1, T2>>(arg0), 6);
        assert!(arg0.funded_total >= v3, 7);
        0x2::object::delete(v0);
        let v4 = TicketClaimed{
            vault   : v1,
            amount  : v2,
            cum_end : v3,
        };
        0x2::event::emit<TicketClaimed>(v4);
        0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.claim_pool, v2), arg2)
    }

    public fun claim_pool_value<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.claim_pool)
    }

    public fun clear_derisk<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &AdminCap) {
        arg0.derisk = false;
    }

    public fun collateral<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : u64 {
        arg0.collateral
    }

    public fun create<T0, T1, T2>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T2>, arg2: Params, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : KeeperCap {
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 11);
        check_params(&arg2);
        let v0 = LoopVault<T0, T1, T2>{
            id             : 0x2::object::new(arg4),
            version        : 1,
            shares         : arg1,
            dead_shares    : 0x2::balance::zero<T2>(),
            pending        : 0x2::balance::zero<T0>(),
            buffer         : 0x2::balance::zero<T0>(),
            claim_pool     : 0x2::balance::zero<T0>(),
            collateral     : 0,
            debt           : 0,
            debt_ts_ms     : 0,
            borrow_apr_bps : 0,
            redeeming      : 0,
            queued_total   : 0,
            funded_total   : 0,
            last_rate      : 0,
            derisk         : false,
            hwm_price      : 1000000000,
            fee_recipient  : arg3,
            params         : arg2,
            paused         : false,
        };
        let v1 = KeeperCap{
            id    : 0x2::object::new(arg4),
            vault : 0x2::object::id<LoopVault<T0, T1, T2>>(&v0),
        };
        0x2::transfer::share_object<LoopVault<T0, T1, T2>>(v0);
        v1
    }

    fun crystallize_fee<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::total_supply<T2>(&arg0.shares);
        if (v0 == 0 || arg0.params.perf_fee_bps == 0) {
            return
        };
        let v1 = nav<T0, T1, T2>(arg0, arg1, arg2);
        let v2 = (v1 as u128) * 1000000000 / (v0 as u128);
        if (v2 <= arg0.hwm_price) {
            return
        };
        let v3 = (v2 - arg0.hwm_price) * (v0 as u128) / 1000000000 * (arg0.params.perf_fee_bps as u128) / (10000 as u128);
        if (v3 == 0 || v3 >= (v1 as u128)) {
            return
        };
        let v4 = ((v3 * (v0 as u128) / ((v1 as u128) - v3)) as u64);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::mint<T2>(&mut arg0.shares, v4, arg3), arg0.fee_recipient);
        };
        arg0.hwm_price = (v1 as u128) * 1000000000 / (0x2::coin::total_supply<T2>(&arg0.shares) as u128);
        let v5 = PerfFeeMinted{
            vault  : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            shares : v4,
            price  : arg0.hwm_price,
        };
        0x2::event::emit<PerfFeeMinted>(v5);
    }

    public fun debt<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : u64 {
        arg0.debt
    }

    public fun debt_now<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64) : u64 {
        if (arg1 <= arg0.debt_ts_ms) {
            arg0.debt
        } else {
            accrue(arg0.debt, arg0.borrow_apr_bps, arg1 - arg0.debt_ts_ms)
        }
    }

    public(friend) fun deposit<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_live<T0, T1, T2>(arg0);
        observe_rate<T0, T1, T2>(arg0, arg2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        crystallize_fee<T0, T1, T2>(arg0, arg2, arg3, arg4);
        let v1 = nav<T0, T1, T2>(arg0, arg2, arg3);
        assert!((v1 as u128) + (v0 as u128) <= (arg0.params.tvl_cap as u128), 3);
        let v2 = 0x2::coin::total_supply<T2>(&arg0.shares);
        let v3 = if (v2 == 0) {
            assert!(v0 >= 1000000, 13);
            0x2::balance::join<T2>(&mut arg0.dead_shares, 0x2::coin::mint_balance<T2>(&mut arg0.shares, 1000));
            v0 - 1000
        } else {
            assert!(v1 > 0, 14);
            mul_div(mul_div(v0, 10000 - arg0.params.entry_fee_bps, 10000), v2, v1)
        };
        assert!(v3 > 0, 2);
        0x2::balance::join<T0>(&mut arg0.pending, 0x2::coin::into_balance<T0>(arg1));
        let v4 = Deposited{
            vault  : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            user   : 0x2::tx_context::sender(arg4),
            amount : v0,
            shares : v3,
            nav    : v1 + v0,
        };
        0x2::event::emit<Deposited>(v4);
        0x2::coin::mint<T2>(&mut arg0.shares, v3, arg4)
    }

    public(friend) fun deposit_receipt<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_live<T0, T1, T2>(arg0);
        observe_rate<T0, T1, T2>(arg0, arg2);
        assert!(arg1 > 0, 2);
        crystallize_fee<T0, T1, T2>(arg0, arg2, arg3, arg4);
        let v0 = (receipt_value(arg1, arg2) as u64);
        let v1 = nav<T0, T1, T2>(arg0, arg2, arg3);
        assert!((v1 as u128) + (v0 as u128) <= (arg0.params.tvl_cap as u128), 3);
        let v2 = 0x2::coin::total_supply<T2>(&arg0.shares);
        let v3 = if (v2 == 0) {
            assert!(v0 >= 1000000, 13);
            0x2::balance::join<T2>(&mut arg0.dead_shares, 0x2::coin::mint_balance<T2>(&mut arg0.shares, 1000));
            v0 - 1000
        } else {
            assert!(v1 > 0, 14);
            mul_div(mul_div(v0, 10000 - arg0.params.entry_fee_bps, 10000), v2, v1)
        };
        assert!(v3 > 0, 2);
        arg0.collateral = arg0.collateral + arg1;
        let v4 = Deposited{
            vault  : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            user   : 0x2::tx_context::sender(arg4),
            amount : v0,
            shares : v3,
            nav    : v1 + v0,
        };
        0x2::event::emit<Deposited>(v4);
        0x2::coin::mint<T2>(&mut arg0.shares, v3, arg4)
    }

    fun emit_position<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64, arg2: u64) {
        let v0 = PositionChanged{
            vault      : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            collateral : arg0.collateral,
            debt       : arg0.debt,
            ltv_bps    : arg2,
            rate       : arg1,
        };
        0x2::event::emit<PositionChanged>(v0);
    }

    public fun fund_queue<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &KeeperCap) {
        assert_keeper<T0, T1, T2>(arg0, arg1);
        let v0 = min(arg0.queued_total - arg0.funded_total, 0x2::balance::value<T0>(&arg0.buffer));
        if (v0 == 0) {
            return
        };
        0x2::balance::join<T0>(&mut arg0.claim_pool, 0x2::balance::split<T0>(&mut arg0.buffer, v0));
        arg0.funded_total = arg0.funded_total + v0;
        let v1 = QueueFunded{
            vault        : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            amount       : v0,
            funded_total : arg0.funded_total,
        };
        0x2::event::emit<QueueFunded>(v1);
    }

    public fun harvest<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &KeeperCap, arg2: 0x2::coin::Coin<T0>) {
        assert_keeper<T0, T1, T2>(arg0, arg1);
        0x2::balance::join<T0>(&mut arg0.pending, 0x2::coin::into_balance<T0>(arg2));
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_derisk<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : bool {
        arg0.derisk
    }

    public fun ltv_bps<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64) : u64 {
        let v0 = receipt_value(arg0.collateral, arg1);
        if (v0 == 0) {
            if (arg0.debt == 0) {
                0
            } else {
                10000
            }
        } else {
            (((arg0.debt as u128) * (10000 as u128) / v0) as u64)
        }
    }

    public(friend) fun max_exit_slippage_bps<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : u64 {
        arg0.params.max_exit_slippage_bps
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun nav<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64, arg2: u64) : u64 {
        let v0 = (0x2::balance::value<T0>(&arg0.pending) as u128) + (0x2::balance::value<T0>(&arg0.buffer) as u128) + receipt_value(arg0.collateral, arg1) + (arg0.redeeming as u128);
        let v1 = (debt_now<T0, T1, T2>(arg0, arg2) as u128) + ((arg0.queued_total - arg0.funded_total) as u128);
        if (v1 >= v0) {
            0
        } else {
            ((v0 - v1) as u64)
        }
    }

    public fun new_keeper<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : KeeperCap {
        KeeperCap{
            id    : 0x2::object::new(arg2),
            vault : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
        }
    }

    public fun new_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) : Params {
        let v0 = Params{
            max_ltv_bps           : arg0,
            tvl_cap               : arg1,
            entry_fee_bps         : arg2,
            exit_fee_bps          : arg3,
            queue_fee_bps         : arg4,
            perf_fee_bps          : arg5,
            max_exit_slippage_bps : arg6,
        };
        check_params(&v0);
        v0
    }

    fun observe_rate<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64) {
        assert!(arg1 > 0, 2);
        if (arg0.last_rate != 0 && arg1 > arg0.last_rate) {
            arg0.derisk = true;
            let v0 = Markdown{
                vault    : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
                old_rate : arg0.last_rate,
                new_rate : arg1,
            };
            0x2::event::emit<Markdown>(v0);
        };
        arg0.last_rate = arg1;
    }

    public fun pending_to_buffer<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &KeeperCap, arg2: u64) {
        assert_keeper<T0, T1, T2>(arg0, arg1);
        0x2::balance::join<T0>(&mut arg0.buffer, 0x2::balance::split<T0>(&mut arg0.pending, arg2));
    }

    public fun pending_value<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : u64 {
        0x2::balance::value<T0>(&arg0.pending)
    }

    public(friend) fun put_buffer<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.buffer, arg1);
    }

    public(friend) fun put_pending<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(&mut arg0.pending, arg1);
    }

    public fun receipt_value(arg0: u64, arg1: u64) : u128 {
        if (arg0 == 0) {
            0
        } else {
            (arg0 as u128) * 1000000000 / (arg1 as u128)
        }
    }

    public(friend) fun record_import<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_live<T0, T1, T2>(arg0);
        observe_rate<T0, T1, T2>(arg0, arg3);
        assert!(!arg0.derisk, 12);
        crystallize_fee<T0, T1, T2>(arg0, arg3, arg4, arg5);
        let v0 = receipt_value(arg1, arg3);
        assert!(v0 > (arg2 as u128), 14);
        let v1 = ((v0 - (arg2 as u128)) as u64);
        let v2 = nav<T0, T1, T2>(arg0, arg3, arg4);
        assert!((v2 as u128) + (v1 as u128) <= (arg0.params.tvl_cap as u128), 3);
        let v3 = 0x2::coin::total_supply<T2>(&arg0.shares);
        let v4 = if (v3 == 0) {
            assert!(v1 >= 1000000, 13);
            0x2::balance::join<T2>(&mut arg0.dead_shares, 0x2::coin::mint_balance<T2>(&mut arg0.shares, 1000));
            v1 - 1000
        } else {
            assert!(v2 > 0, 14);
            mul_div(mul_div(v1, 10000 - arg0.params.entry_fee_bps, 10000), v3, v2)
        };
        assert!(v4 > 0, 2);
        roll_debt<T0, T1, T2>(arg0, arg4);
        arg0.collateral = arg0.collateral + arg1;
        arg0.debt = arg0.debt + arg2;
        let v5 = ltv_bps<T0, T1, T2>(arg0, arg3);
        assert!(v5 <= arg0.params.max_ltv_bps, 8);
        emit_position<T0, T1, T2>(arg0, arg3, v5);
        let v6 = Deposited{
            vault  : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            user   : 0x2::tx_context::sender(arg5),
            amount : v1,
            shares : v4,
            nav    : v2 + v1,
        };
        0x2::event::emit<Deposited>(v6);
        0x2::coin::mint<T2>(&mut arg0.shares, v4, arg5)
    }

    public(friend) fun record_lever_up<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        assert!(!arg0.paused, 1);
        observe_rate<T0, T1, T2>(arg0, arg3);
        assert!(!arg0.derisk, 12);
        roll_debt<T0, T1, T2>(arg0, arg4);
        arg0.collateral = arg0.collateral + arg1;
        arg0.debt = arg0.debt + arg2;
        let v0 = ltv_bps<T0, T1, T2>(arg0, arg3);
        assert!(v0 <= arg0.params.max_ltv_bps, 8);
        emit_position<T0, T1, T2>(arg0, arg3, v0);
    }

    public(friend) fun record_reduce<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        observe_rate<T0, T1, T2>(arg0, arg3);
        roll_debt<T0, T1, T2>(arg0, arg4);
        arg0.collateral = arg0.collateral - arg1;
        let v0 = if (arg2 >= arg0.debt) {
            0
        } else {
            arg0.debt - arg2
        };
        arg0.debt = v0;
        emit_position<T0, T1, T2>(arg0, arg3, ltv_bps<T0, T1, T2>(arg0, arg3));
    }

    public fun redeeming<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : u64 {
        arg0.redeeming
    }

    public(friend) fun request_withdraw<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : WithdrawTicket {
        assert_live<T0, T1, T2>(arg0);
        observe_rate<T0, T1, T2>(arg0, arg2);
        crystallize_fee<T0, T1, T2>(arg0, arg2, arg3, arg4);
        let (v0, v1) = burn_for_value<T0, T1, T2>(arg0, arg1, arg2, arg3);
        let v2 = mul_div(v1, 10000 - arg0.params.queue_fee_bps, 10000);
        assert!(v2 > 0, 2);
        arg0.queued_total = arg0.queued_total + v2;
        let v3 = arg0.queued_total;
        let v4 = WithdrawQueued{
            vault   : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            user    : 0x2::tx_context::sender(arg4),
            shares  : v0,
            amount  : v2,
            cum_end : v3,
        };
        0x2::event::emit<WithdrawQueued>(v4);
        WithdrawTicket{
            id      : 0x2::object::new(arg4),
            vault   : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            amount  : v2,
            cum_end : v3,
        }
    }

    fun roll_debt<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64) {
        arg0.debt = debt_now<T0, T1, T2>(arg0, arg1);
        arg0.debt_ts_ms = arg1;
    }

    public fun set_fee_recipient<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &AdminCap, arg2: address) {
        arg0.fee_recipient = arg2;
    }

    public fun set_params<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &AdminCap, arg2: Params) {
        check_params(&arg2);
        arg0.params = arg2;
    }

    public fun set_paused<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &AdminCap, arg2: bool) {
        arg0.paused = arg2;
    }

    public(friend) fun settle_redemption<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = if (v0 >= arg0.redeeming) {
            0
        } else {
            arg0.redeeming - v0
        };
        arg0.redeeming = v1;
        0x2::balance::join<T0>(&mut arg0.buffer, arg1);
    }

    public fun share_price<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64, arg2: u64) : u128 {
        let v0 = 0x2::coin::total_supply<T2>(&arg0.shares);
        if (v0 == 0) {
            1000000000
        } else {
            (nav<T0, T1, T2>(arg0, arg1, arg2) as u128) * 1000000000 / (v0 as u128)
        }
    }

    public(friend) fun take_buffer<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.buffer, arg1)
    }

    public(friend) fun take_pending<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.pending, arg1)
    }

    public fun ticket_amount(arg0: &WithdrawTicket) : u64 {
        arg0.amount
    }

    public fun total_shares<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : u64 {
        0x2::coin::total_supply<T2>(&arg0.shares)
    }

    public(friend) fun uid<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unfunded<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : u64 {
        arg0.queued_total - arg0.funded_total
    }

    public(friend) fun withdraw<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T2>, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert_live<T0, T1, T2>(arg0);
        observe_rate<T0, T1, T2>(arg0, arg3);
        crystallize_fee<T0, T1, T2>(arg0, arg3, arg4, arg5);
        let (v0, v1) = burn_for_value<T0, T1, T2>(arg0, arg1, arg3, arg4);
        let v2 = mul_div(v1, 10000 - arg0.params.exit_fee_bps, 10000);
        assert!(v2 >= arg2, 4);
        assert!(0x2::balance::value<T0>(&arg0.pending) + 0x2::balance::value<T0>(&arg0.buffer) >= v2, 5);
        let v3 = min(v2, 0x2::balance::value<T0>(&arg0.pending));
        let v4 = 0x2::balance::split<T0>(&mut arg0.pending, v3);
        0x2::balance::join<T0>(&mut v4, 0x2::balance::split<T0>(&mut arg0.buffer, v2 - v3));
        let v5 = Withdrawn{
            vault  : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            user   : 0x2::tx_context::sender(arg5),
            shares : v0,
            amount : v2,
            nav    : nav<T0, T1, T2>(arg0, arg3, arg4),
        };
        0x2::event::emit<Withdrawn>(v5);
        0x2::coin::from_balance<T0>(v4, arg5)
    }

    // decompiled from Move bytecode v7
}

