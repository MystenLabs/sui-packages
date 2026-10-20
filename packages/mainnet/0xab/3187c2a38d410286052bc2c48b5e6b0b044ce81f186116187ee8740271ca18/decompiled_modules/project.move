module 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project {
    struct Project has store, key {
        id: 0x2::object::UID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        auth_sources: vector<AuthSource>,
        policy_registrations: vector<PolicyRegistration>,
        policy_generations: vector<PolicyGeneration>,
        enabled: bool,
    }

    struct PolicySettlementCap<phantom T0: drop> has drop, store {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        policy: 0x1::type_name::TypeName,
        policy_state_id: 0x2::object::ID,
        registration_generation: u64,
    }

    struct PolicyRegistration has copy, drop, store {
        policy: 0x1::type_name::TypeName,
        policy_state_id: 0x2::object::ID,
        generation: u64,
    }

    struct PolicyGeneration has copy, drop, store {
        policy: 0x1::type_name::TypeName,
        generation: u64,
    }

    struct AuthSource has copy, drop, store {
        project_object_id: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
        source_id: 0x2::object::ID,
        enabled: bool,
    }

    struct PolicySettlementCapIssued has copy, drop {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        policy: 0x1::type_name::TypeName,
        policy_state_id: 0x2::object::ID,
        registration_generation: u64,
    }

    struct ProjectCreated has copy, drop {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
    }

    struct ProjectEnabledUpdated has copy, drop {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        enabled: bool,
    }

    struct AuthSourceUpdated has copy, drop {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        witness: 0x1::type_name::TypeName,
        enabled: bool,
    }

    struct PointPolicyUpdated has copy, drop {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        policy: 0x1::type_name::TypeName,
        policy_state_id: 0x2::object::ID,
        registration_generation: u64,
        enabled: bool,
    }

    public fun id(arg0: &Project) : 0x2::object::ID {
        0x2::object::id<Project>(arg0)
    }

    fun active_registration(arg0: &Project, arg1: 0x1::type_name::TypeName) : PolicyRegistration {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PolicyRegistration>(&arg0.policy_registrations)) {
            let v1 = *0x1::vector::borrow<PolicyRegistration>(&arg0.policy_registrations, v0);
            if (v1.policy == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        abort 3
    }

    fun advance_policy_generation(arg0: &mut Project, arg1: 0x1::type_name::TypeName) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PolicyGeneration>(&arg0.policy_generations)) {
            let v1 = 0x1::vector::borrow_mut<PolicyGeneration>(&mut arg0.policy_generations, v0);
            if (v1.policy == arg1) {
                assert!(v1.generation < 18446744073709551615, 7);
                v1.generation = v1.generation + 1;
                return v1.generation
            };
            v0 = v0 + 1;
        };
        let v2 = PolicyGeneration{
            policy     : arg1,
            generation : 1,
        };
        0x1::vector::push_back<PolicyGeneration>(&mut arg0.policy_generations, v2);
        1
    }

    public(friend) fun assert_auth_source(arg0: &Project, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) {
        assert_enabled(arg0);
        assert!(is_auth_source_enabled(arg0, arg1, arg2), 2);
    }

    public(friend) fun assert_enabled(arg0: &Project) {
        assert!(arg0.enabled, 4);
    }

    public(friend) fun assert_next_policy(arg0: &Project, arg1: &vector<PolicyRegistration>, arg2: 0x1::type_name::TypeName, arg3: 0x2::object::ID) : PolicyRegistration {
        assert!(0x1::vector::length<PolicyRegistration>(arg1) < 0x1::vector::length<PolicyRegistration>(&arg0.policy_registrations), 3);
        let v0 = *0x1::vector::borrow<PolicyRegistration>(&arg0.policy_registrations, 0x1::vector::length<PolicyRegistration>(arg1));
        assert!(v0.policy == arg2, 5);
        assert!(v0.policy_state_id == arg3, 8);
        v0
    }

    public(friend) fun assert_policy(arg0: &Project, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) {
        let v0 = active_registration(arg0, arg1);
        assert!(v0.policy_state_id == arg2, 8);
    }

    public(friend) fun assert_policy_settlement_cap<T0: drop>(arg0: &Project, arg1: 0x2::object::ID, arg2: &PolicySettlementCap<T0>) {
        assert_enabled(arg0);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        assert!(arg2.project_object_id == 0x2::object::id<Project>(arg0), 0);
        assert!(arg2.project_id == arg0.project_id, 0);
        assert!(arg2.scoreboard_id == arg0.scoreboard_id, 1);
        assert!(arg2.policy == v0, 3);
        assert!(arg2.policy_state_id == arg1, 8);
        let v1 = active_registration(arg0, v0);
        assert!(v1.policy_state_id == arg2.policy_state_id, 8);
        assert!(v1.generation == arg2.registration_generation, 9);
    }

    public(friend) fun assert_project_cap(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg1: &Project) {
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::get_project_cap_ID(arg0) == arg1.project_id, 0);
    }

    public(friend) fun assert_required_policies(arg0: &Project, arg1: &vector<PolicyRegistration>) {
        assert!(0x1::vector::length<PolicyRegistration>(arg1) == 0x1::vector::length<PolicyRegistration>(&arg0.policy_registrations), 3);
        let v0 = 0;
        while (v0 < 0x1::vector::length<PolicyRegistration>(&arg0.policy_registrations)) {
            let v1 = *0x1::vector::borrow<PolicyRegistration>(arg1, v0);
            let v2 = *0x1::vector::borrow<PolicyRegistration>(&arg0.policy_registrations, v0);
            assert!(v1.policy == v2.policy, 5);
            assert!(v1.policy_state_id == v2.policy_state_id, 8);
            assert!(v1.generation == v2.generation, 9);
            v0 = v0 + 1;
        };
    }

    public(friend) fun assert_scoreboard_match(arg0: &Project, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard) {
        assert!(0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(arg1) == arg0.scoreboard_id, 1);
        assert!(*0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::get_scoreboard_project_ID(arg1) == arg0.project_id, 1);
    }

    public fun auth_source_enabled<T0: drop>(arg0: &Project, arg1: T0, arg2: 0x2::object::ID) : bool {
        is_auth_source_enabled(arg0, 0x1::type_name::with_original_ids<T0>(), arg2)
    }

    public fun auth_source_enabled_by_type(arg0: &Project, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) : bool {
        is_auth_source_enabled(arg0, arg1, arg2)
    }

    public fun auth_sources(arg0: &Project) : vector<AuthSource> {
        arg0.auth_sources
    }

    public fun close_point_policy_scoring<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &Project, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: T0, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert_project_cap(arg1, arg2);
        assert_scoreboard_match(arg2, arg3);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<PolicyRegistration>(&arg2.policy_registrations)) {
            let v2 = 0x1::vector::borrow<PolicyRegistration>(&arg2.policy_registrations, v1);
            if (v2.policy == v0) {
                assert!(v2.policy_state_id == arg5, 8);
                0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::record_policy_cutoff(arg3, 0x2::object::id<Project>(arg2), v0, arg5, v2.generation, arg6);
                return
            };
            v1 = v1 + 1;
        };
        abort 3
    }

    fun contains_policy(arg0: &Project, arg1: 0x1::type_name::TypeName) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PolicyRegistration>(&arg0.policy_registrations)) {
            if (0x1::vector::borrow<PolicyRegistration>(&arg0.policy_registrations, v0).policy == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun create_and_share(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::new_scoreboard(arg1, arg2);
        0x2::transfer::public_share_object<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(v0);
        0x2::transfer::public_share_object<Project>(create_project(arg0, arg1, &v0, arg2));
    }

    public fun create_project(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg3: &mut 0x2::tx_context::TxContext) : Project {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        let v0 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::get_project_cap_ID(arg1);
        assert!(*0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::get_scoreboard_project_ID(arg2) == v0, 1);
        let v1 = Project{
            id                   : 0x2::object::new(arg3),
            project_id           : v0,
            scoreboard_id        : 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(arg2),
            auth_sources         : 0x1::vector::empty<AuthSource>(),
            policy_registrations : 0x1::vector::empty<PolicyRegistration>(),
            policy_generations   : 0x1::vector::empty<PolicyGeneration>(),
            enabled              : true,
        };
        let v2 = ProjectCreated{
            project_object_id : 0x2::object::id<Project>(&v1),
            project_id        : v0,
            scoreboard_id     : 0x2::object::id<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard>(arg2),
        };
        0x2::event::emit<ProjectCreated>(v2);
        v1
    }

    public fun enabled(arg0: &Project) : bool {
        arg0.enabled
    }

    fun is_auth_source_enabled(arg0: &Project, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AuthSource>(&arg0.auth_sources)) {
            let v1 = 0x1::vector::borrow<AuthSource>(&arg0.auth_sources, v0);
            let v2 = if (v1.project_object_id == 0x2::object::id<Project>(arg0)) {
                if (v1.witness == arg1) {
                    v1.source_id == arg2
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return v1.enabled
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun point_policies(arg0: &Project) : vector<0x1::type_name::TypeName> {
        let v0 = 0x1::vector::empty<0x1::type_name::TypeName>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<PolicyRegistration>(&arg0.policy_registrations)) {
            0x1::vector::push_back<0x1::type_name::TypeName>(&mut v0, 0x1::vector::borrow<PolicyRegistration>(&arg0.policy_registrations, v1).policy);
            v1 = v1 + 1;
        };
        v0
    }

    public fun policy_registration_generation(arg0: &PolicyRegistration) : u64 {
        arg0.generation
    }

    public fun policy_registration_policy(arg0: &PolicyRegistration) : 0x1::type_name::TypeName {
        arg0.policy
    }

    public fun policy_registration_state_id(arg0: &PolicyRegistration) : 0x2::object::ID {
        arg0.policy_state_id
    }

    public fun policy_registrations(arg0: &Project) : vector<PolicyRegistration> {
        arg0.policy_registrations
    }

    public fun policy_settlement_cap_generation<T0: drop>(arg0: &PolicySettlementCap<T0>) : u64 {
        arg0.registration_generation
    }

    public fun policy_settlement_cap_project_id<T0: drop>(arg0: &PolicySettlementCap<T0>) : 0x2::object::ID {
        arg0.project_id
    }

    public fun policy_settlement_cap_project_object_id<T0: drop>(arg0: &PolicySettlementCap<T0>) : 0x2::object::ID {
        arg0.project_object_id
    }

    public fun policy_settlement_cap_scoreboard_id<T0: drop>(arg0: &PolicySettlementCap<T0>) : 0x2::object::ID {
        arg0.scoreboard_id
    }

    public fun policy_settlement_cap_state_id<T0: drop>(arg0: &PolicySettlementCap<T0>) : 0x2::object::ID {
        arg0.policy_state_id
    }

    public fun project_id(arg0: &Project) : 0x2::object::ID {
        arg0.project_id
    }

    public fun register_auth_source<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &mut Project, arg3: T0, arg4: 0x2::object::ID) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert_project_cap(arg1, arg2);
        upsert_auth_source(arg2, 0x1::type_name::with_original_ids<T0>(), arg4, true);
    }

    public fun register_point_policy<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &mut Project, arg3: T0, arg4: 0x2::object::ID) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert_project_cap(arg1, arg2);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = register_policy(arg2, v0, arg4);
        let v2 = PointPolicyUpdated{
            project_object_id       : 0x2::object::id<Project>(arg2),
            project_id              : arg2.project_id,
            policy                  : v0,
            policy_state_id         : arg4,
            registration_generation : v1.generation,
            enabled                 : true,
        };
        0x2::event::emit<PointPolicyUpdated>(v2);
    }

    public fun register_point_policy_with_cap<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &mut Project, arg3: T0, arg4: 0x2::object::ID) : PolicySettlementCap<T0> {
        register_point_policy<T0>(arg0, arg1, arg2, arg3, arg4);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = active_registration(arg2, v0);
        let v2 = PolicySettlementCap<T0>{
            project_object_id       : 0x2::object::id<Project>(arg2),
            project_id              : arg2.project_id,
            scoreboard_id           : arg2.scoreboard_id,
            policy                  : v0,
            policy_state_id         : arg4,
            registration_generation : v1.generation,
        };
        let v3 = PolicySettlementCapIssued{
            project_object_id       : 0x2::object::id<Project>(arg2),
            project_id              : arg2.project_id,
            scoreboard_id           : arg2.scoreboard_id,
            policy                  : v0,
            policy_state_id         : arg4,
            registration_generation : v1.generation,
        };
        0x2::event::emit<PolicySettlementCapIssued>(v3);
        v2
    }

    fun register_policy(arg0: &mut Project, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID) : PolicyRegistration {
        assert!(!contains_policy(arg0, arg1), 6);
        let v0 = advance_policy_generation(arg0, arg1);
        let v1 = PolicyRegistration{
            policy          : arg1,
            policy_state_id : arg2,
            generation      : v0,
        };
        0x1::vector::push_back<PolicyRegistration>(&mut arg0.policy_registrations, v1);
        v1
    }

    public fun scoreboard_id(arg0: &Project) : 0x2::object::ID {
        arg0.scoreboard_id
    }

    public fun set_auth_source_enabled<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &mut Project, arg3: T0, arg4: 0x2::object::ID, arg5: bool) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert_project_cap(arg1, arg2);
        upsert_auth_source(arg2, 0x1::type_name::with_original_ids<T0>(), arg4, arg5);
    }

    public fun set_enabled(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &mut Project, arg3: bool) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert_project_cap(arg1, arg2);
        arg2.enabled = arg3;
        let v0 = ProjectEnabledUpdated{
            project_object_id : 0x2::object::id<Project>(arg2),
            project_id        : arg2.project_id,
            enabled           : arg3,
        };
        0x2::event::emit<ProjectEnabledUpdated>(v0);
    }

    public fun unregister_point_policy<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project_cap::ProjectCap, arg2: &mut Project, arg3: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg4: T0, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert_project_cap(arg1, arg2);
        assert_scoreboard_match(arg2, arg3);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<PolicyRegistration>(&arg2.policy_registrations)) {
            if (0x1::vector::borrow<PolicyRegistration>(&arg2.policy_registrations, v1).policy == v0) {
                assert!(0x1::vector::borrow<PolicyRegistration>(&arg2.policy_registrations, v1).policy_state_id == arg5, 8);
                let v2 = 0x1::vector::remove<PolicyRegistration>(&mut arg2.policy_registrations, v1);
                0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::record_policy_cutoff(arg3, 0x2::object::id<Project>(arg2), v0, v2.policy_state_id, v2.generation, arg6);
                advance_policy_generation(arg2, v0);
                let v3 = PointPolicyUpdated{
                    project_object_id       : 0x2::object::id<Project>(arg2),
                    project_id              : arg2.project_id,
                    policy                  : v0,
                    policy_state_id         : v2.policy_state_id,
                    registration_generation : v2.generation,
                    enabled                 : false,
                };
                0x2::event::emit<PointPolicyUpdated>(v3);
                return
            };
            v1 = v1 + 1;
        };
        abort 3
    }

    fun upsert_auth_source(arg0: &mut Project, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID, arg3: bool) {
        let v0 = 0x2::object::id<Project>(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<AuthSource>(&arg0.auth_sources)) {
            let v2 = 0x1::vector::borrow_mut<AuthSource>(&mut arg0.auth_sources, v1);
            if (v2.witness == arg1 && v2.source_id == arg2) {
                v2.enabled = arg3;
                let v3 = AuthSourceUpdated{
                    project_object_id : v0,
                    project_id        : arg0.project_id,
                    source_id         : arg2,
                    witness           : arg1,
                    enabled           : arg3,
                };
                0x2::event::emit<AuthSourceUpdated>(v3);
                return
            };
            v1 = v1 + 1;
        };
        let v4 = AuthSource{
            project_object_id : v0,
            witness           : arg1,
            source_id         : arg2,
            enabled           : arg3,
        };
        0x1::vector::push_back<AuthSource>(&mut arg0.auth_sources, v4);
        let v5 = AuthSourceUpdated{
            project_object_id : v0,
            project_id        : arg0.project_id,
            source_id         : arg2,
            witness           : arg1,
            enabled           : arg3,
        };
        0x2::event::emit<AuthSourceUpdated>(v5);
    }

    // decompiled from Move bytecode v7
}

