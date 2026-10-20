module 0x70ec6c100b7bb33e5f51f58b3d27dfe73b1ce8707c89f87b12e9a660572b8ffa::registry {
    struct RegistryFinalize {
        dummy_field: bool,
    }

    struct Registry has key {
        id: 0x2::object::UID,
        registry_version: u64,
        name: 0x1::string::String,
        paused: bool,
        admin: address,
        sweeper: address,
        destinations: 0x2::vec_set::VecSet<address>,
    }

    struct RegistryCreated has copy, drop {
        registry_id: 0x2::object::ID,
        factory_id: 0x2::object::ID,
        name: 0x1::string::String,
    }

    struct AdminUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        admin: address,
    }

    struct SweeperUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        sweeper: address,
    }

    struct DestinationUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        dest: address,
        added: bool,
    }

    struct PauseUpdated has copy, drop {
        registry_id: 0x2::object::ID,
        paused: bool,
    }

    struct RegistryMigrated has copy, drop {
        registry_id: 0x2::object::ID,
        from: u64,
        to: u64,
    }

    public fun add_destination(arg0: &mut Registry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg2);
        0x2::vec_set::insert<address>(&mut arg0.destinations, arg1);
        let v0 = DestinationUpdated{
            registry_id : 0x2::object::id<Registry>(arg0),
            dest        : arg1,
            added       : true,
        };
        0x2::event::emit<DestinationUpdated>(v0);
    }

    public(friend) fun assert_admin(arg0: &Registry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.admin, 13835340853109063685);
    }

    public(friend) fun assert_destination(arg0: &Registry, arg1: address) {
        assert!(0x2::vec_set::contains<address>(&arg0.destinations, &arg1), 13836185372528869387);
    }

    public(friend) fun assert_key_length(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 13835059528456077315);
    }

    public(friend) fun assert_not_paused(arg0: &Registry) {
        assert!(!arg0.paused, 13836466826030874637);
    }

    public(friend) fun assert_sweeper(arg0: &Registry, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.sweeper, 13835622349560741895);
    }

    public(friend) fun assert_sweeper_or_admin(arg0: &Registry, arg1: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(v0 == arg0.sweeper || v0 == arg0.admin, 13835903854602354697);
    }

    public(friend) fun assert_version(arg0: &Registry) {
        assert!(arg0.registry_version == 1, 13836747777021706255);
    }

    public fun deposit_address(arg0: &Registry, arg1: vector<u8>) : address {
        assert_key_length(&arg1);
        0x2::derived_object::derive_address<vector<u8>>(0x2::object::id<Registry>(arg0), arg1)
    }

    public fun finalize_registry(arg0: Registry, arg1: RegistryFinalize) {
        let RegistryFinalize {  } = arg1;
        0x2::transfer::share_object<Registry>(arg0);
    }

    public fun is_admin(arg0: &Registry, arg1: address) : bool {
        arg1 == arg0.admin
    }

    public fun is_destination(arg0: &Registry, arg1: address) : bool {
        0x2::vec_set::contains<address>(&arg0.destinations, &arg1)
    }

    public fun is_paused(arg0: &Registry) : bool {
        arg0.paused
    }

    public fun is_sweeper(arg0: &Registry, arg1: address) : bool {
        arg1 == arg0.sweeper
    }

    public(friend) fun migrate_internal(arg0: &mut Registry) {
        let v0 = arg0.registry_version;
        assert!(v0 <= 1, 13837029299243188241);
        if (v0 < 1) {
            arg0.registry_version = 1;
            let v1 = RegistryMigrated{
                registry_id : 0x2::object::id<Registry>(arg0),
                from        : v0,
                to          : 1,
            };
            0x2::event::emit<RegistryMigrated>(v1);
        };
    }

    public fun name(arg0: &Registry) : 0x1::string::String {
        arg0.name
    }

    public(friend) fun new(arg0: &mut 0x2::object::UID, arg1: 0x1::string::String, arg2: address, arg3: address) : (Registry, RegistryFinalize) {
        let v0 = Registry{
            id               : 0x2::derived_object::claim<0x1::string::String>(arg0, arg1),
            registry_version : 1,
            name             : arg1,
            paused           : false,
            admin            : arg2,
            sweeper          : arg3,
            destinations     : 0x2::vec_set::empty<address>(),
        };
        let v1 = RegistryCreated{
            registry_id : 0x2::object::id<Registry>(&v0),
            factory_id  : 0x2::object::uid_to_inner(arg0),
            name        : v0.name,
        };
        0x2::event::emit<RegistryCreated>(v1);
        let v2 = AdminUpdated{
            registry_id : 0x2::object::id<Registry>(&v0),
            admin       : arg2,
        };
        0x2::event::emit<AdminUpdated>(v2);
        let v3 = SweeperUpdated{
            registry_id : 0x2::object::id<Registry>(&v0),
            sweeper     : arg3,
        };
        0x2::event::emit<SweeperUpdated>(v3);
        let v4 = RegistryFinalize{dummy_field: false};
        (v0, v4)
    }

    public fun pause(arg0: &mut Registry, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1);
        if (!arg0.paused) {
            arg0.paused = true;
            let v0 = PauseUpdated{
                registry_id : 0x2::object::id<Registry>(arg0),
                paused      : true,
            };
            0x2::event::emit<PauseUpdated>(v0);
        };
    }

    public fun remove_destination(arg0: &mut Registry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg2);
        0x2::vec_set::remove<address>(&mut arg0.destinations, &arg1);
        let v0 = DestinationUpdated{
            registry_id : 0x2::object::id<Registry>(arg0),
            dest        : arg1,
            added       : false,
        };
        0x2::event::emit<DestinationUpdated>(v0);
    }

    public fun set_admin(arg0: &mut Registry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg2);
        set_admin_internal(arg0, arg1);
    }

    public(friend) fun set_admin_internal(arg0: &mut Registry, arg1: address) {
        arg0.admin = arg1;
        let v0 = AdminUpdated{
            registry_id : 0x2::object::id<Registry>(arg0),
            admin       : arg1,
        };
        0x2::event::emit<AdminUpdated>(v0);
    }

    public fun set_sweeper(arg0: &mut Registry, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg2);
        arg0.sweeper = arg1;
        let v0 = SweeperUpdated{
            registry_id : 0x2::object::id<Registry>(arg0),
            sweeper     : arg1,
        };
        0x2::event::emit<SweeperUpdated>(v0);
    }

    public(friend) fun uid_mut(arg0: &mut Registry) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unpause(arg0: &mut Registry, arg1: &0x2::tx_context::TxContext) {
        assert_version(arg0);
        assert_admin(arg0, arg1);
        if (arg0.paused) {
            arg0.paused = false;
            let v0 = PauseUpdated{
                registry_id : 0x2::object::id<Registry>(arg0),
                paused      : false,
            };
            0x2::event::emit<PauseUpdated>(v0);
        };
    }

    public fun vault_exists(arg0: &Registry, arg1: vector<u8>) : bool {
        assert_key_length(&arg1);
        0x2::derived_object::exists<vector<u8>>(&arg0.id, arg1)
    }

    // decompiled from Move bytecode v7
}

