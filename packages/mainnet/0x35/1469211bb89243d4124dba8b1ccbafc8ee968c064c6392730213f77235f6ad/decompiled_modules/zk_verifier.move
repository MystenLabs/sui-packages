module 0x351469211bb89243d4124dba8b1ccbafc8ee968c064c6392730213f77235f6ad::zk_verifier {
    struct Circuit has copy, drop, store {
        id: vector<u8>,
        name: vector<u8>,
        curve: u8,
        pvk: 0x2::groth16::PreparedVerifyingKey,
        num_public_inputs: u64,
        input_schema_hash: vector<u8>,
        active: bool,
    }

    struct CircuitRegistry has store, key {
        id: 0x2::object::UID,
        version: u64,
        circuits: vector<Circuit>,
        owner: address,
        trusted: bool,
    }

    struct RegistryAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VerificationResult has copy, drop, store {
        valid: bool,
        circuit_id: vector<u8>,
        inputs_hash: vector<u8>,
        timestamp: u64,
    }

    struct ZkStateProof has copy, drop, store {
        circuit_id: vector<u8>,
        public_inputs: vector<u8>,
        proof: vector<u8>,
        state_version: u64,
    }

    struct PreparedProof has copy, drop, store {
        curve: 0x2::groth16::Curve,
        inputs: 0x2::groth16::PublicProofInputs,
        proof_points: 0x2::groth16::ProofPoints,
    }

    struct CircuitRegistered has copy, drop {
        circuit_id: vector<u8>,
        num_public_inputs: u64,
        curve: u8,
    }

    struct CircuitDeactivated has copy, drop {
        circuit_id: vector<u8>,
    }

    struct ProofVerified has copy, drop {
        circuit_id: vector<u8>,
        success: bool,
    }

    public fun address_to_scalar(arg0: address) : vector<u8> {
        0x2::address::to_bytes(arg0)
    }

    public fun assert_current_version(arg0: &CircuitRegistry) {
        assert!(arg0.version == 1, 13906835836496117767);
    }

    public fun circuit_curve(arg0: &Circuit) : u8 {
        arg0.curve
    }

    public fun circuit_id(arg0: &Circuit) : &vector<u8> {
        &arg0.id
    }

    public fun circuit_input_schema_hash(arg0: &Circuit) : &vector<u8> {
        &arg0.input_schema_hash
    }

    public fun circuit_is_active(arg0: &Circuit) : bool {
        arg0.active
    }

    public fun circuit_name(arg0: &Circuit) : &vector<u8> {
        &arg0.name
    }

    public fun circuit_num_inputs(arg0: &Circuit) : u64 {
        arg0.num_public_inputs
    }

    public fun circuit_pvk(arg0: &Circuit) : &0x2::groth16::PreparedVerifyingKey {
        &arg0.pvk
    }

    public fun concat_scalars(arg0: vector<vector<u8>>) : vector<u8> {
        let v0 = b"";
        let v1 = 0x1::vector::length<vector<u8>>(&arg0);
        assert!(v1 <= 8, 13906837073446830089);
        let v2 = 0;
        while (v2 < v1) {
            let v3 = 0x1::vector::borrow<vector<u8>>(&arg0, v2);
            assert!(0x1::vector::length<u8>(v3) == 32, 13906837094921666569);
            0x1::vector::append<u8>(&mut v0, *v3);
            v2 = v2 + 1;
        };
        v0
    }

    public fun create_circuit(arg0: vector<u8>, arg1: u8, arg2: &vector<u8>, arg3: u64, arg4: vector<u8>) : Circuit {
        assert!(is_valid_curve(arg1), 13906835441358864387);
        assert!(arg3 <= 8, 13906835445654224905);
        assert!(0x1::vector::length<u8>(&arg0) > 0, 13906835449948930053);
        let v0 = get_curve(arg1);
        Circuit{
            id                : create_circuit_id(&arg0),
            name              : arg0,
            curve             : arg1,
            pvk               : 0x2::groth16::prepare_verifying_key(&v0, arg2),
            num_public_inputs : arg3,
            input_schema_hash : arg4,
            active            : true,
        }
    }

    public fun create_circuit_id(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::blake2b256(arg0)
    }

    public fun create_circuit_with_pvk(arg0: vector<u8>, arg1: u8, arg2: 0x2::groth16::PreparedVerifyingKey, arg3: u64, arg4: vector<u8>) : Circuit {
        assert!(is_valid_curve(arg1), 13906835553028014083);
        assert!(arg3 <= 8, 13906835557323374601);
        assert!(0x1::vector::length<u8>(&arg0) > 0, 13906835561618079749);
        Circuit{
            id                : create_circuit_id(&arg0),
            name              : arg0,
            curve             : arg1,
            pvk               : arg2,
            num_public_inputs : arg3,
            input_schema_hash : arg4,
            active            : true,
        }
    }

    public fun create_registry(arg0: address, arg1: &mut 0x2::tx_context::TxContext) : CircuitRegistry {
        CircuitRegistry{
            id       : 0x2::object::new(arg1),
            version  : 1,
            circuits : 0x1::vector::empty<Circuit>(),
            owner    : arg0,
            trusted  : false,
        }
    }

    public fun create_trusted_registry(arg0: &RegistryAdminCap, arg1: &mut 0x2::tx_context::TxContext) : CircuitRegistry {
        CircuitRegistry{
            id       : 0x2::object::new(arg1),
            version  : 1,
            circuits : 0x1::vector::empty<Circuit>(),
            owner    : 0x2::tx_context::sender(arg1),
            trusted  : true,
        }
    }

    public fun create_verification_result(arg0: bool, arg1: vector<u8>, arg2: &vector<u8>, arg3: u64) : VerificationResult {
        VerificationResult{
            valid       : arg0,
            circuit_id  : arg1,
            inputs_hash : 0x2::hash::blake2b256(arg2),
            timestamp   : arg3,
        }
    }

    public fun create_zk_state_proof(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64) : ZkStateProof {
        ZkStateProof{
            circuit_id    : arg0,
            public_inputs : arg1,
            proof         : arg2,
            state_version : arg3,
        }
    }

    public fun current_version() : u64 {
        1
    }

    public fun curve_bls12381() : u8 {
        0
    }

    public fun curve_bn254() : u8 {
        1
    }

    public fun deactivate_circuit(arg0: &mut CircuitRegistry, arg1: &vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 13906835978229645313);
        let v0 = &arg0.circuits;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Circuit>(v0)) {
            if (&0x1::vector::borrow<Circuit>(v0, v1).id == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 8 */
                assert!(0x1::option::is_some<u64>(&v2), 13906835991115202571);
                0x1::vector::borrow_mut<Circuit>(&mut arg0.circuits, 0x1::option::destroy_some<u64>(v2)).active = false;
                let v3 = CircuitDeactivated{circuit_id: *arg1};
                0x2::event::emit<CircuitDeactivated>(v3);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 8 */
    }

    public fun get_circuit(arg0: &CircuitRegistry, arg1: &vector<u8>) : &Circuit {
        let v0 = &arg0.circuits;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Circuit>(v0)) {
            if (&0x1::vector::borrow<Circuit>(v0, v1).id == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 13906836094194417675);
                return 0x1::vector::borrow<Circuit>(&arg0.circuits, 0x1::option::destroy_some<u64>(v2))
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun get_curve(arg0: u8) : 0x2::groth16::Curve {
        if (arg0 == 0) {
            0x2::groth16::bls12381()
        } else {
            assert!(arg0 == 1, 13906835299624943619);
            0x2::groth16::bn254()
        }
    }

    public fun hash_to_scalar(arg0: &vector<u8>) : vector<u8> {
        0x2::hash::blake2b256(arg0)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RegistryAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<RegistryAdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun is_circuit_active(arg0: &CircuitRegistry, arg1: &vector<u8>) : bool {
        let v0 = &arg0.circuits;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Circuit>(v0)) {
            if (&0x1::vector::borrow<Circuit>(v0, v1).id == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                return 0x1::option::is_some<u64>(&v2) && 0x1::vector::borrow<Circuit>(&arg0.circuits, 0x1::option::destroy_some<u64>(v2)).active
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun is_circuit_registered(arg0: &CircuitRegistry, arg1: &vector<u8>) : bool {
        let v0 = &arg0.circuits;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Circuit>(v0)) {
            if (&0x1::vector::borrow<Circuit>(v0, v1).id == arg1) {
                v2 = true;
                return v2
            };
            v1 = v1 + 1;
        };
        v2 = false;
        v2
    }

    public fun is_trusted_registry(arg0: &CircuitRegistry) : bool {
        arg0.trusted
    }

    public fun is_valid_curve(arg0: u8) : bool {
        arg0 == 0 || arg0 == 1
    }

    public fun max_public_inputs() : u64 {
        8
    }

    public fun prepare_proof(arg0: u8, arg1: &vector<u8>, arg2: &vector<u8>) : PreparedProof {
        PreparedProof{
            curve        : get_curve(arg0),
            inputs       : 0x2::groth16::public_proof_inputs_from_bytes(*arg1),
            proof_points : 0x2::groth16::proof_points_from_bytes(*arg2),
        }
    }

    public fun reactivate_circuit(arg0: &mut CircuitRegistry, arg1: &vector<u8>, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 13906836038359187457);
        let v0 = &arg0.circuits;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Circuit>(v0)) {
            if (&0x1::vector::borrow<Circuit>(v0, v1).id == arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 9 */
                assert!(0x1::option::is_some<u64>(&v2), 13906836051244744715);
                0x1::vector::borrow_mut<Circuit>(&mut arg0.circuits, 0x1::option::destroy_some<u64>(v2)).active = true;
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 9 */
    }

    public fun register_circuit(arg0: &mut CircuitRegistry, arg1: Circuit, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 13906835875150430209);
        let v0 = &arg0.circuits;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Circuit>(v0)) {
            if (0x1::vector::borrow<Circuit>(v0, v1).id == arg1.id) {
                v2 = true;
                /* label 9 */
                assert!(!v2, 13906835896626053133);
                0x1::vector::push_back<Circuit>(&mut arg0.circuits, arg1);
                let v3 = 0x1::vector::borrow<Circuit>(&arg0.circuits, 0x1::vector::length<Circuit>(&arg0.circuits) - 1);
                let v4 = CircuitRegistered{
                    circuit_id        : v3.id,
                    num_public_inputs : v3.num_public_inputs,
                    curve             : v3.curve,
                };
                0x2::event::emit<CircuitRegistered>(v4);
                return
            };
            v1 = v1 + 1;
        };
        v2 = false;
        /* goto 9 */
    }

    public fun registry_circuit_count(arg0: &CircuitRegistry) : u64 {
        0x1::vector::length<Circuit>(&arg0.circuits)
    }

    public fun registry_owner(arg0: &CircuitRegistry) : address {
        arg0.owner
    }

    public fun registry_version(arg0: &CircuitRegistry) : u64 {
        arg0.version
    }

    public fun result_circuit_id(arg0: &VerificationResult) : &vector<u8> {
        &arg0.circuit_id
    }

    public fun result_inputs_hash(arg0: &VerificationResult) : &vector<u8> {
        &arg0.inputs_hash
    }

    public fun result_timestamp(arg0: &VerificationResult) : u64 {
        arg0.timestamp
    }

    public fun result_valid(arg0: &VerificationResult) : bool {
        arg0.valid
    }

    public fun scalar_size() : u64 {
        32
    }

    public fun state_proof_version(arg0: &ZkStateProof) : u64 {
        arg0.state_version
    }

    public fun u256_to_scalar(arg0: u256) : vector<u8> {
        let v0 = b"";
        let v1 = 0;
        while (v1 < 32) {
            0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
            arg0 = arg0 >> 8;
            v1 = v1 + 1;
        };
        v0
    }

    public fun u64_to_scalar(arg0: u64) : vector<u8> {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, ((arg0 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(&mut v0, ((arg0 >> 56 & 255) as u8));
        while (0x1::vector::length<u8>(&v0) < 32) {
            0x1::vector::push_back<u8>(&mut v0, 0);
        };
        v0
    }

    public fun verify_circuit_proof(arg0: &CircuitRegistry, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>) : bool {
        let v0 = get_circuit(arg0, arg1);
        assert!(v0.active, 13906836274583044107);
        assert!(0x1::vector::length<u8>(arg2) == v0.num_public_inputs * 32, 13906836291762782217);
        let v1 = verify_with_circuit(v0, arg2, arg3);
        let v2 = ProofVerified{
            circuit_id : *arg1,
            success    : v1,
        };
        0x2::event::emit<ProofVerified>(v2);
        v1
    }

    public fun verify_prepared(arg0: &0x2::groth16::PreparedVerifyingKey, arg1: &PreparedProof) : bool {
        0x2::groth16::verify_groth16_proof(&arg1.curve, arg0, &arg1.inputs, &arg1.proof_points)
    }

    public fun verify_raw(arg0: u8, arg1: &0x2::groth16::PreparedVerifyingKey, arg2: &vector<u8>, arg3: &vector<u8>) : bool {
        let v0 = get_curve(arg0);
        let v1 = 0x2::groth16::public_proof_inputs_from_bytes(*arg2);
        let v2 = 0x2::groth16::proof_points_from_bytes(*arg3);
        0x2::groth16::verify_groth16_proof(&v0, arg1, &v1, &v2)
    }

    public fun verify_with_circuit(arg0: &Circuit, arg1: &vector<u8>, arg2: &vector<u8>) : bool {
        assert!(0x1::vector::length<u8>(arg1) == arg0.num_public_inputs * 32, 13906836356187291657);
        let v0 = get_curve(arg0.curve);
        let v1 = 0x2::groth16::public_proof_inputs_from_bytes(*arg1);
        let v2 = 0x2::groth16::proof_points_from_bytes(*arg2);
        0x2::groth16::verify_groth16_proof(&v0, &arg0.pvk, &v1, &v2)
    }

    public fun verify_zk_state_proof(arg0: &CircuitRegistry, arg1: &ZkStateProof) : bool {
        verify_circuit_proof(arg0, &arg1.circuit_id, &arg1.public_inputs, &arg1.proof)
    }

    public fun zk_proof_circuit_id(arg0: &ZkStateProof) : &vector<u8> {
        &arg0.circuit_id
    }

    public fun zk_proof_proof(arg0: &ZkStateProof) : &vector<u8> {
        &arg0.proof
    }

    public fun zk_proof_public_inputs(arg0: &ZkStateProof) : &vector<u8> {
        &arg0.public_inputs
    }

    public fun zk_proof_state_version(arg0: &ZkStateProof) : u64 {
        arg0.state_version
    }

    // decompiled from Move bytecode v7
}

