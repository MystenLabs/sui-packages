module 0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::nami_config {
    struct ConfigRegistry has key {
        id: 0x2::object::UID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        entry_count: u64,
    }

    struct MasterConfigCap has store, key {
        id: 0x2::object::UID,
    }

    struct ConfigKey has copy, drop, store {
        namespace: 0x1::string::String,
        key: 0x1::string::String,
    }

    struct ConfigCreatedEvent has copy, drop {
        namespace: 0x1::string::String,
        key: 0x1::string::String,
        value: 0x1::string::String,
        creator: address,
    }

    struct ConfigUpdatedEvent has copy, drop {
        namespace: 0x1::string::String,
        key: 0x1::string::String,
        old_value: 0x1::string::String,
        new_value: 0x1::string::String,
        updater: address,
    }

    struct ConfigRemovedEvent has copy, drop {
        namespace: 0x1::string::String,
        key: 0x1::string::String,
        remover: address,
    }

    struct VersionEnabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    struct VersionDisabledEvent has copy, drop {
        object_id: 0x2::object::ID,
        version: u64,
    }

    public fun remove(arg0: &MasterConfigCap, arg1: &mut ConfigRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::version::assert_version(&arg1.allowed_versions);
        assert_key(&arg2, &arg3);
        let v0 = ConfigKey{
            namespace : arg2,
            key       : arg3,
        };
        assert!(0x2::dynamic_field::exists<ConfigKey>(&arg1.id, v0), 0);
        0x2::dynamic_field::remove<ConfigKey, 0x1::string::String>(&mut arg1.id, v0);
        arg1.entry_count = arg1.entry_count - 1;
        let v1 = ConfigRemovedEvent{
            namespace : v0.namespace,
            key       : v0.key,
            remover   : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<ConfigRemovedEvent>(v1);
    }

    public fun allowed_versions(arg0: &ConfigRegistry) : &0x2::vec_set::VecSet<u64> {
        &arg0.allowed_versions
    }

    fun assert_key(arg0: &0x1::string::String, arg1: &0x1::string::String) {
        assert!(!0x1::string::is_empty(arg0), 2);
        assert!(!0x1::string::is_empty(arg1), 3);
        assert!(0x1::string::length(arg0) <= 256, 6);
        assert!(0x1::string::length(arg1) <= 256, 6);
    }

    public fun batch_remove(arg0: &MasterConfigCap, arg1: &mut ConfigRegistry, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::version::assert_version(&arg1.allowed_versions);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg3), 1);
        let v1 = 0;
        while (v1 < v0) {
            remove(arg0, arg1, *0x1::vector::borrow<0x1::string::String>(&arg2, v1), *0x1::vector::borrow<0x1::string::String>(&arg3, v1), arg4);
            v1 = v1 + 1;
        };
    }

    entry fun batch_remove_entry(arg0: &MasterConfigCap, arg1: &mut ConfigRegistry, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::version::assert_version(&arg1.allowed_versions);
        batch_remove(arg0, arg1, arg2, arg3, arg4);
    }

    public fun batch_set(arg0: &MasterConfigCap, arg1: &mut ConfigRegistry, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::version::assert_version(&arg1.allowed_versions);
        let v0 = 0x1::vector::length<0x1::string::String>(&arg2);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg3), 1);
        assert!(v0 == 0x1::vector::length<0x1::string::String>(&arg4), 1);
        let v1 = 0;
        while (v1 < v0) {
            set(arg0, arg1, *0x1::vector::borrow<0x1::string::String>(&arg2, v1), *0x1::vector::borrow<0x1::string::String>(&arg3, v1), *0x1::vector::borrow<0x1::string::String>(&arg4, v1), arg5);
            v1 = v1 + 1;
        };
    }

    entry fun batch_set_entry(arg0: &MasterConfigCap, arg1: &mut ConfigRegistry, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: &mut 0x2::tx_context::TxContext) {
        0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::version::assert_version(&arg1.allowed_versions);
        batch_set(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun contains(arg0: &ConfigRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String) : bool {
        let v0 = ConfigKey{
            namespace : arg1,
            key       : arg2,
        };
        0x2::dynamic_field::exists<ConfigKey>(&arg0.id, v0)
    }

    public fun disable_version(arg0: &MasterConfigCap, arg1: &mut ConfigRegistry, arg2: u64) {
        assert!(arg2 != 0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::version::current_version(), 901);
        assert!(0x2::vec_set::length<u64>(&arg1.allowed_versions) > 1, 8);
        0x2::vec_set::remove<u64>(&mut arg1.allowed_versions, &arg2);
        let v0 = VersionDisabledEvent{
            object_id : 0x2::object::id<ConfigRegistry>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionDisabledEvent>(v0);
    }

    public fun enable_version(arg0: &MasterConfigCap, arg1: &mut ConfigRegistry, arg2: u64) {
        assert!(arg2 <= 0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::version::current_version() + 1, 7);
        0x2::vec_set::insert<u64>(&mut arg1.allowed_versions, arg2);
        let v0 = VersionEnabledEvent{
            object_id : 0x2::object::id<ConfigRegistry>(arg1),
            version   : arg2,
        };
        0x2::event::emit<VersionEnabledEvent>(v0);
    }

    public fun entry_count(arg0: &ConfigRegistry) : u64 {
        arg0.entry_count
    }

    public fun get(arg0: &ConfigRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String) : 0x1::string::String {
        let v0 = ConfigKey{
            namespace : arg1,
            key       : arg2,
        };
        assert!(0x2::dynamic_field::exists<ConfigKey>(&arg0.id, v0), 0);
        *0x2::dynamic_field::borrow<ConfigKey, 0x1::string::String>(&arg0.id, v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ConfigRegistry{
            id               : 0x2::object::new(arg0),
            allowed_versions : 0x2::vec_set::singleton<u64>(0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::version::current_version()),
            entry_count      : 0,
        };
        0x2::transfer::share_object<ConfigRegistry>(v0);
        let v1 = MasterConfigCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MasterConfigCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun max_key_length() : u64 {
        256
    }

    public fun max_value_length() : u64 {
        8192
    }

    entry fun remove_entry(arg0: &MasterConfigCap, arg1: &mut ConfigRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::version::assert_version(&arg1.allowed_versions);
        remove(arg0, arg1, arg2, arg3, arg4);
    }

    public fun set(arg0: &MasterConfigCap, arg1: &mut ConfigRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::version::assert_version(&arg1.allowed_versions);
        assert_key(&arg2, &arg3);
        assert!(!0x1::string::is_empty(&arg4), 5);
        assert!(0x1::string::length(&arg4) <= 8192, 4);
        let v0 = ConfigKey{
            namespace : arg2,
            key       : arg3,
        };
        if (0x2::dynamic_field::exists<ConfigKey>(&arg1.id, v0)) {
            let v1 = 0x2::dynamic_field::borrow_mut<ConfigKey, 0x1::string::String>(&mut arg1.id, v0);
            *v1 = arg4;
            let v2 = ConfigUpdatedEvent{
                namespace : v0.namespace,
                key       : v0.key,
                old_value : *v1,
                new_value : *v1,
                updater   : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<ConfigUpdatedEvent>(v2);
        } else {
            0x2::dynamic_field::add<ConfigKey, 0x1::string::String>(&mut arg1.id, v0, arg4);
            arg1.entry_count = arg1.entry_count + 1;
            let v3 = ConfigCreatedEvent{
                namespace : v0.namespace,
                key       : v0.key,
                value     : arg4,
                creator   : 0x2::tx_context::sender(arg5),
            };
            0x2::event::emit<ConfigCreatedEvent>(v3);
        };
    }

    entry fun set_entry(arg0: &MasterConfigCap, arg1: &mut ConfigRegistry, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        0xd7da5276981f4909879dc62587c27dc0f9de482490e27ac692c4c8d1c5a43a5a::version::assert_version(&arg1.allowed_versions);
        set(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun try_get(arg0: &ConfigRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String) : 0x1::option::Option<0x1::string::String> {
        let v0 = ConfigKey{
            namespace : arg1,
            key       : arg2,
        };
        if (0x2::dynamic_field::exists<ConfigKey>(&arg0.id, v0)) {
            0x1::option::some<0x1::string::String>(*0x2::dynamic_field::borrow<ConfigKey, 0x1::string::String>(&arg0.id, v0))
        } else {
            0x1::option::none<0x1::string::String>()
        }
    }

    // decompiled from Move bytecode v7
}

