module 0x607f22a34a18d888809060135bbb4a652d1095df5370a5b080df7e10ec97b916::strc {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
    }

    struct OracleCap has key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
    }

    struct HaltCap has key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        multiplier: u64,
        total_shares: u64,
        attested_shares: u64,
        last_attest_ms: u64,
        last_attest_clock_ms: u64,
        max_change_bps: u64,
        oracle_cap: 0x1::option::Option<0x2::object::ID>,
        pending_redeem: 0x2::table::Table<address, Redeem>,
        pending_redeem_total: u64,
        initial_cap: u64,
        wrap_auth_issued: bool,
        last_attester: 0x1::option::Option<0x2::object::ID>,
        mint_stale_ms: u64,
        total_minted: u64,
        total_burned: u64,
        halt_cap: 0x1::option::Option<0x2::object::ID>,
        halted: bool,
        redeem_enabled: bool,
        multiplier_locked: bool,
        oracle_holder: address,
        attest_history: vector<Checkpoint>,
        max_supply: u64,
        pending_max_supply: u64,
        pending_eta_ms: u64,
        raise_applied_clock_ms: u64,
        prev_max_supply: u64,
    }

    struct Checkpoint has copy, drop, store {
        clock_ms: u64,
        shares: u64,
    }

    struct AttestedBy has copy, drop {
        registry: 0x2::object::ID,
        oracle_cap: 0x2::object::ID,
        attested_shares: u64,
        clock_ms: u64,
    }

    struct MintStaleSet has copy, drop {
        registry: 0x2::object::ID,
        mint_stale_ms: u64,
    }

    struct HaltIssued has copy, drop {
        registry: 0x2::object::ID,
        cap: 0x2::object::ID,
        to: address,
    }

    struct HaltSet has copy, drop {
        registry: 0x2::object::ID,
        halted: bool,
    }

    struct Redeem has drop, store {
        shares: u64,
        deadline_ms: u64,
        wrapped: bool,
        acknowledged: bool,
    }

    struct RedeemAcknowledged has copy, drop {
        registry: 0x2::object::ID,
        holder: address,
        shares: u64,
    }

    struct WrapAuth has store {
        registry: 0x2::object::ID,
    }

    struct Balance has key {
        id: 0x2::object::UID,
        registry: 0x2::object::ID,
        shares: u64,
    }

    struct Attested has copy, drop {
        attested_shares: u64,
        multiplier: u64,
        timestamp_ms: u64,
        clock_ms: u64,
    }

    struct RateUpdated has copy, drop {
        registry: 0x2::object::ID,
        multiplier: u64,
        scale: u64,
        clock_ms: u64,
    }

    struct Minted has copy, drop {
        registry: 0x2::object::ID,
        shares: u64,
        to: address,
    }

    struct Burned has copy, drop {
        registry: 0x2::object::ID,
        shares: u64,
        burned_by: address,
    }

    struct Transferred has copy, drop {
        registry: 0x2::object::ID,
        shares: u64,
        from: address,
        to: address,
    }

    struct Joined has copy, drop {
        registry: 0x2::object::ID,
        shares: u64,
        owner: address,
    }

    struct MaxChangeSet has copy, drop {
        old_bps: u64,
        new_bps: u64,
    }

    struct Undercollateralized has copy, drop {
        attested_shares: u64,
        total_shares: u64,
        timestamp_ms: u64,
    }

    struct OracleIssued has copy, drop {
        cap: 0x2::object::ID,
        to: address,
    }

    struct OracleRevoked has copy, drop {
        cap: 0x2::object::ID,
    }

    struct OracleReissued has copy, drop {
        registry: 0x2::object::ID,
        old_cap: 0x2::object::ID,
        new_cap: 0x2::object::ID,
        to: address,
    }

    struct OracleHolderSet has copy, drop {
        registry: 0x2::object::ID,
        old_holder: address,
        new_holder: address,
    }

    struct HaltRevoked has copy, drop {
        registry: 0x2::object::ID,
        cap: 0x2::object::ID,
    }

    struct RedeemEnabledSet has copy, drop {
        registry: 0x2::object::ID,
        enabled: bool,
    }

    struct RedeemRequested has copy, drop {
        registry: 0x2::object::ID,
        holder: address,
        shares: u64,
        wrapped: bool,
    }

    struct RedeemSettled has copy, drop {
        registry: 0x2::object::ID,
        holder: address,
        shares: u64,
    }

    struct RedeemCancelled has copy, drop {
        registry: 0x2::object::ID,
        holder: address,
        shares: u64,
        expired: bool,
    }

    struct InitialCapSet has copy, drop {
        registry: 0x2::object::ID,
        initial_cap: u64,
    }

    struct CapRaiseAnnounced has copy, drop {
        registry: 0x2::object::ID,
        old_max: u64,
        new_max: u64,
        eta_ms: u64,
    }

    struct CapRaiseApplied has copy, drop {
        registry: 0x2::object::ID,
        old_max: u64,
        new_max: u64,
        clock_ms: u64,
    }

    struct CapRaiseCancelled has copy, drop {
        registry: 0x2::object::ID,
        cancelled_max: u64,
    }

    fun abs_diff(arg0: u128, arg1: u128) : u128 {
        if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        }
    }

    public fun acknowledge_redeem(arg0: &mut Registry, arg1: &AdminCap, arg2: address, arg3: &0x2::clock::Clock) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(0x2::table::contains<address, Redeem>(&arg0.pending_redeem, arg2), 20);
        let v0 = 0x2::table::borrow_mut<address, Redeem>(&mut arg0.pending_redeem, arg2);
        assert!(!v0.acknowledged, 22);
        v0.acknowledged = true;
        v0.deadline_ms = 0x2::clock::timestamp_ms(arg3) + 604800000;
        let v1 = RedeemAcknowledged{
            registry : 0x2::object::id<Registry>(arg0),
            holder   : arg2,
            shares   : v0.shares,
        };
        0x2::event::emit<RedeemAcknowledged>(v1);
    }

    public fun admin_cap_registry(arg0: &AdminCap) : 0x2::object::ID {
        arg0.registry
    }

    public fun admin_set_halted(arg0: &mut Registry, arg1: &AdminCap, arg2: bool) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        arg0.halted = arg2;
        let v0 = HaltSet{
            registry : 0x2::object::id<Registry>(arg0),
            halted   : arg2,
        };
        0x2::event::emit<HaltSet>(v0);
    }

    public fun announce_cap_raise(arg0: &mut Registry, arg1: &AdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(!arg0.halted, 26);
        assert!(arg0.max_supply > 0, 16);
        assert!(arg2 > arg0.max_supply, 34);
        assert!(arg0.pending_max_supply == 0, 35);
        let v0 = 0x2::clock::timestamp_ms(arg3) + 86400000;
        arg0.pending_max_supply = arg2;
        arg0.pending_eta_ms = v0;
        let v1 = CapRaiseAnnounced{
            registry : 0x2::object::id<Registry>(arg0),
            old_max  : arg0.max_supply,
            new_max  : arg2,
            eta_ms   : v0,
        };
        0x2::event::emit<CapRaiseAnnounced>(v1);
    }

    public fun apply_cap_raise(arg0: &mut Registry, arg1: &AdminCap, arg2: &0x2::clock::Clock) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(!arg0.halted, 26);
        assert!(arg0.pending_max_supply != 0, 32);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg0.pending_eta_ms, 33);
        let v1 = arg0.max_supply;
        arg0.prev_max_supply = v1;
        arg0.max_supply = arg0.pending_max_supply;
        arg0.raise_applied_clock_ms = v0;
        arg0.pending_max_supply = 0;
        arg0.pending_eta_ms = 0;
        let v2 = CapRaiseApplied{
            registry : 0x2::object::id<Registry>(arg0),
            old_max  : v1,
            new_max  : arg0.max_supply,
            clock_ms : v0,
        };
        0x2::event::emit<CapRaiseApplied>(v2);
    }

    fun assert_active(arg0: &Registry, arg1: &0x2::clock::Clock) {
        assert_fresh(arg0, arg1);
        assert!(is_backed(arg0), 11);
        assert!(!arg0.halted, 26);
    }

    fun assert_fresh(arg0: &Registry, arg1: &0x2::clock::Clock) {
        assert!(!is_stale(arg0, arg1), 1);
    }

    public fun attest(arg0: &mut Registry, arg1: &OracleCap, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.oracle_cap) && *0x1::option::borrow<0x2::object::ID>(&arg0.oracle_cap) == 0x2::object::id<OracleCap>(arg1), 8);
        assert!(arg3 > 0, 4);
        assert!(!arg0.multiplier_locked || arg3 == 1000000000, 29);
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = if (arg4 > arg0.last_attest_ms) {
            if (arg4 <= v0) {
                v0 - arg4 <= 3600000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 6);
        let v2 = arg0.last_attest_clock_ms == 0;
        if (v2) {
            assert!(arg0.initial_cap > 0, 16);
            assert!(arg2 <= arg0.initial_cap, 17);
        };
        assert!(v2 || v0 >= arg0.last_attest_clock_ms + 43200000, 9);
        let v3 = (arg0.multiplier as u128);
        assert!(abs_diff((arg3 as u128), v3) * (10000 as u128) <= v3 * (arg0.max_change_bps as u128), 3);
        if (!v2) {
            let v4 = (arg0.attested_shares as u128);
            let v5 = v4 * (2360 as u128) / (10000 as u128);
            let v6 = if (v5 > (1 as u128)) {
                v5
            } else {
                (1 as u128)
            };
            assert!(abs_diff((arg2 as u128), v4) <= v6, 12);
        };
        prune_history(arg0, v0);
        if (!v2) {
            let v7 = (window_low(arg0) as u128);
            let v8 = v7 * (2360 as u128) / (10000 as u128);
            let v9 = if (v8 > (1 as u128)) {
                v8
            } else {
                (1 as u128)
            };
            assert!((arg2 as u128) <= v7 + v9, 12);
        };
        let v10 = Checkpoint{
            clock_ms : v0,
            shares   : arg2,
        };
        0x1::vector::push_back<Checkpoint>(&mut arg0.attest_history, v10);
        arg0.multiplier = arg3;
        arg0.attested_shares = arg2;
        arg0.last_attest_ms = arg4;
        arg0.last_attest_clock_ms = v0;
        arg0.last_attester = 0x1::option::some<0x2::object::ID>(0x2::object::id<OracleCap>(arg1));
        let v11 = AttestedBy{
            registry        : 0x2::object::id<Registry>(arg0),
            oracle_cap      : 0x2::object::id<OracleCap>(arg1),
            attested_shares : arg2,
            clock_ms        : v0,
        };
        0x2::event::emit<AttestedBy>(v11);
        let v12 = Attested{
            attested_shares : arg2,
            multiplier      : arg3,
            timestamp_ms    : arg4,
            clock_ms        : v0,
        };
        0x2::event::emit<Attested>(v12);
        let v13 = RateUpdated{
            registry   : 0x2::object::id<Registry>(arg0),
            multiplier : arg3,
            scale      : 1000000000,
            clock_ms   : v0,
        };
        0x2::event::emit<RateUpdated>(v13);
        if (!is_backed(arg0)) {
            let v14 = Undercollateralized{
                attested_shares : arg2,
                total_shares    : arg0.total_shares,
                timestamp_ms    : arg4,
            };
            0x2::event::emit<Undercollateralized>(v14);
        };
    }

    public fun attested_shares(arg0: &Registry) : u64 {
        arg0.attested_shares
    }

    public fun balance_registry(arg0: &Balance) : 0x2::object::ID {
        arg0.registry
    }

    public fun burn(arg0: &mut Registry, arg1: &AdminCap, arg2: Balance, arg3: &0x2::tx_context::TxContext) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        let Balance {
            id       : v0,
            registry : v1,
            shares   : v2,
        } = arg2;
        assert!(v1 == 0x2::object::id<Registry>(arg0), 7);
        0x2::object::delete(v0);
        arg0.total_shares = arg0.total_shares - v2;
        arg0.total_burned = arg0.total_burned + v2;
        let v3 = Burned{
            registry  : v1,
            shares    : v2,
            burned_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<Burned>(v3);
    }

    public fun cancel_cap_raise(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(arg0.pending_max_supply != 0, 32);
        arg0.pending_max_supply = 0;
        arg0.pending_eta_ms = 0;
        let v0 = CapRaiseCancelled{
            registry      : 0x2::object::id<Registry>(arg0),
            cancelled_max : arg0.pending_max_supply,
        };
        0x2::event::emit<CapRaiseCancelled>(v0);
    }

    public fun cancel_redeem(arg0: &mut Registry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, Redeem>(&arg0.pending_redeem, v0), 20);
        assert!(!0x2::table::borrow<address, Redeem>(&arg0.pending_redeem, v0).acknowledged, 22);
        return_redeem(arg0, v0, false, arg1);
    }

    fun check_auth(arg0: &Registry, arg1: &WrapAuth) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
    }

    public fun circulating_shares(arg0: &Registry) : u64 {
        arg0.total_shares - arg0.pending_redeem_total
    }

    public fun destroy_oracle_cap(arg0: OracleCap) {
        let OracleCap {
            id       : v0,
            registry : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_zero(arg0: Balance) {
        let Balance {
            id       : v0,
            registry : _,
            shares   : v2,
        } = arg0;
        assert!(v2 == 0, 13);
        0x2::object::delete(v0);
    }

    public fun display_balance(arg0: &Registry, arg1: &Balance) : u64 {
        to_display(arg0, arg1.shares)
    }

    public fun expire_redeem(arg0: &mut Registry, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, Redeem>(&arg0.pending_redeem, arg1), 20);
        assert!(0x2::clock::timestamp_ms(arg2) > 0x2::table::borrow<address, Redeem>(&arg0.pending_redeem, arg1).deadline_ms, 21);
        return_redeem(arg0, arg1, true, arg3);
    }

    public fun halt(arg0: &mut Registry, arg1: &HaltCap) {
        assert!(0x1::option::is_some<0x2::object::ID>(&arg0.halt_cap) && *0x1::option::borrow<0x2::object::ID>(&arg0.halt_cap) == 0x2::object::id<HaltCap>(arg1), 8);
        arg0.halted = true;
        let v0 = HaltSet{
            registry : 0x2::object::id<Registry>(arg0),
            halted   : true,
        };
        0x2::event::emit<HaltSet>(v0);
    }

    public fun increase_window_low(arg0: &Registry) : u64 {
        window_low(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = new_registry(arg0);
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun initial_cap(arg0: &Registry) : u64 {
        arg0.initial_cap
    }

    public fun is_backed(arg0: &Registry) : bool {
        arg0.attested_shares >= circulating_shares(arg0)
    }

    public fun is_halted(arg0: &Registry) : bool {
        arg0.halted
    }

    public fun is_redeem_acknowledged(arg0: &Registry, arg1: address) : bool {
        0x2::table::contains<address, Redeem>(&arg0.pending_redeem, arg1) && 0x2::table::borrow<address, Redeem>(&arg0.pending_redeem, arg1).acknowledged
    }

    public fun is_stale(arg0: &Registry, arg1: &0x2::clock::Clock) : bool {
        arg0.last_attest_clock_ms == 0 || 0x2::clock::timestamp_ms(arg1) > arg0.last_attest_clock_ms + 129600000
    }

    public fun issue_halt_cap(arg0: &mut Registry, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(arg2 != @0x0, 15);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.halt_cap)) {
            let v0 = HaltRevoked{
                registry : 0x2::object::id<Registry>(arg0),
                cap      : 0x1::option::extract<0x2::object::ID>(&mut arg0.halt_cap),
            };
            0x2::event::emit<HaltRevoked>(v0);
        };
        let v1 = HaltCap{
            id       : 0x2::object::new(arg3),
            registry : 0x2::object::id<Registry>(arg0),
        };
        arg0.halt_cap = 0x1::option::some<0x2::object::ID>(0x2::object::id<HaltCap>(&v1));
        let v2 = HaltIssued{
            registry : 0x2::object::id<Registry>(arg0),
            cap      : 0x2::object::id<HaltCap>(&v1),
            to       : arg2,
        };
        0x2::event::emit<HaltIssued>(v2);
        0x2::transfer::transfer<HaltCap>(v1, arg2);
    }

    public fun issue_oracle_cap(arg0: &mut Registry, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(arg2 != @0x0, 15);
        assert!(arg2 == arg0.oracle_holder, 30);
        let v0 = OracleCap{
            id       : 0x2::object::new(arg3),
            registry : 0x2::object::id<Registry>(arg0),
        };
        let v1 = 0x2::object::id<OracleCap>(&v0);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.oracle_cap)) {
            let v2 = 0x1::option::extract<0x2::object::ID>(&mut arg0.oracle_cap);
            let v3 = OracleRevoked{cap: v2};
            0x2::event::emit<OracleRevoked>(v3);
            let v4 = OracleReissued{
                registry : 0x2::object::id<Registry>(arg0),
                old_cap  : v2,
                new_cap  : v1,
                to       : arg2,
            };
            0x2::event::emit<OracleReissued>(v4);
        };
        arg0.oracle_cap = 0x1::option::some<0x2::object::ID>(v1);
        let v5 = OracleIssued{
            cap : v1,
            to  : arg2,
        };
        0x2::event::emit<OracleIssued>(v5);
        0x2::transfer::transfer<OracleCap>(v0, arg2);
    }

    public(friend) fun issue_wrap_auth(arg0: &mut Registry, arg1: &AdminCap) : WrapAuth {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(!arg0.wrap_auth_issued, 18);
        arg0.wrap_auth_issued = true;
        WrapAuth{registry: 0x2::object::id<Registry>(arg0)}
    }

    public fun join(arg0: &Registry, arg1: &mut Balance, arg2: Balance, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_active(arg0, arg3);
        let Balance {
            id       : v0,
            registry : v1,
            shares   : v2,
        } = arg2;
        assert!(v1 == arg1.registry && v1 == 0x2::object::id<Registry>(arg0), 7);
        0x2::object::delete(v0);
        arg1.shares = arg1.shares + v2;
        let v3 = Joined{
            registry : v1,
            shares   : v2,
            owner    : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<Joined>(v3);
    }

    public fun keep(arg0: Balance, arg1: &0x2::tx_context::TxContext) {
        0x2::transfer::transfer<Balance>(arg0, 0x2::tx_context::sender(arg1));
    }

    public fun last_attest_clock_ms(arg0: &Registry) : u64 {
        arg0.last_attest_clock_ms
    }

    public fun last_attest_ms(arg0: &Registry) : u64 {
        arg0.last_attest_ms
    }

    public fun last_attester(arg0: &Registry) : 0x1::option::Option<0x2::object::ID> {
        arg0.last_attester
    }

    public fun lock_for_wrap(arg0: &Registry, arg1: &WrapAuth, arg2: Balance, arg3: &0x2::clock::Clock) : u64 {
        check_auth(arg0, arg1);
        assert_active(arg0, arg3);
        let Balance {
            id       : v0,
            registry : v1,
            shares   : v2,
        } = arg2;
        assert!(v1 == 0x2::object::id<Registry>(arg0), 7);
        assert!(v2 > 0, 4);
        0x2::object::delete(v0);
        v2
    }

    public fun max_change_bps(arg0: &Registry) : u64 {
        arg0.max_change_bps
    }

    public fun max_supply(arg0: &Registry) : u64 {
        arg0.max_supply
    }

    public fun mint(arg0: &mut Registry, arg1: &AdminCap, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(arg2 > 0, 4);
        assert!(arg3 != @0x0, 15);
        assert!(!arg0.halted, 26);
        assert!(arg0.last_attest_clock_ms != 0, 1);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg0.last_attest_clock_ms + arg0.mint_stale_ms, 27);
        assert!(arg0.total_shares + arg2 <= arg0.attested_shares, 2);
        assert!(arg0.total_shares + arg2 <= arg0.max_supply, 2);
        if (arg0.total_shares + arg2 > arg0.prev_max_supply) {
            assert!(arg0.last_attest_clock_ms > arg0.raise_applied_clock_ms, 36);
        };
        arg0.total_shares = arg0.total_shares + arg2;
        arg0.total_minted = arg0.total_minted + arg2;
        let v0 = Balance{
            id       : 0x2::object::new(arg5),
            registry : 0x2::object::id<Registry>(arg0),
            shares   : arg2,
        };
        0x2::transfer::transfer<Balance>(v0, arg3);
        let v1 = Minted{
            registry : 0x2::object::id<Registry>(arg0),
            shares   : arg2,
            to       : arg3,
        };
        0x2::event::emit<Minted>(v1);
    }

    public fun mint_stale_ms(arg0: &Registry) : u64 {
        arg0.mint_stale_ms
    }

    public fun multiplier(arg0: &Registry) : u64 {
        arg0.multiplier
    }

    public fun multiplier_locked(arg0: &Registry) : bool {
        arg0.multiplier_locked
    }

    fun new_registry(arg0: &mut 0x2::tx_context::TxContext) : AdminCap {
        let v0 = Registry{
            id                     : 0x2::object::new(arg0),
            multiplier             : 1000000000,
            total_shares           : 0,
            attested_shares        : 0,
            last_attest_ms         : 0,
            last_attest_clock_ms   : 0,
            max_change_bps         : 236,
            oracle_cap             : 0x1::option::none<0x2::object::ID>(),
            pending_redeem         : 0x2::table::new<address, Redeem>(arg0),
            pending_redeem_total   : 0,
            initial_cap            : 0,
            wrap_auth_issued       : false,
            last_attester          : 0x1::option::none<0x2::object::ID>(),
            mint_stale_ms          : 129600000,
            total_minted           : 0,
            total_burned           : 0,
            halt_cap               : 0x1::option::none<0x2::object::ID>(),
            halted                 : false,
            redeem_enabled         : false,
            multiplier_locked      : true,
            oracle_holder          : 0x2::tx_context::sender(arg0),
            attest_history         : 0x1::vector::empty<Checkpoint>(),
            max_supply             : 0,
            pending_max_supply     : 0,
            pending_eta_ms         : 0,
            raise_applied_clock_ms : 0,
            prev_max_supply        : 0,
        };
        0x2::transfer::share_object<Registry>(v0);
        AdminCap{
            id       : 0x2::object::new(arg0),
            registry : 0x2::object::id<Registry>(&v0),
        }
    }

    public fun oracle_holder(arg0: &Registry) : address {
        arg0.oracle_holder
    }

    public fun pending_eta_ms(arg0: &Registry) : u64 {
        arg0.pending_eta_ms
    }

    public fun pending_max_supply(arg0: &Registry) : u64 {
        arg0.pending_max_supply
    }

    public fun pending_redeem_deadline(arg0: &Registry, arg1: address) : u64 {
        if (0x2::table::contains<address, Redeem>(&arg0.pending_redeem, arg1)) {
            0x2::table::borrow<address, Redeem>(&arg0.pending_redeem, arg1).deadline_ms
        } else {
            0
        }
    }

    public fun pending_redeem_of(arg0: &Registry, arg1: address) : u64 {
        if (0x2::table::contains<address, Redeem>(&arg0.pending_redeem, arg1)) {
            0x2::table::borrow<address, Redeem>(&arg0.pending_redeem, arg1).shares
        } else {
            0
        }
    }

    public fun pending_redeem_total(arg0: &Registry) : u64 {
        arg0.pending_redeem_total
    }

    fun prune_history(arg0: &mut Registry, arg1: u64) {
        while (0x1::vector::length<Checkpoint>(&arg0.attest_history) >= 2 && 0x1::vector::borrow<Checkpoint>(&arg0.attest_history, 1).clock_ms + 604800000 <= arg1) {
            0x1::vector::remove<Checkpoint>(&mut arg0.attest_history, 0);
        };
    }

    fun queue_redeem(arg0: &mut Registry, arg1: address, arg2: u64, arg3: bool, arg4: &0x2::clock::Clock) {
        assert!(arg0.redeem_enabled, 28);
        assert!(!0x2::table::contains<address, Redeem>(&arg0.pending_redeem, arg1), 19);
        let v0 = Redeem{
            shares       : arg2,
            deadline_ms  : 0x2::clock::timestamp_ms(arg4) + 604800000,
            wrapped      : arg3,
            acknowledged : false,
        };
        0x2::table::add<address, Redeem>(&mut arg0.pending_redeem, arg1, v0);
        arg0.pending_redeem_total = arg0.pending_redeem_total + arg2;
        let v1 = RedeemRequested{
            registry : 0x2::object::id<Registry>(arg0),
            holder   : arg1,
            shares   : arg2,
            wrapped  : arg3,
        };
        0x2::event::emit<RedeemRequested>(v1);
    }

    public fun queue_redeem_wrapped(arg0: &mut Registry, arg1: &WrapAuth, arg2: address, arg3: u64, arg4: &0x2::clock::Clock) {
        check_auth(arg0, arg1);
        queue_redeem(arg0, arg2, arg3, true, arg4);
    }

    public fun redeem_enabled(arg0: &Registry) : bool {
        arg0.redeem_enabled
    }

    public fun redeem_request(arg0: &mut Registry, arg1: Balance, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let Balance {
            id       : v0,
            registry : v1,
            shares   : v2,
        } = arg1;
        assert!(v1 == 0x2::object::id<Registry>(arg0), 7);
        assert!(v2 > 0, 4);
        0x2::object::delete(v0);
        queue_redeem(arg0, 0x2::tx_context::sender(arg3), v2, false, arg2);
    }

    public fun release_from_wrap(arg0: &Registry, arg1: &WrapAuth, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Balance {
        check_auth(arg0, arg1);
        assert_active(arg0, arg3);
        assert!(arg2 > 0, 4);
        Balance{
            id       : 0x2::object::new(arg4),
            registry : 0x2::object::id<Registry>(arg0),
            shares   : arg2,
        }
    }

    fun return_redeem(arg0: &mut Registry, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<address, Redeem>(&arg0.pending_redeem, arg1), 20);
        let Redeem {
            shares       : v0,
            deadline_ms  : _,
            wrapped      : _,
            acknowledged : _,
        } = 0x2::table::remove<address, Redeem>(&mut arg0.pending_redeem, arg1);
        arg0.pending_redeem_total = arg0.pending_redeem_total - v0;
        let v4 = Balance{
            id       : 0x2::object::new(arg3),
            registry : 0x2::object::id<Registry>(arg0),
            shares   : v0,
        };
        0x2::transfer::transfer<Balance>(v4, arg1);
        let v5 = RedeemCancelled{
            registry : 0x2::object::id<Registry>(arg0),
            holder   : arg1,
            shares   : v0,
            expired  : arg2,
        };
        0x2::event::emit<RedeemCancelled>(v5);
    }

    public fun revoke_halt_cap(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.halt_cap)) {
            let v0 = HaltRevoked{
                registry : 0x2::object::id<Registry>(arg0),
                cap      : 0x1::option::extract<0x2::object::ID>(&mut arg0.halt_cap),
            };
            0x2::event::emit<HaltRevoked>(v0);
        };
    }

    public fun revoke_oracle_cap(arg0: &mut Registry, arg1: &AdminCap) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.oracle_cap)) {
            let v0 = OracleRevoked{cap: 0x1::option::extract<0x2::object::ID>(&mut arg0.oracle_cap)};
            0x2::event::emit<OracleRevoked>(v0);
        };
    }

    public fun scale() : u64 {
        1000000000
    }

    public fun set_initial_cap(arg0: &mut Registry, arg1: &AdminCap, arg2: u64) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(arg0.last_attest_clock_ms == 0, 17);
        assert!(arg2 > 0, 4);
        arg0.initial_cap = arg2;
        arg0.max_supply = arg2;
        arg0.prev_max_supply = arg2;
        let v0 = InitialCapSet{
            registry    : 0x2::object::id<Registry>(arg0),
            initial_cap : arg2,
        };
        0x2::event::emit<InitialCapSet>(v0);
    }

    public fun set_max_change_bps(arg0: &mut Registry, arg1: &AdminCap, arg2: u64) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(arg2 > 0, 4);
        assert!(arg2 <= 236, 10);
        let v0 = MaxChangeSet{
            old_bps : arg0.max_change_bps,
            new_bps : arg2,
        };
        0x2::event::emit<MaxChangeSet>(v0);
        arg0.max_change_bps = arg2;
    }

    public fun set_mint_stale_ms(arg0: &mut Registry, arg1: &AdminCap, arg2: u64) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(arg2 > 0 && arg2 <= 129600000, 31);
        arg0.mint_stale_ms = arg2;
        let v0 = MintStaleSet{
            registry      : 0x2::object::id<Registry>(arg0),
            mint_stale_ms : arg2,
        };
        0x2::event::emit<MintStaleSet>(v0);
    }

    public fun set_oracle_holder(arg0: &mut Registry, arg1: &AdminCap, arg2: address) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(arg2 != @0x0, 15);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.oracle_cap)) {
            let v0 = OracleRevoked{cap: 0x1::option::extract<0x2::object::ID>(&mut arg0.oracle_cap)};
            0x2::event::emit<OracleRevoked>(v0);
        };
        let v1 = OracleHolderSet{
            registry   : 0x2::object::id<Registry>(arg0),
            old_holder : arg0.oracle_holder,
            new_holder : arg2,
        };
        0x2::event::emit<OracleHolderSet>(v1);
        arg0.oracle_holder = arg2;
    }

    public fun set_redeem_enabled(arg0: &mut Registry, arg1: &AdminCap, arg2: bool) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        arg0.redeem_enabled = arg2;
        let v0 = RedeemEnabledSet{
            registry : 0x2::object::id<Registry>(arg0),
            enabled  : arg2,
        };
        0x2::event::emit<RedeemEnabledSet>(v0);
    }

    public fun settle_redeem(arg0: &mut Registry, arg1: &AdminCap, arg2: address, arg3: u64) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 8);
        assert!(0x2::table::contains<address, Redeem>(&arg0.pending_redeem, arg2), 20);
        let v0 = 0x2::table::borrow_mut<address, Redeem>(&mut arg0.pending_redeem, arg2);
        assert!(v0.acknowledged, 23);
        assert!(v0.shares >= arg3 && arg3 > 0, 14);
        v0.shares = v0.shares - arg3;
        if (v0.shares == 0) {
            0x2::table::remove<address, Redeem>(&mut arg0.pending_redeem, arg2);
        };
        arg0.pending_redeem_total = arg0.pending_redeem_total - arg3;
        arg0.total_shares = arg0.total_shares - arg3;
        let v1 = RedeemSettled{
            registry : 0x2::object::id<Registry>(arg0),
            holder   : arg2,
            shares   : arg3,
        };
        0x2::event::emit<RedeemSettled>(v1);
    }

    public fun shares(arg0: &Balance) : u64 {
        arg0.shares
    }

    public fun to_display(arg0: &Registry, arg1: u64) : u64 {
        let v0 = (arg1 as u128) * (arg0.multiplier as u128) / (1000000000 as u128);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    public fun total_burned(arg0: &Registry) : u64 {
        arg0.total_burned
    }

    public fun total_minted(arg0: &Registry) : u64 {
        arg0.total_minted
    }

    public fun total_shares(arg0: &Registry) : u64 {
        arg0.total_shares
    }

    public fun transfer_shares(arg0: &Registry, arg1: &mut Balance, arg2: u64, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.registry == 0x2::object::id<Registry>(arg0), 7);
        assert_active(arg0, arg4);
        assert!(arg2 > 0, 4);
        assert!(arg3 != @0x0, 15);
        assert!(arg1.shares >= arg2, 5);
        arg1.shares = arg1.shares - arg2;
        let v0 = Balance{
            id       : 0x2::object::new(arg5),
            registry : arg1.registry,
            shares   : arg2,
        };
        0x2::transfer::transfer<Balance>(v0, arg3);
        let v1 = Transferred{
            registry : arg1.registry,
            shares   : arg2,
            from     : 0x2::tx_context::sender(arg5),
            to       : arg3,
        };
        0x2::event::emit<Transferred>(v1);
    }

    fun window_low(arg0: &Registry) : u64 {
        let v0 = arg0.attested_shares;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Checkpoint>(&arg0.attest_history)) {
            let v2 = 0x1::vector::borrow<Checkpoint>(&arg0.attest_history, v1).shares;
            if (v2 < v0) {
                v0 = v2;
            };
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

