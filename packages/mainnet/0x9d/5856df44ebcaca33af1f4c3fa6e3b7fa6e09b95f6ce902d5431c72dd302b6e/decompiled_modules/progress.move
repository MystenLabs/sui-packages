module 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::progress {
    struct UserProgress has key {
        id: 0x2::object::UID,
        xp: u64,
        level: u64,
        achievement_count: u64,
        points_mirror: u64,
    }

    public fun id(arg0: &UserProgress) : 0x2::object::ID {
        0x2::object::id<UserProgress>(arg0)
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : UserProgress {
        UserProgress{
            id                : 0x2::object::new(arg0),
            xp                : 0,
            level             : 0,
            achievement_count : 0,
            points_mirror     : 0,
        }
    }

    public fun achievement_count(arg0: &UserProgress) : u64 {
        arg0.achievement_count
    }

    public(friend) fun add_points_mirror(arg0: &mut UserProgress, arg1: u64) {
        arg0.points_mirror = arg0.points_mirror + arg1;
    }

    public(friend) fun add_xp(arg0: &mut UserProgress, arg1: u64) {
        arg0.xp = arg0.xp + arg1;
        arg0.level = level_from_xp(arg0.xp);
    }

    public(friend) fun bump_achievement_count(arg0: &mut UserProgress) {
        arg0.achievement_count = arg0.achievement_count + 1;
    }

    public fun level(arg0: &UserProgress) : u64 {
        arg0.level
    }

    public(friend) fun level_from_xp(arg0: u64) : u64 {
        let v0 = vector[100, 300, 700, 1400, 2500, 4000, 6000, 8500, 11500, 15000];
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&v0)) {
            if (arg0 >= *0x1::vector::borrow<u64>(&v0, v2)) {
                v1 = v2 + 1;
                v2 = v2 + 1;
            } else {
                break
            };
        };
        v1
    }

    public fun points_mirror(arg0: &UserProgress) : u64 {
        arg0.points_mirror
    }

    public(friend) fun transfer_to(arg0: UserProgress, arg1: address) {
        0x2::transfer::transfer<UserProgress>(arg0, arg1);
    }

    public fun xp(arg0: &UserProgress) : u64 {
        arg0.xp
    }

    // decompiled from Move bytecode v7
}

