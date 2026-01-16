module 0xf1684efcebfea0daaeada7ab324cf3824192e16af5af1dc1a8bb2f476de77e96::vault_registry {
    struct VaultRegistry has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct VaultRegistryInner has store {
        registry_id: 0x2::object::ID,
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        vaults: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
    }

    struct AbyssAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct AbyssSupplierCap has key {
        id: 0x2::object::UID,
        margin_pool_supplier_cap: 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap,
    }

    struct VaultManagerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultIncentivesManagerCap has store, key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct VaultRegistered has copy, drop {
        vault_id: 0x2::object::ID,
        timestamp: u64,
    }

    struct VAULT_REGISTRY has drop {
        dummy_field: bool,
    }

    public fun mint_supplier_cap(arg0: &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_registry::MarginRegistry, arg1: &0x2::clock::Clock, arg2: &AbyssAdminCap, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = AbyssSupplierCap{
            id                       : 0x2::object::new(arg3),
            margin_pool_supplier_cap : 0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::mint_supplier_cap(arg0, arg1, arg3),
        };
        0x2::transfer::share_object<AbyssSupplierCap>(v0);
    }

    public fun disable_version(arg0: &mut VaultRegistry, arg1: u64, arg2: &AbyssAdminCap) {
        let v0 = 0x2::versioned::load_value_mut<VaultRegistryInner>(&mut arg0.inner);
        assert!(arg1 != 0xf1684efcebfea0daaeada7ab324cf3824192e16af5af1dc1a8bb2f476de77e96::abyss_constants::version(), 6);
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg1), 5);
        0x2::vec_set::remove<u64>(&mut v0.allowed_versions, &arg1);
    }

    public fun enable_version(arg0: &mut VaultRegistry, arg1: u64, arg2: &AbyssAdminCap) {
        let v0 = 0x2::versioned::load_value_mut<VaultRegistryInner>(&mut arg0.inner);
        assert!(!0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg1), 4);
        0x2::vec_set::insert<u64>(&mut v0.allowed_versions, arg1);
    }

    fun init(arg0: VAULT_REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let v1 = VaultRegistryInner{
            registry_id      : 0x2::object::uid_to_inner(&v0),
            allowed_versions : 0x2::vec_set::singleton<u64>(0xf1684efcebfea0daaeada7ab324cf3824192e16af5af1dc1a8bb2f476de77e96::abyss_constants::version()),
            vaults           : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg1),
        };
        let v2 = VaultRegistry{
            id    : v0,
            inner : 0x2::versioned::create<VaultRegistryInner>(0xf1684efcebfea0daaeada7ab324cf3824192e16af5af1dc1a8bb2f476de77e96::abyss_constants::version(), v1, arg1),
        };
        let v3 = AbyssAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<VaultRegistry>(v2);
        0x2::transfer::public_transfer<AbyssAdminCap>(v3, 0x2::tx_context::sender(arg1));
    }

    public(friend) fun load_inner(arg0: &VaultRegistry) : &VaultRegistryInner {
        let v0 = 0x2::versioned::load_value<VaultRegistryInner>(&arg0.inner);
        let v1 = 0xf1684efcebfea0daaeada7ab324cf3824192e16af5af1dc1a8bb2f476de77e96::abyss_constants::version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 2);
        v0
    }

    public(friend) fun load_inner_mut(arg0: &mut VaultRegistry) : &mut VaultRegistryInner {
        let v0 = 0x2::versioned::load_value_mut<VaultRegistryInner>(&mut arg0.inner);
        let v1 = 0xf1684efcebfea0daaeada7ab324cf3824192e16af5af1dc1a8bb2f476de77e96::abyss_constants::version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 2);
        v0
    }

    public(friend) fun load_supplier_cap(arg0: &AbyssSupplierCap) : &0x97d9473771b01f77b0940c589484184b49f6444627ec121314fae6a6d36fb86b::margin_pool::SupplierCap {
        &arg0.margin_pool_supplier_cap
    }

    public(friend) fun register_vault(arg0: &mut VaultRegistry, arg1: &AbyssAdminCap, arg2: 0x1::type_name::TypeName, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = load_inner_mut(arg0);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&v0.vaults, arg2), 3);
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut v0.vaults, arg2, arg3);
        let v1 = VaultManagerCap{
            id       : 0x2::object::new(arg5),
            vault_id : arg3,
        };
        let v2 = VaultIncentivesManagerCap{
            id       : 0x2::object::new(arg5),
            vault_id : arg3,
        };
        let v3 = VaultRegistered{
            vault_id  : arg3,
            timestamp : 0x2::clock::timestamp_ms(arg4),
        };
        0x2::event::emit<VaultRegistered>(v3);
        0x2::transfer::public_transfer<VaultManagerCap>(v1, 0x2::tx_context::sender(arg5));
        0x2::transfer::public_transfer<VaultIncentivesManagerCap>(v2, 0x2::tx_context::sender(arg5));
    }

    public fun validate_vault_incentives_manager_cap(arg0: &VaultIncentivesManagerCap, arg1: 0x2::object::ID) {
        assert!(arg0.vault_id == arg1, 7);
    }

    public fun validate_vault_manager_cap(arg0: &VaultManagerCap, arg1: 0x2::object::ID) {
        assert!(arg0.vault_id == arg1, 8);
    }

    public fun vault_id<T0>(arg0: &VaultRegistry) : 0x2::object::ID {
        let v0 = 0x2::versioned::load_value<VaultRegistryInner>(&arg0.inner);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&v0.vaults, v1), 1);
        *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&v0.vaults, v1)
    }

    public(friend) fun vault_incentives_manager_cap_id(arg0: &VaultIncentivesManagerCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun vault_manager_cap_id(arg0: &VaultManagerCap) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun vault_manager_vault_id(arg0: &VaultManagerCap) : 0x2::object::ID {
        arg0.vault_id
    }

    // decompiled from Move bytecode v6
}

