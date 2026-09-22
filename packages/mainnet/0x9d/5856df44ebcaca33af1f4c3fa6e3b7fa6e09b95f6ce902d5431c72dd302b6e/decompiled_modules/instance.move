module 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::instance {
    struct AchievementInstance has key {
        id: 0x2::object::UID,
        achievement_id: 0x1::string::String,
        unlocked_at_ms: u64,
    }

    public fun achievement_id(arg0: &AchievementInstance) : 0x1::string::String {
        arg0.achievement_id
    }

    public(friend) fun mint_to(arg0: address, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = AchievementInstance{
            id             : 0x2::object::new(arg3),
            achievement_id : arg1,
            unlocked_at_ms : arg2,
        };
        0x2::transfer::transfer<AchievementInstance>(v0, arg0);
        0x2::object::id<AchievementInstance>(&v0)
    }

    public fun unlocked_at_ms(arg0: &AchievementInstance) : u64 {
        arg0.unlocked_at_ms
    }

    // decompiled from Move bytecode v7
}

