module 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::recycle {
    struct RecycleConfig has key {
        id: 0x2::object::UID,
        version: u64,
        c: u64,
        r: u64,
        e: u64,
    }

    struct Recycled has copy, drop {
        by: address,
        count: u64,
        pearls: u64,
    }

    fun assert_rewards(arg0: u64, arg1: u64, arg2: u64) {
        let v0 = if (arg0 <= 15) {
            if (arg1 <= 15) {
                arg2 <= 15
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 1);
    }

    public fun migrate(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut RecycleConfig) {
        assert!(arg1.version < 1, 0);
        arg1.version = 1;
    }

    public fun new_recycle_config(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: u64, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert_rewards(arg1, arg2, arg3);
        let v0 = RecycleConfig{
            id      : 0x2::object::new(arg4),
            version : 1,
            c       : arg1,
            r       : arg2,
            e       : arg3,
        };
        0x2::transfer::share_object<RecycleConfig>(v0);
    }

    public fun recycle_for_pearl(arg0: 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling, arg1: &RecycleConfig, arg2: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>();
        0x1::vector::push_back<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(&mut v0, arg0);
        recycle_many(v0, arg1, arg2, arg3);
    }

    public fun recycle_many(arg0: vector<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>, arg1: &RecycleConfig, arg2: &mut 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::PearlMint, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == 1, 0);
        assert!(0x1::vector::length<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(&arg0) <= 50, 2);
        let v0 = 0;
        let v1 = 0;
        while (!0x1::vector::is_empty<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(&arg0)) {
            let v2 = 0x1::vector::pop_back<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(&mut arg0);
            v0 = v0 + reward_for(arg1, 0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::rarity(&v2));
            0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::burn(v2);
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::Mythling>(arg0);
        let v3 = 0x2::tx_context::sender(arg3);
        if (v0 > 0) {
            0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::pearl::award_soulbound(arg2, v3, v0);
        };
        let v4 = Recycled{
            by     : v3,
            count  : v1,
            pearls : v0,
        };
        0x2::event::emit<Recycled>(v4);
    }

    public fun reward_c(arg0: &RecycleConfig) : u64 {
        arg0.c
    }

    public fun reward_e(arg0: &RecycleConfig) : u64 {
        arg0.e
    }

    fun reward_for(arg0: &RecycleConfig, arg1: &0x1::string::String) : u64 {
        if (*arg1 == 0x1::string::utf8(b"C")) {
            arg0.c
        } else if (*arg1 == 0x1::string::utf8(b"R")) {
            arg0.r
        } else if (*arg1 == 0x1::string::utf8(b"E")) {
            arg0.e
        } else {
            0
        }
    }

    public fun reward_r(arg0: &RecycleConfig) : u64 {
        arg0.r
    }

    public fun set_rewards(arg0: &0x88782c4ba986224d44d231b897e8c52d4ca94a936b3d20956716e4573e732326::mythling::AdminCap, arg1: &mut RecycleConfig, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg1.version == 1, 0);
        assert_rewards(arg2, arg3, arg4);
        arg1.c = arg2;
        arg1.r = arg3;
        arg1.e = arg4;
    }

    // decompiled from Move bytecode v7
}

