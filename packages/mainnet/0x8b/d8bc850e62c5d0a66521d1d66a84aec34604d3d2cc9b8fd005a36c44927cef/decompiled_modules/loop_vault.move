module 0xe735b91dcdfb1a572ce9f0171790bdad4e711e30d682eb4387e1f5642d5ab984::loop_vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct KeeperCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct GuardianCap has store, key {
        id: 0x2::object::UID,
        vault: 0x2::object::ID,
    }

    struct Params has copy, drop, store {
        tvl_cap: u64,
        entry_fee_bps: u64,
        exit_fee_bps: u64,
        queue_fee_bps: u64,
        perf_fee_bps: u64,
        max_exit_slippage_bps: u64,
    }

    struct LegLimits has copy, drop, store {
        enabled: bool,
        max_ltv_bps: u64,
        min_debt: u64,
    }

    struct Leg has copy, drop, store {
        collateral: u64,
        debt: u64,
        debt_ts_ms: u64,
        borrow_apr_bps: u64,
        attest_ts_ms: u64,
        limits: LegLimits,
        pending: 0x1::option::Option<LegLimits>,
        pending_eta_ms: u64,
    }

    struct LoopVault<phantom T0, phantom T1, phantom T2> has key {
        id: 0x2::object::UID,
        version: u64,
        shares: 0x2::coin::TreasuryCap<T2>,
        dead_shares: 0x2::balance::Balance<T2>,
        pending: 0x2::balance::Balance<T0>,
        buffer: 0x2::balance::Balance<T0>,
        claim_pool: 0x2::balance::Balance<T0>,
        legs: vector<Leg>,
        redeeming: u64,
        queued_total: u64,
        funded_total: u64,
        last_rate: u64,
        derisk: bool,
        hwm_price: u128,
        fee_recipient: address,
        params: Params,
        pending_params: 0x1::option::Option<Params>,
        pending_params_eta_ms: u64,
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
        leg: u64,
        collateral: u64,
        debt: u64,
        ltv_bps: u64,
        rate: u64,
    }

    struct LegSynced has copy, drop {
        vault: 0x2::object::ID,
        leg: u64,
        collateral: u64,
        booked_debt: u64,
        lender_debt: u64,
    }

    struct DebtAttested has copy, drop {
        vault: 0x2::object::ID,
        leg: u64,
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

    struct ChangeQueued has copy, drop {
        vault: 0x2::object::ID,
        what: u64,
        eta_ms: u64,
    }

    struct ChangeApplied has copy, drop {
        vault: 0x2::object::ID,
        what: u64,
        immediate: bool,
    }

    struct GuardianPaused has copy, drop {
        vault: 0x2::object::ID,
    }

    fun accrue(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) + (arg0 as u128) * (arg1 as u128) * (arg2 as u128) / (10000 as u128) * 31536000000) as u64)
    }

    public(friend) fun add_redeeming<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64) {
        arg0.redeeming = arg0.redeeming + arg1;
    }

    public(friend) fun assert_can_lever<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64) {
        assert!(!arg0.paused, 1);
        assert!(!arg0.derisk, 12);
        assert!(arg1 < 2, 19);
        assert!(0x1::vector::borrow<Leg>(&arg0.legs, arg1).limits.enabled, 20);
    }

    public(friend) fun assert_keeper<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: &KeeperCap) {
        assert!(arg1.vault == 0x2::object::id<LoopVault<T0, T1, T2>>(arg0), 6);
        assert!(arg0.version == 3, 15);
    }

    fun assert_live<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) {
        assert!(!arg0.paused, 1);
        assert!(arg0.version == 3, 15);
    }

    public fun attest_debt<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &KeeperCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert_keeper<T0, T1, T2>(arg0, arg1);
        assert!(arg4 <= 2000, 9);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::object::id<LoopVault<T0, T1, T2>>(arg0);
        let v2 = leg_debt_now<T0, T1, T2>(arg0, arg2, v0);
        let v3 = leg_mut<T0, T1, T2>(arg0, arg2);
        let v4 = if (v0 > v3.attest_ts_ms) {
            v0 - v3.attest_ts_ms
        } else {
            0
        };
        assert!(arg3 >= v2 - mul_div(v2, 10, 10000) && arg3 <= accrue(v2, 2000, v4) + 1, 9);
        v3.debt = arg3;
        v3.debt_ts_ms = v0;
        v3.attest_ts_ms = v0;
        v3.borrow_apr_bps = arg4;
        let v5 = DebtAttested{
            vault          : v1,
            leg            : arg2,
            booked         : v2,
            attested       : arg3,
            borrow_apr_bps : arg4,
        };
        0x2::event::emit<DebtAttested>(v5);
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

    public fun cancel_params<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &AdminCap) {
        arg0.pending_params = 0x1::option::none<Params>();
    }

    fun check_leg<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64, arg2: u64) {
        check_leg_with_ceiling<T0, T1, T2>(arg0, arg1, arg2, 0x1::vector::borrow<Leg>(&arg0.legs, arg1).limits.max_ltv_bps);
    }

    public(friend) fun check_leg_after_sync<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: bool, arg4: u64) {
        observe_rate<T0, T1, T2>(arg0, arg2);
        let v0 = if (arg3) {
            max_u64(arg4, 0x1::vector::borrow<Leg>(&arg0.legs, arg1).limits.max_ltv_bps)
        } else {
            0x1::vector::borrow<Leg>(&arg0.legs, arg1).limits.max_ltv_bps
        };
        check_leg_with_ceiling<T0, T1, T2>(arg0, arg1, arg2, v0);
    }

    fun check_leg_with_ceiling<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = 0x1::vector::borrow<Leg>(&arg0.legs, arg1);
        assert!(v0.debt == 0 || v0.debt >= v0.limits.min_debt, 16);
        let v1 = leg_ltv_bps<T0, T1, T2>(arg0, arg1, arg2);
        assert!(v0.debt == 0 || v1 <= arg3, 8);
        let v2 = PositionChanged{
            vault      : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            leg        : arg1,
            collateral : v0.collateral,
            debt       : v0.debt,
            ltv_bps    : v1,
            rate       : arg2,
        };
        0x2::event::emit<PositionChanged>(v2);
    }

    fun check_limits(arg0: &LegLimits) {
        assert!(arg0.max_ltv_bps <= 8100, 10);
        assert!(arg0.min_debt <= 1000000000, 10);
    }

    fun check_params(arg0: &Params) {
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
        0x1::vector::borrow<Leg>(&arg0.legs, 0).collateral + 0x1::vector::borrow<Leg>(&arg0.legs, 1).collateral
    }

    public fun create<T0, T1, T2>(arg0: &AdminCap, arg1: 0x2::coin::TreasuryCap<T2>, arg2: Params, arg3: LegLimits, arg4: LegLimits, arg5: u64, arg6: address, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : KeeperCap {
        assert!(0x2::coin::total_supply<T2>(&arg1) == 0, 11);
        assert!(arg5 <= 2000, 10);
        check_params(&arg2);
        check_limits(&arg3);
        check_limits(&arg4);
        let v0 = 0x2::clock::timestamp_ms(arg7);
        let v1 = 0x1::vector::empty<Leg>();
        0x1::vector::push_back<Leg>(&mut v1, new_leg(arg3, 0, v0));
        0x1::vector::push_back<Leg>(&mut v1, new_leg(arg4, arg5, v0));
        let v2 = LoopVault<T0, T1, T2>{
            id                    : 0x2::object::new(arg8),
            version               : 3,
            shares                : arg1,
            dead_shares           : 0x2::balance::zero<T2>(),
            pending               : 0x2::balance::zero<T0>(),
            buffer                : 0x2::balance::zero<T0>(),
            claim_pool            : 0x2::balance::zero<T0>(),
            legs                  : v1,
            redeeming             : 0,
            queued_total          : 0,
            funded_total          : 0,
            last_rate             : 0,
            derisk                : false,
            hwm_price             : 1000000000,
            fee_recipient         : arg6,
            params                : arg2,
            pending_params        : 0x1::option::none<Params>(),
            pending_params_eta_ms : 0,
            paused                : false,
        };
        let v3 = KeeperCap{
            id    : 0x2::object::new(arg8),
            vault : 0x2::object::id<LoopVault<T0, T1, T2>>(&v2),
        };
        0x2::transfer::share_object<LoopVault<T0, T1, T2>>(v2);
        v3
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

    public fun current_leg() : u64 {
        1
    }

    public fun debt<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : u64 {
        0x1::vector::borrow<Leg>(&arg0.legs, 0).debt + 0x1::vector::borrow<Leg>(&arg0.legs, 1).debt
    }

    public(friend) fun deposit<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: 0x2::coin::Coin<T0>, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_live<T0, T1, T2>(arg0);
        observe_rate<T0, T1, T2>(arg0, arg2);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 2);
        crystallize_fee<T0, T1, T2>(arg0, arg2, arg3, arg4);
        let v1 = mint_for_value<T0, T1, T2>(arg0, v0, arg2, arg3);
        0x2::balance::join<T0>(&mut arg0.pending, 0x2::coin::into_balance<T0>(arg1));
        let v2 = Deposited{
            vault  : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            user   : 0x2::tx_context::sender(arg4),
            amount : v0,
            shares : v1,
            nav    : nav<T0, T1, T2>(arg0, arg2, arg3),
        };
        0x2::event::emit<Deposited>(v2);
        0x2::coin::mint<T2>(&mut arg0.shares, v1, arg4)
    }

    public(friend) fun deposit_receipt<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_live<T0, T1, T2>(arg0);
        observe_rate<T0, T1, T2>(arg0, arg3);
        assert!(arg2 > 0, 2);
        crystallize_fee<T0, T1, T2>(arg0, arg3, arg4, arg5);
        let v0 = (receipt_value(arg2, arg3) as u64);
        let v1 = mint_for_value<T0, T1, T2>(arg0, v0, arg3, arg4);
        let v2 = leg_mut<T0, T1, T2>(arg0, arg1);
        v2.collateral = v2.collateral + arg2;
        let v3 = Deposited{
            vault  : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            user   : 0x2::tx_context::sender(arg5),
            amount : v0,
            shares : v1,
            nav    : nav<T0, T1, T2>(arg0, arg3, arg4),
        };
        0x2::event::emit<Deposited>(v3);
        0x2::coin::mint<T2>(&mut arg0.shares, v1, arg5)
    }

    public fun execute_leg_limits<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<LoopVault<T0, T1, T2>>(arg0);
        let v1 = leg_mut<T0, T1, T2>(arg0, arg2);
        assert!(0x1::option::is_some<LegLimits>(&v1.pending), 17);
        assert!(0x2::clock::timestamp_ms(arg3) >= v1.pending_eta_ms, 18);
        v1.limits = 0x1::option::extract<LegLimits>(&mut v1.pending);
        let v2 = ChangeApplied{
            vault     : v0,
            what      : arg2,
            immediate : false,
        };
        0x2::event::emit<ChangeApplied>(v2);
    }

    public fun execute_params<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<Params>(&arg0.pending_params), 17);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.pending_params_eta_ms, 18);
        arg0.params = 0x1::option::extract<Params>(&mut arg0.pending_params);
        let v0 = ChangeApplied{
            vault     : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            what      : 99,
            immediate : false,
        };
        0x2::event::emit<ChangeApplied>(v0);
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

    public fun guardian_pause<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &GuardianCap) {
        assert!(arg1.vault == 0x2::object::id<LoopVault<T0, T1, T2>>(arg0), 6);
        arg0.paused = true;
        arg0.derisk = true;
        let v0 = GuardianPaused{vault: 0x2::object::id<LoopVault<T0, T1, T2>>(arg0)};
        0x2::event::emit<GuardianPaused>(v0);
    }

    public fun harvest<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &KeeperCap, arg2: 0x2::coin::Coin<T0>) {
        assert_keeper<T0, T1, T2>(arg0, arg1);
        0x2::balance::join<T0>(&mut arg0.pending, 0x2::coin::into_balance<T0>(arg2));
    }

    public fun has_pending_params<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : bool {
        0x1::option::is_some<Params>(&arg0.pending_params)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_derisk<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : bool {
        arg0.derisk
    }

    public fun is_paused<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : bool {
        arg0.paused
    }

    public fun leg_collateral<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64) : u64 {
        0x1::vector::borrow<Leg>(&arg0.legs, arg1).collateral
    }

    public fun leg_debt<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64) : u64 {
        0x1::vector::borrow<Leg>(&arg0.legs, arg1).debt
    }

    public fun leg_debt_now<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1::vector::borrow<Leg>(&arg0.legs, arg1);
        if (arg2 <= v0.debt_ts_ms) {
            v0.debt
        } else {
            accrue(v0.debt, v0.borrow_apr_bps, arg2 - v0.debt_ts_ms)
        }
    }

    public fun leg_enabled<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64) : bool {
        0x1::vector::borrow<Leg>(&arg0.legs, arg1).limits.enabled
    }

    public fun leg_has_pending<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64) : bool {
        0x1::option::is_some<LegLimits>(&0x1::vector::borrow<Leg>(&arg0.legs, arg1).pending)
    }

    public fun leg_ltv_bps<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1::vector::borrow<Leg>(&arg0.legs, arg1);
        let v1 = receipt_value(v0.collateral, arg2);
        if (v1 == 0) {
            if (v0.debt == 0) {
                0
            } else {
                10000
            }
        } else {
            (((v0.debt as u128) * (10000 as u128) / v1) as u64)
        }
    }

    public fun leg_max_ltv<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64) : u64 {
        0x1::vector::borrow<Leg>(&arg0.legs, arg1).limits.max_ltv_bps
    }

    fun leg_mut<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64) : &mut Leg {
        assert!(arg1 < 2, 19);
        0x1::vector::borrow_mut<Leg>(&mut arg0.legs, arg1)
    }

    fun limits_risk_reducing(arg0: &LegLimits, arg1: &LegLimits) : bool {
        if (!arg1.enabled || arg0.enabled) {
            if (arg1.max_ltv_bps <= arg0.max_ltv_bps) {
                arg1.min_debt == arg0.min_debt
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun max_exit_slippage_bps<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>) : u64 {
        arg0.params.max_exit_slippage_bps
    }

    fun max_u64(arg0: u64, arg1: u64) : u64 {
        if (arg0 > arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun min(arg0: u64, arg1: u64) : u64 {
        if (arg0 < arg1) {
            arg0
        } else {
            arg1
        }
    }

    fun mint_for_value<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = nav<T0, T1, T2>(arg0, arg2, arg3);
        assert!((v0 as u128) + (arg1 as u128) <= (arg0.params.tvl_cap as u128), 3);
        let v1 = 0x2::coin::total_supply<T2>(&arg0.shares);
        let v2 = if (v1 == 0) {
            assert!(arg1 >= 1000000, 13);
            0x2::balance::join<T2>(&mut arg0.dead_shares, 0x2::coin::mint_balance<T2>(&mut arg0.shares, 1000));
            arg1 - 1000
        } else {
            assert!(v0 > 0, 14);
            mul_div(mul_div(arg1, 10000 - arg0.params.entry_fee_bps, 10000), v1, v0)
        };
        assert!(v2 > 0, 2);
        v2
    }

    fun mul_div(arg0: u64, arg1: u64, arg2: u64) : u64 {
        (((arg0 as u128) * (arg1 as u128) / (arg2 as u128)) as u64)
    }

    public fun nav<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: u64, arg2: u64) : u64 {
        let v0 = (0x2::balance::value<T0>(&arg0.pending) as u128) + (0x2::balance::value<T0>(&arg0.buffer) as u128) + (arg0.redeeming as u128);
        let v1 = ((arg0.queued_total - arg0.funded_total) as u128);
        let v2 = 0;
        while (v2 < 2) {
            v0 = v0 + receipt_value(0x1::vector::borrow<Leg>(&arg0.legs, v2).collateral, arg1);
            v1 = v1 + (leg_debt_now<T0, T1, T2>(arg0, v2, arg2) as u128);
            v2 = v2 + 1;
        };
        if (v1 >= v0) {
            0
        } else {
            ((v0 - v1) as u64)
        }
    }

    public fun new_guardian<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : GuardianCap {
        GuardianCap{
            id    : 0x2::object::new(arg2),
            vault : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
        }
    }

    public fun new_keeper<T0, T1, T2>(arg0: &LoopVault<T0, T1, T2>, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : KeeperCap {
        KeeperCap{
            id    : 0x2::object::new(arg2),
            vault : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
        }
    }

    fun new_leg(arg0: LegLimits, arg1: u64, arg2: u64) : Leg {
        Leg{
            collateral     : 0,
            debt           : 0,
            debt_ts_ms     : arg2,
            borrow_apr_bps : arg1,
            attest_ts_ms   : arg2,
            limits         : arg0,
            pending        : 0x1::option::none<LegLimits>(),
            pending_eta_ms : 0,
        }
    }

    public fun new_limits(arg0: bool, arg1: u64, arg2: u64) : LegLimits {
        let v0 = LegLimits{
            enabled     : arg0,
            max_ltv_bps : arg1,
            min_debt    : arg2,
        };
        check_limits(&v0);
        v0
    }

    public fun new_params(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : Params {
        let v0 = Params{
            tvl_cap               : arg0,
            entry_fee_bps         : arg1,
            exit_fee_bps          : arg2,
            queue_fee_bps         : arg3,
            perf_fee_bps          : arg4,
            max_exit_slippage_bps : arg5,
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

    fun params_risk_reducing(arg0: &Params, arg1: &Params) : bool {
        if (arg1.entry_fee_bps <= arg0.entry_fee_bps) {
            if (arg1.exit_fee_bps <= arg0.exit_fee_bps) {
                if (arg1.queue_fee_bps <= arg0.queue_fee_bps) {
                    if (arg1.perf_fee_bps <= arg0.perf_fee_bps) {
                        arg1.max_exit_slippage_bps <= arg0.max_exit_slippage_bps
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
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

    public(friend) fun record_import<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        assert_live<T0, T1, T2>(arg0);
        observe_rate<T0, T1, T2>(arg0, arg4);
        assert!(!arg0.derisk, 12);
        crystallize_fee<T0, T1, T2>(arg0, arg4, arg5, arg6);
        let v0 = receipt_value(arg2, arg4);
        assert!(v0 > (arg3 as u128), 14);
        let v1 = ((v0 - (arg3 as u128)) as u64);
        let v2 = mint_for_value<T0, T1, T2>(arg0, v1, arg4, arg5);
        roll_debt<T0, T1, T2>(arg0, arg1, arg5);
        let v3 = leg_mut<T0, T1, T2>(arg0, arg1);
        assert!(v3.limits.enabled, 20);
        v3.collateral = v3.collateral + arg2;
        v3.debt = v3.debt + arg3;
        check_leg<T0, T1, T2>(arg0, arg1, arg4);
        let v4 = Deposited{
            vault  : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
            user   : 0x2::tx_context::sender(arg6),
            amount : v1,
            shares : v2,
            nav    : nav<T0, T1, T2>(arg0, arg4, arg5),
        };
        0x2::event::emit<Deposited>(v4);
        0x2::coin::mint<T2>(&mut arg0.shares, v2, arg6)
    }

    public(friend) fun record_lever_up<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert!(!arg0.paused, 1);
        observe_rate<T0, T1, T2>(arg0, arg4);
        assert!(!arg0.derisk, 12);
        roll_debt<T0, T1, T2>(arg0, arg1, arg5);
        let v0 = leg_mut<T0, T1, T2>(arg0, arg1);
        assert!(v0.limits.enabled, 20);
        v0.collateral = v0.collateral + arg2;
        v0.debt = v0.debt + arg3;
        check_leg<T0, T1, T2>(arg0, arg1, arg4);
    }

    public(friend) fun record_reduce<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        observe_rate<T0, T1, T2>(arg0, arg4);
        roll_debt<T0, T1, T2>(arg0, arg1, arg5);
        let v0 = leg_ltv_bps<T0, T1, T2>(arg0, arg1, arg4);
        let v1 = leg_mut<T0, T1, T2>(arg0, arg1);
        v1.collateral = v1.collateral - arg2;
        let v2 = if (arg3 >= v1.debt) {
            0
        } else {
            v1.debt - arg3
        };
        v1.debt = v2;
        check_leg_with_ceiling<T0, T1, T2>(arg0, arg1, arg4, max_u64(v0, 0x1::vector::borrow<Leg>(&arg0.legs, arg1).limits.max_ltv_bps));
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

    fun roll_debt<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64) {
        let v0 = leg_debt_now<T0, T1, T2>(arg0, arg1, arg2);
        let v1 = leg_mut<T0, T1, T2>(arg0, arg1);
        v1.debt = v0;
        v1.debt_ts_ms = arg2;
    }

    public fun set_fee_recipient<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &AdminCap, arg2: address) {
        arg0.fee_recipient = arg2;
    }

    public fun set_leg_limits<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &AdminCap, arg2: u64, arg3: LegLimits, arg4: &0x2::clock::Clock) {
        check_limits(&arg3);
        let v0 = 0x2::object::id<LoopVault<T0, T1, T2>>(arg0);
        let v1 = leg_mut<T0, T1, T2>(arg0, arg2);
        if (limits_risk_reducing(&v1.limits, &arg3)) {
            v1.limits = arg3;
            v1.pending = 0x1::option::none<LegLimits>();
            let v2 = ChangeApplied{
                vault     : v0,
                what      : arg2,
                immediate : true,
            };
            0x2::event::emit<ChangeApplied>(v2);
        } else {
            let v3 = 0x2::clock::timestamp_ms(arg4) + 86400000;
            v1.pending = 0x1::option::some<LegLimits>(arg3);
            v1.pending_eta_ms = v3;
            let v4 = ChangeQueued{
                vault  : v0,
                what   : arg2,
                eta_ms : v3,
            };
            0x2::event::emit<ChangeQueued>(v4);
        };
    }

    public fun set_params<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: &AdminCap, arg2: Params, arg3: &0x2::clock::Clock) {
        check_params(&arg2);
        if (params_risk_reducing(&arg0.params, &arg2)) {
            arg0.params = arg2;
            arg0.pending_params = 0x1::option::none<Params>();
            let v0 = ChangeApplied{
                vault     : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
                what      : 99,
                immediate : true,
            };
            0x2::event::emit<ChangeApplied>(v0);
        } else {
            let v1 = 0x2::clock::timestamp_ms(arg3) + 86400000;
            arg0.pending_params = 0x1::option::some<Params>(arg2);
            arg0.pending_params_eta_ms = v1;
            let v2 = ChangeQueued{
                vault  : 0x2::object::id<LoopVault<T0, T1, T2>>(arg0),
                what   : 99,
                eta_ms : v1,
            };
            0x2::event::emit<ChangeQueued>(v2);
        };
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

    public fun suilend_leg() : u64 {
        0
    }

    public(friend) fun sync_leg<T0, T1, T2>(arg0: &mut LoopVault<T0, T1, T2>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = 0x2::object::id<LoopVault<T0, T1, T2>>(arg0);
        let v1 = leg_mut<T0, T1, T2>(arg0, arg1);
        v1.collateral = arg2;
        v1.debt = arg3;
        v1.debt_ts_ms = arg4;
        v1.attest_ts_ms = arg4;
        let v2 = LegSynced{
            vault       : v0,
            leg         : arg1,
            collateral  : arg2,
            booked_debt : v1.debt,
            lender_debt : arg3,
        };
        0x2::event::emit<LegSynced>(v2);
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
        abort 21
    }

    // decompiled from Move bytecode v7
}

