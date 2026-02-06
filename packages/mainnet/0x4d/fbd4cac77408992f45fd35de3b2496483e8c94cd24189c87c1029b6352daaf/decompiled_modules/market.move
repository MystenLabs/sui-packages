module 0x4dfbd4cac77408992f45fd35de3b2496483e8c94cd24189c87c1029b6352daaf::market {
    struct Market has key {
        id: 0x2::object::UID,
        market_type: u8,
        proof_id: 0x1::string::String,
        creator: address,
        proof_creator: address,
        question: 0x1::string::String,
        token_symbol: 0x1::string::String,
        pyth_feed_id: vector<u8>,
        target_price: u64,
        direction: u8,
        deadline_ms: u64,
        betting_closes_ms: u64,
        designated_resolver: 0x1::option::Option<address>,
        yes_pool: 0x2::balance::Balance<0x2::sui::SUI>,
        no_pool: 0x2::balance::Balance<0x2::sui::SUI>,
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

    public(friend) fun add_bet(arg0: &mut Market, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: bool) : u64 {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        if (arg2) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.yes_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
            arg0.yes_total = arg0.yes_total + v0;
            arg0.yes_count = arg0.yes_count + 1;
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.no_pool, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
            arg0.no_total = arg0.no_total + v0;
            arg0.no_count = arg0.no_count + 1;
        };
        v0
    }

    public(friend) fun betting_closes_ms(arg0: &Market) : u64 {
        arg0.betting_closes_ms
    }

    public(friend) fun created_at_ms(arg0: &Market) : u64 {
        arg0.created_at_ms
    }

    public(friend) fun creator(arg0: &Market) : address {
        arg0.creator
    }

    public(friend) fun deadline_ms(arg0: &Market) : u64 {
        arg0.deadline_ms
    }

    public(friend) fun designated_resolver(arg0: &Market) : 0x1::option::Option<address> {
        arg0.designated_resolver
    }

    public(friend) fun determine_outcome(arg0: u64, arg1: u64, arg2: u8) : bool {
        arg2 == 0 && arg0 >= arg1 || arg0 <= arg1
    }

    public(friend) fun direction(arg0: &Market) : u8 {
        arg0.direction
    }

    public(friend) fun is_betting_open(arg0: &Market, arg1: u64) : bool {
        arg0.status == 0 && arg1 < arg0.betting_closes_ms
    }

    public(friend) fun is_manually_resolvable(arg0: &Market, arg1: u64) : bool {
        arg0.status == 0 && arg1 >= arg0.deadline_ms
    }

    public(friend) fun is_resolvable(arg0: &Market, arg1: u64) : bool {
        if (arg0.status == 0) {
            if (arg1 >= arg0.deadline_ms) {
                arg1 <= arg0.deadline_ms + 172800000
            } else {
                false
            }
        } else {
            false
        }
    }

    public(friend) fun market_type(arg0: &Market) : u8 {
        arg0.market_type
    }

    public(friend) fun new_manual(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: address, arg7: 0x2::coin::Coin<0x2::sui::SUI>, arg8: bool, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : Market {
        let (v0, v1, v2, v3, v4, v5) = split_initial_bet(arg7, arg8);
        Market{
            id                  : 0x2::object::new(arg10),
            market_type         : 1,
            proof_id            : arg0,
            creator             : arg1,
            proof_creator       : arg2,
            question            : arg3,
            token_symbol        : 0x1::string::utf8(b""),
            pyth_feed_id        : b"",
            target_price        : 0,
            direction           : 0,
            deadline_ms         : arg4,
            betting_closes_ms   : arg5,
            designated_resolver : 0x1::option::some<address>(arg6),
            yes_pool            : v0,
            no_pool             : v1,
            yes_total           : v2,
            no_total            : v3,
            yes_count           : v4,
            no_count            : v5,
            status              : 0,
            outcome             : 0x1::option::none<bool>(),
            resolved_price      : 0x1::option::none<u64>(),
            resolved_at_ms      : 0x1::option::none<u64>(),
            resolver            : 0x1::option::none<address>(),
            created_at_ms       : arg9,
        }
    }

    public(friend) fun new_oracle(arg0: 0x1::string::String, arg1: address, arg2: address, arg3: 0x1::string::String, arg4: vector<u8>, arg5: u64, arg6: u8, arg7: u64, arg8: u64, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: bool, arg11: u64, arg12: &mut 0x2::tx_context::TxContext) : Market {
        let (v0, v1, v2, v3, v4, v5) = split_initial_bet(arg9, arg10);
        Market{
            id                  : 0x2::object::new(arg12),
            market_type         : 0,
            proof_id            : arg0,
            creator             : arg1,
            proof_creator       : arg2,
            question            : 0x1::string::utf8(b""),
            token_symbol        : arg3,
            pyth_feed_id        : arg4,
            target_price        : arg5,
            direction           : arg6,
            deadline_ms         : arg7,
            betting_closes_ms   : arg8,
            designated_resolver : 0x1::option::none<address>(),
            yes_pool            : v0,
            no_pool             : v1,
            yes_total           : v2,
            no_total            : v3,
            yes_count           : v4,
            no_count            : v5,
            status              : 0,
            outcome             : 0x1::option::none<bool>(),
            resolved_price      : 0x1::option::none<u64>(),
            resolved_at_ms      : 0x1::option::none<u64>(),
            resolver            : 0x1::option::none<address>(),
            created_at_ms       : arg11,
        }
    }

    public(friend) fun no_count(arg0: &Market) : u64 {
        arg0.no_count
    }

    public(friend) fun no_total(arg0: &Market) : u64 {
        arg0.no_total
    }

    public(friend) fun outcome(arg0: &Market) : 0x1::option::Option<bool> {
        arg0.outcome
    }

    public(friend) fun proof_creator(arg0: &Market) : address {
        arg0.proof_creator
    }

    public(friend) fun proof_id(arg0: &Market) : 0x1::string::String {
        arg0.proof_id
    }

    public(friend) fun pyth_feed_id(arg0: &Market) : vector<u8> {
        arg0.pyth_feed_id
    }

    public(friend) fun question(arg0: &Market) : 0x1::string::String {
        arg0.question
    }

    public(friend) fun remaining_pool(arg0: &Market) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.yes_pool)
    }

    public(friend) fun resolve_market(arg0: &mut Market, arg1: bool, arg2: u64, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>, u64) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.yes_pool, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.no_pool));
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.yes_pool);
        arg0.status = 1;
        arg0.outcome = 0x1::option::some<bool>(arg1);
        arg0.resolved_price = 0x1::option::some<u64>(arg2);
        arg0.resolved_at_ms = 0x1::option::some<u64>(arg4);
        arg0.resolver = 0x1::option::some<address>(arg3);
        (0x2::balance::split<0x2::sui::SUI>(&mut arg0.yes_pool, v0 * arg5 / 10000), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.yes_pool, v0 * arg6 / 10000), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.yes_pool, v0 * arg7 / 10000), v0)
    }

    public(friend) fun resolved_at_ms(arg0: &Market) : 0x1::option::Option<u64> {
        arg0.resolved_at_ms
    }

    public(friend) fun resolved_price(arg0: &Market) : 0x1::option::Option<u64> {
        arg0.resolved_price
    }

    public(friend) fun resolver(arg0: &Market) : 0x1::option::Option<address> {
        arg0.resolver
    }

    public(friend) fun share(arg0: Market) {
        0x2::transfer::share_object<Market>(arg0);
    }

    public(friend) fun should_auto_void(arg0: &Market) : bool {
        let v0 = arg0.yes_total + arg0.no_total;
        if (v0 == 0) {
            return true
        };
        let v1 = if (arg0.yes_total > arg0.no_total) {
            arg0.yes_total
        } else {
            arg0.no_total
        };
        v1 * 10000 / v0 >= 9500
    }

    fun split_initial_bet(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: bool) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<0x2::sui::SUI>, u64, u64, u64, u64) {
        let v0 = 0x2::balance::zero<0x2::sui::SUI>();
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        let v5 = 0;
        if (arg1) {
            0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
            v2 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
            v4 = 1;
        } else {
            0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::coin::into_balance<0x2::sui::SUI>(arg0));
            v3 = 0x2::coin::value<0x2::sui::SUI>(&arg0);
            v5 = 1;
        };
        (v0, v1, v2, v3, v4, v5)
    }

    public(friend) fun status(arg0: &Market) : u8 {
        arg0.status
    }

    public(friend) fun sweep_remaining(arg0: &mut Market) : 0x2::balance::Balance<0x2::sui::SUI> {
        let v0 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.yes_pool);
        0x2::balance::join<0x2::sui::SUI>(&mut v0, 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.no_pool));
        v0
    }

    public(friend) fun target_price(arg0: &Market) : u64 {
        arg0.target_price
    }

    public(friend) fun token_symbol(arg0: &Market) : 0x1::string::String {
        arg0.token_symbol
    }

    public(friend) fun uid(arg0: &Market) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun void_market(arg0: &mut Market) {
        arg0.status = 2;
    }

    public(friend) fun winning_total(arg0: &Market) : u64 {
        if (0x1::option::destroy_some<bool>(arg0.outcome)) {
            arg0.yes_total
        } else {
            arg0.no_total
        }
    }

    public(friend) fun withdraw_payout(arg0: &mut Market, arg1: u64) : 0x2::balance::Balance<0x2::sui::SUI> {
        0x2::balance::split<0x2::sui::SUI>(&mut arg0.yes_pool, arg1)
    }

    public(friend) fun withdraw_refund(arg0: &mut Market, arg1: u64, arg2: bool) : 0x2::balance::Balance<0x2::sui::SUI> {
        if (arg2) {
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.yes_pool, arg1)
        } else {
            0x2::balance::split<0x2::sui::SUI>(&mut arg0.no_pool, arg1)
        }
    }

    public(friend) fun yes_count(arg0: &Market) : u64 {
        arg0.yes_count
    }

    public(friend) fun yes_total(arg0: &Market) : u64 {
        arg0.yes_total
    }

    // decompiled from Move bytecode v6
}

