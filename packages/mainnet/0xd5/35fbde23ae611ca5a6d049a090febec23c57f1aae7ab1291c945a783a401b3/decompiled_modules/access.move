module 0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::access {
    struct PackageAdmin has store, key {
        id: 0x2::object::UID,
        package: 0x1::ascii::String,
    }

    struct Entity has store, key {
        id: 0x2::object::UID,
    }

    struct Rule has store {
        actions: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        conditions: 0x2::vec_set::VecSet<0x1::type_name::TypeName>,
        condition_configs: 0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::DynamicMap<0x1::type_name::TypeName>,
    }

    struct Policy has key {
        id: 0x2::object::UID,
        package: 0x1::ascii::String,
        allowed_entities: 0x2::vec_set::VecSet<0x2::object::ID>,
        rules: 0x2::vec_map::VecMap<address, Rule>,
        enabled: bool,
    }

    struct ActionRequest {
        action_name: 0x1::type_name::TypeName,
        context: 0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::DynamicMap<0x1::ascii::String>,
        approved_conditions: 0x2::vec_map::VecMap<0x1::type_name::TypeName, address>,
    }

    struct ConditionWitness<phantom T0, T1: copy + drop + store> has drop {
        rule_id: address,
        config: T1,
        policy: 0x2::object::ID,
        entity: 0x2::object::ID,
    }

    struct ConfigNone has copy, drop, store {
        dummy_field: bool,
    }

    public fun add_action_to_rule<T0: drop>(arg0: &mut Policy, arg1: &PackageAdmin, arg2: address) {
        assert!(arg0.package == arg1.package, 2);
        let v0 = 0x2::vec_map::get_mut<address, Rule>(&mut arg0.rules, &arg2);
        let v1 = 0x1::type_name::get<T0>();
        assert!(0x1::type_name::get_address(&v1) == arg1.package, 3);
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.actions, v1);
    }

    public fun add_condition_to_rule<T0: drop>(arg0: &mut Policy, arg1: &PackageAdmin, arg2: address) {
        let v0 = ConfigNone{dummy_field: false};
        add_condition_to_rule_with_config<T0, ConfigNone>(arg0, arg1, arg2, v0);
    }

    public fun add_condition_to_rule_with_config<T0: drop, T1: copy + drop + store>(arg0: &mut Policy, arg1: &PackageAdmin, arg2: address, arg3: T1) {
        assert!(arg0.package == arg1.package, 2);
        let v0 = 0x2::vec_map::get_mut<address, Rule>(&mut arg0.rules, &arg2);
        let v1 = 0x1::type_name::get<T0>();
        0x2::vec_set::insert<0x1::type_name::TypeName>(&mut v0.conditions, v1);
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::insert<0x1::type_name::TypeName, T1>(&mut v0.condition_configs, v1, arg3);
    }

    public fun add_config_for_condition<T0, T1: copy + drop + store>(arg0: &mut Policy, arg1: &PackageAdmin, arg2: address, arg3: T1) {
        assert!(arg0.package == arg1.package, 2);
        let v0 = 0x2::vec_map::get_mut<address, Rule>(&mut arg0.rules, &arg2);
        let v1 = 0x1::type_name::get<T0>();
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::remove<0x1::type_name::TypeName, ConfigNone>(&mut v0.condition_configs, v1);
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::insert<0x1::type_name::TypeName, T1>(&mut v0.condition_configs, v1, arg3);
    }

    public fun add_empty_rule(arg0: &mut Policy, arg1: &PackageAdmin, arg2: &mut 0x2::tx_context::TxContext) : address {
        assert!(arg0.package == arg1.package, 2);
        let v0 = 0x2::tx_context::fresh_object_address(arg2);
        let v1 = Rule{
            actions           : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            conditions        : 0x2::vec_set::empty<0x1::type_name::TypeName>(),
            condition_configs : 0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::new<0x1::type_name::TypeName>(arg2),
        };
        0x2::vec_map::insert<address, Rule>(&mut arg0.rules, v0, v1);
        v0
    }

    public fun admin_approve_request(arg0: ActionRequest, arg1: &PackageAdmin) {
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::force_drop<0x1::ascii::String>(admin_approve_request_and_return_context(arg0, arg1));
    }

    public fun admin_approve_request_and_return_context(arg0: ActionRequest, arg1: &PackageAdmin) : 0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::DynamicMap<0x1::ascii::String> {
        assert!(0x1::type_name::get_address(&arg0.action_name) == arg1.package, 3);
        let ActionRequest {
            action_name         : _,
            context             : v1,
            approved_conditions : _,
        } = arg0;
        v1
    }

    public fun allowlist_entity_for_policy(arg0: &mut Policy, arg1: &PackageAdmin, arg2: &Entity) {
        assert!(arg0.package == arg1.package, 2);
        0x2::vec_set::insert<0x2::object::ID>(&mut arg0.allowed_entities, 0x2::object::id<Entity>(arg2));
    }

    public fun approve_and_return_context(arg0: ActionRequest, arg1: &Entity, arg2: &Policy, arg3: address) : 0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::DynamicMap<0x1::ascii::String> {
        assert!(arg2.enabled, 4);
        let v0 = 0x2::object::id<Entity>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg2.allowed_entities, &v0), 5);
        let v1 = 0x2::vec_map::get<address, Rule>(&arg2.rules, &arg3);
        let ActionRequest {
            action_name         : v2,
            context             : v3,
            approved_conditions : v4,
        } = arg0;
        let v5 = v4;
        let v6 = v2;
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&v1.actions, &v6), 6);
        let v7 = v1.conditions;
        let v8 = 0;
        while (v8 < 0x2::vec_set::size<0x1::type_name::TypeName>(&v7)) {
            let (v9, v10) = 0x2::vec_map::pop<0x1::type_name::TypeName, address>(&mut v5);
            let v11 = v9;
            assert!(v10 == arg3, 7);
            0x2::vec_set::remove<0x1::type_name::TypeName>(&mut v7, &v11);
            v8 = v8 + 1;
        };
        v3
    }

    public fun approve_condition<T0: drop, T1: copy + drop + store>(arg0: &mut ActionRequest, arg1: &ConditionWitness<T0, T1>, arg2: T0) {
        0x2::vec_map::insert<0x1::type_name::TypeName, address>(&mut arg0.approved_conditions, 0x1::type_name::get<T0>(), arg1.rule_id);
    }

    public fun approve_request(arg0: ActionRequest, arg1: &Entity, arg2: &Policy, arg3: address) {
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::force_drop<0x1::ascii::String>(approve_and_return_context(arg0, arg1, arg2, arg3));
    }

    public fun borrow_condition_config<T0, T1: copy + drop + store>(arg0: &Policy, arg1: &address) : &T1 {
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::borrow<0x1::type_name::TypeName, T1>(&0x2::vec_map::get<address, Rule>(&arg0.rules, arg1).condition_configs, 0x1::type_name::get<T0>())
    }

    public fun borrow_context(arg0: &ActionRequest) : &0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::DynamicMap<0x1::ascii::String> {
        &arg0.context
    }

    public fun borrow_mut_condition_config<T0, T1: copy + drop + store>(arg0: &mut Policy, arg1: &PackageAdmin, arg2: address) : &mut T1 {
        assert!(arg0.package == arg1.package, 2);
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::borrow_mut<0x1::type_name::TypeName, T1>(&mut 0x2::vec_map::get_mut<address, Rule>(&mut arg0.rules, &arg2).condition_configs, 0x1::type_name::get<T0>())
    }

    public fun claim_package<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : PackageAdmin {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        let v0 = 0x1::type_name::get_with_original_ids<T0>();
        assert!(0x1::type_name::get_module(&v0) == 0x1::ascii::string(b"access_init"), 1);
        PackageAdmin{
            id      : 0x2::object::new(arg1),
            package : 0x1::type_name::get_address(&v0),
        }
    }

    public fun context_value<T0: copy + drop + store>(arg0: &ActionRequest, arg1: 0x1::ascii::String) : &T0 {
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::borrow<0x1::ascii::String, T0>(&arg0.context, arg1)
    }

    public fun create_empty_policy(arg0: &PackageAdmin, arg1: &mut 0x2::tx_context::TxContext) : Policy {
        Policy{
            id               : 0x2::object::new(arg1),
            package          : arg0.package,
            allowed_entities : 0x2::vec_set::empty<0x2::object::ID>(),
            rules            : 0x2::vec_map::empty<address, Rule>(),
            enabled          : true,
        }
    }

    public fun create_entity(arg0: &mut 0x2::tx_context::TxContext) : Entity {
        Entity{id: 0x2::object::new(arg0)}
    }

    public fun cw_config<T0, T1: copy + drop + store>(arg0: &ConditionWitness<T0, T1>) : T1 {
        arg0.config
    }

    public fun cw_entity_id<T0, T1: copy + drop + store>(arg0: &ConditionWitness<T0, T1>) : 0x2::object::ID {
        arg0.entity
    }

    public fun cw_policy_id<T0, T1: copy + drop + store>(arg0: &ConditionWitness<T0, T1>) : 0x2::object::ID {
        arg0.policy
    }

    public fun cw_rule_id<T0, T1: copy + drop + store>(arg0: &ConditionWitness<T0, T1>) : address {
        arg0.rule_id
    }

    public fun destroy_empty_policy(arg0: Policy, arg1: &PackageAdmin) {
        assert!(arg0.package == arg1.package, 2);
        let Policy {
            id               : v0,
            package          : _,
            allowed_entities : _,
            rules            : v3,
            enabled          : _,
        } = arg0;
        0x2::object::delete(v0);
        0x2::vec_map::destroy_empty<address, Rule>(v3);
    }

    public fun destroy_entity(arg0: Entity) {
        let Entity { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun disable_policy(arg0: &mut Policy, arg1: &PackageAdmin) {
        assert!(arg0.package == arg1.package, 2);
        arg0.enabled = false;
    }

    public fun drop_rule(arg0: &mut Policy, arg1: &PackageAdmin, arg2: address) {
        assert!(arg0.package == arg1.package, 2);
        let (_, v1) = 0x2::vec_map::remove<address, Rule>(&mut arg0.rules, &arg2);
        let Rule {
            actions           : _,
            conditions        : _,
            condition_configs : v4,
        } = v1;
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::force_drop<0x1::type_name::TypeName>(v4);
    }

    public fun enable_policy(arg0: &mut Policy, arg1: &PackageAdmin) {
        assert!(arg0.package == arg1.package, 2);
        arg0.enabled = true;
    }

    public fun get_condition_witness<T0, T1: drop, T2: copy + drop + store>(arg0: &Policy, arg1: &Entity, arg2: address) : ConditionWitness<T0, T2> {
        assert!(arg0.enabled, 4);
        let v0 = 0x2::object::id<Entity>(arg1);
        assert!(0x2::vec_set::contains<0x2::object::ID>(&arg0.allowed_entities, &v0), 5);
        let v1 = 0x2::vec_map::get<address, Rule>(&arg0.rules, &arg2);
        let v2 = 0x1::type_name::get<T1>();
        assert!(0x2::vec_set::contains<0x1::type_name::TypeName>(&v1.actions, &v2), 6);
        ConditionWitness<T0, T2>{
            rule_id : arg2,
            config  : *0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::borrow<0x1::type_name::TypeName, T2>(&v1.condition_configs, 0x1::type_name::get<T0>()),
            policy  : 0x2::object::id<Policy>(arg0),
            entity  : 0x2::object::id<Entity>(arg1),
        }
    }

    public fun irreversibly_destroy_admin(arg0: PackageAdmin) {
        let PackageAdmin {
            id      : v0,
            package : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public fun new_request<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : ActionRequest {
        ActionRequest{
            action_name         : 0x1::type_name::get<T0>(),
            context             : 0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::new<0x1::ascii::String>(arg1),
            approved_conditions : 0x2::vec_map::empty<0x1::type_name::TypeName, address>(),
        }
    }

    public fun new_request_for_resource<T0: key>(arg0: 0x1::ascii::String, arg1: &T0, arg2: &mut 0x2::tx_context::TxContext) : ActionRequest {
        let v0 = new_request<0x1::ascii::String>(arg0, arg2);
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::insert<0x1::ascii::String, 0x2::object::ID>(&mut v0.context, 0x1::ascii::string(b"resource_id"), 0x2::object::id<T0>(arg1));
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::insert<0x1::ascii::String, 0x1::type_name::TypeName>(&mut v0.context, 0x1::ascii::string(b"resource_type_name"), 0x1::type_name::get<T0>());
        v0
    }

    public fun new_request_with_context<T0: drop>(arg0: T0, arg1: 0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::DynamicMap<0x1::ascii::String>) : ActionRequest {
        ActionRequest{
            action_name         : 0x1::type_name::get<T0>(),
            context             : arg1,
            approved_conditions : 0x2::vec_map::empty<0x1::type_name::TypeName, address>(),
        }
    }

    public fun remove_action_from_rule<T0: drop>(arg0: &mut Policy, arg1: &PackageAdmin, arg2: address) {
        assert!(arg0.package == arg1.package, 2);
        let v0 = 0x1::type_name::get<T0>();
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut 0x2::vec_map::get_mut<address, Rule>(&mut arg0.rules, &arg2).actions, &v0);
    }

    public fun remove_condition_from_rule<T0: drop>(arg0: &mut Policy, arg1: &PackageAdmin, arg2: address) {
        assert!(arg0.package == arg1.package, 2);
        let v0 = 0x2::vec_map::get_mut<address, Rule>(&mut arg0.rules, &arg2);
        let v1 = 0x1::type_name::get<T0>();
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::remove<0x1::type_name::TypeName, ConfigNone>(&mut v0.condition_configs, v1);
        0x2::vec_set::remove<0x1::type_name::TypeName>(&mut v0.conditions, &v1);
    }

    public fun remove_config_for_condition<T0, T1: copy + drop + store>(arg0: &mut Policy, arg1: &PackageAdmin, arg2: address) {
        assert!(arg0.package == arg1.package, 2);
        let v0 = 0x2::vec_map::get_mut<address, Rule>(&mut arg0.rules, &arg2);
        let v1 = 0x1::type_name::get<T0>();
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::remove<0x1::type_name::TypeName, T1>(&mut v0.condition_configs, v1);
        let v2 = ConfigNone{dummy_field: false};
        0xd535fbde23ae611ca5a6d049a090febec23c57f1aae7ab1291c945a783a401b3::dynamic_map::insert<0x1::type_name::TypeName, ConfigNone>(&mut v0.condition_configs, v1, v2);
    }

    public fun remove_entity_from_policy(arg0: &mut Policy, arg1: &PackageAdmin, arg2: &Entity) {
        assert!(arg0.package == arg1.package, 2);
        let v0 = 0x2::object::id<Entity>(arg2);
        0x2::vec_set::remove<0x2::object::ID>(&mut arg0.allowed_entities, &v0);
    }

    public fun share_policy(arg0: Policy, arg1: &PackageAdmin) {
        assert!(arg0.package == arg1.package, 2);
        0x2::transfer::share_object<Policy>(arg0);
    }

    // decompiled from Move bytecode v6
}

