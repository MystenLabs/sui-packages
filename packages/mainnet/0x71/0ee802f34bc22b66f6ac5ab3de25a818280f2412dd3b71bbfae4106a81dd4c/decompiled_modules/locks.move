module 0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::locks {
    struct Lock has copy, drop, store {
        unlock_ms: u64,
        tier: u8,
        multiplier_bps: u64,
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

    public fun same(arg0: &Lock, arg1: &Lock) : bool {
        arg0.unlock_ms == arg1.unlock_ms && arg0.tier == arg1.tier
    }

    public fun tier(arg0: &Lock) : u8 {
        arg0.tier
    }

    public fun unlock_ms(arg0: &Lock) : u64 {
        arg0.unlock_ms
    }

    public(friend) fun upgrade(arg0: &mut Lock, arg1: u8, arg2: u64, arg3: &0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::config::Params) {
        let (v0, v1) = 0x710ee802f34bc22b66f6ac5ab3de25a818280f2412dd3b71bbfae4106a81dd4c::config::lock_tier(arg3, arg1);
        assert!(arg1 >= arg0.tier && arg2 + v0 >= arg0.unlock_ms, 1);
        arg0.unlock_ms = arg2 + v0;
        arg0.tier = arg1;
        arg0.multiplier_bps = v1;
    }

    // decompiled from Move bytecode v7
}

