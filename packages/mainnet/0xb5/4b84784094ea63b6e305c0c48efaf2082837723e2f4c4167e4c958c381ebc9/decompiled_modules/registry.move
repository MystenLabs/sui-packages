module 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::registry {
    struct REGISTRY has drop {
        dummy_field: bool,
    }

    struct IronBankRegistry has key {
        id: 0x2::object::UID,
        inner: 0x2::versioned::Versioned,
    }

    struct RegistryInner has store {
        allowed_versions: 0x2::vec_set::VecSet<u64>,
        entities: 0x2::table::Table<0x1::type_name::TypeName, EntityInfo>,
        max_reward_ratio: u64,
    }

    struct EntityInfo has copy, drop, store {
        enabled: bool,
        registered_at_ms: u64,
        max_deposit: u64,
    }

    struct IronBankAdminCap has store, key {
        id: 0x2::object::UID,
    }

    public fun allowed_versions(arg0: &IronBankRegistry) : 0x2::vec_set::VecSet<u64> {
        load_inner(arg0).allowed_versions
    }

    public(friend) fun assert_entity_enabled<T0: drop>(arg0: &IronBankRegistry) {
        assert!(is_entity_registered<T0>(arg0), 13906835196545597441);
        assert!(is_entity_enabled<T0>(arg0), 13906835200840695811);
    }

    public(friend) fun assert_entity_registered<T0: drop>(arg0: &IronBankRegistry) {
        assert!(is_entity_registered<T0>(arg0), 13906835218020433921);
    }

    public(friend) fun assert_reward_within_ratio(arg0: &IronBankRegistry, arg1: u64, arg2: u64) {
        assert!(arg1 <= 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::math::mul(arg2, load_inner(arg0).max_reward_ratio), 13906835333985730579);
    }

    public(friend) fun assert_within_max_deposit<T0: drop>(arg0: &IronBankRegistry, arg1: u64) {
        let v0 = load_inner(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, EntityInfo>(&v0.entities, v1), 13906835269560041473);
        assert!(arg1 <= 0x2::table::borrow<0x1::type_name::TypeName, EntityInfo>(&v0.entities, v1).max_deposit, 13906835278150893583);
    }

    public fun disable_version(arg0: &mut IronBankRegistry, arg1: &IronBankAdminCap, arg2: u64) {
        let v0 = 0x2::versioned::load_value_mut<RegistryInner>(&mut arg0.inner);
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg2), 13906834986092986381);
        0x2::vec_set::remove<u64>(&mut v0.allowed_versions, &arg2);
    }

    public fun enable_version(arg0: &mut IronBankRegistry, arg1: &IronBankAdminCap, arg2: u64) {
        let v0 = 0x2::versioned::load_value_mut<RegistryInner>(&mut arg0.inner);
        assert!(!0x2::vec_set::contains<u64>(&v0.allowed_versions, &arg2), 13906834960323051531);
        0x2::vec_set::insert<u64>(&mut v0.allowed_versions, arg2);
    }

    fun init(arg0: REGISTRY, arg1: &mut 0x2::tx_context::TxContext) {
        share_new(arg1);
        let v0 = IronBankAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::public_transfer<IronBankAdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun is_entity_enabled<T0: drop>(arg0: &IronBankRegistry) : bool {
        is_entity_enabled_by_typename(arg0, 0x1::type_name::with_defining_ids<T0>())
    }

    public fun is_entity_enabled_by_typename(arg0: &IronBankRegistry, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = load_inner(arg0);
        !0x2::table::contains<0x1::type_name::TypeName, EntityInfo>(&v0.entities, arg1) && false || 0x2::table::borrow<0x1::type_name::TypeName, EntityInfo>(&v0.entities, arg1).enabled
    }

    public fun is_entity_registered<T0: drop>(arg0: &IronBankRegistry) : bool {
        0x2::table::contains<0x1::type_name::TypeName, EntityInfo>(&load_inner(arg0).entities, 0x1::type_name::with_defining_ids<T0>())
    }

    public(friend) fun load_inner(arg0: &IronBankRegistry) : &RegistryInner {
        let v0 = 0x2::versioned::load_value<RegistryInner>(&arg0.inner);
        let v1 = 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 13906835389819650057);
        v0
    }

    public(friend) fun load_inner_mut(arg0: &mut IronBankRegistry) : &mut RegistryInner {
        let v0 = 0x2::versioned::load_value_mut<RegistryInner>(&mut arg0.inner);
        let v1 = 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::constants::current_version();
        assert!(0x2::vec_set::contains<u64>(&v0.allowed_versions, &v1), 13906835359754878985);
        v0
    }

    public fun max_deposit<T0: drop>(arg0: &IronBankRegistry) : u64 {
        let v0 = load_inner(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, EntityInfo>(&v0.entities, v1)) {
            0
        } else {
            0x2::table::borrow<0x1::type_name::TypeName, EntityInfo>(&v0.entities, v1).max_deposit
        }
    }

    public fun max_reward_ratio(arg0: &IronBankRegistry) : u64 {
        load_inner(arg0).max_reward_ratio
    }

    public fun register_entity<T0: drop>(arg0: &mut IronBankRegistry, arg1: &IronBankAdminCap, arg2: &0x2::clock::Clock) {
        let v0 = load_inner_mut(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        let v2 = 0x2::clock::timestamp_ms(arg2);
        if (!0x2::table::contains<0x1::type_name::TypeName, EntityInfo>(&v0.entities, v1)) {
            let v3 = EntityInfo{
                enabled          : true,
                registered_at_ms : v2,
                max_deposit      : 18446744073709551615,
            };
            0x2::table::add<0x1::type_name::TypeName, EntityInfo>(&mut v0.entities, v1, v3);
            0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::events::emit_entity_registered(v1, v2);
        } else {
            let v4 = 0x2::table::borrow_mut<0x1::type_name::TypeName, EntityInfo>(&mut v0.entities, v1);
            assert!(!v4.enabled, 13906834681149784069);
            v4.enabled = true;
            0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::events::emit_entity_enabled(v1, v2);
        };
    }

    public fun revoke_entity<T0: drop>(arg0: &mut IronBankRegistry, arg1: &IronBankAdminCap, arg2: &0x2::clock::Clock) {
        let v0 = load_inner_mut(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, EntityInfo>(&v0.entities, v1), 13906834745574031361);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, EntityInfo>(&mut v0.entities, v1);
        assert!(v2.enabled, 13906834754164359175);
        v2.enabled = false;
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::events::emit_entity_revoked(v1, 0x2::clock::timestamp_ms(arg2));
    }

    public fun set_max_deposit<T0: drop>(arg0: &mut IronBankRegistry, arg1: &IronBankAdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = load_inner_mut(arg0);
        let v1 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, EntityInfo>(&v0.entities, v1), 13906834831473377281);
        let v2 = 0x2::table::borrow_mut<0x1::type_name::TypeName, EntityInfo>(&mut v0.entities, v1);
        let v3 = v2.max_deposit;
        if (v3 == arg2) {
            return
        };
        v2.max_deposit = arg2;
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::events::emit_max_deposit_updated(v1, v3, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    public fun set_max_reward_ratio(arg0: &mut IronBankRegistry, arg1: &IronBankAdminCap, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg2 <= 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::constants::max_reward_ratio_ceiling(), 13906834917373771793);
        let v0 = load_inner_mut(arg0);
        let v1 = v0.max_reward_ratio;
        if (v1 == arg2) {
            return
        };
        v0.max_reward_ratio = arg2;
        0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::events::emit_max_reward_ratio_updated(v1, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    fun share_new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::constants::current_version();
        let v1 = RegistryInner{
            allowed_versions : 0x2::vec_set::singleton<u64>(v0),
            entities         : 0x2::table::new<0x1::type_name::TypeName, EntityInfo>(arg0),
            max_reward_ratio : 0xb54b84784094ea63b6e305c0c48efaf2082837723e2f4c4167e4c958c381ebc9::constants::default_max_reward_ratio(),
        };
        let v2 = IronBankRegistry{
            id    : 0x2::object::new(arg0),
            inner : 0x2::versioned::create<RegistryInner>(v0, v1, arg0),
        };
        0x2::transfer::share_object<IronBankRegistry>(v2);
    }

    // decompiled from Move bytecode v7
}

