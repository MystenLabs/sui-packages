module 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition {
    struct AchievementDefinition has copy, drop, store {
        id: 0x1::string::String,
        name: 0x1::string::String,
        description: 0x1::string::String,
        image_url: 0x1::string::String,
        xp_reward: u64,
        points_reward_hint: u64,
        enabled: bool,
    }

    public fun description(arg0: &AchievementDefinition) : &0x1::string::String {
        &arg0.description
    }

    public fun enabled(arg0: &AchievementDefinition) : bool {
        arg0.enabled
    }

    public fun id(arg0: &AchievementDefinition) : &0x1::string::String {
        &arg0.id
    }

    public fun image_url(arg0: &AchievementDefinition) : &0x1::string::String {
        &arg0.image_url
    }

    public fun name(arg0: &AchievementDefinition) : &0x1::string::String {
        &arg0.name
    }

    public(friend) fun new(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64, arg6: bool) : AchievementDefinition {
        AchievementDefinition{
            id                 : arg0,
            name               : arg1,
            description        : arg2,
            image_url          : arg3,
            xp_reward          : arg4,
            points_reward_hint : arg5,
            enabled            : arg6,
        }
    }

    public fun points_reward_hint(arg0: &AchievementDefinition) : u64 {
        arg0.points_reward_hint
    }

    public(friend) fun set_enabled(arg0: &mut AchievementDefinition, arg1: bool) {
        arg0.enabled = arg1;
    }

    public(friend) fun update(arg0: &mut AchievementDefinition, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u64, arg5: u64) {
        arg0.name = arg1;
        arg0.description = arg2;
        arg0.image_url = arg3;
        arg0.xp_reward = arg4;
        arg0.points_reward_hint = arg5;
    }

    public fun xp_reward(arg0: &AchievementDefinition) : u64 {
        arg0.xp_reward
    }

    // decompiled from Move bytecode v7
}

