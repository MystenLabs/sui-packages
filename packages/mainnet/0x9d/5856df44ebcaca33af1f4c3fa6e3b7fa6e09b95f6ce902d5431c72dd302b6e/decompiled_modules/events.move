module 0x9d5856df44ebcaca33af1f4c3fa6e3b7fa6e09b95f6ce902d5431c72dd302b6e::events {
    struct Event<T0: copy + drop> has copy, drop {
        event: T0,
    }

    struct RegisterDefinitionEventV1 has copy, drop {
        achievement_id: 0x1::string::String,
    }

    struct MintAchievementEventV1 has copy, drop {
        recipient: address,
        achievement_id: 0x1::string::String,
        instance_id: 0x2::object::ID,
    }

    struct UpdateProgressEventV1 has copy, drop {
        owner: address,
        xp: u64,
        level: u64,
        achievement_count: u64,
    }

    struct SetDefinitionEnabledEventV1 has copy, drop {
        achievement_id: 0x1::string::String,
        enabled: bool,
    }

    public(friend) fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{event: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_mint_achievement(arg0: address, arg1: 0x1::string::String, arg2: 0x2::object::ID) {
        let v0 = MintAchievementEventV1{
            recipient      : arg0,
            achievement_id : arg1,
            instance_id    : arg2,
        };
        emit<MintAchievementEventV1>(v0);
    }

    public(friend) fun emit_register_definition(arg0: 0x1::string::String) {
        let v0 = RegisterDefinitionEventV1{achievement_id: arg0};
        emit<RegisterDefinitionEventV1>(v0);
    }

    public(friend) fun emit_set_definition_enabled(arg0: 0x1::string::String, arg1: bool) {
        let v0 = SetDefinitionEnabledEventV1{
            achievement_id : arg0,
            enabled        : arg1,
        };
        emit<SetDefinitionEnabledEventV1>(v0);
    }

    public(friend) fun emit_update_progress(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = UpdateProgressEventV1{
            owner             : arg0,
            xp                : arg1,
            level             : arg2,
            achievement_count : arg3,
        };
        emit<UpdateProgressEventV1>(v0);
    }

    // decompiled from Move bytecode v7
}

