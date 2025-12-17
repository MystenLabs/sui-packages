module 0xcc3ac0c9cc23c0bcc31ec566ef4baf6f64adcee83175924030829a3f82270f37::round {
    struct Round has store {
        id: u64,
        start_at_ms: u64,
        ended_at_ms: u64,
        is_ended: bool,
        total_deployed: u64,
        rewards_deployed: u64,
        rewards_aur: u64,
        motherlode: u64,
        is_motherlode: bool,
        lucky_cumulative: 0x1::option::Option<u64>,
        lucky_block_id: 0x1::option::Option<u64>,
        block_ids: vector<u64>,
        block_total_miners: vector<u64>,
        block_total_deployed: vector<u64>,
    }

    public fun borrow_block_ids(arg0: &Round) : &vector<u64> {
        &arg0.block_ids
    }

    public(friend) fun borrow_block_info(arg0: &Round, arg1: u64) : (u64, u64) {
        let v0 = find_block_idx(&arg0.block_ids, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            let v3 = 0x1::option::extract<u64>(&mut v0);
            (*0x1::vector::borrow<u64>(&arg0.block_total_miners, v3), *0x1::vector::borrow<u64>(&arg0.block_total_deployed, v3))
        } else {
            (0, 0)
        }
    }

    public fun borrow_ended_at_ms(arg0: &Round) : u64 {
        arg0.ended_at_ms
    }

    public fun borrow_id(arg0: &Round) : u64 {
        arg0.id
    }

    public fun borrow_is_ended(arg0: &Round) : bool {
        arg0.is_ended
    }

    public fun borrow_is_motherlode(arg0: &Round) : bool {
        arg0.is_motherlode
    }

    public fun borrow_lucky_block_id(arg0: &Round) : u64 {
        *0x1::option::borrow<u64>(&arg0.lucky_block_id)
    }

    public fun borrow_lucky_cumulative(arg0: &Round) : u64 {
        *0x1::option::borrow<u64>(&arg0.lucky_cumulative)
    }

    public fun borrow_motherlode(arg0: &Round) : u64 {
        arg0.motherlode
    }

    public fun borrow_option_lucky_block_id(arg0: &Round) : 0x1::option::Option<u64> {
        arg0.lucky_block_id
    }

    public fun borrow_option_lucky_cumulative(arg0: &Round) : 0x1::option::Option<u64> {
        arg0.lucky_cumulative
    }

    public fun borrow_rewards_aur(arg0: &Round) : u64 {
        arg0.rewards_aur
    }

    public fun borrow_rewards_deployed(arg0: &Round) : u64 {
        arg0.rewards_deployed
    }

    public fun borrow_start_at_ms(arg0: &Round) : u64 {
        arg0.start_at_ms
    }

    public fun borrow_total_deployed(arg0: &Round) : u64 {
        arg0.total_deployed
    }

    public(friend) fun deploy(arg0: &mut Round, arg1: u64, arg2: u64) : u64 {
        let v0 = find_block_idx(&arg0.block_ids, arg1);
        let v1 = if (0x1::option::is_some<u64>(&v0)) {
            let v2 = 0x1::option::extract<u64>(&mut v0);
            let v3 = 0x1::vector::borrow_mut<u64>(&mut arg0.block_total_miners, v2);
            let v4 = 0x1::vector::borrow_mut<u64>(&mut arg0.block_total_deployed, v2);
            let v5 = *v4 + arg2;
            *v3 = *v3 + 1;
            *v4 = v5;
            v5
        } else {
            0x1::vector::push_back<u64>(&mut arg0.block_ids, arg1);
            0x1::vector::push_back<u64>(&mut arg0.block_total_miners, 1);
            0x1::vector::push_back<u64>(&mut arg0.block_total_deployed, arg2);
            arg2
        };
        arg0.total_deployed = arg0.total_deployed + arg2;
        v1
    }

    fun find_block_idx(arg0: &vector<u64>, arg1: u64) : 0x1::option::Option<u64> {
        let v0 = 0;
        let v1;
        while (v0 < 0x1::vector::length<u64>(arg0)) {
            if (*0x1::vector::borrow<u64>(arg0, v0) == arg1) {
                v1 = 0x1::option::some<u64>(v0);
                return v1
            };
            v0 = v0 + 1;
        };
        v1 = 0x1::option::none<u64>();
        v1
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Round {
        Round{
            id                   : arg0,
            start_at_ms          : arg2,
            ended_at_ms          : arg3,
            is_ended             : false,
            total_deployed       : 0,
            rewards_deployed     : 0,
            rewards_aur          : 0,
            motherlode           : arg1,
            is_motherlode        : false,
            lucky_cumulative     : 0x1::option::none<u64>(),
            lucky_block_id       : 0x1::option::none<u64>(),
            block_ids            : 0x1::vector::empty<u64>(),
            block_total_miners   : 0x1::vector::empty<u64>(),
            block_total_deployed : 0x1::vector::empty<u64>(),
        }
    }

    public(friend) fun set_ended_at_ms(arg0: &mut Round, arg1: u64) {
        arg0.ended_at_ms = arg1;
    }

    public(friend) fun set_is_ended(arg0: &mut Round, arg1: bool) {
        arg0.is_ended = arg1;
    }

    public(friend) fun set_is_motherlode(arg0: &mut Round, arg1: bool) {
        arg0.is_motherlode = arg1;
    }

    public(friend) fun set_lucky_block_id(arg0: &mut Round, arg1: u64) {
        0x1::option::fill<u64>(&mut arg0.lucky_block_id, arg1);
    }

    public(friend) fun set_lucky_cumulative(arg0: &mut Round, arg1: 0x1::option::Option<u64>) {
        arg0.lucky_cumulative = arg1;
    }

    public(friend) fun set_motherlode(arg0: &mut Round, arg1: u64) {
        arg0.motherlode = arg1;
    }

    public(friend) fun set_rewards_aur(arg0: &mut Round, arg1: u64) {
        arg0.rewards_aur = arg1;
    }

    public(friend) fun set_rewards_deployed(arg0: &mut Round, arg1: u64) {
        arg0.rewards_deployed = arg1;
    }

    public(friend) fun set_start_at_ms(arg0: &mut Round, arg1: u64) {
        arg0.start_at_ms = arg1;
    }

    public(friend) fun set_total_deployed(arg0: &mut Round, arg1: u64) {
        arg0.total_deployed = arg1;
    }

    // decompiled from Move bytecode v6
}

