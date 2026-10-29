module 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::locks {
    struct Lock has copy, drop, store {
        unlock_ms: u64,
        tier: u8,
        multiplier_bps: u64,
    }

    struct Release has copy, drop, store {
        at_ms: u64,
        durations_ms: vector<u64>,
    }

    public fun assert_unlocked(arg0: &Lock, arg1: u64, arg2: u8) {
        assert!(arg2 != 0 || arg1 >= arg0.unlock_ms, 2);
    }

    public(friend) fun clear(arg0: &mut Lock) {
        *arg0 = flexible();
    }

    public fun flexible() : Lock {
        Lock{
            unlock_ms      : 0,
            tier           : 0,
            multiplier_bps : 10000,
        }
    }

    public fun multiplier(arg0: &Lock, arg1: u64) : u64 {
        if (arg1 < arg0.unlock_ms) {
            arg0.multiplier_bps
        } else {
            10000
        }
    }

    public fun multiplier_bps(arg0: &Lock) : u64 {
        arg0.multiplier_bps
    }

    public(friend) fun release(arg0: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Params, arg1: u64) : Release {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::lock_tiers(arg0)) {
            let (v2, _) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::lock_tier(arg0, (v1 as u8));
            0x1::vector::push_back<u64>(&mut v0, v2);
            v1 = v1 + 1;
        };
        Release{
            at_ms        : arg1,
            durations_ms : v0,
        }
    }

    public fun release_ms(arg0: &Release) : u64 {
        arg0.at_ms
    }

    public fun released_by(arg0: &Lock, arg1: &Release) : bool {
        if (*arg0 == flexible()) {
            return false
        };
        let v0 = (arg0.tier as u64);
        let v1 = if (v0 < 0x1::vector::length<u64>(&arg1.durations_ms)) {
            *0x1::vector::borrow<u64>(&arg1.durations_ms, v0)
        } else {
            0
        };
        let v2 = if (arg0.unlock_ms > v1) {
            arg0.unlock_ms - v1
        } else {
            0
        };
        v2 < arg1.at_ms
    }

    public fun same(arg0: &Lock, arg1: &Lock) : bool {
        arg0.unlock_ms == arg1.unlock_ms && arg0.tier == arg1.tier
    }

    public fun tier(arg0: &Lock) : u8 {
        arg0.tier
    }

    public fun unlock_ms(arg0: &Lock) : u64 {
        arg0.unlock_ms
    }

    public(friend) fun upgrade(arg0: &mut Lock, arg1: u8, arg2: u64, arg3: &0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::Params) {
        let (v0, v1) = 0x97fea95545c04dc73f8174c6195013b100a26e3fa978e7cf8b100a51dfaf8354::config::lock_tier(arg3, arg1);
        assert!(arg1 >= arg0.tier && arg2 + v0 >= arg0.unlock_ms, 1);
        arg0.unlock_ms = arg2 + v0;
        arg0.tier = arg1;
        arg0.multiplier_bps = v1;
    }

    // decompiled from Move bytecode v7
}

