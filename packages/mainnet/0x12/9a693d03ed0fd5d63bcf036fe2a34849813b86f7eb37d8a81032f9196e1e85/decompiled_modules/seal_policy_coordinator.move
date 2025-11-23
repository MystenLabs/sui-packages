module 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::seal_policy_coordinator {
    struct EnclaveConfig has key {
        id: 0x2::object::UID,
        enclave_pk: vector<u8>,
        admin_addr: address,
    }

    struct IntentAccessGranted has copy, drop {
        intent_id: 0x2::object::ID,
        requester_addr: address,
        granted_at_ms: u64,
    }

    struct SolutionAccessGranted has copy, drop {
        solution_id: 0x2::object::ID,
        intent_id: 0x2::object::ID,
        requester_addr: address,
        granted_at_ms: u64,
    }

    struct EnclaveConfigUpdated has copy, drop {
        new_enclave_pk: vector<u8>,
        updated_at_ms: u64,
    }

    fun check_solver_access(arg0: address, arg1: &0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::SolverRegistry, arg2: &0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::TimeWindow, arg3: &0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::AccessCondition, arg4: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        if (v0 < 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::get_time_window_start(arg2) || v0 > 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::get_time_window_end(arg2)) {
            return false
        };
        if (0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::get_access_condition_requires_solver_registration(arg3)) {
            if (!0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::is_solver_active(arg1, arg0)) {
                return false
            };
            if (0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::get_solver_stake(arg1, arg0) < 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::get_access_condition_min_solver_stake(arg3)) {
                return false
            };
            let v1 = 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::get_access_condition_min_solver_reputation_score(arg3);
            if (v1 > 0) {
                if (0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::get_solver_reputation(arg1, arg0) < v1) {
                    return false
                };
            };
        };
        true
    }

    fun get_requester_role(arg0: &0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::SolverRegistry, arg1: address) : u8 {
        let v0 = 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::get_solver_profile(arg0, arg1);
        if (0x1::option::is_some<0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::SolverProfile>(&v0)) {
            1
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = EnclaveConfig{
            id         : 0x2::object::new(arg0),
            enclave_pk : 0x1::vector::empty<u8>(),
            admin_addr : 0x2::tx_context::sender(arg0),
        };
        0x2::transfer::share_object<EnclaveConfig>(v0);
    }

    fun is_enclave_caller(arg0: address, arg1: &EnclaveConfig) : bool {
        if (0x1::vector::is_empty<u8>(&arg1.enclave_pk)) {
            return false
        };
        0x2::address::to_bytes(arg0) == pk_to_address(&arg1.enclave_pk)
    }

    fun pk_to_address(arg0: &vector<u8>) : vector<u8> {
        let v0 = x"00";
        0x1::vector::append<u8>(&mut v0, *arg0);
        0x2::hash::blake2b256(&v0)
    }

    entry fun seal_approve_intent(arg0: &0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::Intent, arg1: &EnclaveConfig, arg2: &0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::solver_registry::SolverRegistry, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        if (is_enclave_caller(v0, arg1)) {
            let v1 = IntentAccessGranted{
                intent_id      : 0x2::object::id<0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::Intent>(arg0),
                requester_addr : v0,
                granted_at_ms  : 0x2::clock::timestamp_ms(arg3),
            };
            0x2::event::emit<IntentAccessGranted>(v1);
            return
        };
        assert!(!0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::is_intent_revoked(arg0), 3001);
        let v2 = 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::get_intent_policy(arg0);
        let v3 = 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::get_policy_access_condition(v2);
        let v4 = 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::get_policy_solver_window(v2);
        let v5 = get_requester_role(arg2, v0);
        assert!(v5 == 0 && v0 == 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::get_intent_user(arg0) || v5 == 1 && check_solver_access(v0, arg2, v4, v3, arg3), 3002);
        let v6 = IntentAccessGranted{
            intent_id      : 0x2::object::id<0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::Intent>(arg0),
            requester_addr : v0,
            granted_at_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<IntentAccessGranted>(v6);
    }

    entry fun seal_approve_solution(arg0: &0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::Solution, arg1: &EnclaveConfig, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        if (is_enclave_caller(v0, arg1)) {
            let v1 = SolutionAccessGranted{
                solution_id    : 0x2::object::id<0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::Solution>(arg0),
                intent_id      : 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::get_solution_intent_id(arg0),
                requester_addr : v0,
                granted_at_ms  : 0x2::clock::timestamp_ms(arg2),
            };
            0x2::event::emit<SolutionAccessGranted>(v1);
            return
        };
        assert!(v0 == 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::get_solution_solver(arg0), 3002);
        let v2 = SolutionAccessGranted{
            solution_id    : 0x2::object::id<0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::Solution>(arg0),
            intent_id      : 0x129a693d03ed0fd5d63bcf036fe2a34849813b86f7eb37d8a81032f9196e1e85::registry::get_solution_intent_id(arg0),
            requester_addr : v0,
            granted_at_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SolutionAccessGranted>(v2);
    }

    entry fun update_enclave_pk(arg0: &mut EnclaveConfig, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin_addr, 3002);
        arg0.enclave_pk = arg1;
        let v0 = EnclaveConfigUpdated{
            new_enclave_pk : arg1,
            updated_at_ms  : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<EnclaveConfigUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

