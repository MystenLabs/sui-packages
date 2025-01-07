module 0x788ceec9c41a9867307667269c80ba7bc67e8ee2d421b1bf1addada06812c78a::event {
    struct Deposit has copy, drop {
        id: 0x2::object::ID,
        locked_value: u64,
        unlock_time: u64,
    }

    struct Withdraw has copy, drop {
        id: 0x2::object::ID,
        unlocked_value: u64,
        ts: u64,
    }

    struct LevelUp has copy, drop {
        id: 0x2::object::ID,
        level: u8,
    }

    struct EarnXP has copy, drop {
        id: 0x2::object::ID,
        exp: u64,
    }

    public fun deposit(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = Deposit{
            id           : arg0,
            locked_value : arg1,
            unlock_time  : arg2,
        };
        0x2::event::emit<Deposit>(v0);
    }

    public fun earn_xp(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = EarnXP{
            id  : arg0,
            exp : arg1,
        };
        0x2::event::emit<EarnXP>(v0);
    }

    public fun level_up(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = LevelUp{
            id    : arg0,
            level : arg1,
        };
        0x2::event::emit<LevelUp>(v0);
    }

    public fun withdraw(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = Withdraw{
            id             : arg0,
            unlocked_value : arg1,
            ts             : arg2,
        };
        0x2::event::emit<Withdraw>(v0);
    }

    // decompiled from Move bytecode v6
}

