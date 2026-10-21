module 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::stamp {
    struct LiquidlinkStamp {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        auth_sig: 0x1::type_name::TypeName,
        owner: address,
        subject_id: 0x2::object::ID,
        op: u8,
        amount: u64,
        duration: u64,
        redirects: vector<PointRedirect>,
        confirmed_policies: vector<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>,
        confirm_only: vector<PolicyRoute>,
        historical: bool,
        accrual_checkpoint: 0x1::option::Option<AccrualCheckpoint>,
    }

    struct AccrualSequenceKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AccrualCheckpoint has copy, drop {
        state_id: 0x2::object::ID,
        sequence: u64,
        drained: bool,
    }

    struct PolicyRoute has copy, drop, store {
        policy: 0x1::type_name::TypeName,
        state_id: 0x2::object::ID,
    }

    struct PointRedirect has copy, drop, store {
        owner: address,
        op: u8,
        amount: u64,
        duration: u64,
    }

    struct StampCreated has copy, drop {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        auth_sig: 0x1::type_name::TypeName,
        owner: address,
        subject_id: 0x2::object::ID,
        op: u8,
        amount: u64,
        duration: u64,
    }

    struct StampPolicyConfirmed has copy, drop {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        owner: address,
        subject_id: 0x2::object::ID,
        policy: 0x1::type_name::TypeName,
        policy_state_id: 0x2::object::ID,
        registration_generation: u64,
    }

    struct StampAmountAdjusted has copy, drop {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        owner: address,
        subject_id: 0x2::object::ID,
        policy: 0x1::type_name::TypeName,
        policy_state_id: 0x2::object::ID,
        registration_generation: u64,
        amount_before: u64,
        amount_after: u64,
        multiplier_bps: u64,
    }

    struct StampRedirectAdded has copy, drop {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        owner: address,
        recipient: address,
        subject_id: 0x2::object::ID,
        policy: 0x1::type_name::TypeName,
        policy_state_id: 0x2::object::ID,
        registration_generation: u64,
        amount: u64,
        bps: u64,
    }

    struct StampSettled has copy, drop {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        source_id: 0x2::object::ID,
        auth_sig: 0x1::type_name::TypeName,
        owner: address,
        subject_id: 0x2::object::ID,
        op: u8,
        amount: u64,
        duration: u64,
    }

    struct PolicyScoreSettled has copy, drop {
        project_object_id: 0x2::object::ID,
        project_id: 0x2::object::ID,
        scoreboard_id: 0x2::object::ID,
        policy: 0x1::type_name::TypeName,
        policy_state_id: 0x2::object::ID,
        registration_generation: u64,
        owner: address,
        subject_id: 0x2::object::ID,
        amount: u64,
        duration: u64,
    }

    public fun accrual_checkpoint(arg0: &LiquidlinkStamp) : 0x1::option::Option<AccrualCheckpoint> {
        arg0.accrual_checkpoint
    }

    public fun accrual_drained(arg0: &AccrualCheckpoint) : bool {
        arg0.drained
    }

    public fun accrual_sequence(arg0: &AccrualCheckpoint) : u64 {
        arg0.sequence
    }

    public fun accrual_state(arg0: &AccrualCheckpoint) : 0x2::object::ID {
        arg0.state_id
    }

    public fun amount(arg0: &LiquidlinkStamp) : u64 {
        arg0.amount
    }

    public fun apply_multiplier_bps<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: T0, arg3: 0x2::object::ID, arg4: &mut LiquidlinkStamp, arg5: u64) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(!is_confirm_only<T0>(arg4, arg3), 10);
        assert!(arg5 > 0, 6);
        assert_stamp_project_match(arg1, arg4);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::assert_next_policy(arg1, &arg4.confirmed_policies, v0, arg3);
        assert!(!contains_registration(&arg4.confirmed_policies, &v1), 4);
        let v2 = arg4.amount;
        let v3 = mul_div_to_u64(v2, arg5, 10000);
        arg4.amount = v3;
        0x1::vector::push_back<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>(&mut arg4.confirmed_policies, v1);
        let v4 = StampAmountAdjusted{
            project_object_id       : arg4.project_object_id,
            project_id              : arg4.project_id,
            scoreboard_id           : arg4.scoreboard_id,
            source_id               : arg4.source_id,
            owner                   : arg4.owner,
            subject_id              : arg4.subject_id,
            policy                  : v0,
            policy_state_id         : arg3,
            registration_generation : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_generation(&v1),
            amount_before           : v2,
            amount_after            : v3,
            multiplier_bps          : arg5,
        };
        0x2::event::emit<StampAmountAdjusted>(v4);
        emit_policy_confirmed(arg4, v0, arg3, &v1);
    }

    fun assert_stamp_project_match(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg1: &LiquidlinkStamp) {
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::id(arg0) == arg1.project_object_id, 3);
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg0) == arg1.project_id, 3);
        assert!(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::scoreboard_id(arg0) == arg1.scoreboard_id, 3);
    }

    public fun begin_add<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: T0, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: u64) : LiquidlinkStamp {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        begin_operation<T0>(arg1, arg3, arg4, arg5, 1, arg6, arg7)
    }

    fun begin_operation<T0: drop>(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID, arg4: u8, arg5: u64, arg6: u64) : LiquidlinkStamp {
        if (arg4 == 2) {
            assert!(arg5 > 0, 1);
        };
        let v0 = if (arg4 == 1) {
            true
        } else if (arg4 == 3) {
            true
        } else {
            arg4 == 4
        };
        if (v0) {
            assert!(arg6 > 0, 2);
        } else {
            assert!(arg4 == 2, 0);
        };
        let v1 = 0x1::type_name::with_original_ids<T0>();
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::assert_auth_source(arg0, v1, arg1);
        let v2 = LiquidlinkStamp{
            project_object_id  : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::id(arg0),
            project_id         : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg0),
            scoreboard_id      : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::scoreboard_id(arg0),
            source_id          : arg1,
            auth_sig           : v1,
            owner              : arg2,
            subject_id         : arg3,
            op                 : arg4,
            amount             : arg5,
            duration           : arg6,
            redirects          : 0x1::vector::empty<PointRedirect>(),
            confirmed_policies : 0x1::vector::empty<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>(),
            confirm_only       : 0x1::vector::empty<PolicyRoute>(),
            historical         : false,
            accrual_checkpoint : 0x1::option::none<AccrualCheckpoint>(),
        };
        let v3 = StampCreated{
            project_object_id : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::id(arg0),
            project_id        : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg0),
            scoreboard_id     : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::scoreboard_id(arg0),
            source_id         : arg1,
            auth_sig          : v1,
            owner             : arg2,
            subject_id        : arg3,
            op                : arg4,
            amount            : arg5,
            duration          : arg6,
        };
        0x2::event::emit<StampCreated>(v3);
        v2
    }

    public fun begin_set_linear<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: T0, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: u64) : LiquidlinkStamp {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        begin_operation<T0>(arg1, arg3, arg4, arg5, 3, arg6, arg7)
    }

    public fun begin_subtract<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: T0, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::object::ID, arg6: u64) : LiquidlinkStamp {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        begin_operation<T0>(arg1, arg3, arg4, arg5, 2, arg6, 1)
    }

    public fun begin_update_linear<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: T0, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::object::ID, arg6: u64, arg7: u64) : LiquidlinkStamp {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        begin_operation<T0>(arg1, arg3, arg4, arg5, 4, arg6, arg7)
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun confirm_policy<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: T0, arg3: 0x2::object::ID, arg4: &mut LiquidlinkStamp) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert_stamp_project_match(arg1, arg4);
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::assert_next_policy(arg1, &arg4.confirmed_policies, v0, arg3);
        assert!(!contains_registration(&arg4.confirmed_policies, &v1), 4);
        0x1::vector::push_back<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>(&mut arg4.confirmed_policies, v1);
        let v2 = StampPolicyConfirmed{
            project_object_id       : arg4.project_object_id,
            project_id              : arg4.project_id,
            scoreboard_id           : arg4.scoreboard_id,
            source_id               : arg4.source_id,
            owner                   : arg4.owner,
            subject_id              : arg4.subject_id,
            policy                  : v0,
            policy_state_id         : arg3,
            registration_generation : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_generation(&v1),
        };
        0x2::event::emit<StampPolicyConfirmed>(v2);
    }

    fun contains_registration(arg0: &vector<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>(arg0)) {
            let v1 = 0x1::vector::borrow<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>(arg0, v0);
            let v2 = if (0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_policy(v1) == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_policy(arg1)) {
                if (0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_state_id(v1) == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_state_id(arg1)) {
                    0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_generation(v1) == 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_generation(arg1)
                } else {
                    false
                }
            } else {
                false
            };
            if (v2) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun duration(arg0: &LiquidlinkStamp) : u64 {
        arg0.duration
    }

    fun emit_policy_confirmed(arg0: &LiquidlinkStamp, arg1: 0x1::type_name::TypeName, arg2: 0x2::object::ID, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration) {
        let v0 = StampPolicyConfirmed{
            project_object_id       : arg0.project_object_id,
            project_id              : arg0.project_id,
            scoreboard_id           : arg0.scoreboard_id,
            source_id               : arg0.source_id,
            owner                   : arg0.owner,
            subject_id              : arg0.subject_id,
            policy                  : arg1,
            policy_state_id         : arg2,
            registration_generation : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_generation(arg3),
        };
        0x2::event::emit<StampPolicyConfirmed>(v0);
    }

    public fun historical(arg0: &LiquidlinkStamp) : bool {
        arg0.historical
    }

    public fun is_confirm_only<T0>(arg0: &LiquidlinkStamp, arg1: 0x2::object::ID) : bool {
        let v0 = PolicyRoute{
            policy   : 0x1::type_name::with_original_ids<T0>(),
            state_id : arg1,
        };
        0x1::vector::contains<PolicyRoute>(&arg0.confirm_only, &v0)
    }

    public fun mark_accrual<T0: drop>(arg0: T0, arg1: &mut LiquidlinkStamp, arg2: &mut 0x2::object::UID, arg3: bool) {
        mark_historical<T0>(arg0, arg1);
        let v0 = AccrualSequenceKey{dummy_field: false};
        if (!0x2::dynamic_field::exists<AccrualSequenceKey>(arg2, v0)) {
            0x2::dynamic_field::add<AccrualSequenceKey, u64>(arg2, v0, 0);
        };
        let v1 = 0x2::dynamic_field::borrow_mut<AccrualSequenceKey, u64>(arg2, v0);
        *v1 = *v1 + 1;
        let v2 = AccrualCheckpoint{
            state_id : 0x2::object::uid_to_inner(arg2),
            sequence : *v1,
            drained  : arg3,
        };
        arg1.accrual_checkpoint = 0x1::option::some<AccrualCheckpoint>(v2);
    }

    public fun mark_historical<T0: drop>(arg0: T0, arg1: &mut LiquidlinkStamp) {
        assert!(arg1.auth_sig == 0x1::type_name::with_original_ids<T0>(), 9);
        assert!(arg1.op == 1 && 0x1::vector::is_empty<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>(&arg1.confirmed_policies), 0);
        arg1.historical = true;
    }

    fun merge_linear_redirect(arg0: &mut vector<PointRedirect>, arg1: address, arg2: u8, arg3: u64, arg4: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PointRedirect>(arg0)) {
            let v1 = 0x1::vector::borrow_mut<PointRedirect>(arg0, v0);
            if (v1.owner == arg1) {
                assert!(v1.op == arg2, 8);
                assert!(v1.duration == arg4, 2);
                v1.amount = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v1.amount, arg3);
                return
            };
            v0 = v0 + 1;
        };
        let v2 = PointRedirect{
            owner    : arg1,
            op       : arg2,
            amount   : arg3,
            duration : arg4,
        };
        0x1::vector::push_back<PointRedirect>(arg0, v2);
    }

    fun mul_div_to_u64(arg0: u64, arg1: u64, arg2: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (arg2 as u128);
        assert!(v0 <= 18446744073709551615, 5);
        (v0 as u64)
    }

    public fun op(arg0: &LiquidlinkStamp) : u8 {
        arg0.op
    }

    public fun op_add() : u8 {
        1
    }

    public fun op_set_linear() : u8 {
        3
    }

    public fun op_subtract() : u8 {
        2
    }

    public fun op_update_linear() : u8 {
        4
    }

    public fun owner(arg0: &LiquidlinkStamp) : address {
        arg0.owner
    }

    public fun policy_dependencies(arg0: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project) : vector<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::PolicyDependency> {
        let v0 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registrations(arg0);
        to_policy_dependencies(&v0)
    }

    public fun project_object_id(arg0: &LiquidlinkStamp) : 0x2::object::ID {
        arg0.project_object_id
    }

    public fun redirect_bps<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: T0, arg3: 0x2::object::ID, arg4: &mut LiquidlinkStamp, arg5: address, arg6: u64) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(!is_confirm_only<T0>(arg4, arg3), 10);
        assert!(arg6 <= 10000, 7);
        let v0 = if (arg4.op == 1) {
            true
        } else if (arg4.op == 3) {
            true
        } else {
            arg4.op == 4
        };
        assert!(v0, 8);
        assert_stamp_project_match(arg1, arg4);
        let v1 = 0x1::type_name::with_original_ids<T0>();
        let v2 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::assert_next_policy(arg1, &arg4.confirmed_policies, v1, arg3);
        assert!(!contains_registration(&arg4.confirmed_policies, &v2), 4);
        let v3 = mul_div_to_u64(arg4.amount, arg6, 10000);
        arg4.amount = arg4.amount - v3;
        if (v3 > 0) {
            let v4 = PointRedirect{
                owner    : arg5,
                op       : arg4.op,
                amount   : v3,
                duration : arg4.duration,
            };
            0x1::vector::push_back<PointRedirect>(&mut arg4.redirects, v4);
        } else if (arg4.op == 3 || arg4.op == 4) {
            let v5 = PointRedirect{
                owner    : arg5,
                op       : arg4.op,
                amount   : 0,
                duration : arg4.duration,
            };
            0x1::vector::push_back<PointRedirect>(&mut arg4.redirects, v5);
        };
        0x1::vector::push_back<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>(&mut arg4.confirmed_policies, v2);
        let v6 = StampRedirectAdded{
            project_object_id       : arg4.project_object_id,
            project_id              : arg4.project_id,
            scoreboard_id           : arg4.scoreboard_id,
            source_id               : arg4.source_id,
            owner                   : arg4.owner,
            recipient               : arg5,
            subject_id              : arg4.subject_id,
            policy                  : v1,
            policy_state_id         : arg3,
            registration_generation : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_generation(&v2),
            amount                  : v3,
            bps                     : arg6,
        };
        0x2::event::emit<StampRedirectAdded>(v6);
        emit_policy_confirmed(arg4, v1, arg3, &v2);
    }

    public fun redirects(arg0: &LiquidlinkStamp) : vector<PointRedirect> {
        arg0.redirects
    }

    public fun require_confirm_only<T0: drop, T1>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: T0, arg2: &mut LiquidlinkStamp, arg3: 0x2::object::ID) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        assert!(arg2.auth_sig == 0x1::type_name::with_original_ids<T0>(), 9);
        assert!(0x1::vector::is_empty<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>(&arg2.confirmed_policies), 10);
        let v0 = PolicyRoute{
            policy   : 0x1::type_name::with_original_ids<T1>(),
            state_id : arg3,
        };
        if (!0x1::vector::contains<PolicyRoute>(&arg2.confirm_only, &v0)) {
            0x1::vector::push_back<PolicyRoute>(&mut arg2.confirm_only, v0);
        };
    }

    public fun settle_add<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: T0, arg3: 0x2::object::ID, arg4: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg5: u64, arg6: u64, arg7: address, arg8: 0x2::object::ID, arg9: &0x2::clock::Clock) {
        settle_stamp(arg0, arg1, arg4, begin_add<T0>(arg0, arg1, arg2, arg3, arg7, arg8, arg5, arg6), arg9);
    }

    public fun settle_policy_add<T0: drop, T1: key>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: &T1, arg3: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicySettlementCap<T0>, arg4: T0, arg5: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg6: u64, arg7: u64, arg8: address, arg9: 0x2::object::ID) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::assert_scoreboard_match(arg1, arg5);
        let v0 = 0x2::object::id<T1>(arg2);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::assert_policy_settlement_cap<T0>(arg1, v0, arg3);
        if (arg6 > 0) {
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::add_score(arg5, arg6, arg7, arg8);
        };
        let v1 = PolicyScoreSettled{
            project_object_id       : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::id(arg1),
            project_id              : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::project_id(arg1),
            scoreboard_id           : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::scoreboard_id(arg1),
            policy                  : 0x1::type_name::with_original_ids<T0>(),
            policy_state_id         : v0,
            registration_generation : 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_settlement_cap_generation<T0>(arg3),
            owner                   : arg8,
            subject_id              : arg9,
            amount                  : arg6,
            duration                : arg7,
        };
        0x2::event::emit<PolicyScoreSettled>(v1);
    }

    fun settle_redirects(arg0: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg1: vector<PointRedirect>, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: address, arg5: 0x2::object::ID, arg6: vector<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::PolicyDependency>, arg7: &0x2::clock::Clock) {
        let v0 = 0x1::vector::empty<PointRedirect>();
        0x1::vector::reverse<PointRedirect>(&mut arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<PointRedirect>(&arg1)) {
            let PointRedirect {
                owner    : v2,
                op       : v3,
                amount   : v4,
                duration : v5,
            } = 0x1::vector::pop_back<PointRedirect>(&mut arg1);
            if (v3 == 1) {
                if (v4 > 0) {
                    0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::add_score(arg0, v4, v5, v2);
                };
            } else {
                assert!(v3 == 3 || v3 == 4, 8);
                let v6 = &mut v0;
                merge_linear_redirect(v6, v2, v3, v4, v5);
            };
            v1 = v1 + 1;
        };
        0x1::vector::destroy_empty<PointRedirect>(arg1);
        0x1::vector::reverse<PointRedirect>(&mut v0);
        let v7 = 0;
        while (v7 < 0x1::vector::length<PointRedirect>(&v0)) {
            let PointRedirect {
                owner    : v8,
                op       : _,
                amount   : v10,
                duration : v11,
            } = 0x1::vector::pop_back<PointRedirect>(&mut v0);
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::set_linear_stream(arg0, v10, v11, arg7, v8, arg4, arg2, arg3, arg5, arg6);
            v7 = v7 + 1;
        };
        0x1::vector::destroy_empty<PointRedirect>(v0);
    }

    public fun settle_set_linear<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: T0, arg3: 0x2::object::ID, arg4: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg5: u64, arg6: u64, arg7: address, arg8: 0x2::object::ID, arg9: &0x2::clock::Clock) {
        settle_stamp(arg0, arg1, arg4, begin_set_linear<T0>(arg0, arg1, arg2, arg3, arg7, arg8, arg5, arg6), arg9);
    }

    public fun settle_stamp(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg3: LiquidlinkStamp, arg4: &0x2::clock::Clock) {
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::package_version::assert_domain_enabled(arg0, 0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::router_domain());
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::assert_scoreboard_match(arg1, arg2);
        assert_stamp_project_match(arg1, &arg3);
        0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::assert_required_policies(arg1, &arg3.confirmed_policies);
        let v0 = to_policy_dependencies(&arg3.confirmed_policies);
        let LiquidlinkStamp {
            project_object_id  : v1,
            project_id         : v2,
            scoreboard_id      : v3,
            source_id          : v4,
            auth_sig           : v5,
            owner              : v6,
            subject_id         : v7,
            op                 : v8,
            amount             : v9,
            duration           : v10,
            redirects          : v11,
            confirmed_policies : _,
            confirm_only       : _,
            historical         : _,
            accrual_checkpoint : _,
        } = arg3;
        let v16 = v11;
        let v17 = v9;
        if (v8 == 3 || v8 == 4) {
            let v18 = 0x1::vector::empty<PointRedirect>();
            let v19 = v16;
            0x1::vector::reverse<PointRedirect>(&mut v19);
            let v20 = 0;
            while (v20 < 0x1::vector::length<PointRedirect>(&v19)) {
                let v21 = 0x1::vector::pop_back<PointRedirect>(&mut v19);
                if (v21.owner == v6) {
                    assert!(v21.op == v8 && v21.duration == v10, 8);
                    v17 = 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::point_math::checked_add(v17, v21.amount);
                } else {
                    0x1::vector::push_back<PointRedirect>(&mut v18, v21);
                };
                v20 = v20 + 1;
            };
            0x1::vector::destroy_empty<PointRedirect>(v19);
            v16 = v18;
        };
        if (v8 == 1) {
            if (v17 > 0) {
                0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::add_score(arg2, v17, v10, v6);
            };
            settle_redirects(arg2, v16, v4, v7, v6, v1, v0, arg4);
        } else if (v8 == 2) {
            assert!(0x1::vector::is_empty<PointRedirect>(&v16), 8);
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::sub_score(arg2, v17, v6);
        } else if (v8 == 3) {
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::set_linear_stream(arg2, v17, v10, arg4, v6, v6, v4, v7, v1, v0);
            settle_redirects(arg2, v16, v4, v7, v6, v1, v0, arg4);
        } else {
            assert!(v8 == 4, 0);
            0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::update_linear_stream(arg2, v17, v10, arg4, v6, v6, v4, v7, v1, v0);
            settle_redirects(arg2, v16, v4, v7, v6, v1, v0, arg4);
        };
        let v22 = StampSettled{
            project_object_id : v1,
            project_id        : v2,
            scoreboard_id     : v3,
            source_id         : v4,
            auth_sig          : v5,
            owner             : v6,
            subject_id        : v7,
            op                : v8,
            amount            : v17,
            duration          : v10,
        };
        0x2::event::emit<StampSettled>(v22);
    }

    public fun settle_subtract<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: T0, arg3: 0x2::object::ID, arg4: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg5: u64, arg6: address, arg7: 0x2::object::ID, arg8: &0x2::clock::Clock) {
        settle_stamp(arg0, arg1, arg4, begin_subtract<T0>(arg0, arg1, arg2, arg3, arg6, arg7, arg5), arg8);
    }

    public fun settle_update_linear<T0: drop>(arg0: &0xceb670f2749c93192f50d32f3343b0e34911465e434ed7230333afc48f33272b::global_config::GlobalConfig, arg1: &0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::Project, arg2: T0, arg3: 0x2::object::ID, arg4: &mut 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::Scoreboard, arg5: u64, arg6: u64, arg7: address, arg8: 0x2::object::ID, arg9: &0x2::clock::Clock) {
        settle_stamp(arg0, arg1, arg4, begin_update_linear<T0>(arg0, arg1, arg2, arg3, arg7, arg8, arg5, arg6), arg9);
    }

    public fun source_id(arg0: &LiquidlinkStamp) : 0x2::object::ID {
        arg0.source_id
    }

    public fun subject_id(arg0: &LiquidlinkStamp) : 0x2::object::ID {
        arg0.subject_id
    }

    fun to_policy_dependencies(arg0: &vector<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>) : vector<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::PolicyDependency> {
        let v0 = 0x1::vector::empty<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::PolicyDependency>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>(arg0)) {
            let v2 = 0x1::vector::borrow<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::PolicyRegistration>(arg0, v1);
            0x1::vector::push_back<0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::PolicyDependency>(&mut v0, 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::scoreboard::new_policy_dependency(0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_policy(v2), 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_state_id(v2), 0x15e9e1df6c5c67e16244069eb4b2feb10f16ae7d3f06fc51b8b51e1dc70a6f37::project::policy_registration_generation(v2)));
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v7
}

