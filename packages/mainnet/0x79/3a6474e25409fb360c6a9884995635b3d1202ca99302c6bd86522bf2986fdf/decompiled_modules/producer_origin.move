module 0x793a6474e25409fb360c6a9884995635b3d1202ca99302c6bd86522bf2986fdf::producer_origin {
    struct Snapshot has copy, drop, store {
        producer: 0x1::type_name::TypeName,
        source_type: 0x1::type_name::TypeName,
        source: 0x2::object::ID,
        version: u64,
        policy: vector<u8>,
        actor: address,
        name: 0x1::string::String,
        attempt: vector<u8>,
        config: 0x2::object::ID,
        revision: u64,
        commitment: vector<u8>,
        expiry: u64,
        operation: u8,
        adapter: 0x1::type_name::TypeName,
        adapter_revision: 0x1::type_name::TypeName,
        target_type: 0x1::type_name::TypeName,
    }

    struct OriginRequest {
        snapshot: Snapshot,
    }

    struct PaidAction {
        producer: 0x1::type_name::TypeName,
        snapshot: Snapshot,
        target: 0x2::object::ID,
        receipt: vector<u8>,
    }

    struct CompletionAuthorization {
        snapshot: Snapshot,
        target: 0x2::object::ID,
    }

    public fun action_producer(arg0: &PaidAction) : 0x1::type_name::TypeName {
        arg0.producer
    }

    public fun actor(arg0: &Snapshot) : address {
        arg0.actor
    }

    public fun adapter(arg0: &Snapshot) : 0x1::type_name::TypeName {
        arg0.adapter
    }

    public fun adapter_revision(arg0: &Snapshot) : 0x1::type_name::TypeName {
        arg0.adapter_revision
    }

    fun assert_actual<T0: key, T1: key>(arg0: &Snapshot, arg1: &T0, arg2: &T1, arg3: &0x2::tx_context::TxContext) {
        let v0 = if (arg0.source == 0x2::object::id<T0>(arg1)) {
            if (arg0.source_type == 0x1::type_name::with_defining_ids<T0>()) {
                if (arg0.target_type == 0x1::type_name::with_defining_ids<T1>()) {
                    arg0.actor == 0x2::tx_context::sender(arg3)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
    }

    public fun assert_adapter<T0, T1, T2: key>(arg0: &Snapshot, arg1: &T2, arg2: &0x2::tx_context::TxContext) {
        let v0 = if (arg0.actor == 0x2::tx_context::sender(arg2)) {
            if (arg0.adapter == 0x1::type_name::with_defining_ids<T0>()) {
                if (arg0.adapter_revision == 0x1::type_name::with_defining_ids<T1>()) {
                    arg0.target_type == 0x1::type_name::with_defining_ids<T2>()
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 4);
    }

    fun assert_producer<T0, T1>(arg0: vector<u8>) {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<T1>();
        let v2 = if (!0x1::type_name::is_primitive(&v0)) {
            if (!0x1::type_name::is_primitive(&v1)) {
                if (0x1::type_name::address_string(&v0) == 0x1::type_name::address_string(&v1)) {
                    if (0x1::type_name::module_string(&v0) == 0x1::type_name::module_string(&v1)) {
                        let v3 = 0x1::type_name::datatype_string(&v0);
                        *0x1::ascii::as_bytes(&v3) == arg0
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v2, 1);
    }

    public fun attempt(arg0: &Snapshot) : vector<u8> {
        arg0.attempt
    }

    public fun authorize_action<T0: drop, T1: key, T2: key>(arg0: T0, arg1: &T1, arg2: &T2, arg3: Snapshot, arg4: vector<u8>, arg5: &0x2::tx_context::TxContext) : PaidAction {
        assert_producer<T0, T1>(b"ManufacturingProducer");
        assert_actual<T1, T2>(&arg3, arg1, arg2, arg5);
        assert!(0x1::vector::length<u8>(&arg4) == 32, 2);
        PaidAction{
            producer : 0x1::type_name::with_defining_ids<T0>(),
            snapshot : arg3,
            target   : 0x2::object::id<T2>(arg2),
            receipt  : arg4,
        }
    }

    public fun commitment(arg0: &Snapshot) : vector<u8> {
        arg0.commitment
    }

    public fun complete<T0: drop, T1: key, T2: key>(arg0: T0, arg1: &T1, arg2: &T2, arg3: Snapshot, arg4: &0x2::tx_context::TxContext) : CompletionAuthorization {
        assert_producer<T0, T1>(b"SoulProducer");
        assert!(arg3.producer == 0x1::type_name::with_defining_ids<T0>(), 1);
        assert_actual<T1, T2>(&arg3, arg1, arg2, arg4);
        CompletionAuthorization{
            snapshot : arg3,
            target   : 0x2::object::id<T2>(arg2),
        }
    }

    public fun config(arg0: &Snapshot) : 0x2::object::ID {
        arg0.config
    }

    public fun consume_action<T0: drop, T1: drop, T2: key>(arg0: PaidAction, arg1: T0, arg2: T1, arg3: &T2, arg4: u8, arg5: &0x2::tx_context::TxContext) : (Snapshot, vector<u8>) {
        let PaidAction {
            producer : _,
            snapshot : v1,
            target   : v2,
            receipt  : v3,
        } = arg0;
        let v4 = v1;
        assert_adapter<T0, T1, T2>(&v4, arg3, arg5);
        assert!(v2 == 0x2::object::id<T2>(arg3) && v4.operation == arg4, 4);
        (v4, v3)
    }

    public fun consume_completion<T0, T1, T2: key>(arg0: CompletionAuthorization, arg1: &T2, arg2: &Snapshot, arg3: &0x2::tx_context::TxContext) {
        let CompletionAuthorization {
            snapshot : v0,
            target   : v1,
        } = arg0;
        let v2 = v0;
        assert!(v1 == 0x2::object::id<T2>(arg1) && v2 == *arg2, 2);
        assert_adapter<T0, T1, T2>(&v2, arg1, arg3);
    }

    public fun consume_delivery<T0: key>(arg0: CompletionAuthorization, arg1: &T0, arg2: &Snapshot, arg3: &0x2::tx_context::TxContext) {
        let CompletionAuthorization {
            snapshot : v0,
            target   : v1,
        } = arg0;
        let v2 = v0;
        let v3 = if (v1 == 0x2::object::id<T0>(arg1)) {
            if (v2 == *arg2) {
                if (v2.target_type == 0x1::type_name::with_defining_ids<T0>()) {
                    v2.actor == 0x2::tx_context::sender(arg3)
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v3, 2);
    }

    public fun consume_request<T0: key>(arg0: OriginRequest, arg1: &0x2::tx_context::TxContext) : Snapshot {
        let OriginRequest { snapshot: v0 } = arg0;
        assert!(v0.actor == 0x2::tx_context::sender(arg1) && v0.target_type == 0x1::type_name::with_defining_ids<T0>(), 3);
        v0
    }

    public fun expiry(arg0: &Snapshot) : u64 {
        arg0.expiry
    }

    public fun name(arg0: &Snapshot) : 0x1::string::String {
        arg0.name
    }

    public fun operation(arg0: &Snapshot) : u8 {
        arg0.operation
    }

    public fun policy(arg0: &Snapshot) : vector<u8> {
        arg0.policy
    }

    public fun producer(arg0: &Snapshot) : 0x1::type_name::TypeName {
        arg0.producer
    }

    public fun request<T0: drop, T1: key, T2: drop, T3: drop, T4: key>(arg0: T0, arg1: &T1, arg2: T2, arg3: T3, arg4: u64, arg5: vector<u8>, arg6: 0x1::string::String, arg7: vector<u8>, arg8: 0x2::object::ID, arg9: u64, arg10: vector<u8>, arg11: u64, arg12: u8, arg13: &0x2::tx_context::TxContext) : OriginRequest {
        assert_producer<T0, T1>(b"SoulProducer");
        let v0 = if (arg4 > 0) {
            if (0x1::vector::length<u8>(&arg5) == 32) {
                if (0x1::vector::length<u8>(&arg7) == 32) {
                    0x1::vector::length<u8>(&arg10) == 32
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 2);
        let v1 = Snapshot{
            producer         : 0x1::type_name::with_defining_ids<T0>(),
            source_type      : 0x1::type_name::with_defining_ids<T1>(),
            source           : 0x2::object::id<T1>(arg1),
            version          : arg4,
            policy           : arg5,
            actor            : 0x2::tx_context::sender(arg13),
            name             : arg6,
            attempt          : arg7,
            config           : arg8,
            revision         : arg9,
            commitment       : arg10,
            expiry           : arg11,
            operation        : arg12,
            adapter          : 0x1::type_name::with_defining_ids<T2>(),
            adapter_revision : 0x1::type_name::with_defining_ids<T3>(),
            target_type      : 0x1::type_name::with_defining_ids<T4>(),
        };
        OriginRequest{snapshot: v1}
    }

    public fun revision(arg0: &Snapshot) : u64 {
        arg0.revision
    }

    public fun snapshot(arg0: &OriginRequest) : Snapshot {
        arg0.snapshot
    }

    public fun source(arg0: &Snapshot) : 0x2::object::ID {
        arg0.source
    }

    public fun source_type(arg0: &Snapshot) : 0x1::type_name::TypeName {
        arg0.source_type
    }

    public fun target_type(arg0: &Snapshot) : 0x1::type_name::TypeName {
        arg0.target_type
    }

    public fun version(arg0: &Snapshot) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v7
}

