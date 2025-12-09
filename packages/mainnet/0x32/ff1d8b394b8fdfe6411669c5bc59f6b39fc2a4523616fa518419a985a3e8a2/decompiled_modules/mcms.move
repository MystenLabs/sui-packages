module 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms {
    struct MultisigState has store, key {
        id: 0x2::object::UID,
        bypasser: Multisig,
        canceller: Multisig,
        proposer: Multisig,
    }

    struct Multisig has store {
        role: u8,
        signers: 0x2::vec_map::VecMap<vector<u8>, Signer>,
        config: Config,
        seen_signed_hashes: 0x2::linked_table::LinkedTable<vector<u8>, bool>,
        expiring_root_and_op_count: ExpiringRootAndOpCount,
        root_metadata: RootMetadata,
    }

    struct Signer has copy, drop, store {
        addr: vector<u8>,
        index: u8,
        group: u8,
    }

    struct Config has copy, drop, store {
        signers: vector<Signer>,
        group_quorums: vector<u8>,
        group_parents: vector<u8>,
    }

    struct ExpiringRootAndOpCount has copy, drop, store {
        root: vector<u8>,
        valid_until: u64,
        op_count: u64,
    }

    struct Op has copy, drop {
        role: u8,
        chain_id: u256,
        multisig: address,
        nonce: u64,
        to: address,
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
        data: vector<u8>,
    }

    struct RootMetadata has copy, drop, store {
        role: u8,
        chain_id: u256,
        multisig: address,
        pre_op_count: u64,
        post_op_count: u64,
        override_previous_root: bool,
    }

    struct TimelockCallbackParams {
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
        data: vector<u8>,
        role: u8,
    }

    struct MultisigStateInitialized has copy, drop {
        bypasser: u8,
        canceller: u8,
        proposer: u8,
    }

    struct ConfigSet has copy, drop {
        role: u8,
        config: Config,
        is_root_cleared: bool,
    }

    struct NewRoot has copy, drop {
        role: u8,
        root: vector<u8>,
        valid_until: u64,
        metadata: RootMetadata,
    }

    struct OpExecuted has copy, drop {
        role: u8,
        chain_id: u256,
        multisig: address,
        nonce: u64,
        to: address,
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
        data: vector<u8>,
    }

    struct MCMS has drop {
        dummy_field: bool,
    }

    struct Timelock has store, key {
        id: 0x2::object::UID,
        min_delay: u64,
        timestamps: 0x2::table::Table<vector<u8>, u64>,
        blocked_functions: 0x2::vec_set::VecSet<Function>,
    }

    struct Call has copy, drop, store {
        function: Function,
        data: vector<u8>,
    }

    struct Function has copy, drop, store {
        target: address,
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
    }

    struct TimelockInitialized has copy, drop {
        min_delay: u64,
    }

    struct BypasserCallInitiated has copy, drop {
        index: u64,
        target: address,
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
        data: vector<u8>,
    }

    struct Cancelled has copy, drop {
        id: vector<u8>,
    }

    struct CallScheduled has copy, drop {
        id: vector<u8>,
        index: u64,
        target: address,
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
        data: vector<u8>,
        predecessor: vector<u8>,
        salt: vector<u8>,
        delay: u64,
    }

    struct CallInitiated has copy, drop {
        id: vector<u8>,
        index: u64,
        target: address,
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
        data: vector<u8>,
    }

    struct UpdateMinDelay has copy, drop {
        old_min_delay: u64,
        new_min_delay: u64,
    }

    struct FunctionBlocked has copy, drop {
        target: address,
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
    }

    struct FunctionUnblocked has copy, drop {
        target: address,
        module_name: 0x1::string::String,
        function_name: 0x1::string::String,
    }

    fun assert_not_blocked(arg0: &Timelock, arg1: &Function) {
        let v0 = 0;
        while (v0 < 0x2::vec_set::length<Function>(&arg0.blocked_functions)) {
            let v1 = *0x1::vector::borrow<Function>(0x2::vec_set::keys<Function>(&arg0.blocked_functions), v0);
            if (equals(arg1, &v1)) {
                abort 34
            };
            v0 = v0 + 1;
        };
    }

    fun borrow_multisig(arg0: &MultisigState, arg1: u8) : &Multisig {
        if (arg1 == 0) {
            return &arg0.bypasser
        };
        if (arg1 == 1) {
            return &arg0.canceller
        };
        assert!(arg1 == 2, 1);
        &arg0.proposer
    }

    fun borrow_multisig_mut(arg0: &mut MultisigState, arg1: u8) : &mut Multisig {
        if (arg1 == 0) {
            return &mut arg0.bypasser
        };
        if (arg1 == 1) {
            return &mut arg0.canceller
        };
        assert!(arg1 == 2, 1);
        &mut arg0.proposer
    }

    public fun bypasser_role() : u8 {
        0
    }

    public fun canceller_role() : u8 {
        1
    }

    public fun chain_id(arg0: &RootMetadata) : u256 {
        arg0.chain_id
    }

    public fun compute_eth_message_hash(arg0: vector<u8>, arg1: u64) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 2);
        0x1::vector::append<u8>(&mut arg0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::params::encode_uint<u64>(arg1, 32));
        let v0 = x"19457468657265756d205369676e6564204d6573736167653a0a3332";
        0x1::vector::append<u8>(&mut v0, 0x2::hash::keccak256(&arg0));
        v0
    }

    public fun config_group_parents(arg0: &Config) : vector<u8> {
        arg0.group_parents
    }

    public fun config_group_quorums(arg0: &Config) : vector<u8> {
        arg0.group_quorums
    }

    public fun config_signers(arg0: &Config) : vector<Signer> {
        arg0.signers
    }

    public(friend) fun create_calls(arg0: vector<address>, arg1: vector<0x1::string::String>, arg2: vector<0x1::string::String>, arg3: vector<vector<u8>>) : vector<Call> {
        let v0 = 0x1::vector::length<address>(&arg0);
        let v1 = if (v0 == 0x1::vector::length<0x1::string::String>(&arg1)) {
            if (v0 == 0x1::vector::length<0x1::string::String>(&arg2)) {
                v0 == 0x1::vector::length<vector<u8>>(&arg3)
            } else {
                false
            }
        } else {
            false
        };
        assert!(v1, 35);
        let v2 = 0x1::vector::empty<Call>();
        let v3 = 0;
        while (v3 < v0) {
            let v4 = Function{
                target        : *0x1::vector::borrow<address>(&arg0, v3),
                module_name   : *0x1::vector::borrow<0x1::string::String>(&arg1, v3),
                function_name : *0x1::vector::borrow<0x1::string::String>(&arg2, v3),
            };
            let v5 = Call{
                function : v4,
                data     : *0x1::vector::borrow<vector<u8>>(&arg3, v3),
            };
            0x1::vector::push_back<Call>(&mut v2, v5);
            v3 = v3 + 1;
        };
        v2
    }

    fun create_multisig(arg0: u8, arg1: &mut 0x2::tx_context::TxContext) : Multisig {
        let v0 = Config{
            signers       : 0x1::vector::empty<Signer>(),
            group_quorums : x"0000000000000000000000000000000000000000000000000000000000000000",
            group_parents : x"0000000000000000000000000000000000000000000000000000000000000000",
        };
        let v1 = ExpiringRootAndOpCount{
            root        : b"",
            valid_until : 0,
            op_count    : 0,
        };
        let v2 = RootMetadata{
            role                   : arg0,
            chain_id               : 0,
            multisig               : 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(),
            pre_op_count           : 0,
            post_op_count          : 0,
            override_previous_root : false,
        };
        Multisig{
            role                       : arg0,
            signers                    : 0x2::vec_map::empty<vector<u8>, Signer>(),
            config                     : v0,
            seen_signed_hashes         : 0x2::linked_table::new<vector<u8>, bool>(arg1),
            expiring_root_and_op_count : v1,
            root_metadata              : v2,
        }
    }

    public fun data(arg0: Call) : vector<u8> {
        arg0.data
    }

    fun deserialize_timelock_bypasser_execute_batch(arg0: vector<u8>) : (vector<address>, vector<0x1::string::String>, vector<0x1::string::String>, vector<vector<u8>>) {
        let v0 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(arg0);
        let v1 = &mut v0;
        let v2 = 0x1::vector::empty<address>();
        let v3 = 0;
        while (v3 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(v1)) {
            0x1::vector::push_back<address>(&mut v2, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(v1));
            v3 = v3 + 1;
        };
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = 0;
        while (v5 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(v1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v4, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(v1));
            v5 = v5 + 1;
        };
        let v6 = 0x1::vector::empty<0x1::string::String>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(v1)) {
            0x1::vector::push_back<0x1::string::String>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(v1));
            v7 = v7 + 1;
        };
        let v8 = 0x1::vector::empty<vector<u8>>();
        let v9 = 0;
        while (v9 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(v1)) {
            0x1::vector::push_back<vector<u8>>(&mut v8, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(v1));
            v9 = v9 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(v1);
        (v2, v4, v6, v8)
    }

    fun deserialize_timelock_cancel(arg0: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::BCSStream) : vector<u8> {
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(arg0);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(arg0)
    }

    fun deserialize_timelock_execute_batch(arg0: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::BCSStream) : (vector<address>, vector<0x1::string::String>, vector<0x1::string::String>, vector<vector<u8>>, vector<u8>, vector<u8>) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(arg0)) {
            0x1::vector::push_back<address>(&mut v0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(arg0));
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0;
        while (v3 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(arg0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(arg0));
            v3 = v3 + 1;
        };
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = 0;
        while (v5 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(arg0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v4, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(arg0));
            v5 = v5 + 1;
        };
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(arg0)) {
            0x1::vector::push_back<vector<u8>>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(arg0));
            v7 = v7 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(arg0);
        (v0, v2, v4, v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(arg0), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(arg0))
    }

    fun deserialize_timelock_function_action(arg0: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::BCSStream) : (address, 0x1::string::String, 0x1::string::String) {
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(arg0);
        (0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(arg0), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(arg0), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(arg0))
    }

    fun deserialize_timelock_schedule_batch(arg0: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::BCSStream) : (vector<address>, vector<0x1::string::String>, vector<0x1::string::String>, vector<vector<u8>>, vector<u8>, vector<u8>, u64) {
        let v0 = 0x1::vector::empty<address>();
        let v1 = 0;
        while (v1 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(arg0)) {
            0x1::vector::push_back<address>(&mut v0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(arg0));
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<0x1::string::String>();
        let v3 = 0;
        while (v3 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(arg0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v2, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(arg0));
            v3 = v3 + 1;
        };
        let v4 = 0x1::vector::empty<0x1::string::String>();
        let v5 = 0;
        while (v5 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(arg0)) {
            0x1::vector::push_back<0x1::string::String>(&mut v4, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_string(arg0));
            v5 = v5 + 1;
        };
        let v6 = 0x1::vector::empty<vector<u8>>();
        let v7 = 0;
        while (v7 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(arg0)) {
            0x1::vector::push_back<vector<u8>>(&mut v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(arg0));
            v7 = v7 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(arg0);
        (v0, v2, v4, v6, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(arg0), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(arg0), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u64(arg0))
    }

    fun deserialize_timelock_update_min_delay(arg0: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::BCSStream) : u64 {
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(arg0);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u64(arg0)
    }

    public fun dispatch_timelock_bypasser_execute_batch(arg0: TimelockCallbackParams, arg1: &mut 0x2::tx_context::TxContext) : vector<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams> {
        let TimelockCallbackParams {
            module_name   : v0,
            function_name : v1,
            data          : v2,
            role          : v3,
        } = arg0;
        let v4 = v1;
        let v5 = v0;
        assert!(*0x1::string::as_bytes(&v5) == b"mcms", 25);
        assert!(*0x1::string::as_bytes(&v4) == b"timelock_bypasser_execute_batch", 26);
        let (v6, v7, v8, v9) = deserialize_timelock_bypasser_execute_batch(v2);
        timelock_bypasser_execute_batch(v3, v6, v7, v8, v9, arg1)
    }

    public fun dispatch_timelock_cancel(arg0: &mut Timelock, arg1: TimelockCallbackParams, arg2: &mut 0x2::tx_context::TxContext) {
        let TimelockCallbackParams {
            module_name   : v0,
            function_name : v1,
            data          : v2,
            role          : v3,
        } = arg1;
        let v4 = v1;
        let v5 = v0;
        assert!(*0x1::string::as_bytes(&v5) == b"mcms", 25);
        assert!(*0x1::string::as_bytes(&v4) == b"timelock_cancel", 26);
        let v6 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v7 = &mut v6;
        timelock_cancel(arg0, v3, deserialize_timelock_cancel(v7), arg2);
    }

    public fun dispatch_timelock_execute_batch(arg0: &mut Timelock, arg1: &0x2::clock::Clock, arg2: &0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg3: TimelockCallbackParams, arg4: &mut 0x2::tx_context::TxContext) : vector<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams> {
        let TimelockCallbackParams {
            module_name   : v0,
            function_name : v1,
            data          : v2,
            role          : v3,
        } = arg3;
        let v4 = v1;
        let v5 = v0;
        assert!(is_valid_role(v3), 1);
        assert!(*0x1::string::as_bytes(&v5) == b"mcms", 25);
        assert!(*0x1::string::as_bytes(&v4) == b"timelock_execute_batch", 26);
        let v6 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v7 = &mut v6;
        let (v8, v9, v10, v11, v12, v13) = deserialize_timelock_execute_batch(v7);
        timelock_execute_batch(arg0, arg1, arg2, v8, v9, v10, v11, v12, v13, arg4)
    }

    public fun dispatch_timelock_schedule_batch(arg0: &mut Timelock, arg1: &0x2::clock::Clock, arg2: TimelockCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let TimelockCallbackParams {
            module_name   : v0,
            function_name : v1,
            data          : v2,
            role          : v3,
        } = arg2;
        let v4 = v1;
        let v5 = v0;
        assert!(*0x1::string::as_bytes(&v5) == b"mcms", 25);
        assert!(*0x1::string::as_bytes(&v4) == b"timelock_schedule_batch", 26);
        let v6 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v2);
        let v7 = &mut v6;
        let (v8, v9, v10, v11, v12, v13, v14) = deserialize_timelock_schedule_batch(v7);
        timelock_schedule_batch(arg0, arg1, v3, v8, v9, v10, v11, v12, v13, v14, arg3);
    }

    fun ecdsa_recover_evm_addr(arg0: vector<u8>, arg1: vector<u8>) : vector<u8> {
        let v0 = 0x1::vector::borrow_mut<u8>(&mut arg1, 64);
        if (*v0 == 27) {
            *v0 = 0;
        } else if (*v0 == 28) {
            *v0 = 1;
        } else if (*v0 > 35) {
            *v0 = (*v0 - 1) % 2;
        };
        let v1 = 0x2::ecdsa_k1::secp256k1_ecrecover(&arg1, &arg0, 0);
        let v2 = 0x2::ecdsa_k1::decompress_pubkey(&v1);
        let v3 = b"";
        let v4 = 1;
        while (v4 < 65) {
            0x1::vector::push_back<u8>(&mut v3, *0x1::vector::borrow<u8>(&v2, v4));
            v4 = v4 + 1;
        };
        let v5 = 0x2::hash::keccak256(&v3);
        let v6 = b"";
        let v7 = 12;
        while (v7 < 32) {
            0x1::vector::push_back<u8>(&mut v6, *0x1::vector::borrow<u8>(&v5, v7));
            v7 = v7 + 1;
        };
        v6
    }

    fun equals(arg0: &Function, arg1: &Function) : bool {
        if (arg0.target == arg1.target) {
            if (0x1::string::as_bytes(&arg0.module_name) == 0x1::string::as_bytes(&arg1.module_name)) {
                0x1::string::as_bytes(&arg0.function_name) == 0x1::string::as_bytes(&arg1.function_name)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun execute(arg0: &mut MultisigState, arg1: &0x2::clock::Clock, arg2: u8, arg3: u256, arg4: address, arg5: u64, arg6: address, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: vector<u8>, arg10: vector<vector<u8>>, arg11: &mut 0x2::tx_context::TxContext) : TimelockCallbackParams {
        assert!(is_valid_role(arg2), 1);
        let v0 = Op{
            role          : arg2,
            chain_id      : arg3,
            multisig      : arg4,
            nonce         : arg5,
            to            : arg6,
            module_name   : arg7,
            function_name : arg8,
            data          : arg9,
        };
        let v1 = borrow_multisig_mut(arg0, arg2);
        assert!(v1.root_metadata.post_op_count > v1.expiring_root_and_op_count.op_count, 23);
        assert!(get_timestamp_seconds(arg1) <= v1.expiring_root_and_op_count.valid_until, 8);
        assert!(v1.root_metadata.multisig == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        assert!(v0.multisig == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        assert!(arg5 == v1.expiring_root_and_op_count.op_count, 24);
        assert!(verify_merkle_proof(arg10, v1.expiring_root_and_op_count.root, hash_op_leaf(x"542b28b7edb99385286abe2b9c308f91a385cbcb48fc98127cfd13deb28a50b8", v0)), 6);
        v1.expiring_root_and_op_count.op_count = v1.expiring_root_and_op_count.op_count + 1;
        assert!(0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address() == v0.to, 40);
        assert!(*0x1::string::as_bytes(&v0.module_name) == b"mcms", 25);
        let v2 = OpExecuted{
            role          : arg2,
            chain_id      : arg3,
            multisig      : arg4,
            nonce         : arg5,
            to            : arg6,
            module_name   : arg7,
            function_name : arg8,
            data          : arg9,
        };
        0x2::event::emit<OpExecuted>(v2);
        TimelockCallbackParams{
            module_name   : arg7,
            function_name : arg8,
            data          : arg9,
            role          : arg2,
        }
    }

    public fun expiring_root_and_op_count(arg0: &MultisigState, arg1: u8) : (vector<u8>, u64, u64) {
        let v0 = borrow_multisig(arg0, arg1);
        (v0.expiring_root_and_op_count.root, v0.expiring_root_and_op_count.valid_until, v0.expiring_root_and_op_count.op_count)
    }

    public fun function_name(arg0: Function) : 0x1::string::String {
        arg0.function_name
    }

    public fun get_config(arg0: &MultisigState, arg1: u8) : Config {
        borrow_multisig(arg0, arg1).config
    }

    public fun get_op_count(arg0: &MultisigState, arg1: u8) : u64 {
        borrow_multisig(arg0, arg1).expiring_root_and_op_count.op_count
    }

    public fun get_root(arg0: &MultisigState, arg1: u8) : (vector<u8>, u64) {
        let v0 = borrow_multisig(arg0, arg1);
        (v0.expiring_root_and_op_count.root, v0.expiring_root_and_op_count.valid_until)
    }

    public fun get_root_metadata(arg0: &MultisigState, arg1: u8) : RootMetadata {
        borrow_multisig(arg0, arg1).root_metadata
    }

    fun get_timestamp_seconds(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    fun hash_metadata_leaf(arg0: RootMetadata) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, x"8d82f6d1169cfb3fd9bc8641ea8b89677f50fe86e8d61d0d3fa6149778c934cf");
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg0.role));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg0.chain_id));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg0.multisig));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.pre_op_count));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg0.post_op_count));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<bool>(&arg0.override_previous_root));
        0x2::hash::keccak256(&v0)
    }

    public fun hash_op_leaf(arg0: vector<u8>, arg1: Op) : vector<u8> {
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u8>(&arg1.role));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u256>(&arg1.chain_id));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1.multisig));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1.nonce));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<address>(&arg1.to));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg1.module_name));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x1::string::String>(&arg1.function_name));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<u8>>(&arg1.data));
        0x2::hash::keccak256(&v0)
    }

    public(friend) fun hash_operation_batch(arg0: vector<Call>, arg1: vector<u8>, arg2: vector<u8>) : vector<u8> {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 42);
        let v0 = b"";
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<vector<Call>>(&arg0));
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, arg2);
        0x2::hash::keccak256(&v0)
    }

    fun init(arg0: MCMS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_multisig(0, arg1);
        let v1 = create_multisig(1, arg1);
        let v2 = create_multisig(2, arg1);
        let v3 = MultisigState{
            id        : 0x2::object::new(arg1),
            bypasser  : v0,
            canceller : v1,
            proposer  : v2,
        };
        let v4 = Timelock{
            id                : 0x2::object::new(arg1),
            min_delay         : 0,
            timestamps        : 0x2::table::new<vector<u8>, u64>(arg1),
            blocked_functions : 0x2::vec_set::empty<Function>(),
        };
        let v5 = MultisigStateInitialized{
            bypasser  : v3.bypasser.role,
            canceller : v3.canceller.role,
            proposer  : v3.proposer.role,
        };
        0x2::event::emit<MultisigStateInitialized>(v5);
        let v6 = TimelockInitialized{min_delay: v4.min_delay};
        0x2::event::emit<TimelockInitialized>(v6);
        0x2::transfer::share_object<MultisigState>(v3);
        0x2::transfer::share_object<Timelock>(v4);
    }

    public fun is_valid_role(arg0: u8) : bool {
        arg0 < 4
    }

    public fun max_num_signers() : u64 {
        200
    }

    public fun mcms_dispatch_to_account(arg0: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::AccountState, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_from_mcms(arg0, arg2);
        let v4 = v2;
        let v5 = v1;
        assert!(v0 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        assert!(*0x1::string::as_bytes(&v5) == b"mcms_account", 37);
        let v6 = *0x1::string::as_bytes(&v4);
        let v7 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        if (v6 == b"transfer_ownership") {
            let v8 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::borrow_owner_cap<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::OwnerCap>(arg0);
            let v9 = 0x1::vector::empty<address>();
            let v10 = &mut v9;
            0x1::vector::push_back<address>(v10, 0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::OwnerCap>(v8));
            0x1::vector::push_back<address>(v10, 0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::AccountState>(arg1));
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v9, &mut v7);
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v7);
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::transfer_ownership(v8, arg1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v7), arg3);
        } else if (v6 == b"accept_ownership_as_timelock") {
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addr(0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::AccountState>(arg1), &mut v7);
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v7);
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::accept_ownership_as_timelock(arg1, arg3);
        } else {
            assert!(v6 == b"execute_ownership_transfer", 37);
            let v11 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::release_cap<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::McmsAccountProof, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::OwnerCap>(arg0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::create_mcms_account_proof());
            let v12 = 0x1::vector::empty<address>();
            let v13 = &mut v12;
            0x1::vector::push_back<address>(v13, 0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::OwnerCap>(&v11));
            0x1::vector::push_back<address>(v13, 0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::AccountState>(arg1));
            0x1::vector::push_back<address>(v13, 0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry>(arg0));
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v12, &mut v7);
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v7);
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::execute_ownership_transfer(v11, arg1, arg0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v7), arg3);
        };
    }

    public fun mcms_dispatch_to_deployer(arg0: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_deployer::DeployerState, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        let (v0, v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_from_mcms(arg0, arg2);
        let v4 = v2;
        let v5 = v1;
        assert!(v0 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 38);
        assert!(*0x1::string::as_bytes(&v5) == b"mcms_deployer", 39);
        let v6 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        assert!(*0x1::string::as_bytes(&v4) == b"authorize_upgrade", 39);
        let v7 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::borrow_owner_cap<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::OwnerCap>(arg0);
        let v8 = 0x1::vector::empty<address>();
        let v9 = &mut v8;
        0x1::vector::push_back<address>(v9, 0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::OwnerCap>(v7));
        0x1::vector::push_back<address>(v9, 0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_deployer::DeployerState>(arg1));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v8, &mut v6);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v6);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_deployer::authorize_upgrade(v7, arg1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u8(&mut v6), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v6), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_address(&mut v6), arg3)
    }

    public fun mcms_dispatch_to_registry(arg0: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg1: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_from_mcms(arg0, arg1);
        let v4 = v2;
        let v5 = v1;
        assert!(v0 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        assert!(*0x1::string::as_bytes(&v5) == b"mcms_registry", 41);
        let v6 = *0x1::string::as_bytes(&v4);
        if (v6 == b"add_allowed_modules") {
            let v7 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addr(0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry>(arg0), &mut v7);
            let v8 = 0x1::vector::empty<vector<u8>>();
            let v9 = 0;
            while (v9 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v7)) {
                0x1::vector::push_back<vector<u8>>(&mut v8, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v7));
                v9 = v9 + 1;
            };
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v7);
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::add_allowed_modules<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::McmsAccountProof>(arg0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::create_mcms_account_proof(), v8, arg2);
        } else {
            assert!(v6 == b"remove_allowed_modules", 41);
            let v10 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addr(0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry>(arg0), &mut v10);
            let v11 = 0x1::vector::empty<vector<u8>>();
            let v12 = 0;
            while (v12 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(&mut v10)) {
                0x1::vector::push_back<vector<u8>>(&mut v11, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(&mut v10));
                v12 = v12 + 1;
            };
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(&v10);
            0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::remove_allowed_modules<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::McmsAccountProof>(arg0, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::create_mcms_account_proof(), v11, arg2);
        };
    }

    public fun mcms_set_config(arg0: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg1: &mut MultisigState, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_from_mcms(arg0, arg2);
        let v4 = v2;
        let v5 = v1;
        assert!(v0 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        assert!(*0x1::string::as_bytes(&v5) == b"mcms", 25);
        assert!(*0x1::string::as_bytes(&v4) == b"set_config", 26);
        let v6 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::borrow_owner_cap<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::OwnerCap>(arg0);
        let v7 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        let v8 = &mut v7;
        let v9 = 0x1::vector::empty<address>();
        let v10 = &mut v9;
        0x1::vector::push_back<address>(v10, 0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::OwnerCap>(v6));
        0x1::vector::push_back<address>(v10, 0x2::object::id_address<MultisigState>(arg1));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v9, v8);
        let v11 = 0x1::vector::empty<vector<u8>>();
        let v12 = 0;
        while (v12 < 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_uleb128(v8)) {
            0x1::vector::push_back<vector<u8>>(&mut v11, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(v8));
            v12 = v12 + 1;
        };
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::assert_is_consumed(v8);
        set_config(v6, arg1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u8(v8), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_u256(v8), v11, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(v8), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(v8), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_vector_u8(v8), 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::deserialize_bool(v8), arg3);
    }

    public fun mcms_timelock_block_function(arg0: &mut Timelock, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_from_mcms(arg1, arg2);
        let v4 = v2;
        let v5 = v1;
        assert!(v0 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        assert!(*0x1::string::as_bytes(&v5) == b"mcms", 25);
        assert!(*0x1::string::as_bytes(&v4) == b"timelock_block_function", 26);
        let v6 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addr(0x2::object::id_address<Timelock>(arg0), &mut v6);
        let v7 = &mut v6;
        let (v8, v9, v10) = deserialize_timelock_function_action(v7);
        timelock_block_function(arg0, 3, v8, v9, v10, arg3);
    }

    public fun mcms_timelock_bypasser_execute_batch(arg0: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg1: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg2: &mut 0x2::tx_context::TxContext) : vector<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams> {
        let (v0, v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_from_mcms(arg0, arg1);
        let v4 = v2;
        let v5 = v1;
        assert!(v0 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        assert!(*0x1::string::as_bytes(&v5) == b"mcms", 25);
        assert!(*0x1::string::as_bytes(&v4) == b"timelock_bypasser_execute_batch", 26);
        let (v6, v7, v8, v9) = deserialize_timelock_bypasser_execute_batch(v3);
        timelock_bypasser_execute_batch(3, v6, v7, v8, v9, arg2)
    }

    public fun mcms_timelock_cancel(arg0: &mut Timelock, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_from_mcms(arg1, arg2);
        let v4 = v2;
        let v5 = v1;
        assert!(v0 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        assert!(*0x1::string::as_bytes(&v5) == b"mcms", 25);
        assert!(*0x1::string::as_bytes(&v4) == b"timelock_cancel", 26);
        let v6 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addr(0x2::object::id_address<Timelock>(arg0), &mut v6);
        let v7 = &mut v6;
        timelock_cancel(arg0, 3, deserialize_timelock_cancel(v7), arg3);
    }

    public fun mcms_timelock_execute_batch(arg0: &mut Timelock, arg1: &0x2::clock::Clock, arg2: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg3: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg4: &mut 0x2::tx_context::TxContext) : vector<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams> {
        let (v0, v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_from_mcms(arg2, arg3);
        let v4 = v2;
        let v5 = v1;
        assert!(v0 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        assert!(*0x1::string::as_bytes(&v5) == b"mcms", 25);
        assert!(*0x1::string::as_bytes(&v4) == b"timelock_execute_batch", 26);
        let v6 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        let v7 = &mut v6;
        let v8 = 0x1::vector::empty<address>();
        let v9 = &mut v8;
        0x1::vector::push_back<address>(v9, 0x2::object::id_address<Timelock>(arg0));
        0x1::vector::push_back<address>(v9, 0x2::object::id_address<0x2::clock::Clock>(arg1));
        0x1::vector::push_back<address>(v9, 0x2::object::id_address<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry>(arg2));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v8, v7);
        let (v10, v11, v12, v13, v14, v15) = deserialize_timelock_execute_batch(v7);
        timelock_execute_batch(arg0, arg1, arg2, v10, v11, v12, v13, v14, v15, arg4)
    }

    public fun mcms_timelock_schedule_batch(arg0: &mut Timelock, arg1: &0x2::clock::Clock, arg2: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg3: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg4: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_from_mcms(arg2, arg3);
        let v4 = v2;
        let v5 = v1;
        assert!(v0 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        assert!(*0x1::string::as_bytes(&v5) == b"mcms", 25);
        assert!(*0x1::string::as_bytes(&v4) == b"timelock_schedule_batch", 26);
        let v6 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        let v7 = &mut v6;
        let v8 = 0x1::vector::empty<address>();
        let v9 = &mut v8;
        0x1::vector::push_back<address>(v9, 0x2::object::id_address<Timelock>(arg0));
        0x1::vector::push_back<address>(v9, 0x2::object::id_address<0x2::clock::Clock>(arg1));
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addrs(v8, v7);
        let (v10, v11, v12, v13, v14, v15, v16) = deserialize_timelock_schedule_batch(v7);
        timelock_schedule_batch(arg0, arg1, 3, v10, v11, v12, v13, v14, v15, v16, arg4);
    }

    public fun mcms_timelock_unblock_function(arg0: &mut Timelock, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_from_mcms(arg1, arg2);
        let v4 = v2;
        let v5 = v1;
        assert!(v0 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        assert!(*0x1::string::as_bytes(&v5) == b"mcms", 25);
        assert!(*0x1::string::as_bytes(&v4) == b"timelock_unblock_function", 26);
        let v6 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addr(0x2::object::id_address<Timelock>(arg0), &mut v6);
        let v7 = &mut v6;
        let (v8, v9, v10) = deserialize_timelock_function_action(v7);
        timelock_unblock_function(arg0, 3, v8, v9, v10, arg3);
    }

    public fun mcms_timelock_update_min_delay(arg0: &mut Timelock, arg1: &mut 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg2: 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_callback_params_from_mcms(arg1, arg2);
        let v4 = v2;
        let v5 = v1;
        assert!(v0 == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        assert!(*0x1::string::as_bytes(&v5) == b"mcms", 25);
        assert!(*0x1::string::as_bytes(&v4) == b"timelock_update_min_delay", 26);
        let v6 = 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::new(v3);
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::bcs_stream::validate_obj_addr(0x2::object::id_address<Timelock>(arg0), &mut v6);
        let v7 = &mut v6;
        timelock_update_min_delay(arg0, 3, deserialize_timelock_update_min_delay(v7), arg3);
    }

    public fun module_name(arg0: Function) : 0x1::string::String {
        arg0.module_name
    }

    public fun num_groups() : u64 {
        32
    }

    public fun override_previous_root(arg0: &RootMetadata) : bool {
        arg0.override_previous_root
    }

    public fun post_op_count(arg0: &RootMetadata) : u64 {
        arg0.post_op_count
    }

    public fun pre_op_count(arg0: &RootMetadata) : u64 {
        arg0.pre_op_count
    }

    public fun proposer_role() : u8 {
        2
    }

    public fun recent_seen_signed_hashes(arg0: &MultisigState, arg1: u8, arg2: u64) : vector<vector<u8>> {
        let v0 = borrow_multisig(arg0, arg1);
        let v1 = vector[];
        let v2 = 0x2::linked_table::back<vector<u8>, bool>(&v0.seen_signed_hashes);
        let v3 = 0;
        while (0x1::option::is_some<vector<u8>>(v2) && v3 < arg2) {
            let v4 = *0x1::option::borrow<vector<u8>>(v2);
            0x1::vector::push_back<vector<u8>>(&mut v1, v4);
            v2 = 0x2::linked_table::prev<vector<u8>, bool>(&v0.seen_signed_hashes, v4);
            v3 = v3 + 1;
        };
        v1
    }

    public fun role(arg0: &RootMetadata) : u8 {
        arg0.role
    }

    public fun root_metadata(arg0: &Multisig) : RootMetadata {
        arg0.root_metadata
    }

    public fun root_metadata_multisig(arg0: &RootMetadata) : address {
        arg0.multisig
    }

    public fun seen_signed_hashes(arg0: &MultisigState, arg1: u8) : vector<vector<u8>> {
        let v0 = borrow_multisig(arg0, arg1);
        let v1 = vector[];
        let v2 = 0x2::linked_table::front<vector<u8>, bool>(&v0.seen_signed_hashes);
        while (0x1::option::is_some<vector<u8>>(v2)) {
            let v3 = *0x1::option::borrow<vector<u8>>(v2);
            0x1::vector::push_back<vector<u8>>(&mut v1, v3);
            v2 = 0x2::linked_table::next<vector<u8>, bool>(&v0.seen_signed_hashes, v3);
        };
        v1
    }

    public fun seen_signed_hashes_count(arg0: &MultisigState, arg1: u8) : u64 {
        0x2::linked_table::length<vector<u8>, bool>(&borrow_multisig(arg0, arg1).seen_signed_hashes)
    }

    public fun set_config(arg0: &0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_account::OwnerCap, arg1: &mut MultisigState, arg2: u8, arg3: u256, arg4: vector<vector<u8>>, arg5: vector<u8>, arg6: vector<u8>, arg7: vector<u8>, arg8: bool, arg9: &0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<vector<u8>>(&arg4) != 0 && 0x1::vector::length<vector<u8>>(&arg4) <= 200, 19);
        assert!(0x1::vector::length<vector<u8>>(&arg4) == 0x1::vector::length<u8>(&arg5), 20);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 13);
        assert!(0x1::vector::length<u8>(&arg7) == 32, 14);
        let v0 = b"";
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::params::right_pad_vec(&mut v0, 32);
        let v1 = &arg5;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(v1)) {
            let v3 = (*0x1::vector::borrow<u8>(v1, v2) as u64);
            assert!(v3 < 32, 15);
            let v4 = 0x1::vector::borrow_mut<u8>(&mut v0, v3);
            *v4 = *v4 + 1;
            v2 = v2 + 1;
        };
        let v5 = 0;
        while (v5 < 32) {
            let v6 = 32 - v5 - 1;
            let v7 = (*0x1::vector::borrow<u8>(&arg7, v6) as u64);
            assert!(v6 == 0 || v7 < v6, 21);
            assert!(v6 != 0 || v7 == 0, 21);
            let v8 = *0x1::vector::borrow<u8>(&arg6, v6);
            if (v8 == 0) {
                assert!(*0x1::vector::borrow<u8>(&v0, v6) == 0, 11);
            } else {
                assert!(*0x1::vector::borrow<u8>(&v0, v6) >= v8, 16);
                let v9 = 0x1::vector::borrow_mut<u8>(&mut v0, v7);
                *v9 = *v9 + 1;
            };
            v5 = v5 + 1;
        };
        let v10 = borrow_multisig_mut(arg1, arg2);
        v10.signers = 0x2::vec_map::empty<vector<u8>, Signer>();
        v10.config.signers = 0x1::vector::empty<Signer>();
        v10.config.group_quorums = arg6;
        v10.config.group_parents = arg7;
        let v11 = b"";
        let v12 = 0;
        while (v12 < 0x1::vector::length<vector<u8>>(&arg4)) {
            v11 = *0x1::vector::borrow<vector<u8>>(&arg4, v12);
            assert!(0x1::vector::length<u8>(&v11) == 20, 22);
            if (v12 > 0) {
                assert!(0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::params::vector_u8_gt(&v11, &v11), 17);
            };
            let v13 = Signer{
                addr  : v11,
                index : (v12 as u8),
                group : *0x1::vector::borrow<u8>(&arg5, v12),
            };
            0x2::vec_map::insert<vector<u8>, Signer>(&mut v10.signers, v11, v13);
            0x1::vector::push_back<Signer>(&mut v10.config.signers, v13);
            v12 = v12 + 1;
        };
        if (arg8) {
            let v14 = v10.expiring_root_and_op_count.op_count;
            let v15 = ExpiringRootAndOpCount{
                root        : b"",
                valid_until : 0,
                op_count    : v14,
            };
            v10.expiring_root_and_op_count = v15;
            let v16 = RootMetadata{
                role                   : arg2,
                chain_id               : arg3,
                multisig               : 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(),
                pre_op_count           : v14,
                post_op_count          : v14,
                override_previous_root : true,
            };
            v10.root_metadata = v16;
        };
        let v17 = ConfigSet{
            role            : arg2,
            config          : v10.config,
            is_root_cleared : arg8,
        };
        0x2::event::emit<ConfigSet>(v17);
    }

    public fun set_root(arg0: &mut MultisigState, arg1: &0x2::clock::Clock, arg2: u8, arg3: vector<u8>, arg4: u64, arg5: u256, arg6: address, arg7: u64, arg8: u64, arg9: bool, arg10: vector<vector<u8>>, arg11: vector<vector<u8>>, arg12: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid_role(arg2), 1);
        let v0 = RootMetadata{
            role                   : arg2,
            chain_id               : arg5,
            multisig               : arg6,
            pre_op_count           : arg7,
            post_op_count          : arg8,
            override_previous_root : arg9,
        };
        let v1 = compute_eth_message_hash(arg3, arg4);
        let v2 = borrow_multisig_mut(arg0, arg2);
        assert!(!0x2::linked_table::contains<vector<u8>, bool>(&v2.seen_signed_hashes, v1), 7);
        assert!(get_timestamp_seconds(arg1) <= arg4, 8);
        assert!(v0.multisig == 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::get_multisig_address(), 9);
        let v3 = v2.expiring_root_and_op_count.op_count;
        assert!(arg9 || v3 == v2.root_metadata.post_op_count, 18);
        assert!(v3 == v0.pre_op_count, 4);
        assert!(v0.pre_op_count <= v0.post_op_count, 5);
        assert!(verify_merkle_proof(arg10, arg3, hash_metadata_leaf(v0)), 6);
        let v4 = b"";
        let v5 = b"";
        0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::params::right_pad_vec(&mut v5, 32);
        let v6 = 0;
        while (v6 < 0x1::vector::length<vector<u8>>(&arg11)) {
            v4 = ecdsa_recover_evm_addr(v1, *0x1::vector::borrow<vector<u8>>(&arg11, v6));
            if (v6 > 0) {
                assert!(0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::params::vector_u8_gt(&v4, &v4), 17);
            };
            assert!(0x2::vec_map::contains<vector<u8>, Signer>(&v2.signers, &v4), 10);
            let v7 = *0x2::vec_map::get<vector<u8>, Signer>(&v2.signers, &v4);
            let v8 = v7.group;
            loop {
                let v9 = 0x1::vector::borrow_mut<u8>(&mut v5, (v8 as u64));
                *v9 = *v9 + 1;
                if (*v9 != *0x1::vector::borrow<u8>(&v2.config.group_quorums, (v8 as u64))) {
                    break
                };
                if (v8 == 0) {
                    break
                };
                let v10 = 0x1::vector::borrow<u8>(&v2.config.group_parents, (v8 as u64));
                v8 = *v10;
            };
            v6 = v6 + 1;
        };
        let v11 = *0x1::vector::borrow<u8>(&v2.config.group_quorums, 0);
        assert!(v11 != 0, 3);
        assert!(*0x1::vector::borrow<u8>(&v5, 0) >= v11, 12);
        0x2::linked_table::push_back<vector<u8>, bool>(&mut v2.seen_signed_hashes, v1, true);
        let v12 = ExpiringRootAndOpCount{
            root        : arg3,
            valid_until : arg4,
            op_count    : v0.pre_op_count,
        };
        v2.expiring_root_and_op_count = v12;
        v2.root_metadata = v0;
        let v13 = RootMetadata{
            role                   : arg2,
            chain_id               : arg5,
            multisig               : arg6,
            pre_op_count           : v0.pre_op_count,
            post_op_count          : v0.post_op_count,
            override_previous_root : v0.override_previous_root,
        };
        let v14 = NewRoot{
            role        : arg2,
            root        : arg3,
            valid_until : arg4,
            metadata    : v13,
        };
        0x2::event::emit<NewRoot>(v14);
    }

    public fun signer_view(arg0: &Signer) : (vector<u8>, u8, u8) {
        (arg0.addr, arg0.index, arg0.group)
    }

    public fun signers(arg0: &MultisigState, arg1: u8) : 0x2::vec_map::VecMap<vector<u8>, Signer> {
        borrow_multisig(arg0, arg1).signers
    }

    public fun target(arg0: Function) : address {
        arg0.target
    }

    fun timelock_after_call(arg0: &mut Timelock, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(timelock_is_operation_ready(arg0, arg1, arg2), 30);
        *0x2::table::borrow_mut<vector<u8>, u64>(&mut arg0.timestamps, arg2) = 1;
    }

    fun timelock_before_call(arg0: &Timelock, arg1: &0x2::clock::Clock, arg2: &0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg3: vector<u8>, arg4: vector<u8>) {
        assert!(timelock_is_operation_ready(arg0, arg1, arg3), 30);
        assert!(arg4 == x"0000000000000000000000000000000000000000000000000000000000000000" || 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::is_batch_completed(arg2, arg4) && timelock_is_operation_done(arg0, arg4), 31);
    }

    fun timelock_block_function(arg0: &mut Timelock, arg1: u8, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 3, 32);
        let v0 = false;
        let v1 = Function{
            target        : arg2,
            module_name   : arg3,
            function_name : arg4,
        };
        let v2 = 0;
        while (v2 < 0x2::vec_set::length<Function>(&arg0.blocked_functions)) {
            let v3 = *0x1::vector::borrow<Function>(0x2::vec_set::keys<Function>(&arg0.blocked_functions), v2);
            if (equals(&v1, &v3)) {
                v0 = true;
                break
            };
            v2 = v2 + 1;
        };
        if (!v0) {
            0x2::vec_set::insert<Function>(&mut arg0.blocked_functions, v1);
            let v4 = FunctionBlocked{
                target        : arg2,
                module_name   : arg3,
                function_name : arg4,
            };
            0x2::event::emit<FunctionBlocked>(v4);
        };
    }

    fun timelock_bypasser_execute_batch(arg0: u8, arg1: vector<address>, arg2: vector<0x1::string::String>, arg3: vector<0x1::string::String>, arg4: vector<vector<u8>>, arg5: &0x2::tx_context::TxContext) : vector<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams> {
        assert!(arg0 == 0 || arg0 == 3, 27);
        let v0 = create_calls(arg1, arg2, arg3, arg4);
        let v1 = 0x1::vector::empty<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams>();
        let v2 = 0x1::vector::length<Call>(&v0);
        let v3 = 0;
        while (v3 < v2) {
            let v4 = 0x1::vector::borrow<Call>(&v0, v3).function;
            let v5 = v4.target;
            let v6 = v4.module_name;
            let v7 = v4.function_name;
            let v8 = 0x1::vector::borrow<Call>(&v0, v3).data;
            0x1::vector::push_back<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams>(&mut v1, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::create_executing_callback_params(v5, v6, v7, v8, hash_operation_batch(v0, x"0000000000000000000000000000000000000000000000000000000000000000", *0x2::tx_context::digest(arg5)), v3, v2));
            let v9 = BypasserCallInitiated{
                index         : v3,
                target        : v5,
                module_name   : v6,
                function_name : v7,
                data          : v8,
            };
            0x2::event::emit<BypasserCallInitiated>(v9);
            v3 = v3 + 1;
        };
        v1
    }

    fun timelock_cancel(arg0: &mut Timelock, arg1: u8, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 1 || arg1 == 3, 27);
        assert!(timelock_is_operation_pending(arg0, arg2), 36);
        0x2::table::remove<vector<u8>, u64>(&mut arg0.timestamps, arg2);
        let v0 = Cancelled{id: arg2};
        0x2::event::emit<Cancelled>(v0);
    }

    public fun timelock_execute_batch(arg0: &mut Timelock, arg1: &0x2::clock::Clock, arg2: &0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::Registry, arg3: vector<address>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<vector<u8>>, arg7: vector<u8>, arg8: vector<u8>, arg9: &mut 0x2::tx_context::TxContext) : vector<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams> {
        let v0 = create_calls(arg3, arg4, arg5, arg6);
        let v1 = hash_operation_batch(v0, arg7, arg8);
        timelock_before_call(arg0, arg1, arg2, v1, arg7);
        let v2 = 0x1::vector::empty<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams>();
        let v3 = 0x1::vector::length<Call>(&v0);
        let v4 = 0;
        while (v4 < v3) {
            let v5 = 0x1::vector::borrow<Call>(&v0, v4).function;
            let v6 = v5.target;
            let v7 = v5.module_name;
            let v8 = v5.function_name;
            let v9 = 0x1::vector::borrow<Call>(&v0, v4).data;
            0x1::vector::push_back<0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::ExecutingCallbackParams>(&mut v2, 0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::mcms_registry::create_executing_callback_params(v6, v7, v8, v9, v1, v4, v3));
            let v10 = CallInitiated{
                id            : v1,
                index         : v4,
                target        : v6,
                module_name   : v7,
                function_name : v8,
                data          : v9,
            };
            0x2::event::emit<CallInitiated>(v10);
            v4 = v4 + 1;
        };
        timelock_after_call(arg0, arg1, v1, arg9);
        v2
    }

    public fun timelock_get_blocked_function(arg0: &Timelock, arg1: u64) : Function {
        assert!(arg1 < 0x2::vec_set::length<Function>(&arg0.blocked_functions), 33);
        *0x1::vector::borrow<Function>(0x2::vec_set::keys<Function>(&arg0.blocked_functions), arg1)
    }

    public fun timelock_get_blocked_functions(arg0: &Timelock) : vector<Function> {
        let v0 = 0x1::vector::empty<Function>();
        let v1 = 0x2::vec_set::keys<Function>(&arg0.blocked_functions);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Function>(v1)) {
            0x1::vector::push_back<Function>(&mut v0, *0x1::vector::borrow<Function>(v1, v2));
            v2 = v2 + 1;
        };
        v0
    }

    public fun timelock_get_blocked_functions_count(arg0: &Timelock) : u64 {
        0x2::vec_set::length<Function>(&arg0.blocked_functions)
    }

    public fun timelock_get_timestamp(arg0: &Timelock, arg1: vector<u8>) : u64 {
        if (0x2::table::contains<vector<u8>, u64>(&arg0.timestamps, arg1)) {
            *0x2::table::borrow<vector<u8>, u64>(&arg0.timestamps, arg1)
        } else {
            0
        }
    }

    public fun timelock_is_operation(arg0: &Timelock, arg1: vector<u8>) : bool {
        timelock_is_operation_internal(arg0, arg1)
    }

    public fun timelock_is_operation_done(arg0: &Timelock, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, u64>(&arg0.timestamps, arg1) && *0x2::table::borrow<vector<u8>, u64>(&arg0.timestamps, arg1) == 1
    }

    fun timelock_is_operation_internal(arg0: &Timelock, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, u64>(&arg0.timestamps, arg1) && *0x2::table::borrow<vector<u8>, u64>(&arg0.timestamps, arg1) > 0
    }

    public fun timelock_is_operation_pending(arg0: &Timelock, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, u64>(&arg0.timestamps, arg1) && *0x2::table::borrow<vector<u8>, u64>(&arg0.timestamps, arg1) > 1
    }

    public fun timelock_is_operation_ready(arg0: &Timelock, arg1: &0x2::clock::Clock, arg2: vector<u8>) : bool {
        if (!0x2::table::contains<vector<u8>, u64>(&arg0.timestamps, arg2)) {
            return false
        };
        let v0 = *0x2::table::borrow<vector<u8>, u64>(&arg0.timestamps, arg2);
        v0 > 1 && v0 <= get_timestamp_seconds(arg1)
    }

    public fun timelock_min_delay(arg0: &Timelock) : u64 {
        arg0.min_delay
    }

    public fun timelock_role() : u8 {
        3
    }

    fun timelock_schedule(arg0: &mut Timelock, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: u64) {
        assert!(!timelock_is_operation_internal(arg0, arg2), 29);
        assert!(arg3 >= arg0.min_delay, 28);
        0x2::table::add<vector<u8>, u64>(&mut arg0.timestamps, arg2, get_timestamp_seconds(arg1) + arg3);
    }

    fun timelock_schedule_batch(arg0: &mut Timelock, arg1: &0x2::clock::Clock, arg2: u8, arg3: vector<address>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<vector<u8>>, arg7: vector<u8>, arg8: vector<u8>, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 == 2 || arg2 == 3, 27);
        let v0 = create_calls(arg3, arg4, arg5, arg6);
        let v1 = hash_operation_batch(v0, arg7, arg8);
        timelock_schedule(arg0, arg1, v1, arg9);
        let v2 = 0;
        while (v2 < 0x1::vector::length<Call>(&v0)) {
            assert_not_blocked(arg0, &0x1::vector::borrow<Call>(&v0, v2).function);
            let v3 = CallScheduled{
                id            : v1,
                index         : v2,
                target        : 0x1::vector::borrow<Call>(&v0, v2).function.target,
                module_name   : 0x1::vector::borrow<Call>(&v0, v2).function.module_name,
                function_name : 0x1::vector::borrow<Call>(&v0, v2).function.function_name,
                data          : 0x1::vector::borrow<Call>(&v0, v2).data,
                predecessor   : arg7,
                salt          : arg8,
                delay         : arg9,
            };
            0x2::event::emit<CallScheduled>(v3);
            v2 = v2 + 1;
        };
    }

    fun timelock_unblock_function(arg0: &mut Timelock, arg1: u8, arg2: address, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 3, 32);
        let v0 = Function{
            target        : arg2,
            module_name   : arg3,
            function_name : arg4,
        };
        let v1 = 0;
        while (v1 < 0x2::vec_set::length<Function>(&arg0.blocked_functions)) {
            let v2 = *0x1::vector::borrow<Function>(0x2::vec_set::keys<Function>(&arg0.blocked_functions), v1);
            if (equals(&v0, &v2)) {
                0x2::vec_set::remove<Function>(&mut arg0.blocked_functions, &v2);
                let v3 = FunctionUnblocked{
                    target        : arg2,
                    module_name   : arg3,
                    function_name : arg4,
                };
                0x2::event::emit<FunctionUnblocked>(v3);
                break
            };
            v1 = v1 + 1;
        };
    }

    fun timelock_update_min_delay(arg0: &mut Timelock, arg1: u8, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg1 == 3, 1);
        arg0.min_delay = arg2;
        let v0 = UpdateMinDelay{
            old_min_delay : arg0.min_delay,
            new_min_delay : arg2,
        };
        0x2::event::emit<UpdateMinDelay>(v0);
    }

    public fun verify_merkle_proof(arg0: vector<vector<u8>>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = arg2;
        let v1 = &arg0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<vector<u8>>(v1)) {
            let v3 = 0x1::vector::borrow<vector<u8>>(v1, v2);
            let (v4, v5) = if (0x32ff1d8b394b8fdfe6411669c5bc59f6b39fc2a4523616fa518419a985a3e8a2::params::vector_u8_gt(&v0, v3)) {
                (*v3, v0)
            } else {
                (v0, *v3)
            };
            let v6 = v4;
            0x1::vector::append<u8>(&mut v6, v5);
            v0 = 0x2::hash::keccak256(&v6);
            v2 = v2 + 1;
        };
        v0 == arg1
    }

    public fun zero_hash() : vector<u8> {
        x"0000000000000000000000000000000000000000000000000000000000000000"
    }

    // decompiled from Move bytecode v6
}

