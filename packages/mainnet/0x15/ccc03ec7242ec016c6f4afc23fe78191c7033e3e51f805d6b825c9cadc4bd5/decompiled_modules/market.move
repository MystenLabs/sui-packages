module 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        ticker: 0x2::object::ID,
        params: 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params,
        pool: 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::Pool,
        vault: 0x2::balance::Balance<T0>,
        accounts: 0x2::table::Table<address, Account>,
        sessions: 0x2::table::Table<address, Session>,
        positions: 0x2::table::Table<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>,
        next_position: u64,
        claims: 0x2::table::Table<u64, ClaimRecord>,
        next_claim: u64,
        long_oi: u64,
        short_oi: u64,
        long_cap: u64,
        short_cap: u64,
        total_free: u64,
        total_margin: u64,
        opens_paused: bool,
        emergency: bool,
        emergency_tick: u64,
        emergency_price: u64,
        sponsor_only: bool,
        sponsor: address,
        stall_ms: u64,
        emergency_ms: u64,
        keeper_cap: 0x2::object::ID,
        guardian_cap: 0x2::object::ID,
        team_cap: 0x2::object::ID,
    }

    struct Account has store {
        free: u64,
        notional: u64,
        holder: 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::Holder,
        positions: vector<u64>,
        claims: vector<u64>,
        referrer: 0x1::option::Option<address>,
        ref_earned: u64,
    }

    struct Session has drop, store {
        owner: address,
        expires_ms: u64,
    }

    struct ClaimRecord has drop, store {
        owner: address,
        claim: 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::Claim,
    }

    struct MarketCreated has copy, drop {
        market: 0x2::object::ID,
        ticker: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        market: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct Withdrew has copy, drop {
        market: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct SessionSet has copy, drop {
        market: 0x2::object::ID,
        owner: address,
        key: address,
        expires_ms: u64,
    }

    struct SessionRevoked has copy, drop {
        market: 0x2::object::ID,
        owner: address,
        key: address,
    }

    struct Opened has copy, drop {
        market: 0x2::object::ID,
        id: u64,
        owner: address,
        is_long: bool,
        margin: u64,
        leverage: u64,
        notional: u64,
        entry_tick: u64,
        day: u64,
        entry_price: u64,
        bust_price: u64,
    }

    struct Closed has copy, drop {
        market: 0x2::object::ID,
        id: u64,
        owner: address,
        how: u8,
        outcome: u8,
        exit_tick: u64,
        exit_price: u64,
        amount: u64,
        paid: u64,
        queued: u64,
        claim_id: 0x1::option::Option<u64>,
        paper: u64,
        close_fee: u64,
    }

    struct Harvested has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
    }

    struct ReferrerSet has copy, drop {
        market: 0x2::object::ID,
        owner: address,
        referrer: address,
    }

    struct ReferralPaid has copy, drop {
        market: 0x2::object::ID,
        owner: address,
        referrer: address,
        bonus: u64,
        referrer2: 0x1::option::Option<address>,
        bonus2: u64,
    }

    struct ClaimCollected has copy, drop {
        market: 0x2::object::ID,
        id: u64,
        owner: address,
        amount: u64,
        done: bool,
    }

    struct RewardsCollected has copy, drop {
        market: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct Swept has copy, drop {
        market: 0x2::object::ID,
        team: u64,
        holders: u64,
    }

    struct TeamWithdrew has copy, drop {
        market: 0x2::object::ID,
        amount: u64,
    }

    struct EmergencyDeclared has copy, drop {
        market: 0x2::object::ID,
        last_draw_ms: u64,
        at_ms: u64,
        tick: u64,
        price: u64,
    }

    struct EmergencyEnded has copy, drop {
        market: 0x2::object::ID,
    }

    struct SettingsChanged has copy, drop {
        market: 0x2::object::ID,
    }

    struct SideCapsChanged has copy, drop {
        market: 0x2::object::ID,
        long_cap: u64,
        short_cap: u64,
    }

    struct OpensPaused has copy, drop {
        market: 0x2::object::ID,
    }

    struct OpensResumed has copy, drop {
        market: 0x2::object::ID,
    }

    struct RoleCapsChanged has copy, drop {
        market: 0x2::object::ID,
        keeper_cap: 0x2::object::ID,
        guardian_cap: 0x2::object::ID,
        team_cap: 0x2::object::ID,
    }

    struct MarketMigrated has copy, drop {
        market: 0x2::object::ID,
        version: u64,
    }

    struct DepositKey has copy, drop, store {
        owner: address,
    }

    struct DepositBox has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    public fun claim<T0>(arg0: &Market<T0>, arg1: u64) : (address, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::Claim) {
        let v0 = 0x2::table::borrow<u64, ClaimRecord>(&arg0.claims, arg1);
        (v0.owner, v0.claim)
    }

    public fun account<T0>(arg0: &Market<T0>, arg1: address) : (u64, u64, u64, vector<u64>, vector<u64>) {
        let v0 = 0x2::table::borrow<address, Account>(&arg0.accounts, arg1);
        (v0.free, v0.notional, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::holder_paper(&v0.holder), v0.positions, v0.claims)
    }

    fun acting_for<T0>(arg0: &Market<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) : address {
        let v0 = 0x2::tx_context::sender(arg2);
        if (0x2::table::contains<address, Session>(&arg0.sessions, v0)) {
            let v1 = 0x2::table::borrow<address, Session>(&arg0.sessions, v0);
            if (v1.expires_ms > 0x2::clock::timestamp_ms(arg1)) {
                return v1.owner
            };
        };
        assert!(0x2::table::contains<address, Account>(&arg0.accounts, v0), 0);
        v0
    }

    fun apply_outcome<T0>(arg0: &mut Market<T0>, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position, arg2: u64, arg3: u8, arg4: u8, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::owner(arg1);
        let v1 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::margin(arg1);
        let v2 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::notional(arg1);
        if (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::is_long(arg1)) {
            arg0.long_oi = arg0.long_oi - v2;
        } else {
            arg0.short_oi = arg0.short_oi - v2;
        };
        arg0.total_margin = arg0.total_margin - v1;
        let v3 = arg3 == 3;
        let v4 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v0);
        v4.notional = v4.notional - v2;
        let (v5, v6) = 0x1::vector::index_of<u64>(&v4.positions, &arg2);
        if (v5) {
            0x1::vector::swap_remove<u64>(&mut v4.positions, v6);
        };
        let v7 = 0;
        let v8 = 0;
        let v9 = 0x1::option::none<u64>();
        let v10 = 0;
        let v11 = 0;
        let v12 = if (arg4 == 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::win()) {
            let v13 = if (v3) {
                0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::on_plain_win(&mut arg0.pool, arg5)
            } else {
                0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::on_win(&mut arg0.pool, arg5, &arg0.params)
            };
            let v14 = v13;
            let v15 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::win_paid(&v14);
            v7 = v15;
            let v16 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::win_queued(&v14);
            if (0x1::option::is_some<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::Claim>(&v16)) {
                let v17 = 0x1::option::destroy_some<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::Claim>(v16);
                v8 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::claim_amount(&v17);
                let v18 = arg0.next_claim;
                arg0.next_claim = v18 + 1;
                0x1::vector::push_back<u64>(&mut v4.claims, v18);
                let v19 = ClaimRecord{
                    owner : v0,
                    claim : v17,
                };
                0x2::table::add<u64, ClaimRecord>(&mut arg0.claims, v18, v19);
                v9 = 0x1::option::some<u64>(v18);
            };
            v1 + v15
        } else {
            let v20 = arg4 == 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::liquidated();
            let v21 = if (v3) {
                0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::on_plain_loss(&mut arg0.pool, arg5, &mut v4.holder, &arg0.params)
            } else {
                0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::on_loss(&mut arg0.pool, arg5, v20, &mut v4.holder, &arg0.params)
            };
            let v22 = v21;
            v10 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::loss_paper(&v22);
            v11 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::loss_rewards(&v22);
            if (v20) {
                0
            } else {
                v1 - arg5
            }
        };
        let v23 = if (v3 || arg4 == 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::liquidated()) {
            0
        } else {
            let v24 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::fixed::wad_mul(v2, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::close_fee_wad(&arg0.params), true);
            if (v24 < v12) {
                v24
            } else {
                v12
            }
        };
        0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::on_close_charge(&mut arg0.pool, v23);
        let v25 = v12 - v23 + v11;
        v4.free = v4.free + v25;
        arg0.total_free = arg0.total_free + v25;
        let v26 = Closed{
            market     : 0x2::object::id<Market<T0>>(arg0),
            id         : arg2,
            owner      : v0,
            how        : arg3,
            outcome    : arg4,
            exit_tick  : arg6,
            exit_price : arg7,
            amount     : arg5,
            paid       : v7,
            queued     : v8,
            claim_id   : v9,
            paper      : v10,
            close_fee  : v23,
        };
        0x2::event::emit<Closed>(v26);
        pay_referral_bonuses<T0>(arg0, v0, v11);
    }

    public fun position<T0>(arg0: &Market<T0>, arg1: u64) : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position {
        *0x2::table::borrow<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(&arg0.positions, arg1)
    }

    fun check_version<T0>(arg0: &Market<T0>) {
        assert!(arg0.version == 1, 19);
    }

    public fun pool<T0>(arg0: &Market<T0>) : &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::Pool {
        &arg0.pool
    }

    public fun close<T0>(arg0: &mut Market<T0>, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker, arg2: &0x2::clock::Clock, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        assert!(0x2::object::id<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker>(arg1) == arg0.ticker, 1);
        assert!(!arg0.emergency, 4);
        assert!(0x2::table::contains<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(&arg0.positions, arg3), 9);
        assert!(0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::owner(0x2::table::borrow<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(&arg0.positions, arg3)) == acting_for<T0>(arg0, arg2, arg4), 0);
        let v0 = if (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::day(0x2::table::borrow<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(&arg0.positions, arg3)) < 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::day(arg1)) {
            2
        } else {
            0
        };
        settle<T0>(arg0, arg1, arg3, v0);
    }

    public fun collect_claim<T0>(arg0: &mut Market<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        let v0 = acting_for<T0>(arg0, arg2, arg3);
        assert!(0x2::table::contains<u64, ClaimRecord>(&arg0.claims, arg1), 15);
        let v1 = 0x2::table::borrow_mut<u64, ClaimRecord>(&mut arg0.claims, arg1);
        assert!(v1.owner == v0, 0);
        let v2 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::collect(&mut arg0.pool, &mut v1.claim);
        let v3 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::claim_done(&v1.claim);
        let v4 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v0);
        v4.free = v4.free + v2;
        arg0.total_free = arg0.total_free + v2;
        if (v3) {
            0x2::table::remove<u64, ClaimRecord>(&mut arg0.claims, arg1);
            let (v5, v6) = 0x1::vector::index_of<u64>(&v4.claims, &arg1);
            if (v5) {
                0x1::vector::swap_remove<u64>(&mut v4.claims, v6);
            };
        };
        let v7 = ClaimCollected{
            market : 0x2::object::id<Market<T0>>(arg0),
            id     : arg1,
            owner  : v0,
            amount : v2,
            done   : v3,
        };
        0x2::event::emit<ClaimCollected>(v7);
    }

    public fun collect_rewards<T0>(arg0: &mut Market<T0>, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        let v0 = acting_for<T0>(arg0, arg1, arg2);
        let v1 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v0);
        let v2 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::settle_holder(&mut arg0.pool, &mut v1.holder);
        v1.free = v1.free + v2;
        arg0.total_free = arg0.total_free + v2;
        let v3 = RewardsCollected{
            market : 0x2::object::id<Market<T0>>(arg0),
            owner  : v0,
            amount : v2,
        };
        0x2::event::emit<RewardsCollected>(v3);
        pay_referral_bonuses<T0>(arg0, v0, v2);
    }

    public fun create<T0>(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::AdminCap, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg5);
        let v1 = MarketCreated{
            market : 0x2::object::uid_to_inner(&v0),
            ticker : 0x2::object::id<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker>(arg1),
        };
        0x2::event::emit<MarketCreated>(v1);
        let v2 = RoleCapsChanged{
            market       : 0x2::object::uid_to_inner(&v0),
            keeper_cap   : arg2,
            guardian_cap : arg3,
            team_cap     : arg4,
        };
        0x2::event::emit<RoleCapsChanged>(v2);
        let v3 = Market<T0>{
            id              : v0,
            version         : 1,
            ticker          : 0x2::object::id<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker>(arg1),
            params          : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::launch(),
            pool            : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::new(),
            vault           : 0x2::balance::zero<T0>(),
            accounts        : 0x2::table::new<address, Account>(arg5),
            sessions        : 0x2::table::new<address, Session>(arg5),
            positions       : 0x2::table::new<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(arg5),
            next_position   : 0,
            claims          : 0x2::table::new<u64, ClaimRecord>(arg5),
            next_claim      : 0,
            long_oi         : 0,
            short_oi        : 0,
            long_cap        : 500000 * 1000000,
            short_cap       : 500000 * 1000000,
            total_free      : 0,
            total_margin    : 0,
            opens_paused    : false,
            emergency       : false,
            emergency_tick  : 0,
            emergency_price : 0,
            sponsor_only    : false,
            sponsor         : @0x0,
            stall_ms        : 120000,
            emergency_ms    : 1800000,
            keeper_cap      : arg2,
            guardian_cap    : arg3,
            team_cap        : arg4,
        };
        0x2::transfer::share_object<Market<T0>>(v3);
    }

    fun credit_bonus<T0>(arg0: &mut Market<T0>, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg1);
        v0.free = v0.free + arg2;
        v0.ref_earned = v0.ref_earned + arg2;
        arg0.total_free = arg0.total_free + arg2;
    }

    fun crossed(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker, arg2: u64) : bool {
        if (arg2 <= 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::entry_tick(arg0)) {
            return false
        };
        let (v0, v1, v2) = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::extremes_in_window(arg1, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::entry_tick(arg0) + 1, arg2);
        v0 && 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::busts_within(arg0, v1, v2)
    }

    public fun declare_emergency<T0>(arg0: &mut Market<T0>, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker, arg2: &0x2::clock::Clock) {
        check_version<T0>(arg0);
        assert!(0x2::object::id<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker>(arg1) == arg0.ticker, 1);
        assert!(!arg0.emergency, 4);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::last_draw_ms(arg1) + arg0.emergency_ms, 12);
        arg0.emergency = true;
        arg0.emergency_tick = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::last_tick(arg1);
        arg0.emergency_price = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::last_price(arg1);
        let v1 = EmergencyDeclared{
            market       : 0x2::object::id<Market<T0>>(arg0),
            last_draw_ms : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::last_draw_ms(arg1),
            at_ms        : v0,
            tick         : arg0.emergency_tick,
            price        : arg0.emergency_price,
        };
        0x2::event::emit<EmergencyDeclared>(v1);
    }

    public fun deposit<T0>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &0x2::tx_context::TxContext) {
        deposit_for<T0>(arg0, arg1, 0x2::tx_context::sender(arg2));
    }

    public fun deposit_address<T0>(arg0: &Market<T0>, arg1: address) : address {
        let v0 = DepositKey{owner: arg1};
        0x2::derived_object::derive_address<DepositKey>(0x2::object::id<Market<T0>>(arg0), v0)
    }

    fun deposit_box<T0>(arg0: &mut Market<T0>, arg1: address) : &mut 0x2::object::UID {
        let v0 = DepositKey{owner: arg1};
        if (!0x2::derived_object::exists<DepositKey>(&arg0.id, v0)) {
            let v1 = DepositBox{
                id    : 0x2::derived_object::claim<DepositKey>(&mut arg0.id, v0),
                owner : arg1,
            };
            0x2::dynamic_object_field::add<DepositKey, DepositBox>(&mut arg0.id, v0, v1);
        };
        &mut 0x2::dynamic_object_field::borrow_mut<DepositKey, DepositBox>(&mut arg0.id, v0).id
    }

    public fun deposit_for<T0>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: address) {
        check_version<T0>(arg0);
        let v0 = 0x2::coin::value<T0>(&arg1);
        assert!(v0 > 0, 16);
        ensure_account<T0>(arg0, arg2);
        let v1 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, arg2);
        v1.free = v1.free + v0;
        arg0.total_free = arg0.total_free + v0;
        0x2::balance::join<T0>(&mut arg0.vault, 0x2::coin::into_balance<T0>(arg1));
        let v2 = Deposited{
            market : 0x2::object::id<Market<T0>>(arg0),
            owner  : arg2,
            amount : v0,
        };
        0x2::event::emit<Deposited>(v2);
    }

    fun ed25519_address(arg0: &vector<u8>) : address {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun emergency_close<T0>(arg0: &mut Market<T0>, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker, arg2: u64) {
        check_version<T0>(arg0);
        assert!(0x2::object::id<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker>(arg1) == arg0.ticker, 1);
        assert!(arg0.emergency, 5);
        assert!(0x2::table::contains<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(&arg0.positions, arg2), 9);
        settle<T0>(arg0, arg1, arg2, 3);
    }

    public fun end_emergency<T0>(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::AdminCap, arg1: &mut Market<T0>) {
        check_version<T0>(arg1);
        assert!(arg1.emergency, 5);
        arg1.emergency = false;
        let v0 = EmergencyEnded{market: 0x2::object::id<Market<T0>>(arg1)};
        0x2::event::emit<EmergencyEnded>(v0);
    }

    fun ensure_account<T0>(arg0: &mut Market<T0>, arg1: address) {
        if (!0x2::table::contains<address, Account>(&arg0.accounts, arg1)) {
            let v0 = Account{
                free       : 0,
                notional   : 0,
                holder     : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::new_holder(),
                positions  : vector[],
                claims     : vector[],
                referrer   : 0x1::option::none<address>(),
                ref_earned : 0,
            };
            0x2::table::add<address, Account>(&mut arg0.accounts, arg1, v0);
        };
    }

    fun exit_point<T0>(arg0: &Market<T0>, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position, arg2: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker) : (u64, u64) {
        if (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::day(arg1) < 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::day(arg2)) {
            let (v0, v1) = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::day_end(arg2, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::day(arg1));
            if (!arg0.emergency || v0 <= arg0.emergency_tick) {
                return (v0, v1)
            };
        };
        if (arg0.emergency) {
            (arg0.emergency_tick, arg0.emergency_price)
        } else {
            (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::last_tick(arg2), 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::last_price(arg2))
        }
    }

    public fun harvest<T0>(arg0: &mut Market<T0>) {
        check_version<T0>(arg0);
        let v0 = Harvested{
            market : 0x2::object::id<Market<T0>>(arg0),
            amount : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::harvest(&mut arg0.pool),
        };
        0x2::event::emit<Harvested>(v0);
    }

    public fun has_account<T0>(arg0: &Market<T0>, arg1: address) : bool {
        0x2::table::contains<address, Account>(&arg0.accounts, arg1)
    }

    public fun has_position<T0>(arg0: &Market<T0>, arg1: u64) : bool {
        0x2::table::contains<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(&arg0.positions, arg1)
    }

    public fun is_emergency<T0>(arg0: &Market<T0>) : bool {
        arg0.emergency
    }

    public fun liquidate<T0>(arg0: &mut Market<T0>, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker, arg2: u64) {
        check_version<T0>(arg0);
        assert!(0x2::object::id<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker>(arg1) == arg0.ticker, 1);
        assert!(0x2::table::contains<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(&arg0.positions, arg2), 9);
        let v0 = 0x2::table::borrow<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(&arg0.positions, arg2);
        let (v1, _) = exit_point<T0>(arg0, v0, arg1);
        assert!(crossed(v0, arg1, v1), 10);
        settle<T0>(arg0, arg1, arg2, 1);
    }

    public fun migrate<T0>(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::AdminCap, arg1: &mut Market<T0>) {
        assert!(arg1.version < 1, 19);
        arg1.version = 1;
        let v0 = MarketMigrated{
            market  : 0x2::object::id<Market<T0>>(arg1),
            version : 1,
        };
        0x2::event::emit<MarketMigrated>(v0);
    }

    public fun open<T0>(arg0: &mut Market<T0>, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: u64, arg6: &0x2::tx_context::TxContext) : u64 {
        check_version<T0>(arg0);
        assert!(0x2::object::id<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker>(arg1) == arg0.ticker, 1);
        assert!(!arg0.opens_paused, 2);
        assert!(!arg0.emergency, 4);
        assert!(0x2::clock::timestamp_ms(arg2) <= 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::last_draw_ms(arg1) + arg0.stall_ms, 3);
        if (arg0.sponsor_only) {
            assert!(0x2::tx_context::sponsor(arg6) == 0x1::option::some<address>(arg0.sponsor), 13);
        };
        let v0 = acting_for<T0>(arg0, arg2, arg6);
        let v1 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::open(v0, arg3, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::last_tick(arg1), 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::day(arg1), 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::last_price(arg1), arg4, arg5, &arg0.params);
        let v2 = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::notional(&v1);
        if (arg3) {
            assert!(arg0.long_oi + v2 <= arg0.long_cap, 8);
            arg0.long_oi = arg0.long_oi + v2;
        } else {
            assert!(arg0.short_oi + v2 <= arg0.short_cap, 8);
            arg0.short_oi = arg0.short_oi + v2;
        };
        let v3 = arg0.next_position;
        arg0.next_position = v3 + 1;
        let v4 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v0);
        assert!(arg4 <= v4.free, 6);
        assert!(v4.notional + v2 <= 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::max_user_notional(&arg0.params), 7);
        v4.free = v4.free - arg4;
        v4.notional = v4.notional + v2;
        0x1::vector::push_back<u64>(&mut v4.positions, v3);
        arg0.total_free = arg0.total_free - arg4;
        arg0.total_margin = arg0.total_margin + arg4;
        let v5 = Opened{
            market      : 0x2::object::id<Market<T0>>(arg0),
            id          : v3,
            owner       : v0,
            is_long     : arg3,
            margin      : arg4,
            leverage    : arg5,
            notional    : v2,
            entry_tick  : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::entry_tick(&v1),
            day         : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::day(&v1),
            entry_price : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::entry_price(&v1),
            bust_price  : 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::bust_line(&v1),
        };
        0x2::event::emit<Opened>(v5);
        0x2::table::add<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(&mut arg0.positions, v3, v1);
        v3
    }

    public fun open_interest<T0>(arg0: &Market<T0>) : (u64, u64) {
        (arg0.long_oi, arg0.short_oi)
    }

    public fun params<T0>(arg0: &Market<T0>) : &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params {
        &arg0.params
    }

    public fun pause_opens<T0>(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::GuardianCap, arg1: &mut Market<T0>) {
        check_version<T0>(arg1);
        assert!(0x2::object::id<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::GuardianCap>(arg0) == arg1.guardian_cap, 20);
        arg1.opens_paused = true;
        let v0 = OpensPaused{market: 0x2::object::id<Market<T0>>(arg1)};
        0x2::event::emit<OpensPaused>(v0);
    }

    fun pay_referral_bonuses<T0>(arg0: &mut Market<T0>, arg1: address, arg2: u64) {
        if (arg2 == 0) {
            return
        };
        let v0 = 0x2::table::borrow<address, Account>(&arg0.accounts, arg1).referrer;
        if (0x1::option::is_none<address>(&v0)) {
            return
        };
        let v1 = 0x1::option::destroy_some<address>(v0);
        let v2 = 0x2::table::borrow<address, Account>(&arg0.accounts, v1).referrer;
        let (v3, v4) = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::pay_referral(&mut arg0.pool, arg2, 0x1::option::is_some<address>(&v2), &arg0.params);
        credit_bonus<T0>(arg0, v1, v3);
        if (0x1::option::is_some<address>(&v2)) {
            credit_bonus<T0>(arg0, *0x1::option::borrow<address>(&v2), v4);
        };
        let v5 = ReferralPaid{
            market    : 0x2::object::id<Market<T0>>(arg0),
            owner     : arg1,
            referrer  : v1,
            bonus     : v3,
            referrer2 : v2,
            bonus2    : v4,
        };
        0x2::event::emit<ReferralPaid>(v5);
    }

    public fun referral<T0>(arg0: &Market<T0>, arg1: address) : (0x1::option::Option<address>, u64) {
        let v0 = 0x2::table::borrow<address, Account>(&arg0.accounts, arg1);
        (v0.referrer, v0.ref_earned)
    }

    public fun rescue_deposit<T0, T1: store + key>(arg0: &mut Market<T0>, arg1: 0x2::transfer::Receiving<T1>, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<T1>(0x2::transfer::public_receive<T1>(deposit_box<T0>(arg0, v0), arg1), v0);
    }

    public fun resume_opens<T0>(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::GuardianCap, arg1: &mut Market<T0>) {
        check_version<T0>(arg1);
        assert!(0x2::object::id<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::GuardianCap>(arg0) == arg1.guardian_cap, 20);
        arg1.opens_paused = false;
        let v0 = OpensResumed{market: 0x2::object::id<Market<T0>>(arg1)};
        0x2::event::emit<OpensResumed>(v0);
    }

    public fun revoke_session<T0>(arg0: &mut Market<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Session>(&arg0.sessions, arg1), 14);
        let v1 = 0x2::table::borrow<address, Session>(&arg0.sessions, arg1).owner;
        assert!(v0 == v1 || v0 == arg1, 14);
        0x2::table::remove<address, Session>(&mut arg0.sessions, arg1);
        let v2 = SessionRevoked{
            market : 0x2::object::id<Market<T0>>(arg0),
            owner  : v1,
            key    : arg1,
        };
        0x2::event::emit<SessionRevoked>(v2);
    }

    public fun role_caps<T0>(arg0: &Market<T0>) : (0x2::object::ID, 0x2::object::ID, 0x2::object::ID) {
        (arg0.keeper_cap, arg0.guardian_cap, arg0.team_cap)
    }

    public fun session<T0>(arg0: &Market<T0>, arg1: address) : (bool, address, u64) {
        if (!0x2::table::contains<address, Session>(&arg0.sessions, arg1)) {
            return (false, @0x0, 0)
        };
        let v0 = 0x2::table::borrow<address, Session>(&arg0.sessions, arg1);
        (true, v0.owner, v0.expires_ms)
    }

    public fun session_message(arg0: address, arg1: u64) : vector<u8> {
        let v0 = b"random_market::session";
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        v0
    }

    public fun set_params<T0>(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::AdminCap, arg1: &mut Market<T0>, arg2: 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::Params) {
        check_version<T0>(arg1);
        0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::params::validate(&arg2);
        arg1.params = arg2;
        let v0 = SettingsChanged{market: 0x2::object::id<Market<T0>>(arg1)};
        0x2::event::emit<SettingsChanged>(v0);
    }

    public fun set_referrer<T0>(arg0: &mut Market<T0>, arg1: address, arg2: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(!0x2::table::contains<address, Session>(&arg0.sessions, v0), 21);
        assert!(arg1 != v0 && 0x2::table::contains<address, Account>(&arg0.accounts, arg1), 21);
        ensure_account<T0>(arg0, v0);
        let v1 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v0);
        assert!(0x1::option::is_none<address>(&v1.referrer), 21);
        v1.referrer = 0x1::option::some<address>(arg1);
        let v2 = ReferrerSet{
            market   : 0x2::object::id<Market<T0>>(arg0),
            owner    : v0,
            referrer : arg1,
        };
        0x2::event::emit<ReferrerSet>(v2);
    }

    public fun set_role_caps<T0>(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::AdminCap, arg1: &mut Market<T0>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID) {
        check_version<T0>(arg1);
        arg1.keeper_cap = arg2;
        arg1.guardian_cap = arg3;
        arg1.team_cap = arg4;
        let v0 = RoleCapsChanged{
            market       : 0x2::object::id<Market<T0>>(arg1),
            keeper_cap   : arg2,
            guardian_cap : arg3,
            team_cap     : arg4,
        };
        0x2::event::emit<RoleCapsChanged>(v0);
    }

    public fun set_session<T0>(arg0: &mut Market<T0>, arg1: vector<u8>, arg2: u64, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        assert!(0x1::vector::length<u8>(&arg1) == 32 && 0x1::vector::length<u8>(&arg3) == 64, 14);
        let v2 = ed25519_address(&arg1);
        let v3 = if (v2 != v0) {
            if (arg2 > v1) {
                arg2 <= v1 + 2592000000
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 14);
        let v4 = session_message(v0, arg2);
        assert!(0x2::ed25519::ed25519_verify(&arg3, &arg1, &v4), 14);
        ensure_account<T0>(arg0, v0);
        if (0x2::table::contains<address, Session>(&arg0.sessions, v2)) {
            assert!(0x2::table::borrow<address, Session>(&arg0.sessions, v2).owner == v0, 14);
            0x2::table::remove<address, Session>(&mut arg0.sessions, v2);
        };
        let v5 = Session{
            owner      : v0,
            expires_ms : arg2,
        };
        0x2::table::add<address, Session>(&mut arg0.sessions, v2, v5);
        let v6 = SessionSet{
            market     : 0x2::object::id<Market<T0>>(arg0),
            owner      : v0,
            key        : v2,
            expires_ms : arg2,
        };
        0x2::event::emit<SessionSet>(v6);
    }

    public fun set_side_caps<T0>(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::KeeperCap, arg1: &mut Market<T0>, arg2: u64, arg3: u64) {
        check_version<T0>(arg1);
        assert!(0x2::object::id<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::KeeperCap>(arg0) == arg1.keeper_cap, 20);
        assert!(arg2 <= 50000000 * 1000000 && arg3 <= 50000000 * 1000000, 17);
        arg1.long_cap = arg2;
        arg1.short_cap = arg3;
        let v0 = SideCapsChanged{
            market    : 0x2::object::id<Market<T0>>(arg1),
            long_cap  : arg2,
            short_cap : arg3,
        };
        0x2::event::emit<SideCapsChanged>(v0);
    }

    public fun set_sponsor_rule<T0>(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::AdminCap, arg1: &mut Market<T0>, arg2: bool, arg3: address) {
        check_version<T0>(arg1);
        arg1.sponsor_only = arg2;
        arg1.sponsor = arg3;
        let v0 = SettingsChanged{market: 0x2::object::id<Market<T0>>(arg1)};
        0x2::event::emit<SettingsChanged>(v0);
    }

    public fun set_timeouts<T0>(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::AdminCap, arg1: &mut Market<T0>, arg2: u64, arg3: u64) {
        check_version<T0>(arg1);
        assert!(arg2 >= 30000 && arg2 <= 600000, 17);
        let v0 = if (arg3 >= 300000) {
            if (arg3 <= 3600000) {
                arg3 > arg2
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 17);
        arg1.stall_ms = arg2;
        arg1.emergency_ms = arg3;
        let v1 = SettingsChanged{market: 0x2::object::id<Market<T0>>(arg1)};
        0x2::event::emit<SettingsChanged>(v1);
    }

    fun settle<T0>(arg0: &mut Market<T0>, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker, arg2: u64, arg3: u8) {
        let v0 = 0x2::table::remove<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(&mut arg0.positions, arg2);
        let (v1, v2) = exit_point<T0>(arg0, &v0, arg1);
        let (v3, v4) = if (crossed(&v0, arg1, v1)) {
            (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::liquidated(), 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::margin(&v0))
        } else if (arg3 == 3) {
            0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::settle_plain(&v0, v2)
        } else {
            0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::settle(&v0, v2, &arg0.params)
        };
        apply_outcome<T0>(arg0, &v0, arg2, arg3, v3, v4, v1, v2);
    }

    public fun settle_expired<T0>(arg0: &mut Market<T0>, arg1: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker, arg2: u64) {
        check_version<T0>(arg0);
        assert!(0x2::object::id<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::Ticker>(arg1) == arg0.ticker, 1);
        assert!(!arg0.emergency, 4);
        assert!(0x2::table::contains<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(&arg0.positions, arg2), 9);
        assert!(0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::day(0x2::table::borrow<u64, 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::position::Position>(&arg0.positions, arg2)) < 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::ticker::day(arg1), 11);
        settle<T0>(arg0, arg1, arg2, 2);
    }

    public fun side_caps<T0>(arg0: &Market<T0>) : (u64, u64) {
        (arg0.long_cap, arg0.short_cap)
    }

    public fun sweep_deposit<T0>(arg0: &mut Market<T0>, arg1: address, arg2: 0x2::transfer::Receiving<0x2::coin::Coin<T0>>) {
        check_version<T0>(arg0);
        let v0 = deposit_box<T0>(arg0, arg1);
        let v1 = 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(v0, arg2);
        if (0x2::coin::value<T0>(&v1) == 0) {
            0x2::coin::destroy_zero<T0>(v1);
        } else {
            deposit_for<T0>(arg0, v1, arg1);
        };
    }

    public fun sweep_overflow<T0>(arg0: &mut Market<T0>) {
        check_version<T0>(arg0);
        let (v0, v1) = 0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::sweep_overflow(&mut arg0.pool, &arg0.params);
        let v2 = Swept{
            market  : 0x2::object::id<Market<T0>>(arg0),
            team    : v0,
            holders : v1,
        };
        0x2::event::emit<Swept>(v2);
    }

    public fun ticker_id<T0>(arg0: &Market<T0>) : 0x2::object::ID {
        arg0.ticker
    }

    public fun total_free<T0>(arg0: &Market<T0>) : u64 {
        arg0.total_free
    }

    public fun total_margin<T0>(arg0: &Market<T0>) : u64 {
        arg0.total_margin
    }

    public fun vault_matches<T0>(arg0: &Market<T0>) : bool {
        (0x2::balance::value<T0>(&arg0.vault) as u128) == (arg0.total_free as u128) + (arg0.total_margin as u128) + (0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::held(&arg0.pool) as u128)
    }

    public fun vault_value<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.vault)
    }

    public fun version<T0>(arg0: &Market<T0>) : u64 {
        arg0.version
    }

    public fun withdraw<T0>(arg0: &mut Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_version<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, Account>(&arg0.accounts, v0), 18);
        let v1 = 0x2::table::borrow_mut<address, Account>(&mut arg0.accounts, v0);
        assert!(arg1 > 0 && arg1 <= v1.free, 6);
        v1.free = v1.free - arg1;
        arg0.total_free = arg0.total_free - arg1;
        let v2 = Withdrew{
            market : 0x2::object::id<Market<T0>>(arg0),
            owner  : v0,
            amount : arg1,
        };
        0x2::event::emit<Withdrew>(v2);
        0x2::coin::take<T0>(&mut arg0.vault, arg1, arg2)
    }

    public fun withdraw_team<T0>(arg0: &0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::TeamCap, arg1: &mut Market<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_version<T0>(arg1);
        assert!(0x2::object::id<0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::roles::TeamCap>(arg0) == arg1.team_cap, 20);
        0x15ccc03ec7242ec016c6f4afc23fe78191c7033e3e51f805d6b825c9cadc4bd5::pool::withdraw_team(&mut arg1.pool, arg2);
        let v0 = TeamWithdrew{
            market : 0x2::object::id<Market<T0>>(arg1),
            amount : arg2,
        };
        0x2::event::emit<TeamWithdrew>(v0);
        0x2::coin::take<T0>(&mut arg1.vault, arg2, arg3)
    }

    entry fun withdraw_to_sender<T0>(arg0: &mut Market<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = withdraw<T0>(arg0, arg1, arg2);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

