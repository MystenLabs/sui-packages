module 0xc30b7f9ee9753b874ba97171897b087288a239109faeeb38cb85cd4e1cad000::versioning {
    struct Versioning has copy, drop, store {
        blocked_versions: 0x2::vec_set::VecSet<u64>,
    }

    struct VersionRegistry has key {
        id: 0x2::object::UID,
        upgrade_cap_id: 0x1::option::Option<0x2::object::ID>,
        versioning: Versioning,
    }

    struct VersioningRule has drop {
        dummy_field: bool,
    }

    struct VersionBlocked has copy, drop {
        sender: address,
        version: u64,
    }

    struct VersionUnblocked has copy, drop {
        sender: address,
        version: u64,
    }

    public(friend) fun new() : Versioning {
        Versioning{blocked_versions: 0x2::vec_set::empty<u64>()}
    }

    public(friend) fun versioning(arg0: &VersionRegistry) : Versioning {
        arg0.versioning
    }

    public(friend) fun add_policy_versioning<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: Versioning, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = VersioningRule{dummy_field: false};
        0x2::token::add_rule_config<T0, VersioningRule, Versioning>(v0, arg0, arg1, arg2, arg3);
    }

    public fun assert_is_valid_version(arg0: &Versioning) {
        assert!(is_current_version_valid(arg0), 0);
    }

    public fun assert_policy_version<T0>(arg0: &0x2::token::TokenPolicy<T0>) {
        assert!(has_policy_versioning<T0>(arg0), 3);
        let v0 = VersioningRule{dummy_field: false};
        assert!(is_current_version_valid(0x2::token::rule_config<T0, VersioningRule, Versioning>(v0, arg0)), 0);
    }

    public fun block_version(arg0: &mut VersionRegistry, arg1: &0x2::package::UpgradeCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(is_linked_cap(arg0, arg1), 2);
        if (0x2::vec_set::contains<u64>(&arg0.versioning.blocked_versions, &arg2)) {
            return
        };
        0x2::vec_set::insert<u64>(&mut arg0.versioning.blocked_versions, arg2);
        let v0 = VersionBlocked{
            sender  : 0x2::tx_context::sender(arg3),
            version : arg2,
        };
        0x2::event::emit<VersionBlocked>(v0);
    }

    public fun current_breaking_version() : u64 {
        1
    }

    public fun has_policy_versioning<T0>(arg0: &0x2::token::TokenPolicy<T0>) : bool {
        0x2::token::has_rule_config<T0, VersioningRule>(arg0)
    }

    public fun has_upgrade_cap(arg0: &VersionRegistry) : bool {
        0x1::option::is_some<0x2::object::ID>(&arg0.upgrade_cap_id)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = VersionRegistry{
            id             : 0x2::object::new(arg0),
            upgrade_cap_id : 0x1::option::none<0x2::object::ID>(),
            versioning     : new(),
        };
        0x2::transfer::share_object<VersionRegistry>(v0);
    }

    public fun is_current_version_valid(arg0: &Versioning) : bool {
        is_valid_version(arg0, 1)
    }

    fun is_linked_cap(arg0: &VersionRegistry, arg1: &0x2::package::UpgradeCap) : bool {
        let v0 = &arg0.upgrade_cap_id;
        if (0x1::option::is_some<0x2::object::ID>(v0)) {
            let v2 = 0x2::object::id<0x2::package::UpgradeCap>(arg1);
            0x1::option::borrow<0x2::object::ID>(v0) == &v2
        } else {
            false
        }
    }

    public fun is_policy_version_valid<T0>(arg0: &0x2::token::TokenPolicy<T0>) : bool {
        if (has_policy_versioning<T0>(arg0)) {
            let v1 = VersioningRule{dummy_field: false};
            is_current_version_valid(0x2::token::rule_config<T0, VersioningRule, Versioning>(v1, arg0))
        } else {
            false
        }
    }

    public fun is_valid_version(arg0: &Versioning, arg1: u64) : bool {
        !0x2::vec_set::contains<u64>(&arg0.blocked_versions, &arg1)
    }

    public fun is_version_blocked(arg0: &VersionRegistry, arg1: u64) : bool {
        !is_valid_version(&arg0.versioning, arg1)
    }

    public(friend) fun set_policy_versioning<T0>(arg0: &mut 0x2::token::TokenPolicy<T0>, arg1: &0x2::token::TokenPolicyCap<T0>, arg2: Versioning, arg3: &mut 0x2::tx_context::TxContext) {
        if (has_policy_versioning<T0>(arg0)) {
            let v0 = VersioningRule{dummy_field: false};
            *0x2::token::rule_config_mut<T0, VersioningRule, Versioning>(v0, arg0, arg1) = arg2;
        } else {
            add_policy_versioning<T0>(arg0, arg1, arg2, arg3);
        };
    }

    public fun setup(arg0: &mut VersionRegistry, arg1: &0x2::package::UpgradeCap) {
        assert!(0x1::option::is_none<0x2::object::ID>(&arg0.upgrade_cap_id), 1);
        let v0 = 0x1::type_name::with_defining_ids<VersionRegistry>();
        let v1 = 0x2::package::upgrade_package(arg1);
        assert!(0x1::type_name::address_string(&v0) == 0x2::address::to_ascii_string(0x2::object::id_to_address(&v1)), 2);
        0x1::option::fill<0x2::object::ID>(&mut arg0.upgrade_cap_id, 0x2::object::id<0x2::package::UpgradeCap>(arg1));
    }

    public fun unblock_version(arg0: &mut VersionRegistry, arg1: &0x2::package::UpgradeCap, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(is_linked_cap(arg0, arg1), 2);
        if (!0x2::vec_set::contains<u64>(&arg0.versioning.blocked_versions, &arg2)) {
            return
        };
        0x2::vec_set::remove<u64>(&mut arg0.versioning.blocked_versions, &arg2);
        let v0 = VersionUnblocked{
            sender  : 0x2::tx_context::sender(arg3),
            version : arg2,
        };
        0x2::event::emit<VersionUnblocked>(v0);
    }

    public fun upgrade_cap_id(arg0: &VersionRegistry) : 0x1::option::Option<0x2::object::ID> {
        arg0.upgrade_cap_id
    }

    // decompiled from Move bytecode v7
}

