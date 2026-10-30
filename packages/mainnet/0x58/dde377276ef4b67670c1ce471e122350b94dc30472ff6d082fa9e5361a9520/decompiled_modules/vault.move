module 0x58dde377276ef4b67670c1ce471e122350b94dc30472ff6d082fa9e5361a9520::vault {
    struct Vault<T0: store + key> has key {
        id: 0x2::object::UID,
        vaulted_cap_id: 0x2::object::ID,
        vaulted_cap: 0x1::option::Option<0x2::borrow::Referent<T0>>,
        authorized_plugins: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
    }

    struct VaultAdminCap<phantom T0: store + key> has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultRegistry has key {
        id: 0x2::object::UID,
    }

    struct VaultKey<phantom T0: store + key> has copy, drop, store {
        pos0: 0x2::object::ID,
    }

    struct VaultAdminCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct VaultRegistryCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
    }

    struct VaultCreatedEvent<phantom T0> has copy, drop {
        registry_id: 0x2::object::ID,
        vault_id: 0x2::object::ID,
        vaulted_cap_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    struct VaultCapabilityWithdrawnEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        vaulted_cap_id: 0x2::object::ID,
    }

    struct VaultCapabilityRestoredEvent<phantom T0> has copy, drop {
        vault_id: 0x2::object::ID,
        vaulted_cap_id: 0x2::object::ID,
    }

    struct PluginAuthorizedEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        vaulted_cap_id: 0x2::object::ID,
        authorized_plugin_count: u64,
    }

    struct PluginRevokedEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        vaulted_cap_id: 0x2::object::ID,
        authorized_plugin_count: u64,
    }

    struct VaultDestroyedEvent has copy, drop {
        vault_id: 0x2::object::ID,
    }

    public fun destroy<T0: store + key>(arg0: Vault<T0>, arg1: VaultAdminCap<T0>) {
        authorize<T0>(&arg0, &arg1);
        assert!(0x2::vec_set::is_empty<0x1::type_name::TypeName>(&arg0.authorized_plugins), 3);
        assert!(0x1::option::is_none<0x2::borrow::Referent<T0>>(&arg0.vaulted_cap), 6);
        let Vault {
            id                 : v0,
            vaulted_cap_id     : _,
            vaulted_cap        : v2,
            authorized_plugins : _,
        } = arg0;
        let VaultAdminCap {
            id       : v4,
            vault_id : v5,
        } = arg1;
        0x1::option::destroy_none<0x2::borrow::Referent<T0>>(v2);
        0x2::object::delete(v0);
        0x2::object::delete(v4);
        let v6 = VaultDestroyedEvent{vault_id: v5};
        0x2::event::emit<VaultDestroyedEvent>(v6);
    }

    public fun new<T0: store + key>(arg0: &mut VaultRegistry, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) : (Vault<T0>, VaultAdminCap<T0>) {
        let v0 = 0x2::object::id<T0>(&arg1);
        let v1 = VaultKey<T0>{pos0: v0};
        let v2 = 0x2::derived_object::claim<VaultKey<T0>>(&mut arg0.id, v1);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = VaultAdminCapKey{dummy_field: false};
        let v5 = VaultAdminCap<T0>{
            id       : 0x2::derived_object::claim<VaultAdminCapKey>(&mut v2, v4),
            vault_id : v3,
        };
        let v6 = Vault<T0>{
            id                 : v2,
            vaulted_cap_id     : v0,
            vaulted_cap        : 0x1::option::some<0x2::borrow::Referent<T0>>(0x2::borrow::new<T0>(arg1, arg2)),
            authorized_plugins : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
        };
        let v7 = VaultCreatedEvent<T0>{
            registry_id    : 0x2::object::id<VaultRegistry>(arg0),
            vault_id       : v3,
            vaulted_cap_id : v0,
            cap_id         : 0x2::object::id<VaultAdminCap<T0>>(&v5),
        };
        0x2::event::emit<VaultCreatedEvent<T0>>(v7);
        (v6, v5)
    }

    public fun put_back<T0: store + key>(arg0: &mut Vault<T0>, arg1: T0, arg2: 0x2::borrow::Borrow) {
        assert!(0x1::option::is_some<0x2::borrow::Referent<T0>>(&arg0.vaulted_cap), 4);
        0x2::borrow::put_back<T0>(0x1::option::borrow_mut<0x2::borrow::Referent<T0>>(&mut arg0.vaulted_cap), arg1, arg2);
    }

    public fun derive_address<T0: store + key>(arg0: &VaultRegistry, arg1: 0x2::object::ID) : address {
        let v0 = VaultKey<T0>{pos0: arg1};
        0x2::derived_object::derive_address<VaultKey<T0>>(0x2::object::id<VaultRegistry>(arg0), v0)
    }

    fun authorize<T0: store + key>(arg0: &Vault<T0>, arg1: &VaultAdminCap<T0>) {
        assert!(0x2::object::id<Vault<T0>>(arg0) == arg1.vault_id, 0);
    }

    public fun authorize_plugin<T0: store + key, T1: drop>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: T1) {
        authorize<T0>(arg0, arg1);
        assert!(0x1::option::is_some<0x2::borrow::Referent<T0>>(&arg0.vaulted_cap), 4);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(!0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.authorized_plugins, &v0), 1);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut arg0.authorized_plugins, v0);
        let v1 = PluginAuthorizedEvent<T0, T1>{
            vault_id                : 0x2::object::id<Vault<T0>>(arg0),
            vaulted_cap_id          : arg0.vaulted_cap_id,
            authorized_plugin_count : 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.authorized_plugins),
        };
        0x2::event::emit<PluginAuthorizedEvent<T0, T1>>(v1);
    }

    public fun authorized_plugins<T0: store + key>(arg0: &Vault<T0>) : &0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        &arg0.authorized_plugins
    }

    public fun borrow_as_admin<T0: store + key>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>) : (T0, 0x2::borrow::Borrow) {
        authorize<T0>(arg0, arg1);
        assert!(0x1::option::is_some<0x2::borrow::Referent<T0>>(&arg0.vaulted_cap), 4);
        0x2::borrow::borrow<T0>(0x1::option::borrow_mut<0x2::borrow::Referent<T0>>(&mut arg0.vaulted_cap))
    }

    public fun borrow_as_plugin<T0: store + key, T1: drop>(arg0: &mut Vault<T0>, arg1: T1) : (T0, 0x2::borrow::Borrow) {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.authorized_plugins, &v0), 2);
        0x2::borrow::borrow<T0>(0x1::option::borrow_mut<0x2::borrow::Referent<T0>>(&mut arg0.vaulted_cap))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VaultRegistry{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<VaultRegistry>(v0);
        let v1 = VaultRegistryCreatedEvent{registry_id: 0x2::object::id<VaultRegistry>(&v0)};
        0x2::event::emit<VaultRegistryCreatedEvent>(v1);
    }

    public fun is_active<T0: store + key>(arg0: &Vault<T0>) : bool {
        0x1::option::is_some<0x2::borrow::Referent<T0>>(&arg0.vaulted_cap)
    }

    public fun is_plugin_authorized<T0: store + key, T1: drop>(arg0: &Vault<T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.authorized_plugins, &v0)
    }

    public fun restore_vaulted_cap<T0: store + key>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>, arg2: T0, arg3: &mut 0x2::tx_context::TxContext) {
        authorize<T0>(arg0, arg1);
        assert!(0x2::object::id<T0>(&arg2) == arg0.vaulted_cap_id, 5);
        0x1::option::fill<0x2::borrow::Referent<T0>>(&mut arg0.vaulted_cap, 0x2::borrow::new<T0>(arg2, arg3));
        let v0 = VaultCapabilityRestoredEvent<T0>{
            vault_id       : 0x2::object::id<Vault<T0>>(arg0),
            vaulted_cap_id : arg0.vaulted_cap_id,
        };
        0x2::event::emit<VaultCapabilityRestoredEvent<T0>>(v0);
    }

    public fun revoke_plugin<T0: store + key, T1: drop>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>) {
        authorize<T0>(arg0, arg1);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&arg0.authorized_plugins, &v0), 2);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut arg0.authorized_plugins, &v0);
        let v1 = PluginRevokedEvent<T0, T1>{
            vault_id                : 0x2::object::id<Vault<T0>>(arg0),
            vaulted_cap_id          : arg0.vaulted_cap_id,
            authorized_plugin_count : 0x2::vec_set::length<0x1::type_name::TypeName>(&arg0.authorized_plugins),
        };
        0x2::event::emit<PluginRevokedEvent<T0, T1>>(v1);
    }

    public fun share<T0: store + key>(arg0: Vault<T0>) {
        0x2::transfer::share_object<Vault<T0>>(arg0);
    }

    public fun vaulted_cap_id<T0: store + key>(arg0: &Vault<T0>) : 0x2::object::ID {
        arg0.vaulted_cap_id
    }

    public fun withdraw_vaulted_cap<T0: store + key>(arg0: &mut Vault<T0>, arg1: &VaultAdminCap<T0>) : T0 {
        authorize<T0>(arg0, arg1);
        assert!(0x2::vec_set::is_empty<0x1::type_name::TypeName>(&arg0.authorized_plugins), 3);
        let v0 = VaultCapabilityWithdrawnEvent<T0>{
            vault_id       : 0x2::object::id<Vault<T0>>(arg0),
            vaulted_cap_id : arg0.vaulted_cap_id,
        };
        0x2::event::emit<VaultCapabilityWithdrawnEvent<T0>>(v0);
        0x2::borrow::destroy<T0>(0x1::option::extract<0x2::borrow::Referent<T0>>(&mut arg0.vaulted_cap))
    }

    // decompiled from Move bytecode v7
}

