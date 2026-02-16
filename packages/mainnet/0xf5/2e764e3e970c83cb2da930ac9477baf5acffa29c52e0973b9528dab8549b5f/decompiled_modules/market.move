module 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        market_number: u64,
        pyth_feed_id: vector<u8>,
        token_symbol: 0x1::string::String,
        target_price: u64,
        duration: u8,
        deadline: u64,
        trading_cutoff: u64,
        created_at: u64,
        fee_bps: u16,
        yes_pool: 0x2::balance::Balance<T0>,
        no_pool: 0x2::balance::Balance<T0>,
        yes_deposits: u64,
        no_deposits: u64,
        positions: 0x2::table::Table<address, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position>,
        resolved: bool,
        voided: bool,
        outcome: u8,
        resolved_price: u64,
        resolved_at: u64,
        resolver: address,
        fees: 0x2::balance::Balance<T0>,
        resolve_pool: u64,
        total_volume: u64,
        trade_count: u64,
    }

    public(friend) fun new<T0>(arg0: u64, arg1: vector<u8>, arg2: 0x1::string::String, arg3: u64, arg4: u8, arg5: u64, arg6: u64, arg7: u64, arg8: u16, arg9: &mut 0x2::tx_context::TxContext) : Market<T0> {
        Market<T0>{
            id             : 0x2::object::new(arg9),
            market_number  : arg0,
            pyth_feed_id   : arg1,
            token_symbol   : arg2,
            target_price   : arg3,
            duration       : arg4,
            deadline       : arg5,
            trading_cutoff : arg6,
            created_at     : arg7,
            fee_bps        : arg8,
            yes_pool       : 0x2::balance::zero<T0>(),
            no_pool        : 0x2::balance::zero<T0>(),
            yes_deposits   : 0,
            no_deposits    : 0,
            positions      : 0x2::table::new<address, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position>(arg9),
            resolved       : false,
            voided         : false,
            outcome        : 0,
            resolved_price : 0,
            resolved_at    : 0,
            resolver       : @0x0,
            fees           : 0x2::balance::zero<T0>(),
            resolve_pool   : 0,
            total_volume   : 0,
            trade_count    : 0,
        }
    }

    public(friend) fun collect_fees<T0>(arg0: &mut Market<T0>) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.fees)
    }

    public(friend) fun created_at<T0>(arg0: &Market<T0>) : u64 {
        arg0.created_at
    }

    public(friend) fun deadline<T0>(arg0: &Market<T0>) : u64 {
        arg0.deadline
    }

    public(friend) fun duration<T0>(arg0: &Market<T0>) : u8 {
        arg0.duration
    }

    fun ensure_position<T0>(arg0: &mut Market<T0>, arg1: address) {
        if (!0x2::table::contains<address, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position>(&arg0.positions, arg1)) {
            0x2::table::add<address, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position>(&mut arg0.positions, arg1, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::empty());
        };
    }

    public(friend) fun execute_claim<T0>(arg0: &mut Market<T0>, arg1: address) : (u64, 0x2::balance::Balance<T0>) {
        assert!(arg0.resolved, 16);
        assert!(!arg0.voided, 10);
        assert!(0x2::table::contains<address, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position>(&arg0.positions, arg1), 18);
        let v0 = 0x2::table::borrow_mut<address, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position>(&mut arg0.positions, arg1);
        assert!(!0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::claimed(v0), 19);
        let v1 = if (arg0.outcome == 1) {
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::yes_amount(v0)
        } else {
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::no_amount(v0)
        };
        assert!(v1 > 0, 20);
        let v2 = if (arg0.outcome == 1) {
            arg0.yes_deposits
        } else {
            arg0.no_deposits
        };
        let v3 = if (arg0.outcome == 1) {
            &mut arg0.yes_pool
        } else {
            &mut arg0.no_pool
        };
        let v4 = (((v1 as u128) * (arg0.resolve_pool as u128) / (v2 as u128)) as u64);
        let v5 = if (v4 > 0x2::balance::value<T0>(v3)) {
            0x2::balance::value<T0>(v3)
        } else {
            v4
        };
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::mark_claimed(v0);
        (v1, 0x2::balance::split<T0>(v3, v5))
    }

    public(friend) fun execute_deposit<T0>(arg0: &mut Market<T0>, arg1: 0x2::balance::Balance<T0>, arg2: u8, arg3: address, arg4: u16) : (u64, u64) {
        let v0 = 0x2::balance::value<T0>(&arg1);
        let v1 = v0 * (arg4 as u64) / 10000;
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut arg1, v1));
        };
        let v2 = 0x2::balance::value<T0>(&arg1);
        if (arg2 == 0) {
            0x2::balance::join<T0>(&mut arg0.yes_pool, arg1);
            arg0.yes_deposits = arg0.yes_deposits + v2;
        } else {
            0x2::balance::join<T0>(&mut arg0.no_pool, arg1);
            arg0.no_deposits = arg0.no_deposits + v2;
        };
        ensure_position<T0>(arg0, arg3);
        if (arg2 == 0) {
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::add_yes(0x2::table::borrow_mut<address, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position>(&mut arg0.positions, arg3), v2);
        } else {
            0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::add_no(0x2::table::borrow_mut<address, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position>(&mut arg0.positions, arg3), v2);
        };
        arg0.total_volume = arg0.total_volume + v0;
        arg0.trade_count = arg0.trade_count + 1;
        (v2, v1)
    }

    public(friend) fun execute_refund<T0>(arg0: &mut Market<T0>, arg1: address) : 0x2::balance::Balance<T0> {
        assert!(arg0.voided, 17);
        assert!(0x2::table::contains<address, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position>(&arg0.positions, arg1), 18);
        let v0 = 0x2::table::borrow_mut<address, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position>(&mut arg0.positions, arg1);
        assert!(!0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::claimed(v0), 19);
        let v1 = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::yes_amount(v0);
        let v2 = 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::no_amount(v0);
        0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::mark_claimed(v0);
        let v3 = 0x2::balance::zero<T0>();
        if (v1 > 0) {
            0x2::balance::join<T0>(&mut v3, 0x2::balance::split<T0>(&mut arg0.yes_pool, v1));
        };
        if (v2 > 0) {
            0x2::balance::join<T0>(&mut v3, 0x2::balance::split<T0>(&mut arg0.no_pool, v2));
        };
        v3
    }

    public(friend) fun execute_resolve<T0>(arg0: &mut Market<T0>, arg1: u8, arg2: u64, arg3: address, arg4: u64) : u64 {
        let v0 = if (arg1 == 1) {
            let v1 = 0x2::balance::value<T0>(&arg0.no_pool) * (arg0.fee_bps as u64) / 10000;
            if (v1 > 0) {
                0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut arg0.no_pool, v1));
            };
            0x2::balance::join<T0>(&mut arg0.yes_pool, 0x2::balance::withdraw_all<T0>(&mut arg0.no_pool));
            v1
        } else {
            let v2 = 0x2::balance::value<T0>(&arg0.yes_pool) * (arg0.fee_bps as u64) / 10000;
            if (v2 > 0) {
                0x2::balance::join<T0>(&mut arg0.fees, 0x2::balance::split<T0>(&mut arg0.yes_pool, v2));
            };
            0x2::balance::join<T0>(&mut arg0.no_pool, 0x2::balance::withdraw_all<T0>(&mut arg0.yes_pool));
            v2
        };
        arg0.resolved = true;
        arg0.outcome = arg1;
        arg0.resolved_price = arg2;
        arg0.resolved_at = arg4;
        arg0.resolver = arg3;
        let v3 = if (arg1 == 1) {
            0x2::balance::value<T0>(&arg0.yes_pool)
        } else {
            0x2::balance::value<T0>(&arg0.no_pool)
        };
        arg0.resolve_pool = v3;
        v0
    }

    public(friend) fun fee_bps<T0>(arg0: &Market<T0>) : u16 {
        arg0.fee_bps
    }

    public(friend) fun fees_balance<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.fees)
    }

    public(friend) fun has_position<T0>(arg0: &Market<T0>, arg1: address) : bool {
        0x2::table::contains<address, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position>(&arg0.positions, arg1)
    }

    public(friend) fun is_resolvable<T0>(arg0: &Market<T0>, arg1: u64) : bool {
        if (!arg0.resolved) {
            if (!arg0.voided) {
                arg1 >= arg0.deadline
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun is_trading_open<T0>(arg0: &Market<T0>, arg1: u64) : bool {
        if (!arg0.resolved) {
            if (!arg0.voided) {
                arg1 < arg0.trading_cutoff
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun mark_voided<T0>(arg0: &mut Market<T0>) {
        arg0.voided = true;
    }

    public(friend) fun market_number<T0>(arg0: &Market<T0>) : u64 {
        arg0.market_number
    }

    public(friend) fun no_deposits<T0>(arg0: &Market<T0>) : u64 {
        arg0.no_deposits
    }

    public(friend) fun no_pool_value<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.no_pool)
    }

    public(friend) fun outcome<T0>(arg0: &Market<T0>) : u8 {
        arg0.outcome
    }

    public(friend) fun position<T0>(arg0: &Market<T0>, arg1: address) : &0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position {
        0x2::table::borrow<address, 0x399abdf475acdfbc50ebd6b609ed7fc22dfac34bf7b8633738c53b62ddb3c57::position::Position>(&arg0.positions, arg1)
    }

    public(friend) fun pyth_feed_id<T0>(arg0: &Market<T0>) : vector<u8> {
        arg0.pyth_feed_id
    }

    public(friend) fun resolved<T0>(arg0: &Market<T0>) : bool {
        arg0.resolved
    }

    public(friend) fun resolved_at<T0>(arg0: &Market<T0>) : u64 {
        arg0.resolved_at
    }

    public(friend) fun resolved_price<T0>(arg0: &Market<T0>) : u64 {
        arg0.resolved_price
    }

    public(friend) fun resolver<T0>(arg0: &Market<T0>) : address {
        arg0.resolver
    }

    public(friend) fun share<T0>(arg0: Market<T0>) {
        0x2::transfer::share_object<Market<T0>>(arg0);
    }

    public(friend) fun should_void<T0>(arg0: &Market<T0>, arg1: u64) : bool {
        if (0x2::balance::value<T0>(&arg0.yes_pool) == 0) {
            true
        } else if (0x2::balance::value<T0>(&arg0.no_pool) == 0) {
            true
        } else {
            0x2::balance::value<T0>(&arg0.yes_pool) + 0x2::balance::value<T0>(&arg0.no_pool) < arg1
        }
    }

    public(friend) fun sweep_remaining<T0>(arg0: &mut Market<T0>) : 0x2::balance::Balance<T0> {
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.yes_pool);
        0x2::balance::join<T0>(&mut v0, 0x2::balance::withdraw_all<T0>(&mut arg0.no_pool));
        v0
    }

    public(friend) fun target_price<T0>(arg0: &Market<T0>) : u64 {
        arg0.target_price
    }

    public(friend) fun token_symbol<T0>(arg0: &Market<T0>) : 0x1::string::String {
        arg0.token_symbol
    }

    public(friend) fun total_volume<T0>(arg0: &Market<T0>) : u64 {
        arg0.total_volume
    }

    public(friend) fun trade_count<T0>(arg0: &Market<T0>) : u64 {
        arg0.trade_count
    }

    public(friend) fun trading_cutoff<T0>(arg0: &Market<T0>) : u64 {
        arg0.trading_cutoff
    }

    public(friend) fun uid<T0>(arg0: &Market<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun voided<T0>(arg0: &Market<T0>) : bool {
        arg0.voided
    }

    public(friend) fun yes_deposits<T0>(arg0: &Market<T0>) : u64 {
        arg0.yes_deposits
    }

    public(friend) fun yes_pool_value<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.yes_pool)
    }

    // decompiled from Move bytecode v6
}

