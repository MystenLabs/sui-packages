module 0xe465ec2863d8208a4943744f056f978fefa502d67d0a021de65efdee209ee83a::automaton {
    struct DeterministicAutomaton<phantom T0: copy + drop + store, phantom T1: copy + drop + store> has store {
        states: 0x2::table_vec::TableVec<T0>,
        alphabet: 0x2::table_vec::TableVec<T1>,
        transition: 0x2::table_vec::TableVec<0x2::table_vec::TableVec<u64>>,
        accepting: 0x2::table_vec::TableVec<bool>,
        start: u64,
    }

    struct ConfiguredAutomaton<phantom T0: copy + drop + store, phantom T1: copy + drop + store> has store, key {
        id: 0x2::object::UID,
        dfa: DeterministicAutomaton<T0, T1>,
    }

    struct TransitionKey<T0: copy + drop + store, T1: copy + drop + store> has copy, drop, store {
        state: 0x1::option::Option<T0>,
        symbol: T1,
    }

    struct TransitionConfigKey<T0: copy + drop + store, T1: copy + drop + store> has copy, drop, store {
        transition: TransitionKey<T0, T1>,
        config: 0x1::type_name::TypeName,
    }

    public fun new<T0: copy + drop + store, T1: copy + drop + store>(arg0: 0x2::table_vec::TableVec<T0>, arg1: 0x2::table_vec::TableVec<T1>, arg2: T0, arg3: 0x2::table_vec::TableVec<T0>, arg4: 0x2::table_vec::TableVec<0x2::table_vec::TableVec<T0>>, arg5: &mut 0x2::tx_context::TxContext) : DeterministicAutomaton<T0, T1> {
        assert!(0x2::table_vec::length<T0>(&arg0) > 0, 13906834874423050241);
        ensure_states_unique_table<T0>(&arg0);
        ensure_symbols_unique_table<T1>(&arg1);
        let v0 = accepting_bitmap_table<T0>(&arg0, &arg3, arg5);
        0x2::table_vec::drop<T0>(arg3);
        destroy_table_vec_of_table_vec<T0>(arg4);
        DeterministicAutomaton<T0, T1>{
            states     : arg0,
            alphabet   : arg1,
            transition : canonicalize_transition_table<T0, T1>(&arg0, &arg1, &arg4, arg5),
            accepting  : v0,
            start      : expect_state_index_table<T0>(&arg0, &arg2),
        }
    }

    fun accepting_bitmap_table<T0: copy + drop + store>(arg0: &0x2::table_vec::TableVec<T0>, arg1: &0x2::table_vec::TableVec<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::table_vec::TableVec<bool> {
        let v0 = 0x2::table_vec::empty<bool>(arg2);
        let v1 = 0;
        while (v1 < 0x2::table_vec::length<T0>(arg0)) {
            0x2::table_vec::push_back<bool>(&mut v0, false);
            v1 = v1 + 1;
        };
        let v2 = 0;
        while (v2 < 0x2::table_vec::length<T0>(arg1)) {
            let v3 = *0x2::table_vec::borrow<T0>(arg1, v2);
            *0x2::table_vec::borrow_mut<bool>(&mut v0, expect_state_index_table<T0>(arg0, &v3)) = true;
            v2 = v2 + 1;
        };
        v0
    }

    public fun accepts<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: &0x2::table_vec::TableVec<T1>) : bool {
        *0x2::table_vec::borrow<bool>(&arg0.accepting, follow<T0, T1>(arg0, arg0.start, arg1))
    }

    public fun add_state<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut DeterministicAutomaton<T0, T1>, arg1: T0, arg2: bool, arg3: &0x2::table_vec::TableVec<T0>, arg4: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = index_of_table_vec<T0>(&arg0.states, &arg1);
        assert!(0x1::option::is_none<u64>(&v0), 13906835673287884815);
        let v1 = 0x2::table_vec::length<T1>(&arg0.alphabet);
        assert!(0x2::table_vec::length<T0>(arg3) == v1, 13906835690467622925);
        0x2::table_vec::push_back<T0>(&mut arg0.states, arg1);
        0x2::table_vec::push_back<bool>(&mut arg0.accepting, arg2);
        let v2 = 0x2::table_vec::empty<u64>(arg4);
        let v3 = 0;
        while (v3 < v1) {
            let v4 = *0x2::table_vec::borrow<T0>(arg3, v3);
            0x2::table_vec::push_back<u64>(&mut v2, expect_state_index_table<T0>(&arg0.states, &v4));
            v3 = v3 + 1;
        };
        0x2::table_vec::push_back<0x2::table_vec::TableVec<u64>>(&mut arg0.transition, v2);
        0x2::table_vec::length<T0>(&arg0.states) - 1
    }

    public fun add_symbol<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut DeterministicAutomaton<T0, T1>, arg1: T1, arg2: &0x2::table_vec::TableVec<T0>) : u64 {
        let v0 = index_of_table_vec<T1>(&arg0.alphabet, &arg1);
        assert!(0x1::option::is_none<u64>(&v0), 13906835557323898897);
        let v1 = 0x2::table_vec::length<T0>(&arg0.states);
        assert!(0x2::table_vec::length<T0>(arg2) == v1, 13906835574503505933);
        0x2::table_vec::push_back<T1>(&mut arg0.alphabet, arg1);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = *0x2::table_vec::borrow<T0>(arg2, v2);
            0x2::table_vec::push_back<u64>(0x2::table_vec::borrow_mut<0x2::table_vec::TableVec<u64>>(&mut arg0.transition, v2), expect_state_index_table<T0>(&arg0.states, &v3));
            v2 = v2 + 1;
        };
        0x2::table_vec::length<T1>(&arg0.alphabet) - 1
    }

    public fun alphabet<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>) : &0x2::table_vec::TableVec<T1> {
        &arg0.alphabet
    }

    public fun borrow_core<T0: copy + drop + store, T1: copy + drop + store>(arg0: &ConfiguredAutomaton<T0, T1>) : &DeterministicAutomaton<T0, T1> {
        &arg0.dfa
    }

    public fun borrow_core_mut<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut ConfiguredAutomaton<T0, T1>) : &mut DeterministicAutomaton<T0, T1> {
        &mut arg0.dfa
    }

    public fun borrow_mut_symbol_config<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &mut ConfiguredAutomaton<T0, T1>, arg1: T1) : &mut T2 {
        ensure_symbol_member<T0, T1>(&arg0.dfa, &arg1);
        let v0 = transition_config_key<T0, T1, T2>(wildcard_transition_key<T0, T1>(arg1));
        assert!(0x2::dynamic_field::exists_with_type<TransitionConfigKey<T0, T1>, T2>(&arg0.id, v0), 13906837069152649237);
        0x2::dynamic_field::borrow_mut<TransitionConfigKey<T0, T1>, T2>(&mut arg0.id, v0)
    }

    public fun borrow_mut_transition_config<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &mut ConfiguredAutomaton<T0, T1>, arg1: T0, arg2: T1) : &mut T2 {
        ensure_state_member<T0, T1>(&arg0.dfa, &arg1);
        ensure_symbol_member<T0, T1>(&arg0.dfa, &arg2);
        let v0 = transition_config_key<T0, T1, T2>(specific_transition_key<T0, T1>(arg1, arg2));
        if (0x2::dynamic_field::exists_with_type<TransitionConfigKey<T0, T1>, T2>(&arg0.id, v0)) {
            return 0x2::dynamic_field::borrow_mut<TransitionConfigKey<T0, T1>, T2>(&mut arg0.id, v0)
        };
        let v1 = transition_config_key<T0, T1, T2>(wildcard_transition_key<T0, T1>(arg2));
        assert!(0x2::dynamic_field::exists_with_type<TransitionConfigKey<T0, T1>, T2>(&arg0.id, v1), 13906836893058990101);
        0x2::dynamic_field::borrow_mut<TransitionConfigKey<T0, T1>, T2>(&mut arg0.id, v1)
    }

    public fun borrow_symbol_config<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &ConfiguredAutomaton<T0, T1>, arg1: T1) : &T2 {
        ensure_symbol_member<T0, T1>(&arg0.dfa, &arg1);
        let v0 = transition_config_key<T0, T1, T2>(wildcard_transition_key<T0, T1>(arg1));
        assert!(0x2::dynamic_field::exists_with_type<TransitionConfigKey<T0, T1>, T2>(&arg0.id, v0), 13906837004728139797);
        0x2::dynamic_field::borrow<TransitionConfigKey<T0, T1>, T2>(&arg0.id, v0)
    }

    public fun borrow_transition_config<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &ConfiguredAutomaton<T0, T1>, arg1: T0, arg2: T1) : &T2 {
        ensure_state_member<T0, T1>(&arg0.dfa, &arg1);
        ensure_symbol_member<T0, T1>(&arg0.dfa, &arg2);
        let v0 = transition_config_key<T0, T1, T2>(specific_transition_key<T0, T1>(arg1, arg2));
        if (0x2::dynamic_field::exists_with_type<TransitionConfigKey<T0, T1>, T2>(&arg0.id, v0)) {
            return 0x2::dynamic_field::borrow<TransitionConfigKey<T0, T1>, T2>(&arg0.id, v0)
        };
        let v1 = transition_config_key<T0, T1, T2>(wildcard_transition_key<T0, T1>(arg2));
        assert!(0x2::dynamic_field::exists_with_type<TransitionConfigKey<T0, T1>, T2>(&arg0.id, v1), 13906836794274742293);
        0x2::dynamic_field::borrow<TransitionConfigKey<T0, T1>, T2>(&arg0.id, v1)
    }

    fun canonicalize_transition_table<T0: copy + drop + store, T1: copy + drop + store>(arg0: &0x2::table_vec::TableVec<T0>, arg1: &0x2::table_vec::TableVec<T1>, arg2: &0x2::table_vec::TableVec<0x2::table_vec::TableVec<T0>>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::table_vec::TableVec<0x2::table_vec::TableVec<u64>> {
        let v0 = 0x2::table_vec::length<T0>(arg0);
        assert!(0x2::table_vec::length<0x2::table_vec::TableVec<T0>>(arg2) == v0, 13906836012590039051);
        let v1 = 0x2::table_vec::length<T1>(arg1);
        let v2 = 0x2::table_vec::empty<0x2::table_vec::TableVec<u64>>(arg3);
        let v3 = 0;
        while (v3 < v0) {
            let v4 = 0x2::table_vec::borrow<0x2::table_vec::TableVec<T0>>(arg2, v3);
            assert!(0x2::table_vec::length<T0>(v4) == v1, 13906836042654810123);
            let v5 = 0x2::table_vec::empty<u64>(arg3);
            let v6 = 0;
            while (v6 < v1) {
                let v7 = *0x2::table_vec::borrow<T0>(v4, v6);
                0x2::table_vec::push_back<u64>(&mut v5, expect_state_index_table<T0>(arg0, &v7));
                v6 = v6 + 1;
            };
            0x2::table_vec::push_back<0x2::table_vec::TableVec<u64>>(&mut v2, v5);
            v3 = v3 + 1;
        };
        v2
    }

    public fun delta<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: &T0, arg2: &T1) : T0 {
        state_from_index<T0, T1>(arg0, *0x2::table_vec::borrow<u64>(0x2::table_vec::borrow<0x2::table_vec::TableVec<u64>>(&arg0.transition, expect_state_index_table<T0>(&arg0.states, arg1)), expect_symbol_index_table<T1>(&arg0.alphabet, arg2)))
    }

    public fun delta_indexed<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: u64, arg2: u64) : u64 {
        *0x2::table_vec::borrow<u64>(0x2::table_vec::borrow<0x2::table_vec::TableVec<u64>>(&arg0.transition, arg1), arg2)
    }

    fun destroy_table_vec_of_table_vec<T0: drop + store>(arg0: 0x2::table_vec::TableVec<0x2::table_vec::TableVec<T0>>) {
        while (0x2::table_vec::length<0x2::table_vec::TableVec<T0>>(&arg0) > 0) {
            0x2::table_vec::drop<T0>(0x2::table_vec::pop_back<0x2::table_vec::TableVec<T0>>(&mut arg0));
        };
        0x2::table_vec::destroy_empty<0x2::table_vec::TableVec<T0>>(arg0);
    }

    fun ensure_state_member<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: &T0) {
        expect_state_index_table<T0>(&arg0.states, arg1);
    }

    fun ensure_states_unique_table<T0: copy + drop + store>(arg0: &0x2::table_vec::TableVec<T0>) {
        let v0 = 0x2::table_vec::length<T0>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(*0x2::table_vec::borrow<T0>(arg0, v2) != *0x2::table_vec::borrow<T0>(arg0, v1), 13906836124258926599);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    fun ensure_symbol_member<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: &T1) {
        expect_symbol_index_table<T1>(&arg0.alphabet, arg1);
    }

    fun ensure_symbols_unique_table<T0: copy + drop + store>(arg0: &0x2::table_vec::TableVec<T0>) {
        let v0 = 0x2::table_vec::length<T0>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(*0x2::table_vec::borrow<T0>(arg0, v2) != *0x2::table_vec::borrow<T0>(arg0, v1), 13906836171503697929);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun expect_state_index_of<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: &T0) : u64 {
        expect_state_index_table<T0>(&arg0.states, arg1)
    }

    fun expect_state_index_table<T0: copy + drop + store>(arg0: &0x2::table_vec::TableVec<T0>, arg1: &T0) : u64 {
        let v0 = index_of_table_vec<T0>(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x1::option::destroy_some<u64>(v0)
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 13906836416316440579
        };
    }

    public fun expect_symbol_index_of<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: &T1) : u64 {
        expect_symbol_index_table<T1>(&arg0.alphabet, arg1)
    }

    fun expect_symbol_index_table<T0: copy + drop + store>(arg0: &0x2::table_vec::TableVec<T0>, arg1: &T0) : u64 {
        let v0 = index_of_table_vec<T0>(arg0, arg1);
        if (0x1::option::is_some<u64>(&v0)) {
            return 0x1::option::destroy_some<u64>(v0)
        } else {
            0x1::option::destroy_none<u64>(v0);
            abort 13906836450676310021
        };
    }

    fun follow<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: u64, arg2: &0x2::table_vec::TableVec<T1>) : u64 {
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x2::table_vec::length<T1>(arg2)) {
            let v2 = *0x2::table_vec::borrow<T1>(arg2, v1);
            let v3 = 0x2::table_vec::borrow<u64>(0x2::table_vec::borrow<0x2::table_vec::TableVec<u64>>(&arg0.transition, v0), expect_symbol_index_table<T1>(&arg0.alphabet, &v2));
            v0 = *v3;
            v1 = v1 + 1;
        };
        v0
    }

    public fun has_symbol_config<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &ConfiguredAutomaton<T0, T1>, arg1: T1) : bool {
        ensure_symbol_member<T0, T1>(&arg0.dfa, &arg1);
        0x2::dynamic_field::exists_with_type<TransitionConfigKey<T0, T1>, T2>(&arg0.id, transition_config_key<T0, T1, T2>(wildcard_transition_key<T0, T1>(arg1)))
    }

    fun index_of_table_vec<T0: copy + drop + store>(arg0: &0x2::table_vec::TableVec<T0>, arg1: &T0) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x2::table_vec::length<T0>(arg0)) {
            if (*0x2::table_vec::borrow<T0>(arg0, v0) == *arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun is_accepting<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: &T0) : bool {
        *0x2::table_vec::borrow<bool>(&arg0.accepting, expect_state_index_table<T0>(&arg0.states, arg1))
    }

    public fun new_configured<T0: copy + drop + store, T1: copy + drop + store>(arg0: DeterministicAutomaton<T0, T1>, arg1: &mut 0x2::tx_context::TxContext) : ConfiguredAutomaton<T0, T1> {
        ConfiguredAutomaton<T0, T1>{
            id  : 0x2::object::new(arg1),
            dfa : arg0,
        }
    }

    public fun register_symbol_config<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &mut ConfiguredAutomaton<T0, T1>, arg1: T1, arg2: T2) {
        ensure_symbol_member<T0, T1>(&arg0.dfa, &arg1);
        let v0 = transition_config_key<T0, T1, T2>(wildcard_transition_key<T0, T1>(arg1));
        assert!(!0x2::dynamic_field::exists_<TransitionConfigKey<T0, T1>>(&arg0.id, v0), 13906836618180952083);
        0x2::dynamic_field::add<TransitionConfigKey<T0, T1>, T2>(&mut arg0.id, v0, arg2);
    }

    public fun register_transition_config<T0: copy + drop + store, T1: copy + drop + store, T2: store>(arg0: &mut ConfiguredAutomaton<T0, T1>, arg1: T0, arg2: T1, arg3: T2) {
        ensure_state_member<T0, T1>(&arg0.dfa, &arg1);
        ensure_symbol_member<T0, T1>(&arg0.dfa, &arg2);
        let v0 = transition_config_key<T0, T1, T2>(specific_transition_key<T0, T1>(arg1, arg2));
        assert!(!0x2::dynamic_field::exists_<TransitionConfigKey<T0, T1>>(&arg0.id, v0), 13906836695490363411);
        0x2::dynamic_field::add<TransitionConfigKey<T0, T1>, T2>(&mut arg0.id, v0, arg3);
    }

    public fun run<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: &0x2::table_vec::TableVec<T1>) : T0 {
        state_from_index<T0, T1>(arg0, follow<T0, T1>(arg0, arg0.start, arg1))
    }

    public fun run_from<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: &T0, arg2: &0x2::table_vec::TableVec<T1>) : T0 {
        state_from_index<T0, T1>(arg0, follow<T0, T1>(arg0, expect_state_index_table<T0>(&arg0.states, arg1), arg2))
    }

    public fun set_accepting_state<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut DeterministicAutomaton<T0, T1>, arg1: &T0, arg2: bool) {
        *0x2::table_vec::borrow_mut<bool>(&mut arg0.accepting, expect_state_index_table<T0>(&arg0.states, arg1)) = arg2;
    }

    public fun set_transition<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut DeterministicAutomaton<T0, T1>, arg1: &T0, arg2: &T1, arg3: T0) {
        let v0 = expect_state_index_table<T0>(&arg0.states, arg1);
        let v1 = expect_symbol_index_table<T1>(&arg0.alphabet, arg2);
        let v2 = expect_state_index_table<T0>(&arg0.states, &arg3);
        set_transition_indexed<T0, T1>(arg0, v0, v1, v2);
    }

    public fun set_transition_indexed<T0: copy + drop + store, T1: copy + drop + store>(arg0: &mut DeterministicAutomaton<T0, T1>, arg1: u64, arg2: u64, arg3: u64) {
        *0x2::table_vec::borrow_mut<u64>(0x2::table_vec::borrow_mut<0x2::table_vec::TableVec<u64>>(&mut arg0.transition, arg1), arg2) = arg3;
    }

    fun specific_transition_key<T0: copy + drop + store, T1: copy + drop + store>(arg0: T0, arg1: T1) : TransitionKey<T0, T1> {
        TransitionKey<T0, T1>{
            state  : 0x1::option::some<T0>(arg0),
            symbol : arg1,
        }
    }

    public fun start_index<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>) : u64 {
        arg0.start
    }

    public fun start_state<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>) : T0 {
        state_from_index<T0, T1>(arg0, arg0.start)
    }

    public fun state_at<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: u64) : T0 {
        state_from_index<T0, T1>(arg0, arg1)
    }

    fun state_from_index<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: u64) : T0 {
        *0x2::table_vec::borrow<T0>(&arg0.states, arg1)
    }

    public fun states<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>) : &0x2::table_vec::TableVec<T0> {
        &arg0.states
    }

    public fun symbol_index_of<T0: copy + drop + store, T1: copy + drop + store>(arg0: &DeterministicAutomaton<T0, T1>, arg1: &T1) : 0x1::option::Option<u64> {
        index_of_table_vec<T1>(&arg0.alphabet, arg1)
    }

    fun transition_config_key<T0: copy + drop + store, T1: copy + drop + store, T2>(arg0: TransitionKey<T0, T1>) : TransitionConfigKey<T0, T1> {
        TransitionConfigKey<T0, T1>{
            transition : arg0,
            config     : 0x1::type_name::with_defining_ids<T2>(),
        }
    }

    fun wildcard_transition_key<T0: copy + drop + store, T1: copy + drop + store>(arg0: T1) : TransitionKey<T0, T1> {
        TransitionKey<T0, T1>{
            state  : 0x1::option::none<T0>(),
            symbol : arg0,
        }
    }

    // decompiled from Move bytecode v6
}

