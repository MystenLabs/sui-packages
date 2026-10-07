module 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::dividends {
    struct Pool<phantom T0, phantom T1> has store {
        quote: 0x2::balance::Balance<T1>,
        tokens: 0x2::balance::Balance<T0>,
        next_round: u64,
        open_rounds: u64,
        paid_in_quote: u64,
        paid_in_tokens: u64,
        paid_out_quote: u64,
        paid_out_tokens: u64,
        mark_quote: u64,
        mark_tokens: u64,
        last_post_ms: 0x1::option::Option<u64>,
        first_credit_ms: 0x1::option::Option<u64>,
        last_burn_ms: 0x1::option::Option<u64>,
        burned_quote: u64,
        burned_tokens: u64,
        period_end_ms: u64,
    }

    struct Round<phantom T0, phantom T1> has store {
        root: vector<u8>,
        leaves: u64,
        quote: 0x2::balance::Balance<T1>,
        tokens: 0x2::balance::Balance<T0>,
        total_quote: u64,
        total_tokens: u64,
        ready_ms: u64,
        expires_ms: u64,
        period_start_ms: u64,
        period_end_ms: u64,
        generation: u64,
        fresh_quote: u64,
        fresh_tokens: u64,
        paid: vector<u64>,
        paid_count: u64,
    }

    public(friend) fun assert_lengths(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = if (arg1 == arg0) {
            if (arg2 == arg0) {
                if (arg3 == arg0) {
                    arg4 == arg0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 207);
    }

    public fun available<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x2::balance::value<T1>(&arg0.quote), 0x2::balance::value<T0>(&arg0.tokens))
    }

    public fun burned_totals<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (arg0.burned_quote, arg0.burned_tokens)
    }

    public(friend) fun cancel<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: Round<T0, T1>, arg2: u64, arg3: u64) {
        assert!(arg3 < arg1.ready_ms || arg1.generation != arg2, 209);
        give_back<T0, T1>(arg0, &arg1);
        unwind<T0, T1>(arg0, arg1);
    }

    public(friend) fun cancel_in_review<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: Round<T0, T1>, arg2: u64) {
        assert!(arg2 < arg1.ready_ms, 209);
        give_back<T0, T1>(arg0, &arg1);
        unwind<T0, T1>(arg0, arg1);
    }

    fun cap(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = 0x1::u64::min(arg1, arg0);
        v0 + ((((arg0 - v0) as u128) * (arg2 as u128) / (10000 as u128)) as u64)
    }

    public fun claim_window_ms() : u64 {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::claim_window_ms()
    }

    public(friend) fun close<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: Round<T0, T1>, arg2: u64, arg3: u64) {
        if (arg1.generation != arg2) {
            give_back<T0, T1>(arg0, &arg1);
            unwind<T0, T1>(arg0, arg1);
            return
        };
        assert!(arg3 >= arg1.expires_ms || arg1.paid_count == arg1.leaves, 208);
        unwind<T0, T1>(arg0, arg1);
    }

    public(friend) fun deposit_quote<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: u64) {
        if (0x2::balance::value<T1>(&arg1) > 0 && 0x1::option::is_none<u64>(&arg0.first_credit_ms)) {
            arg0.first_credit_ms = 0x1::option::some<u64>(arg2);
        };
        arg0.paid_in_quote = arg0.paid_in_quote + 0x2::balance::value<T1>(&arg1);
        0x2::balance::join<T1>(&mut arg0.quote, arg1);
    }

    public(friend) fun deposit_tokens<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: u64) {
        if (0x2::balance::value<T0>(&arg1) > 0 && 0x1::option::is_none<u64>(&arg0.first_credit_ms)) {
            arg0.first_credit_ms = 0x1::option::some<u64>(arg2);
        };
        arg0.paid_in_tokens = arg0.paid_in_tokens + 0x2::balance::value<T0>(&arg1);
        0x2::balance::join<T0>(&mut arg0.tokens, arg1);
    }

    public fun fresh_held<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64) {
        (0x1::u64::min(arg0.paid_in_quote - arg0.mark_quote, 0x2::balance::value<T1>(&arg0.quote)), 0x1::u64::min(arg0.paid_in_tokens - arg0.mark_tokens, 0x2::balance::value<T0>(&arg0.tokens)))
    }

    fun give_back<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &Round<T0, T1>) {
        arg0.mark_quote = arg0.mark_quote - 0x1::u64::min(arg1.fresh_quote, 0x2::balance::value<T1>(&arg1.quote));
        arg0.mark_tokens = arg0.mark_tokens - 0x1::u64::min(arg1.fresh_tokens, 0x2::balance::value<T0>(&arg1.tokens));
        if (arg1.paid_count == 0 && arg0.period_end_ms == arg1.period_end_ms) {
            arg0.period_end_ms = arg1.period_start_ms;
        };
    }

    public fun idle<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : bool {
        if (0x2::balance::value<T1>(&arg0.quote) == 0 && 0x2::balance::value<T0>(&arg0.tokens) == 0) {
            return false
        };
        let v0 = if (0x1::option::is_some<u64>(&arg0.last_post_ms)) {
            *0x1::option::borrow<u64>(&arg0.last_post_ms)
        } else if (0x1::option::is_some<u64>(&arg0.first_credit_ms)) {
            *0x1::option::borrow<u64>(&arg0.first_credit_ms)
        } else {
            return false
        };
        if (arg1 < v0 + arg2) {
            return false
        };
        0x1::option::is_none<u64>(&arg0.last_burn_ms) || arg1 >= *0x1::option::borrow<u64>(&arg0.last_burn_ms) + arg3
    }

    public fun leaf_hash(arg0: address, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: u64) : vector<u8> {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg5));
        0x2::hash::blake2b256(&v0)
    }

    fun lt(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return *0x1::vector::borrow<u8>(arg0, v0) < *0x1::vector::borrow<u8>(arg1, v0)
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun max_period_lag_ms() : u64 {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::max_period_lag_ms()
    }

    public fun min_period_ms() : u64 {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::min_period_ms()
    }

    public fun min_review_ms() : u64 {
        0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::min_review_ms()
    }

    public(friend) fun new<T0, T1>(arg0: u64) : Pool<T0, T1> {
        Pool<T0, T1>{
            quote           : 0x2::balance::zero<T1>(),
            tokens          : 0x2::balance::zero<T0>(),
            next_round      : 0,
            open_rounds     : 0,
            paid_in_quote   : 0,
            paid_in_tokens  : 0,
            paid_out_quote  : 0,
            paid_out_tokens : 0,
            mark_quote      : 0,
            mark_tokens     : 0,
            last_post_ms    : 0x1::option::none<u64>(),
            first_credit_ms : 0x1::option::none<u64>(),
            last_burn_ms    : 0x1::option::none<u64>(),
            burned_quote    : 0,
            burned_tokens   : 0,
            period_end_ms   : arg0,
        }
    }

    public fun next_round<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.next_round
    }

    public fun node_hash(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = x"01";
        if (lt(&arg0, &arg1)) {
            0x1::vector::append<u8>(&mut v0, arg0);
            0x1::vector::append<u8>(&mut v0, arg1);
        } else {
            0x1::vector::append<u8>(&mut v0, arg1);
            0x1::vector::append<u8>(&mut v0, arg0);
        };
        0x2::hash::blake2b256(&v0)
    }

    public fun open_rounds<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.open_rounds
    }

    public(friend) fun pay<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &mut Round<T0, T1>, arg2: address, arg3: u64, arg4: u64, arg5: address, arg6: u64, arg7: u64, arg8: &vector<vector<u8>>, arg9: u64, arg10: u64) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        assert!(arg1.generation == arg9, 212);
        assert!(arg10 >= arg1.ready_ms, 202);
        assert!(arg10 < arg1.expires_ms, 203);
        assert!(arg4 < arg1.leaves, 206);
        let v0 = arg4 / 64;
        let v1 = 1 << ((arg4 % 64) as u8);
        assert!(*0x1::vector::borrow<u64>(&arg1.paid, v0) & v1 == 0, 204);
        assert!(verify(&arg1.root, leaf_hash(arg2, arg3, arg4, arg5, arg6, arg7), arg8), 205);
        *0x1::vector::borrow_mut<u64>(&mut arg1.paid, v0) = *0x1::vector::borrow<u64>(&arg1.paid, v0) | v1;
        arg1.paid_count = arg1.paid_count + 1;
        arg0.paid_out_quote = arg0.paid_out_quote + arg6;
        arg0.paid_out_tokens = arg0.paid_out_tokens + arg7;
        (0x2::balance::split<T1>(&mut arg1.quote, arg6), 0x2::balance::split<T0>(&mut arg1.tokens, arg7))
    }

    public fun period_end_ms<T0, T1>(arg0: &Pool<T0, T1>) : u64 {
        arg0.period_end_ms
    }

    public(friend) fun post<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64) : (u64, Round<T0, T1>) {
        assert!(arg0.open_rounds < 4, 213);
        assert!(arg5 >= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::min_review_ms(), 211);
        assert!(0x1::vector::length<u8>(&arg1) == 32, 200);
        assert!(arg2 > 0 && arg2 <= 200000, 206);
        assert!(arg3 > 0 || arg4 > 0, 210);
        let v0 = if (arg8 == arg0.period_end_ms) {
            if (arg9 > arg8) {
                arg9 <= arg10
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 214);
        assert!(arg9 - arg8 >= 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::min_period_ms(), 216);
        assert!(arg9 + 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::max_period_lag_ms() >= arg10, 215);
        let (v1, v2) = postable<T0, T1>(arg0, arg6);
        assert!(arg3 <= v1 && arg4 <= v2, 201);
        let v3 = arg0.next_round;
        arg0.next_round = v3 + 1;
        arg0.open_rounds = arg0.open_rounds + 1;
        let v4 = 0x1::u64::min(arg3, arg0.paid_in_quote - arg0.mark_quote);
        let v5 = 0x1::u64::min(arg4, arg0.paid_in_tokens - arg0.mark_tokens);
        arg0.mark_quote = arg0.mark_quote + v4;
        arg0.mark_tokens = arg0.mark_tokens + v5;
        arg0.last_post_ms = 0x1::option::some<u64>(arg10);
        arg0.period_end_ms = arg9;
        let v6 = vector[];
        let v7 = 0;
        while (v7 < (arg2 + 63) / 64) {
            0x1::vector::push_back<u64>(&mut v6, 0);
            v7 = v7 + 1;
        };
        let v8 = arg10 + arg5;
        let v9 = Round<T0, T1>{
            root            : arg1,
            leaves          : arg2,
            quote           : 0x2::balance::split<T1>(&mut arg0.quote, arg3),
            tokens          : 0x2::balance::split<T0>(&mut arg0.tokens, arg4),
            total_quote     : arg3,
            total_tokens    : arg4,
            ready_ms        : v8,
            expires_ms      : v8 + 0x11ad231f4732251bac2bfc7cd8637103d41da1d2389257b40ef0c46d71fdffa8::params::claim_window_ms(),
            period_start_ms : arg8,
            period_end_ms   : arg9,
            generation      : arg7,
            fresh_quote     : v4,
            fresh_tokens    : v5,
            paid            : v6,
            paid_count      : 0,
        };
        (v3, v9)
    }

    public fun postable<T0, T1>(arg0: &Pool<T0, T1>, arg1: u64) : (u64, u64) {
        (cap(0x2::balance::value<T1>(&arg0.quote), arg0.paid_in_quote - arg0.mark_quote, arg1), cap(0x2::balance::value<T0>(&arg0.tokens), arg0.paid_in_tokens - arg0.mark_tokens, arg1))
    }

    public fun round_fresh<T0, T1>(arg0: &Round<T0, T1>) : (u64, u64) {
        (arg0.fresh_quote, arg0.fresh_tokens)
    }

    public fun round_generation<T0, T1>(arg0: &Round<T0, T1>) : u64 {
        arg0.generation
    }

    public fun round_info<T0, T1>(arg0: &Round<T0, T1>) : (vector<u8>, u64, u64, u64, u64, u64, u64, u64) {
        (arg0.root, arg0.leaves, arg0.total_quote, arg0.total_tokens, 0x2::balance::value<T1>(&arg0.quote), 0x2::balance::value<T0>(&arg0.tokens), arg0.ready_ms, arg0.expires_ms)
    }

    public fun round_paid<T0, T1>(arg0: &Round<T0, T1>, arg1: u64) : bool {
        arg1 < arg0.leaves && *0x1::vector::borrow<u64>(&arg0.paid, arg1 / 64) & 1 << ((arg1 % 64) as u8) != 0
    }

    public fun round_paid_count<T0, T1>(arg0: &Round<T0, T1>) : u64 {
        arg0.paid_count
    }

    public fun round_period<T0, T1>(arg0: &Round<T0, T1>) : (u64, u64) {
        (arg0.period_start_ms, arg0.period_end_ms)
    }

    public(friend) fun skip_period<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = arg0.period_end_ms;
        assert!(arg1 > v0 && arg1 <= arg3, 214);
        let (v1, v2) = postable<T0, T1>(arg0, arg2);
        assert!(v1 == 0 && v2 == 0, 217);
        arg0.period_end_ms = arg1;
        v0
    }

    public(friend) fun take_idle<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: u64, arg2: u64) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        arg0.last_burn_ms = 0x1::option::some<u64>(arg2);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg0.tokens);
        arg0.burned_quote = arg0.burned_quote + arg1;
        arg0.burned_tokens = arg0.burned_tokens + 0x2::balance::value<T0>(&v0);
        (0x2::balance::split<T1>(&mut arg0.quote, arg1), v0)
    }

    public fun times<T0, T1>(arg0: &Pool<T0, T1>) : (0x1::option::Option<u64>, 0x1::option::Option<u64>, 0x1::option::Option<u64>) {
        (arg0.last_post_ms, arg0.first_credit_ms, arg0.last_burn_ms)
    }

    public fun totals<T0, T1>(arg0: &Pool<T0, T1>) : (u64, u64, u64, u64) {
        (arg0.paid_in_quote, arg0.paid_in_tokens, arg0.paid_out_quote, arg0.paid_out_tokens)
    }

    fun unwind<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: Round<T0, T1>) {
        let Round {
            root            : _,
            leaves          : _,
            quote           : v2,
            tokens          : v3,
            total_quote     : _,
            total_tokens    : _,
            ready_ms        : _,
            expires_ms      : _,
            period_start_ms : _,
            period_end_ms   : _,
            generation      : _,
            fresh_quote     : _,
            fresh_tokens    : _,
            paid            : _,
            paid_count      : _,
        } = arg1;
        arg0.open_rounds = arg0.open_rounds - 1;
        0x2::balance::join<T1>(&mut arg0.quote, v2);
        0x2::balance::join<T0>(&mut arg0.tokens, v3);
    }

    fun verify(arg0: &vector<u8>, arg1: vector<u8>, arg2: &vector<vector<u8>>) : bool {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(arg2)) {
            assert!(0x1::vector::length<u8>(0x1::vector::borrow<vector<u8>>(arg2, v1)) == 32, 205);
            let v2 = v0;
            v0 = node_hash(v2, *0x1::vector::borrow<vector<u8>>(arg2, v1));
            v1 = v1 + 1;
        };
        &v0 == arg0
    }

    // decompiled from Move bytecode v7
}

