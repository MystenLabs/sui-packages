module 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::registry {
    struct UnlockKey has copy, drop, store {
        owner: address,
        achievement_id: 0x1::string::String,
    }

    struct AchievementRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        definitions: 0x2::table::Table<0x1::string::String, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::AchievementDefinition>,
        unlock_counts: 0x2::table::Table<0x1::string::String, u64>,
        unlocked: 0x2::table::Table<UnlockKey, bool>,
        progress_ids: 0x2::table::Table<address, 0x2::object::ID>,
        total_user_progress: u64,
    }

    public(friend) fun add_definition(arg0: &mut AchievementRegistry, arg1: 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::AchievementDefinition) {
        let v0 = *0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::id(&arg1);
        assert!(!0x2::table::contains<0x1::string::String, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::AchievementDefinition>(&arg0.definitions, v0), 13835058446124187649);
        0x2::table::add<0x1::string::String, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::AchievementDefinition>(&mut arg0.definitions, v0, arg1);
    }

    public(friend) fun assert_enabled(arg0: &AchievementRegistry, arg1: 0x1::string::String) {
        assert!(0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::enabled(borrow_definition(arg0, arg1)), 13835902926889287687);
    }

    public(friend) fun assert_not_unlocked(arg0: &AchievementRegistry, arg1: address, arg2: 0x1::string::String) {
        assert!(!has_unlocked(arg0, arg1, arg2), 13835621486272184325);
    }

    public fun borrow_definition(arg0: &AchievementRegistry, arg1: 0x1::string::String) : &0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::AchievementDefinition {
        assert!(0x2::table::contains<0x1::string::String, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::AchievementDefinition>(&arg0.definitions, arg1), 13835339792252010499);
        0x2::table::borrow<0x1::string::String, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::AchievementDefinition>(&arg0.definitions, arg1)
    }

    public(friend) fun borrow_definition_mut(arg0: &mut AchievementRegistry, arg1: 0x1::string::String) : &mut 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::AchievementDefinition {
        assert!(0x2::table::contains<0x1::string::String, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::AchievementDefinition>(&arg0.definitions, arg1), 13835339955460767747);
        0x2::table::borrow_mut<0x1::string::String, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::AchievementDefinition>(&mut arg0.definitions, arg1)
    }

    public fun borrow_uid(arg0: &AchievementRegistry) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun borrow_uid_mut(arg0: &mut AchievementRegistry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : AchievementRegistry {
        AchievementRegistry{
            id                  : 0x2::object::new(arg0),
            version             : 1,
            definitions         : 0x2::table::new<0x1::string::String, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::AchievementDefinition>(arg0),
            unlock_counts       : 0x2::table::new<0x1::string::String, u64>(arg0),
            unlocked            : 0x2::table::new<UnlockKey, bool>(arg0),
            progress_ids        : 0x2::table::new<address, 0x2::object::ID>(arg0),
            total_user_progress : 0,
        }
    }

    public fun has_definition(arg0: &AchievementRegistry, arg1: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, 0x184c2db227d9e5457e3917e9d41ea860fe43523e62444cd4061b6534e66b8cad::definition::AchievementDefinition>(&arg0.definitions, arg1)
    }

    public fun has_progress(arg0: &AchievementRegistry, arg1: address) : bool {
        0x2::table::contains<address, 0x2::object::ID>(&arg0.progress_ids, arg1)
    }

    public fun has_unlocked(arg0: &AchievementRegistry, arg1: address, arg2: 0x1::string::String) : bool {
        let v0 = UnlockKey{
            owner          : arg1,
            achievement_id : arg2,
        };
        0x2::table::contains<UnlockKey, bool>(&arg0.unlocked, v0)
    }

    public(friend) fun mark_unlocked(arg0: &mut AchievementRegistry, arg1: address, arg2: 0x1::string::String) {
        let v0 = UnlockKey{
            owner          : arg1,
            achievement_id : arg2,
        };
        0x2::table::add<UnlockKey, bool>(&mut arg0.unlocked, v0, true);
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.unlock_counts, arg2)) {
            let v1 = 0x2::table::borrow_mut<0x1::string::String, u64>(&mut arg0.unlock_counts, arg2);
            *v1 = *v1 + 1;
        } else {
            0x2::table::add<0x1::string::String, u64>(&mut arg0.unlock_counts, arg2, 1);
        };
    }

    public fun progress_id(arg0: &AchievementRegistry, arg1: address) : 0x2::object::ID {
        *0x2::table::borrow<address, 0x2::object::ID>(&arg0.progress_ids, arg1)
    }

    public(friend) fun record_progress_id(arg0: &mut AchievementRegistry, arg1: address, arg2: 0x2::object::ID) {
        if (!0x2::table::contains<address, 0x2::object::ID>(&arg0.progress_ids, arg1)) {
            0x2::table::add<address, 0x2::object::ID>(&mut arg0.progress_ids, arg1, arg2);
            arg0.total_user_progress = arg0.total_user_progress + 1;
        };
    }

    public(friend) fun share(arg0: AchievementRegistry) {
        0x2::transfer::share_object<AchievementRegistry>(arg0);
    }

    public fun total_user_progress(arg0: &AchievementRegistry) : u64 {
        arg0.total_user_progress
    }

    public fun unlock_count(arg0: &AchievementRegistry, arg1: 0x1::string::String) : u64 {
        if (0x2::table::contains<0x1::string::String, u64>(&arg0.unlock_counts, arg1)) {
            *0x2::table::borrow<0x1::string::String, u64>(&arg0.unlock_counts, arg1)
        } else {
            0
        }
    }

    public fun version(arg0: &AchievementRegistry) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

