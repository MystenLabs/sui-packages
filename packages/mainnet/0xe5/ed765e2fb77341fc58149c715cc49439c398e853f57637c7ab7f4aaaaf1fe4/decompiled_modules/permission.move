module 0xf2ef30fcf908952540c0efb5575e4c12b34df7f144e875b9f0eb56577cf8800b::permission {
    struct Policy has store {
        owner: address,
        agent: address,
        max_bet: u64,
        max_week: u64,
        starts_ms: u64,
        expires_ms: u64,
        paused: bool,
        week: u64,
        spent: u64,
        total_spent: u64,
        bets: u64,
    }

    public fun agent(arg0: &Policy) : address {
        arg0.agent
    }

    public(friend) fun assert_owner(arg0: &Policy, arg1: address) {
        assert!(arg1 == arg0.owner, 1);
    }

    public fun bets(arg0: &Policy) : u64 {
        arg0.bets
    }

    public(friend) fun create(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : Policy {
        let v0 = if (arg1 != @0x0) {
            if (arg1 != arg0) {
                if (arg2 > 0) {
                    arg3 >= arg2
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 7);
        assert!(arg4 > arg5, 4);
        assert!(arg4 - arg5 <= 2592000000, 8);
        Policy{
            owner       : arg0,
            agent       : arg1,
            max_bet     : arg2,
            max_week    : arg3,
            starts_ms   : arg5,
            expires_ms  : arg4,
            paused      : false,
            week        : 0,
            spent       : 0,
            total_spent : 0,
            bets        : 0,
        }
    }

    public(friend) fun debit(arg0: &mut Policy, arg1: address, arg2: u64, arg3: u64) {
        assert!(arg1 == arg0.agent, 2);
        assert!(!arg0.paused, 3);
        assert!(arg3 >= arg0.starts_ms && arg3 < arg0.expires_ms, 4);
        assert!(arg2 > 0 && arg2 <= arg0.max_bet, 5);
        let v0 = (arg3 - arg0.starts_ms) / 604800000;
        if (v0 > arg0.week) {
            arg0.week = v0;
            arg0.spent = 0;
        };
        assert!(arg2 <= arg0.max_week - arg0.spent, 6);
        arg0.spent = arg0.spent + arg2;
        arg0.total_spent = arg0.total_spent + arg2;
        arg0.bets = arg0.bets + 1;
    }

    public fun expires_ms(arg0: &Policy) : u64 {
        arg0.expires_ms
    }

    public fun left(arg0: &Policy, arg1: u64) : u64 {
        let v0 = if (arg0.paused) {
            true
        } else if (arg1 < arg0.starts_ms) {
            true
        } else {
            arg1 >= arg0.expires_ms
        };
        if (v0) {
            return 0
        };
        if ((arg1 - arg0.starts_ms) / 604800000 > arg0.week) {
            arg0.max_week
        } else {
            arg0.max_week - arg0.spent
        }
    }

    public fun max_bet(arg0: &Policy) : u64 {
        arg0.max_bet
    }

    public fun max_week(arg0: &Policy) : u64 {
        arg0.max_week
    }

    public fun owner(arg0: &Policy) : address {
        arg0.owner
    }

    public(friend) fun pause(arg0: &mut Policy, arg1: address) {
        assert_owner(arg0, arg1);
        arg0.paused = true;
    }

    public fun paused(arg0: &Policy) : bool {
        arg0.paused
    }

    public(friend) fun resume(arg0: &mut Policy, arg1: address, arg2: u64) {
        assert_owner(arg0, arg1);
        assert!(arg2 < arg0.expires_ms, 4);
        arg0.paused = false;
    }

    public fun starts_ms(arg0: &Policy) : u64 {
        arg0.starts_ms
    }

    public fun total_spent(arg0: &Policy) : u64 {
        arg0.total_spent
    }

    // decompiled from Move bytecode v7
}

