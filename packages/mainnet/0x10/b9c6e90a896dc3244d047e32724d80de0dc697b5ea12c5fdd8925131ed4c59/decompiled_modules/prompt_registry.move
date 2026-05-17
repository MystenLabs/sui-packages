module 0x10b9c6e90a896dc3244d047e32724d80de0dc697b5ea12c5fdd8925131ed4c59::prompt_registry {
    struct PromptRegistry has key {
        id: 0x2::object::UID,
        version: u64,
        root_id: 0x2::object::ID,
        governance_vault_id: 0x2::object::ID,
        prompts: 0x2::table::Table<0x1::string::String, PromptRegistration>,
    }

    struct PromptRegistration has copy, drop, store {
        app_id: 0x1::string::String,
        route_id: 0x1::string::String,
        series_id: 0x2::object::ID,
        pinned_version_id: 0x1::option::Option<0x2::object::ID>,
        use_latest: bool,
        schema_version: u64,
        updated_epoch: u64,
        updated_by: address,
    }

    struct PromptRegistryCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        governance_vault_id: 0x2::object::ID,
    }

    struct PromptRegisteredEvent has copy, drop {
        registry_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        app_id: 0x1::string::String,
        route_id: 0x1::string::String,
        series_id: 0x2::object::ID,
        pinned_version_id: 0x1::option::Option<0x2::object::ID>,
        use_latest: bool,
        schema_version: u64,
        updated_epoch: u64,
        updated_by: address,
    }

    fun assert_active_operator(arg0: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg1: address) {
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::active_operator(arg0) == arg1, 1);
    }

    fun assert_governance_binding(arg0: 0x2::object::ID, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault) {
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_current_vault(arg1);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg1) == arg0, 1);
    }

    fun assert_registry_governance(arg0: &PromptRegistry, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault) {
        assert_governance_binding(arg0.root_id, arg1);
        assert!(arg0.governance_vault_id == 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg1), 1);
    }

    public fun contains_prompt(arg0: &PromptRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String) : bool {
        0x2::table::contains<0x1::string::String, PromptRegistration>(&arg0.prompts, prompt_key(&arg1, &arg2))
    }

    public fun create_registry(arg0: 0x2::object::ID, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id_to_address(&arg0) != @0x0, 6);
        assert_governance_binding(arg0, arg1);
        assert_active_operator(arg1, 0x2::tx_context::sender(arg2));
        let v0 = PromptRegistry{
            id                  : 0x2::object::new(arg2),
            version             : 1,
            root_id             : arg0,
            governance_vault_id : 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg1),
            prompts             : 0x2::table::new<0x1::string::String, PromptRegistration>(arg2),
        };
        let v1 = PromptRegistryCreatedEvent{
            registry_id         : 0x2::object::id<PromptRegistry>(&v0),
            root_id             : arg0,
            governance_vault_id : 0x2::object::id<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault>(arg1),
        };
        0x2::event::emit<PromptRegistryCreatedEvent>(v1);
        0x2::transfer::share_object<PromptRegistry>(v0);
    }

    fun prompt_key(arg0: &0x1::string::String, arg1: &0x1::string::String) : 0x1::string::String {
        let v0 = *arg0;
        0x1::string::append(&mut v0, 0x1::string::utf8(b":"));
        0x1::string::append(&mut v0, *arg1);
        v0
    }

    public fun prompt_registration(arg0: &PromptRegistry, arg1: 0x1::string::String, arg2: 0x1::string::String) : PromptRegistration {
        let v0 = prompt_key(&arg1, &arg2);
        assert!(0x2::table::contains<0x1::string::String, PromptRegistration>(&arg0.prompts, v0), 5);
        *0x2::table::borrow<0x1::string::String, PromptRegistration>(&arg0.prompts, v0)
    }

    public fun register_prompt(arg0: &mut PromptRegistry, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x2::object::ID, arg5: 0x1::option::Option<0x2::object::ID>, arg6: bool, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        assert_registry_governance(arg0, arg1);
        assert_active_operator(arg1, 0x2::tx_context::sender(arg8));
        validate_key(&arg2, 64, 2);
        validate_key(&arg3, 128, 3);
        assert!(arg6 || 0x1::option::is_some<0x2::object::ID>(&arg5), 4);
        let v0 = prompt_key(&arg2, &arg3);
        let v1 = PromptRegistration{
            app_id            : arg2,
            route_id          : arg3,
            series_id         : arg4,
            pinned_version_id : arg5,
            use_latest        : arg6,
            schema_version    : arg7,
            updated_epoch     : 0x2::tx_context::epoch(arg8),
            updated_by        : 0x2::tx_context::sender(arg8),
        };
        if (0x2::table::contains<0x1::string::String, PromptRegistration>(&arg0.prompts, v0)) {
            *0x2::table::borrow_mut<0x1::string::String, PromptRegistration>(&mut arg0.prompts, v0) = v1;
        } else {
            0x2::table::add<0x1::string::String, PromptRegistration>(&mut arg0.prompts, v0, v1);
        };
        let v2 = 0x2::table::borrow<0x1::string::String, PromptRegistration>(&arg0.prompts, v0);
        let v3 = PromptRegisteredEvent{
            registry_id       : 0x2::object::id<PromptRegistry>(arg0),
            root_id           : arg0.root_id,
            app_id            : v2.app_id,
            route_id          : v2.route_id,
            series_id         : v2.series_id,
            pinned_version_id : v2.pinned_version_id,
            use_latest        : v2.use_latest,
            schema_version    : v2.schema_version,
            updated_epoch     : v2.updated_epoch,
            updated_by        : v2.updated_by,
        };
        0x2::event::emit<PromptRegisteredEvent>(v3);
    }

    public fun registration_pinned_version_id(arg0: &PromptRegistration) : 0x1::option::Option<0x2::object::ID> {
        arg0.pinned_version_id
    }

    public fun registration_schema_version(arg0: &PromptRegistration) : u64 {
        arg0.schema_version
    }

    public fun registration_series_id(arg0: &PromptRegistration) : 0x2::object::ID {
        arg0.series_id
    }

    public fun registration_use_latest(arg0: &PromptRegistration) : bool {
        arg0.use_latest
    }

    public fun registry_governance_vault_id(arg0: &PromptRegistry) : 0x2::object::ID {
        arg0.governance_vault_id
    }

    public fun registry_root_id(arg0: &PromptRegistry) : 0x2::object::ID {
        arg0.root_id
    }

    public fun registry_version(arg0: &PromptRegistry) : u64 {
        arg0.version
    }

    fun validate_key(arg0: &0x1::string::String, arg1: u64, arg2: u64) {
        assert!(0x1::string::length(arg0) > 0, arg2);
        assert!(0x1::string::length(arg0) <= arg1, 7);
    }

    // decompiled from Move bytecode v7
}

