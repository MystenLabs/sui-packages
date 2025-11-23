module 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry {
    struct Treasury has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        total_fees_collected: u64,
        admin: address,
    }

    struct TimeWindow has copy, drop, store {
        start_ms: u64,
        end_ms: u64,
    }

    struct AccessCondition has copy, drop, store {
        requires_solver_registration: bool,
        min_solver_stake: u64,
        requires_attestation: bool,
        min_solver_reputation_score: u64,
    }

    struct PolicyParams has copy, drop, store {
        solver_access_window: TimeWindow,
        auto_revoke_ms: u64,
        access_condition: AccessCondition,
    }

    struct Attestation has copy, drop, store {
        input_hash: vector<u8>,
        output_hash: vector<u8>,
        measurement: vector<u8>,
        signature: vector<u8>,
        timestamp_ms: u64,
    }

    struct Intent has store, key {
        id: 0x2::object::UID,
        user_addr: address,
        created_ms: u64,
        blob_id: 0x1::string::String,
        policy: PolicyParams,
        intent_fee: 0x2::balance::Balance<0x2::sui::SUI>,
        status: u8,
        best_solution_id: 0x1::option::Option<0x2::object::ID>,
        pending_solutions: vector<0x2::object::ID>,
    }

    struct Solution has store, key {
        id: 0x2::object::UID,
        intent_id: 0x2::object::ID,
        solver_addr: address,
        created_ms: u64,
        blob_id: 0x1::string::String,
        attestation: 0x1::option::Option<Attestation>,
        status: u8,
    }

    struct IntentSubmitted has copy, drop {
        intent_id: 0x2::object::ID,
        user_addr: address,
        blob_id: 0x1::string::String,
        created_ms: u64,
        solver_access_start_ms: u64,
        solver_access_end_ms: u64,
        fee_amount: u64,
    }

    struct IntentRevoked has copy, drop {
        intent_id: 0x2::object::ID,
        user_addr: address,
        revoked_at_ms: u64,
        refunded_fee: u64,
    }

    struct IntentExecuted has copy, drop {
        intent_id: 0x2::object::ID,
        solution_id: 0x2::object::ID,
        user_addr: address,
        executed_at_ms: u64,
        solver_reward: u64,
        platform_fee: u64,
    }

    struct SolutionSubmitted has copy, drop {
        solution_id: 0x2::object::ID,
        intent_id: 0x2::object::ID,
        solver_addr: address,
        blob_id: 0x1::string::String,
        created_ms: u64,
    }

    struct SolutionAttested has copy, drop {
        solution_id: 0x2::object::ID,
        intent_id: 0x2::object::ID,
        solver_addr: address,
        attested_at_ms: u64,
        measurement: vector<u8>,
    }

    struct SolutionSelected has copy, drop {
        intent_id: 0x2::object::ID,
        solution_id: 0x2::object::ID,
        user_addr: address,
        selected_at_ms: u64,
    }

    struct SolutionRejected has copy, drop {
        solution_id: 0x2::object::ID,
        intent_id: 0x2::object::ID,
        reason: vector<u8>,
        rejected_at_ms: u64,
    }

    public entry fun attest_solution(arg0: &mut Solution, arg1: &Intent, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 6008);
        assert!(arg0.intent_id == 0x2::object::uid_to_inner(&arg1.id), 6005);
        let v0 = Attestation{
            input_hash   : arg2,
            output_hash  : arg3,
            measurement  : arg4,
            signature    : arg5,
            timestamp_ms : arg6,
        };
        arg0.attestation = 0x1::option::some<Attestation>(v0);
        arg0.status = 1;
        let v1 = SolutionAttested{
            solution_id    : 0x2::object::uid_to_inner(&arg0.id),
            intent_id      : arg0.intent_id,
            solver_addr    : arg0.solver_addr,
            attested_at_ms : 0x2::clock::timestamp_ms(arg7),
            measurement    : arg4,
        };
        0x2::event::emit<SolutionAttested>(v1);
    }

    fun bytes_equal(arg0: &vector<u8>, arg1: &vector<u8>) : bool {
        if (0x1::vector::length<u8>(arg0) != 0x1::vector::length<u8>(arg1)) {
            return false
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            if (*0x1::vector::borrow<u8>(arg0, v0) != *0x1::vector::borrow<u8>(arg1, v0)) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    public entry fun execute_solution(arg0: &mut Intent, arg1: &mut Solution, arg2: &mut Treasury, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg0.user_addr == v0, 6005);
        assert!(arg0.status == 1, 6008);
        let v1 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(*0x1::option::borrow<0x2::object::ID>(&arg0.best_solution_id) == v1, 6005);
        assert!(arg1.status == 1, 6009);
        let v2 = 0x2::balance::value<0x2::sui::SUI>(&arg0.intent_fee);
        let v3 = v2 * 1000 / 10000;
        0x2::balance::join<0x2::sui::SUI>(&mut arg2.balance, 0x2::balance::split<0x2::sui::SUI>(&mut arg0.intent_fee, v3));
        arg2.total_fees_collected = arg2.total_fees_collected + v3;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.intent_fee), arg4), arg1.solver_addr);
        arg0.status = 2;
        arg1.status = 3;
        let v4 = IntentExecuted{
            intent_id      : 0x2::object::uid_to_inner(&arg0.id),
            solution_id    : v1,
            user_addr      : v0,
            executed_at_ms : 0x2::clock::timestamp_ms(arg3),
            solver_reward  : v2 - v3,
            platform_fee   : v3,
        };
        0x2::event::emit<IntentExecuted>(v4);
    }

    public fun get_access_condition_min_solver_reputation_score(arg0: &AccessCondition) : u64 {
        arg0.min_solver_reputation_score
    }

    public fun get_access_condition_min_solver_stake(arg0: &AccessCondition) : u64 {
        arg0.min_solver_stake
    }

    public fun get_access_condition_requires_solver_registration(arg0: &AccessCondition) : bool {
        arg0.requires_solver_registration
    }

    public fun get_attestation(arg0: &Solution) : 0x1::option::Option<Attestation> {
        arg0.attestation
    }

    public fun get_intent_best_solution(arg0: &Intent) : 0x1::option::Option<0x2::object::ID> {
        arg0.best_solution_id
    }

    public fun get_intent_blob_id(arg0: &Intent) : 0x1::string::String {
        arg0.blob_id
    }

    public fun get_intent_id(arg0: &Intent) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_intent_pending_solutions(arg0: &Intent) : vector<0x2::object::ID> {
        arg0.pending_solutions
    }

    public fun get_intent_policy(arg0: &Intent) : &PolicyParams {
        &arg0.policy
    }

    public fun get_intent_status(arg0: &Intent) : u8 {
        arg0.status
    }

    public fun get_intent_user(arg0: &Intent) : address {
        arg0.user_addr
    }

    public fun get_policy_access_condition(arg0: &PolicyParams) : &AccessCondition {
        &arg0.access_condition
    }

    public fun get_policy_solver_window(arg0: &PolicyParams) : &TimeWindow {
        &arg0.solver_access_window
    }

    public fun get_solution_blob_id(arg0: &Solution) : 0x1::string::String {
        arg0.blob_id
    }

    public fun get_solution_id(arg0: &Solution) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_solution_intent_id(arg0: &Solution) : 0x2::object::ID {
        arg0.intent_id
    }

    public fun get_solution_solver(arg0: &Solution) : address {
        arg0.solver_addr
    }

    public fun get_solution_status(arg0: &Solution) : u8 {
        arg0.status
    }

    public fun get_time_window_end(arg0: &TimeWindow) : u64 {
        arg0.end_ms
    }

    public fun get_time_window_start(arg0: &TimeWindow) : u64 {
        arg0.start_ms
    }

    public fun has_attestation(arg0: &Solution) : bool {
        0x1::option::is_some<Attestation>(&arg0.attestation)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury{
            id                   : 0x2::object::new(arg0),
            balance              : 0x2::balance::zero<0x2::sui::SUI>(),
            total_fees_collected : 0,
            admin                : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<Treasury>(v0);
    }

    public fun is_intent_revoked(arg0: &Intent) : bool {
        arg0.status == 3
    }

    public entry fun reject_solution(arg0: &mut Solution, arg1: &mut 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::SolverRegistry, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        arg0.status = 4;
        let v0 = SolutionRejected{
            solution_id    : 0x2::object::uid_to_inner(&arg0.id),
            intent_id      : arg0.intent_id,
            reason         : arg2,
            rejected_at_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<SolutionRejected>(v0);
    }

    public entry fun revoke_intent(arg0: &mut Intent, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg0.user_addr == v0, 6005);
        assert!(arg0.status == 0, 6008);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.intent_fee);
        if (v1 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.intent_fee), arg2), v0);
        };
        arg0.status = 3;
        let v2 = IntentRevoked{
            intent_id     : 0x2::object::uid_to_inner(&arg0.id),
            user_addr     : v0,
            revoked_at_ms : 0x2::clock::timestamp_ms(arg1),
            refunded_fee  : v1,
        };
        0x2::event::emit<IntentRevoked>(v2);
    }

    public entry fun select_best_solution(arg0: &mut Intent, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg0.user_addr == v0, 6005);
        assert!(arg0.status == 0, 6007);
        assert!(0x1::vector::contains<0x2::object::ID>(&arg0.pending_solutions, &arg1), 6002);
        arg0.status = 1;
        arg0.best_solution_id = 0x1::option::some<0x2::object::ID>(arg1);
        let v1 = SolutionSelected{
            intent_id      : 0x2::object::uid_to_inner(&arg0.id),
            solution_id    : arg1,
            user_addr      : v0,
            selected_at_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SolutionSelected>(v1);
    }

    public entry fun submit_intent(arg0: 0x1::string::String, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64, arg6: bool, arg7: u64, arg8: 0x2::coin::Coin<0x2::sui::SUI>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg10);
        let v1 = 0x2::clock::timestamp_ms(arg9);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg8);
        assert!(0x1::string::length(&arg0) > 0, 6001);
        assert!(arg1 < arg2, 6006);
        assert!(v2 >= 1000000, 6010);
        let v3 = 0x2::object::new(arg10);
        let v4 = TimeWindow{
            start_ms : arg1,
            end_ms   : arg2,
        };
        let v5 = AccessCondition{
            requires_solver_registration : arg4,
            min_solver_stake             : arg5,
            requires_attestation         : arg6,
            min_solver_reputation_score  : arg7,
        };
        let v6 = PolicyParams{
            solver_access_window : v4,
            auto_revoke_ms       : arg3,
            access_condition     : v5,
        };
        let v7 = Intent{
            id                : v3,
            user_addr         : v0,
            created_ms        : v1,
            blob_id           : arg0,
            policy            : v6,
            intent_fee        : 0x2::coin::into_balance<0x2::sui::SUI>(arg8),
            status            : 0,
            best_solution_id  : 0x1::option::none<0x2::object::ID>(),
            pending_solutions : 0x1::vector::empty<0x2::object::ID>(),
        };
        let v8 = IntentSubmitted{
            intent_id              : 0x2::object::uid_to_inner(&v3),
            user_addr              : v0,
            blob_id                : v7.blob_id,
            created_ms             : v1,
            solver_access_start_ms : arg1,
            solver_access_end_ms   : arg2,
            fee_amount             : v2,
        };
        0x2::event::emit<IntentSubmitted>(v8);
        0x2::transfer::public_transfer<Intent>(v7, v0);
    }

    public entry fun submit_solution(arg0: &mut Intent, arg1: &0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::SolverRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        assert!(0x1::string::length(&arg2) > 0, 6001);
        assert!(arg0.status == 0, 6004);
        validate_solution_against_policy(arg0, v0, v1, arg1);
        let v2 = 0x2::object::new(arg4);
        let v3 = 0x2::object::uid_to_inner(&v2);
        let v4 = 0x2::object::uid_to_inner(&arg0.id);
        let v5 = Solution{
            id          : v2,
            intent_id   : v4,
            solver_addr : v0,
            created_ms  : v1,
            blob_id     : arg2,
            attestation : 0x1::option::none<Attestation>(),
            status      : 0,
        };
        0x1::vector::push_back<0x2::object::ID>(&mut arg0.pending_solutions, v3);
        let v6 = SolutionSubmitted{
            solution_id : v3,
            intent_id   : v4,
            solver_addr : v0,
            blob_id     : v5.blob_id,
            created_ms  : v1,
        };
        0x2::event::emit<SolutionSubmitted>(v6);
        0x2::transfer::public_transfer<Solution>(v5, v0);
    }

    fun validate_solution_against_policy(arg0: &Intent, arg1: address, arg2: u64, arg3: &0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::SolverRegistry) {
        let v0 = &arg0.policy;
        assert!(arg2 >= v0.solver_access_window.start_ms && arg2 <= v0.solver_access_window.end_ms, 6003);
        if (v0.auto_revoke_ms > 0) {
            assert!(arg2 <= v0.auto_revoke_ms, 6003);
        };
        if (v0.access_condition.requires_solver_registration) {
            assert!(0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::is_solver_active(arg3, arg1), 6002);
            assert!(0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::get_solver_stake(arg3, arg1) >= v0.access_condition.min_solver_stake, 6002);
        };
    }

    // decompiled from Move bytecode v6
}

