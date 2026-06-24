module 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::policy {
    struct Policy<phantom T0> has key {
        id: 0x2::object::UID,
        required_approvals: 0x2::vec_map::VecMap<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>,
        versioning: 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::versioning::Versioning,
        clawback_allowed: bool,
    }

    struct PolicyCap<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    struct PolicyCapKey has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun versioning<T0>(arg0: &Policy<T0>) : 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::versioning::Versioning {
        arg0.versioning
    }

    public(friend) fun is_clawback_allowed<T0>(arg0: &Policy<T0>) : bool {
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::versioning::assert_is_valid_version(&arg0.versioning);
        arg0.clawback_allowed
    }

    public fun new_for_currency<T0>(arg0: &mut 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::namespace::Namespace, arg1: &mut 0x2::coin::TreasuryCap<T0>, arg2: bool) : (Policy<0x2::balance::Balance<T0>>, PolicyCap<0x2::balance::Balance<T0>>) {
        assert!(!0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::namespace::policy_exists<0x2::balance::Balance<T0>>(arg0), 13835058274325495809);
        let v0 = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::namespace::versioning(arg0);
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::versioning::assert_is_valid_version(&v0);
        let v1 = Policy<0x2::balance::Balance<T0>>{
            id                 : 0x2::derived_object::claim<0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::keys::PolicyKey<0x2::balance::Balance<T0>>>(0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::namespace::uid_mut(arg0), 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::keys::policy_key<0x2::balance::Balance<T0>>()),
            required_approvals : 0x2::vec_map::empty<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(),
            versioning         : v0,
            clawback_allowed   : arg2,
        };
        let v2 = PolicyCapKey{dummy_field: false};
        let v3 = PolicyCap<0x2::balance::Balance<T0>>{id: 0x2::derived_object::claim<PolicyCapKey>(&mut v1.id, v2)};
        (v1, v3)
    }

    public fun remove_action_approval<T0>(arg0: &mut Policy<T0>, arg1: &PolicyCap<T0>, arg2: 0x1::string::String) {
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::versioning::assert_is_valid_version(&arg0.versioning);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.required_approvals, &arg2);
    }

    public fun required_approvals<T0>(arg0: &Policy<T0>, arg1: 0x1::string::String) : 0x2::vec_set::VecSet<0x1::type_name::TypeName> {
        assert!(0x2::vec_map::contains<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.required_approvals, &arg1), 13835621331653361669);
        *0x2::vec_map::get<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.required_approvals, &arg1)
    }

    public fun set_required_approval<T0, T1: drop>(arg0: &mut Policy<T0>, arg1: &PolicyCap<T0>, arg2: 0x1::string::String) {
        set_required_approvals<T0>(arg0, arg1, arg2, 0x2::vec_set::singleton<0x1::type_name::TypeName>(0x1::type_name::with_defining_ids<T1>()));
    }

    public(friend) fun set_required_approvals<T0>(arg0: &mut Policy<T0>, arg1: &PolicyCap<T0>, arg2: 0x1::string::String, arg3: 0x2::vec_set::VecSet<0x1::type_name::TypeName>) {
        0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::versioning::assert_is_valid_version(&arg0.versioning);
        assert!(0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::keys::is_valid_action(arg2), 13835340019885277187);
        if (0x2::vec_map::contains<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&arg0.required_approvals, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.required_approvals, &arg2);
        };
        0x2::vec_map::insert<0x1::string::String, 0x2::vec_set::VecSet<0x1::type_name::TypeName>>(&mut arg0.required_approvals, arg2, arg3);
    }

    public fun share<T0>(arg0: Policy<T0>) {
        0x2::transfer::share_object<Policy<T0>>(arg0);
    }

    public fun sync_versioning<T0>(arg0: &mut Policy<T0>, arg1: &0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::namespace::Namespace) {
        arg0.versioning = 0x8fed859c611a0ed6f598c6abff26c3f61b98a770a0f0c9f602ac04ab5625bb5d::namespace::versioning(arg1);
    }

    // decompiled from Move bytecode v7
}

