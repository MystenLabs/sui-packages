module 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::growth_codec {
    struct BinGrowthView has copy, drop {
        fee_a: u256,
        fee_b: u256,
        rewards: vector<u256>,
        expanded: bool,
    }

    struct CheckpointView has copy, drop {
        fee_a: u256,
        fee_b: u256,
        rewards: vector<u256>,
        expanded: bool,
    }

    public fun bin_count(arg0: &BinGrowthView) : u64 {
        0x1::vector::length<u256>(&arg0.rewards)
    }

    public fun bin_expanded(arg0: &BinGrowthView) : bool {
        arg0.expanded
    }

    public fun bin_fee_a(arg0: &BinGrowthView) : u256 {
        arg0.fee_a
    }

    public fun bin_fee_b(arg0: &BinGrowthView) : u256 {
        arg0.fee_b
    }

    public fun bin_reward(arg0: &BinGrowthView, arg1: u64) : u256 {
        assert!(arg1 < 5, 1);
        if (arg1 < 0x1::vector::length<u256>(&arg0.rewards)) {
            *0x1::vector::borrow<u256>(&arg0.rewards, arg1)
        } else {
            340282366920938463463374607431768211456
        }
    }

    public fun bin_view(arg0: u128, arg1: u128, arg2: &vector<u128>) : BinGrowthView {
        let v0 = 0x1::vector::length<u128>(arg2);
        assert!(v0 <= 5 || v0 == 13, 0);
        let v1 = v0 == 13;
        let v2 = if (v1) {
            let v3 = *0x1::vector::borrow<u128>(arg2, 5);
            let v4 = ((v3 >> 56 & 255) as u64);
            assert!(v3 == 1407384670066482 | (v4 as u128) << 56 && v4 <= 5, 0);
            v4
        } else {
            v0
        };
        let v5 = vector[];
        let v6 = 0;
        while (v6 < v2) {
            let v7 = if (v1) {
                *0x1::vector::borrow<u128>(arg2, 8 + v6)
            } else {
                1
            };
            let v8 = join(v7, *0x1::vector::borrow<u128>(arg2, v6));
            valid(v8);
            0x1::vector::push_back<u256>(&mut v5, v8);
            v6 = v6 + 1;
        };
        if (v1) {
            while (v6 < 5) {
                assert!(*0x1::vector::borrow<u128>(arg2, v6) == 0 && *0x1::vector::borrow<u128>(arg2, 8 + v6) == 1, 0);
                v6 = v6 + 1;
            };
        };
        let v9 = if (v1) {
            *0x1::vector::borrow<u128>(arg2, 6)
        } else {
            1
        };
        let v10 = join(v9, arg0);
        let v11 = if (v1) {
            *0x1::vector::borrow<u128>(arg2, 7)
        } else {
            1
        };
        let v12 = join(v11, arg1);
        valid(v10);
        valid(v12);
        BinGrowthView{
            fee_a    : v10,
            fee_b    : v12,
            rewards  : v5,
            expanded : v1,
        }
    }

    public fun checkpoint_count(arg0: &CheckpointView) : u64 {
        0x1::vector::length<u256>(&arg0.rewards)
    }

    public fun checkpoint_expanded(arg0: &CheckpointView) : bool {
        arg0.expanded
    }

    public fun checkpoint_fee_a(arg0: &CheckpointView) : u256 {
        arg0.fee_a
    }

    public fun checkpoint_fee_b(arg0: &CheckpointView) : u256 {
        arg0.fee_b
    }

    public fun checkpoint_is_extended_raw(arg0: &vector<u128>) : bool {
        0x1::vector::length<u128>(arg0) == 12
    }

    public fun checkpoint_reward(arg0: &CheckpointView, arg1: u64) : u256 {
        assert!(arg1 < 5, 1);
        if (arg1 < 0x1::vector::length<u256>(&arg0.rewards)) {
            *0x1::vector::borrow<u256>(&arg0.rewards, arg1)
        } else {
            340282366920938463463374607431768211456
        }
    }

    public fun checkpoint_view(arg0: u128, arg1: u128, arg2: &vector<u128>) : CheckpointView {
        let v0 = 0x1::vector::length<u128>(arg2);
        assert!(v0 <= 5 || v0 == 12, 0);
        let v1 = v0 == 12;
        let v2 = vector[];
        let v3 = 0;
        let v4 = false;
        let v5 = if (v1) {
            5
        } else {
            v0
        };
        while (v3 < v5) {
            let v6 = if (v1) {
                *0x1::vector::borrow<u128>(arg2, 7 + v3)
            } else {
                1
            };
            let v7 = *0x1::vector::borrow<u128>(arg2, v3);
            if (v6 == 0 && v7 == 0) {
                v4 = true;
            } else {
                assert!(!v4, 0);
                let v8 = join(v6, v7);
                valid(v8);
                0x1::vector::push_back<u256>(&mut v2, v8);
            };
            v3 = v3 + 1;
        };
        let v9 = if (v1) {
            *0x1::vector::borrow<u128>(arg2, 5)
        } else {
            1
        };
        let v10 = join(v9, arg0);
        let v11 = if (v1) {
            *0x1::vector::borrow<u128>(arg2, 6)
        } else {
            1
        };
        let v12 = join(v11, arg1);
        valid(v10);
        valid(v12);
        CheckpointView{
            fee_a    : v10,
            fee_b    : v12,
            rewards  : v2,
            expanded : v1,
        }
    }

    public fun empty_checkpoint() : (u128, u128, vector<u128>) {
        (0, 0, vector[])
    }

    fun encode_bin(arg0: &BinGrowthView) : vector<u128> {
        let v0 = 0x1::vector::length<u256>(&arg0.rewards);
        let v1 = if (arg0.expanded) {
            true
        } else if (high(arg0.fee_a) != 1) {
            true
        } else {
            high(arg0.fee_b) != 1
        };
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            if (high(*0x1::vector::borrow<u256>(&arg0.rewards, v3)) != 1) {
                v2 = true;
            };
            v3 = v3 + 1;
        };
        let v4 = vector[];
        v3 = 0;
        loop {
            let v5 = if (v2) {
                5
            } else {
                v0
            };
            if (v3 < v5) {
                let v6 = if (v3 < v0) {
                    low(*0x1::vector::borrow<u256>(&arg0.rewards, v3))
                } else {
                    0
                };
                0x1::vector::push_back<u128>(&mut v4, v6);
                v3 = v3 + 1;
            } else {
                break
            };
        };
        if (v2) {
            0x1::vector::push_back<u128>(&mut v4, 1407384670066482 | (v0 as u128) << 56);
            0x1::vector::push_back<u128>(&mut v4, high(arg0.fee_a));
            0x1::vector::push_back<u128>(&mut v4, high(arg0.fee_b));
            v3 = 0;
            while (v3 < 5) {
                let v7 = if (v3 < v0) {
                    high(*0x1::vector::borrow<u256>(&arg0.rewards, v3))
                } else {
                    1
                };
                0x1::vector::push_back<u128>(&mut v4, v7);
                v3 = v3 + 1;
            };
        };
        v4
    }

    fun encode_checkpoint(arg0: &CheckpointView) : vector<u128> {
        let v0 = 0x1::vector::length<u256>(&arg0.rewards);
        let v1 = if (arg0.expanded) {
            true
        } else if (high(arg0.fee_a) != 1) {
            true
        } else {
            high(arg0.fee_b) != 1
        };
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            if (high(*0x1::vector::borrow<u256>(&arg0.rewards, v3)) != 1) {
                v2 = true;
            };
            v3 = v3 + 1;
        };
        let v4 = vector[];
        v3 = 0;
        loop {
            let v5 = if (v2) {
                5
            } else {
                v0
            };
            if (v3 < v5) {
                let v6 = if (v3 < v0) {
                    low(*0x1::vector::borrow<u256>(&arg0.rewards, v3))
                } else {
                    0
                };
                0x1::vector::push_back<u128>(&mut v4, v6);
                v3 = v3 + 1;
            } else {
                break
            };
        };
        if (v2) {
            0x1::vector::push_back<u128>(&mut v4, high(arg0.fee_a));
            0x1::vector::push_back<u128>(&mut v4, high(arg0.fee_b));
            v3 = 0;
            while (v3 < 5) {
                let v7 = if (v3 < v0) {
                    high(*0x1::vector::borrow<u256>(&arg0.rewards, v3))
                } else {
                    0
                };
                0x1::vector::push_back<u128>(&mut v4, v7);
                v3 = v3 + 1;
            };
        };
        v4
    }

    fun high(arg0: u256) : u128 {
        ((arg0 >> 128) as u128)
    }

    fun join(arg0: u128, arg1: u128) : u256 {
        (arg0 as u256) << 128 | (arg1 as u256)
    }

    public fun legacy_bin_rewards(arg0: &BinGrowthView) : vector<u128> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg0.rewards)) {
            0x1::vector::push_back<u128>(&mut v0, low(*0x1::vector::borrow<u256>(&arg0.rewards, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    public fun legacy_checkpoint_rewards(arg0: &CheckpointView) : vector<u128> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&arg0.rewards)) {
            0x1::vector::push_back<u128>(&mut v0, low(*0x1::vector::borrow<u256>(&arg0.rewards, v1)));
            v1 = v1 + 1;
        };
        v0
    }

    fun low(arg0: u256) : u128 {
        ((arg0 & 340282366920938463463374607431768211455) as u128)
    }

    public fun new_bin_growth() : vector<u128> {
        vector[]
    }

    public fun new_checkpoint(arg0: &BinGrowthView) : (u128, u128, vector<u128>) {
        let v0 = CheckpointView{
            fee_a    : arg0.fee_a,
            fee_b    : arg0.fee_b,
            rewards  : arg0.rewards,
            expanded : false,
        };
        (low(v0.fee_a), low(v0.fee_b), encode_checkpoint(&v0))
    }

    public fun origin() : u256 {
        340282366920938463463374607431768211456
    }

    fun valid(arg0: u256) {
        assert!(arg0 >= 340282366920938463463374607431768211456, 0);
    }

    public(friend) fun write_all_checkpoints(arg0: &mut u128, arg1: &mut u128, arg2: &mut vector<u128>, arg3: &BinGrowthView) {
        let v0 = checkpoint_view(*arg0, *arg1, arg2);
        assert!(0x1::vector::length<u256>(&v0.rewards) <= 0x1::vector::length<u256>(&arg3.rewards), 2);
        assert!(v0.fee_a <= arg3.fee_a && v0.fee_b <= arg3.fee_b, 2);
        let v1 = 0;
        while (v1 < 0x1::vector::length<u256>(&v0.rewards)) {
            assert!(*0x1::vector::borrow<u256>(&v0.rewards, v1) <= *0x1::vector::borrow<u256>(&arg3.rewards, v1), 2);
            v1 = v1 + 1;
        };
        let v2 = CheckpointView{
            fee_a    : arg3.fee_a,
            fee_b    : arg3.fee_b,
            rewards  : arg3.rewards,
            expanded : v0.expanded,
        };
        *arg2 = encode_checkpoint(&v2);
        *arg0 = low(v2.fee_a);
        *arg1 = low(v2.fee_b);
    }

    public(friend) fun write_fee_checkpoints(arg0: &mut u128, arg1: &mut u128, arg2: &mut vector<u128>, arg3: u256, arg4: u256) {
        let v0 = checkpoint_view(*arg0, *arg1, arg2);
        assert!(arg3 >= v0.fee_a && arg4 >= v0.fee_b, 2);
        v0.fee_a = arg3;
        v0.fee_b = arg4;
        *arg2 = encode_checkpoint(&v0);
        *arg0 = low(arg3);
        *arg1 = low(arg4);
    }

    public(friend) fun write_fee_globals(arg0: &mut u128, arg1: &mut u128, arg2: &mut vector<u128>, arg3: u256, arg4: u256) {
        let v0 = bin_view(*arg0, *arg1, arg2);
        assert!(arg3 >= v0.fee_a && arg4 >= v0.fee_b, 2);
        v0.fee_a = arg3;
        v0.fee_b = arg4;
        *arg2 = encode_bin(&v0);
        *arg0 = low(arg3);
        *arg1 = low(arg4);
    }

    public(friend) fun write_reward_checkpoint(arg0: u128, arg1: u128, arg2: &mut vector<u128>, arg3: u64, arg4: u256) {
        let v0 = checkpoint_view(arg0, arg1, arg2);
        assert!(arg3 < 5 && arg3 <= 0x1::vector::length<u256>(&v0.rewards), 1);
        assert!(arg4 >= checkpoint_reward(&v0, arg3), 2);
        if (arg3 == 0x1::vector::length<u256>(&v0.rewards)) {
            0x1::vector::push_back<u256>(&mut v0.rewards, arg4);
        } else {
            *0x1::vector::borrow_mut<u256>(&mut v0.rewards, arg3) = arg4;
        };
        *arg2 = encode_checkpoint(&v0);
    }

    public(friend) fun write_reward_global(arg0: u128, arg1: u128, arg2: &mut vector<u128>, arg3: u64, arg4: u256) {
        let v0 = bin_view(arg0, arg1, arg2);
        assert!(arg3 < 5 && arg3 <= 0x1::vector::length<u256>(&v0.rewards), 1);
        assert!(arg4 >= bin_reward(&v0, arg3), 2);
        if (arg3 == 0x1::vector::length<u256>(&v0.rewards)) {
            0x1::vector::push_back<u256>(&mut v0.rewards, arg4);
        } else {
            *0x1::vector::borrow_mut<u256>(&mut v0.rewards, arg3) = arg4;
        };
        *arg2 = encode_bin(&v0);
    }

    // decompiled from Move bytecode v7
}

