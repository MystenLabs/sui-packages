module 0xea1a77e23e794ac834b3de1f1c3a885120a1fb742976ed2e32754f9e851ed055::vault {
    struct VaultRegistry has key {
        id: 0x2::object::UID,
    }

    struct Vault<T0: store + key> has key {
        id: 0x2::object::UID,
        vaulted_cap_id: 0x2::object::ID,
        vaulted_cap: 0x1::option::Option<0x2::borrow::Referent<T0>>,
        authorized_plugins: 0x2::bag::Bag,
    }

    struct VaultAdminCap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultKey<phantom T0: store + key> has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct VaultAdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AuthorizedPluginKey<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultRegistryCreatedEvent has copy, drop {
        registry_id: address,
        shared: bool,
    }

    struct VaultCreatedEvent<phantom T0> has copy, drop {
        registry_id: address,
        vault_id: address,
        vaulted_cap_id: address,
        cap_id: address,
        authorized_plugins_id: address,
        authorized_plugin_count: u64,
        active: bool,
        capability_available: bool,
    }

    struct PluginAuthorizedEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: address,
        vaulted_cap_id: address,
        cap_id: address,
        authorized_plugins_id: address,
        authorized_plugin_count: u64,
        authorized: bool,
    }

    struct PluginRevokedEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: address,
        vaulted_cap_id: address,
        cap_id: address,
        authorized_plugins_id: address,
        authorized_plugin_count: u64,
        authorized: bool,
    }

    struct VaultCapabilityWithdrawnEvent<phantom T0> has copy, drop {
        vault_id: address,
        vaulted_cap_id: address,
        cap_id: address,
        active: bool,
        capability_available: bool,
    }

    struct VaultCapabilityRestoredEvent<phantom T0> has copy, drop {
        vault_id: address,
        vaulted_cap_id: address,
        cap_id: address,
        active: bool,
        capability_available: bool,
    }

    public fun new<T0: store + key>(arg0: &mut VaultRegistry, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : (Vault<T0>, VaultAdminCap<T0>) {
        let v0 = 0x2::object::id<VaultRegistry>(arg0);
        let v1 = 0x2::object::id<T0>(&arg1);
        let v2 = VaultKey<T0>{pos0: v1};
        let v3 = 0x2::derived_object::claim<VaultKey<T0>>(&mut arg0.id, v2);
        let v4 = 0x2::object::uid_to_inner(&v3);
        let v5 = VaultAdminCapKey{dummy_field: false};
        let v6 = VaultAdminCap<T0>{
            id       : 0x2::derived_object::claim<VaultAdminCapKey>(&mut v3, v5),
            vault_id : v4,
        };
        let v7 = Vault<T0>{
            id                 : v3,
            vaulted_cap_id     : v1,
            vaulted_cap        : 0x1::option::some<0x2::borrow::Referent<T0>>(0x2::borrow::new<T0>(arg1, arg2)),
            authorized_plugins : 0x2::bag::new(arg2),
        };
        let v8 = 0x2::object::id<VaultAdminCap<T0>>(&v6);
        let v9 = 0x2::object::id<0x2::bag::Bag>(&v7.authorized_plugins);
        let v10 = VaultCreatedEvent<T0>{
            registry_id             : 0x2::object::id_to_address(&v0),
            vault_id                : 0x2::object::id_to_address(&v4),
            vaulted_cap_id          : 0x2::object::id_to_address(&v1),
            cap_id                  : 0x2::object::id_to_address(&v8),
            authorized_plugins_id   : 0x2::object::id_to_address(&v9),
            authorized_plugin_count : 0x2::bag::length(&v7.authorized_plugins),
            active                  : true,
            capability_available    : true,
        };
        0x2::event::emit<VaultCreatedEvent<T0>>(v10);
        (v7, v6)
    }

    public fun put_back<T0: store + key>(arg0: &mut Vault<T0>, arg1: T0, arg2: 0x2::borrow::Borrow) {
        0x2::borrow::put_back<T0>(0x1::option::borrow_mut<0x2::borrow::Referent<T0>>(&mut arg0.vaulted_cap), arg1, arg2);
    }

    fun assert_admin<T0: store + key>(arg0: &Vault<T0>, arg1: &VaultAdminCap<T0>) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 0);
    }

    public fun authorize_plugin<T0: store + key, T1: drop>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: T1) {
        assert_admin<T0>(arg0, arg1);
        assert!(0x1::option::is_some<0x2::borrow::Referent<T0>>(&arg0.vaulted_cap), 4);
        let v0 = AuthorizedPluginKey<T1>{dummy_field: false};
        assert!(!0x2::bag::contains<AuthorizedPluginKey<T1>>(&arg0.authorized_plugins, v0), 1);
        0x2::bag::add<AuthorizedPluginKey<T1>, bool>(&mut arg0.authorized_plugins, v0, true);
        let v1 = 0x2::object::id<Vault<T0>>(arg0);
        let v2 = 0x2::object::id<VaultAdminCap<T0>>(arg1);
        let v3 = 0x2::object::id<0x2::bag::Bag>(&arg0.authorized_plugins);
        let v4 = PluginAuthorizedEvent<T0, T1>{
            vault_id                : 0x2::object::id_to_address(&v1),
            vaulted_cap_id          : 0x2::object::id_to_address(&arg0.vaulted_cap_id),
            cap_id                  : 0x2::object::id_to_address(&v2),
            authorized_plugins_id   : 0x2::object::id_to_address(&v3),
            authorized_plugin_count : 0x2::bag::length(&arg0.authorized_plugins),
            authorized              : true,
        };
        0x2::event::emit<PluginAuthorizedEvent<T0, T1>>(v4);
    }

    public fun authorized_plugins<T0: store + key>(arg0: &Vault<T0>) : &0x2::bag::Bag {
        &arg0.authorized_plugins
    }

    public fun borrow_as_admin<T0: store + key>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>) : (T0, 0x2::borrow::Borrow) {
        assert_admin<T0>(arg0, arg1);
        0x2::borrow::borrow<T0>(0x1::option::borrow_mut<0x2::borrow::Referent<T0>>(&mut arg0.vaulted_cap))
    }

    public fun borrow_as_plugin<T0: store + key, T1: drop>(arg0: &mut Vault<T0>, arg1: T1) : (T0, 0x2::borrow::Borrow) {
        let v0 = AuthorizedPluginKey<T1>{dummy_field: false};
        assert!(0x2::bag::contains<AuthorizedPluginKey<T1>>(&arg0.authorized_plugins, v0), 2);
        let v1 = AuthorizedPluginKey<T1>{dummy_field: false};
        0x2::bag::borrow<AuthorizedPluginKey<T1>, bool>(&arg0.authorized_plugins, v1);
        0x2::borrow::borrow<T0>(0x1::option::borrow_mut<0x2::borrow::Referent<T0>>(&mut arg0.vaulted_cap))
    }

    public fun derived_address<T0: store + key>(arg0: &VaultRegistry, arg1: 0x2::object::ID) : address {
        let v0 = VaultKey<T0>{pos0: arg1};
        0x2::derived_object::derive_address<VaultKey<T0>>(0x2::object::id<VaultRegistry>(arg0), v0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::id<VaultRegistry>(&v0);
        0x2::transfer::share_object<VaultRegistry>(v0);
        let v2 = VaultRegistryCreatedEvent{
            registry_id : 0x2::object::id_to_address(&v1),
            shared      : true,
        };
        0x2::event::emit<VaultRegistryCreatedEvent>(v2);
    }

    public fun is_active<T0: store + key>(arg0: &Vault<T0>) : bool {
        0x1::option::is_some<0x2::borrow::Referent<T0>>(&arg0.vaulted_cap)
    }

    public fun is_plugin_authorized<T0: store + key, T1: drop>(arg0: &Vault<T0>) : bool {
        let v0 = AuthorizedPluginKey<T1>{dummy_field: false};
        0x2::bag::contains<AuthorizedPluginKey<T1>>(&arg0.authorized_plugins, v0)
    }

    public fun restore_vaulted_cap<T0: store + key>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        assert_admin<T0>(arg0, arg1);
        assert!(0x2::object::id<T0>(&arg2) == arg0.vaulted_cap_id, 5);
        0x1::option::fill<0x2::borrow::Referent<T0>>(&mut arg0.vaulted_cap, 0x2::borrow::new<T0>(arg2, arg3));
        let v0 = 0x2::object::id<Vault<T0>>(arg0);
        let v1 = 0x2::object::id<VaultAdminCap<T0>>(arg1);
        let v2 = VaultCapabilityRestoredEvent<T0>{
            vault_id             : 0x2::object::id_to_address(&v0),
            vaulted_cap_id       : 0x2::object::id_to_address(&arg0.vaulted_cap_id),
            cap_id               : 0x2::object::id_to_address(&v1),
            active               : true,
            capability_available : true,
        };
        0x2::event::emit<VaultCapabilityRestoredEvent<T0>>(v2);
    }

    public fun revoke_plugin<T0: store + key, T1: drop>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>) {
        assert_admin<T0>(arg0, arg1);
        let v0 = AuthorizedPluginKey<T1>{dummy_field: false};
        assert!(0x2::bag::contains<AuthorizedPluginKey<T1>>(&arg0.authorized_plugins, v0), 2);
        0x2::bag::remove<AuthorizedPluginKey<T1>, bool>(&mut arg0.authorized_plugins, v0);
        let v1 = 0x2::object::id<Vault<T0>>(arg0);
        let v2 = 0x2::object::id<VaultAdminCap<T0>>(arg1);
        let v3 = 0x2::object::id<0x2::bag::Bag>(&arg0.authorized_plugins);
        let v4 = PluginRevokedEvent<T0, T1>{
            vault_id                : 0x2::object::id_to_address(&v1),
            vaulted_cap_id          : 0x2::object::id_to_address(&arg0.vaulted_cap_id),
            cap_id                  : 0x2::object::id_to_address(&v2),
            authorized_plugins_id   : 0x2::object::id_to_address(&v3),
            authorized_plugin_count : 0x2::bag::length(&arg0.authorized_plugins),
            authorized              : false,
        };
        0x2::event::emit<PluginRevokedEvent<T0, T1>>(v4);
    }

    public fun share<T0: store + key>(arg0: Vault<T0>) {
        0x2::transfer::share_object<Vault<T0>>(arg0);
    }

    public fun vaulted_cap_id<T0: store + key>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.vaulted_cap_id
    }

    public fun withdraw_vaulted_cap<T0: store + key>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>) : T0 {
        assert_admin<T0>(arg0, arg1);
        assert!(0x2::bag::is_empty(&arg0.authorized_plugins), 3);
        let v0 = 0x2::object::id<Vault<T0>>(arg0);
        let v1 = 0x2::object::id<VaultAdminCap<T0>>(arg1);
        let v2 = VaultCapabilityWithdrawnEvent<T0>{
            vault_id             : 0x2::object::id_to_address(&v0),
            vaulted_cap_id       : 0x2::object::id_to_address(&arg0.vaulted_cap_id),
            cap_id               : 0x2::object::id_to_address(&v1),
            active               : false,
            capability_available : false,
        };
        0x2::event::emit<VaultCapabilityWithdrawnEvent<T0>>(v2);
        0x2::borrow::destroy<T0>(0x1::option::extract<0x2::borrow::Referent<T0>>(&mut arg0.vaulted_cap))
    }

    // decompiled from Move bytecode v7
}

