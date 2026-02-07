module 0x97707e69599fe95a22ae4bfa726491ef7c837a71ac72d6a699c748be8fe61dbd::market {
    struct Market<phantom T0> has key {
        id: 0x2::object::UID,
        proof_id: 0x1::string::String,
        creator: address,
        question: 0x1::string::String,
        token_symbol: 0x1::string::String,
        pyth_feed_id: vector<u8>,
        target_price: u64,
        direction: u8,
        deadline_ms: u64,
        betting_closes_ms: u64,
        yes_pool: 0x2::balance::Balance<T0>,
        no_pool: 0x2::balance::Balance<T0>,
        yes_total: u64,
        no_total: u64,
        yes_count: u64,
        no_count: u64,
        status: u8,
        outcome: 0x1::option::Option<bool>,
        resolved_price: 0x1::option::Option<u64>,
        resolved_at_ms: 0x1::option::Option<u64>,
        resolver: 0x1::option::Option<address>,
        created_at_ms: u64,
    }

    public(friend) fun new<T0>(arg0: 0x1::string::String, arg1: address, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: vector<u8>, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<T0>, arg10: bool, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : Market<T0> {
        let (v0, v1, v2, v3, v4, v5) = split_initial_bet<T0>(arg9, arg10);
        Market<T0>{
            id                : 0x2::object::new(arg12),
            proof_id          : arg0,
            creator           : arg1,
            question          : arg2,
            token_symbol      : arg3,
            pyth_feed_id      : arg4,
            target_price      : arg5,
            direction         : arg6,
            deadline_ms       : arg7,
            betting_closes_ms : arg8,
            yes_pool          : v0,
            no_pool           : v1,
            yes_total         : v2,
            no_total          : v3,
            yes_count         : v4,
            no_count          : v5,
            status            : 0,
            outcome           : 0x1::option::none<bool>(),
            resolved_price    : 0x1::option::none<u64>(),
            resolved_at_ms    : 0x1::option::none<u64>(),
            resolver          : 0x1::option::none<address>(),
            created_at_ms     : arg11,
        }
    }

    public(friend) fun add_bet<T0>(arg0: &mut Market<T0>, arg1: 0x2::coin::Coin<T0>, arg2: bool) : u64 {
        let v0 = 0x2::coin::value<T0>(&arg1);
        if (arg2) {
            0x2::balance::join<T0>(&mut arg0.yes_pool, 0x2::coin::into_balance<T0>(arg1));
            arg0.yes_total = arg0.yes_total + v0;
            arg0.yes_count = arg0.yes_count + 1;
        } else {
            0x2::balance::join<T0>(&mut arg0.no_pool, 0x2::coin::into_balance<T0>(arg1));
            arg0.no_total = arg0.no_total + v0;
            arg0.no_count = arg0.no_count + 1;
        };
        v0
    }

    public(friend) fun betting_closes_ms<T0>(arg0: &Market<T0>) : u64 {
        arg0.betting_closes_ms
    }

    public(friend) fun created_at_ms<T0>(arg0: &Market<T0>) : u64 {
        arg0.created_at_ms
    }

    public(friend) fun creator<T0>(arg0: &Market<T0>) : address {
        arg0.creator
    }

    public(friend) fun deadline_ms<T0>(arg0: &Market<T0>) : u64 {
        arg0.deadline_ms
    }

    public(friend) fun determine_outcome(arg0: u64, arg1: u64, arg2: u8) : bool {
        arg2 == 0 && arg0 >= arg1 || arg0 <= arg1
    }

    public(friend) fun direction<T0>(arg0: &Market<T0>) : u8 {
        arg0.direction
    }

    public(friend) fun is_betting_open<T0>(arg0: &Market<T0>, arg1: u64) : bool {
        arg0.status == 0 && arg1 < arg0.betting_closes_ms
    }

    public(friend) fun is_resolvable<T0>(arg0: &Market<T0>, arg1: u64) : bool {
        arg0.status == 0 && arg1 >= arg0.deadline_ms
    }

    public(friend) fun no_count<T0>(arg0: &Market<T0>) : u64 {
        arg0.no_count
    }

    public(friend) fun no_total<T0>(arg0: &Market<T0>) : u64 {
        arg0.no_total
    }

    public(friend) fun outcome<T0>(arg0: &Market<T0>) : 0x1::option::Option<bool> {
        arg0.outcome
    }

    public(friend) fun proof_id<T0>(arg0: &Market<T0>) : 0x1::string::String {
        arg0.proof_id
    }

    public(friend) fun pyth_feed_id<T0>(arg0: &Market<T0>) : vector<u8> {
        arg0.pyth_feed_id
    }

    public(friend) fun question<T0>(arg0: &Market<T0>) : 0x1::string::String {
        arg0.question
    }

    public(friend) fun remaining_pool<T0>(arg0: &Market<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.yes_pool)
    }

    public(friend) fun resolve_market<T0>(arg0: &mut Market<T0>, arg1: bool, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, u64) {
        0x2::balance::join<T0>(&mut arg0.yes_pool, 0x2::balance::withdraw_all<T0>(&mut arg0.no_pool));
        let v0 = 0x2::balance::value<T0>(&arg0.yes_pool);
        arg0.status = 1;
        arg0.outcome = 0x1::option::some<bool>(arg1);
        arg0.resolved_price = 0x1::option::some<u64>(arg2);
        arg0.resolved_at_ms = 0x1::option::some<u64>(arg4);
        arg0.resolver = 0x1::option::some<address>(arg3);
        (0x2::balance::split<T0>(&mut arg0.yes_pool, v0 * arg5 / 10000), 0x2::balance::split<T0>(&mut arg0.yes_pool, v0 * arg6 / 10000), 0x2::balance::split<T0>(&mut arg0.yes_pool, v0 * arg7 / 10000), v0)
    }

    public(friend) fun resolved_at_ms<T0>(arg0: &Market<T0>) : 0x1::option::Option<u64> {
        arg0.resolved_at_ms
    }

    public(friend) fun resolved_price<T0>(arg0: &Market<T0>) : 0x1::option::Option<u64> {
        arg0.resolved_price
    }

    public(friend) fun resolver<T0>(arg0: &Market<T0>) : 0x1::option::Option<address> {
        arg0.resolver
    }

    public(friend) fun share<T0>(arg0: Market<T0>) {
        0x2::transfer::share_object<Market<T0>>(arg0);
    }

    public(friend) fun should_auto_void<T0>(arg0: &Market<T0>) : bool {
        let v0 = arg0.yes_total + arg0.no_total;
        if (v0 == 0) {
            return true
        };
        if (arg0.yes_total == 0 || arg0.no_total == 0) {
            return true
        };
        let v1 = if (arg0.yes_total > arg0.no_total) {
            arg0.yes_total
        } else {
            arg0.no_total
        };
        v1 * 10000 / v0 >= 9500
    }

    fun split_initial_bet<T0>(arg0: 0x2::coin::Coin<T0>, arg1: bool) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, u64, u64, u64, u64) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T0>();
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        if (arg1) {
            0x2::balance::join<T0>(&mut v0, 0x2::coin::into_balance<T0>(arg0));
            v2 = 0x2::coin::value<T0>(&arg0);
            v4 = 1;
        } else {
            0x2::balance::join<T0>(&mut v1, 0x2::coin::into_balance<T0>(arg0));
            v3 = 0x2::coin::value<T0>(&arg0);
            v5 = 1;
        };
        (v0, v1, v2, v3, v4, v5)
    }

    public(friend) fun status<T0>(arg0: &Market<T0>) : u8 {
        arg0.status
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

    public(friend) fun uid<T0>(arg0: &Market<T0>) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun void_market<T0>(arg0: &mut Market<T0>) {
        arg0.status = 2;
    }

    public(friend) fun winning_total<T0>(arg0: &Market<T0>) : u64 {
        if (0x1::option::destroy_some<bool>(arg0.outcome)) {
            arg0.yes_total
        } else {
            arg0.no_total
        }
    }

    public(friend) fun withdraw_payout<T0>(arg0: &mut Market<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(&mut arg0.yes_pool, arg1)
    }

    public(friend) fun withdraw_refund<T0>(arg0: &mut Market<T0>, arg1: u64, arg2: bool) : 0x2::balance::Balance<T0> {
        if (arg2) {
            0x2::balance::split<T0>(&mut arg0.yes_pool, arg1)
        } else {
            0x2::balance::split<T0>(&mut arg0.no_pool, arg1)
        }
    }

    public(friend) fun yes_count<T0>(arg0: &Market<T0>) : u64 {
        arg0.yes_count
    }

    public(friend) fun yes_total<T0>(arg0: &Market<T0>) : u64 {
        arg0.yes_total
    }

    // decompiled from Move bytecode v6
}

