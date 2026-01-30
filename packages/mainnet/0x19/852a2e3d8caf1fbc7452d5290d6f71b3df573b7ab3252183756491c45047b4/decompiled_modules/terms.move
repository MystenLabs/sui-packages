module 0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::terms {
    struct TermsVersion has copy, drop, store {
        blob_id: vector<u8>,
        version: u64,
        timestamp: u64,
    }

    struct TermsRegistry has key {
        id: 0x2::object::UID,
        admin: 0x2::object::ID,
        current_blob_id: vector<u8>,
        version: u64,
        min_accepted_version: u64,
        history: vector<TermsVersion>,
    }

    struct TermsRegistryCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        initial_blob_id: vector<u8>,
    }

    struct TermsUpdatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        old_version: u64,
        new_version: u64,
        new_blob_id: vector<u8>,
        timestamp: u64,
    }

    struct MinVersionUpdatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        old_min_version: u64,
        new_min_version: u64,
    }

    fun assert_admin(arg0: &TermsRegistry, arg1: &0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::AdminCap) {
        assert!(arg0.admin == 0x2::object::id<0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::AdminCap>(arg1), 0);
    }

    public fun assert_terms_acceptable(arg0: &TermsRegistry, arg1: u64) {
        assert!(arg1 >= arg0.min_accepted_version, 1);
    }

    public entry fun create_terms_registry(arg0: &0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::AdminCap, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) > 0, 2);
        let v0 = 0x2::object::id<0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::AdminCap>(arg0);
        let v1 = 0x2::object::new(arg3);
        let v2 = TermsVersion{
            blob_id   : arg2,
            version   : 1,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        let v3 = TermsRegistry{
            id                   : v1,
            admin                : v0,
            current_blob_id      : arg2,
            version              : 1,
            min_accepted_version : 1,
            history              : 0x1::vector::singleton<TermsVersion>(v2),
        };
        let v4 = TermsRegistryCreatedEvent{
            registry_id     : 0x2::object::uid_to_inner(&v1),
            admin_cap_id    : v0,
            initial_blob_id : arg2,
        };
        0x2::event::emit<TermsRegistryCreatedEvent>(v4);
        0x2::transfer::share_object<TermsRegistry>(v3);
    }

    public fun current_blob_id(arg0: &TermsRegistry) : vector<u8> {
        arg0.current_blob_id
    }

    public fun current_version(arg0: &TermsRegistry) : u64 {
        arg0.version
    }

    public fun history_length(arg0: &TermsRegistry) : u64 {
        0x1::vector::length<TermsVersion>(&arg0.history)
    }

    public fun is_version_acceptable(arg0: &TermsRegistry, arg1: u64) : bool {
        arg1 >= arg0.min_accepted_version
    }

    public fun min_accepted_version(arg0: &TermsRegistry) : u64 {
        arg0.min_accepted_version
    }

    public entry fun set_min_accepted_version(arg0: &mut TermsRegistry, arg1: &0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::AdminCap, arg2: u64) {
        assert_admin(arg0, arg1);
        assert!(arg2 > 0 && arg2 <= arg0.version, 3);
        arg0.min_accepted_version = arg2;
        let v0 = MinVersionUpdatedEvent{
            registry_id     : 0x2::object::uid_to_inner(&arg0.id),
            old_min_version : arg0.min_accepted_version,
            new_min_version : arg2,
        };
        0x2::event::emit<MinVersionUpdatedEvent>(v0);
    }

    public entry fun update_terms(arg0: &mut TermsRegistry, arg1: &0x19852a2e3d8caf1fbc7452d5290d6f71b3df573b7ab3252183756491c45047b4::config::AdminCap, arg2: &0x2::clock::Clock, arg3: vector<u8>) {
        assert_admin(arg0, arg1);
        assert!(0x1::vector::length<u8>(&arg3) > 0, 2);
        let v0 = arg0.version;
        let v1 = v0 + 1;
        let v2 = 0x2::clock::timestamp_ms(arg2);
        let v3 = TermsVersion{
            blob_id   : arg3,
            version   : v1,
            timestamp : v2,
        };
        arg0.current_blob_id = arg3;
        arg0.version = v1;
        0x1::vector::push_back<TermsVersion>(&mut arg0.history, v3);
        let v4 = TermsUpdatedEvent{
            registry_id : 0x2::object::uid_to_inner(&arg0.id),
            old_version : v0,
            new_version : v1,
            new_blob_id : arg3,
            timestamp   : v2,
        };
        0x2::event::emit<TermsUpdatedEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

