module 0x278301424c954dcfdb6e46407728964271fbfff3dc1d4fae5b799c7e977bd4c5::groth16_verifier {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct VerifierRegistry has key {
        id: 0x2::object::UID,
        circuits: 0x2::table::Table<u8, CircuitConfig>,
        circuit_count: u8,
    }

    struct CircuitConfig has store {
        name: vector<u8>,
        pvk: 0x2::groth16::PreparedVerifyingKey,
        n_public: u8,
    }

    struct ProofVerified has copy, drop {
        template_id: u8,
        verifier: address,
        valid: bool,
    }

    struct CircuitRegistered has copy, drop {
        template_id: u8,
        name: vector<u8>,
        n_public: u8,
    }

    public fun circuit_count(arg0: &VerifierRegistry) : u8 {
        arg0.circuit_count
    }

    public fun get_circuit_info(arg0: &VerifierRegistry, arg1: u8) : (vector<u8>, u8, bool) {
        if (!0x2::table::contains<u8, CircuitConfig>(&arg0.circuits, arg1)) {
            return (b"", 0, false)
        };
        let v0 = 0x2::table::borrow<u8, CircuitConfig>(&arg0.circuits, arg1);
        (v0.name, v0.n_public, true)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = VerifierRegistry{
            id            : 0x2::object::new(arg0),
            circuits      : 0x2::table::new<u8, CircuitConfig>(arg0),
            circuit_count : 0,
        };
        0x2::transfer::share_object<VerifierRegistry>(v1);
    }

    public fun register_circuit(arg0: &AdminCap, arg1: &mut VerifierRegistry, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: u8) {
        assert!(!0x2::table::contains<u8, CircuitConfig>(&arg1.circuits, arg2), 2);
        let v0 = 0x2::groth16::bn254();
        let v1 = CircuitConfig{
            name     : arg3,
            pvk      : 0x2::groth16::prepare_verifying_key(&v0, &arg4),
            n_public : arg5,
        };
        0x2::table::add<u8, CircuitConfig>(&mut arg1.circuits, arg2, v1);
        if (arg2 >= arg1.circuit_count) {
            if (arg2 == 255) {
                arg1.circuit_count = 255;
            } else {
                arg1.circuit_count = arg2 + 1;
            };
        };
        let v2 = CircuitRegistered{
            template_id : arg2,
            name        : arg3,
            n_public    : arg5,
        };
        0x2::event::emit<CircuitRegistered>(v2);
    }

    public fun update_circuit(arg0: &AdminCap, arg1: &mut VerifierRegistry, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: u8) {
        assert!(0x2::table::contains<u8, CircuitConfig>(&arg1.circuits, arg2), 0);
        let v0 = 0x2::table::borrow_mut<u8, CircuitConfig>(&mut arg1.circuits, arg2);
        v0.name = arg3;
        let v1 = 0x2::groth16::bn254();
        v0.pvk = 0x2::groth16::prepare_verifying_key(&v1, &arg4);
        v0.n_public = arg5;
        let v2 = CircuitRegistered{
            template_id : arg2,
            name        : arg3,
            n_public    : arg5,
        };
        0x2::event::emit<CircuitRegistered>(v2);
    }

    public fun verify_proof(arg0: &VerifierRegistry, arg1: u8, arg2: vector<u8>, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<u8, CircuitConfig>(&arg0.circuits, arg1), 0);
        let v0 = 0x2::table::borrow<u8, CircuitConfig>(&arg0.circuits, arg1);
        assert!(0x1::vector::length<u8>(&arg3) == (v0.n_public as u64) * 32, 3);
        let v1 = 0x2::groth16::proof_points_from_bytes(arg2);
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(arg3);
        let v3 = 0x2::groth16::bn254();
        let v4 = 0x2::groth16::verify_groth16_proof(&v3, &v0.pvk, &v2, &v1);
        assert!(v4, 1);
        let v5 = ProofVerified{
            template_id : arg1,
            verifier    : 0x2::tx_context::sender(arg4),
            valid       : v4,
        };
        0x2::event::emit<ProofVerified>(v5);
    }

    public fun verify_proof_static(arg0: &VerifierRegistry, arg1: u8, arg2: vector<u8>, arg3: vector<u8>) : bool {
        if (!0x2::table::contains<u8, CircuitConfig>(&arg0.circuits, arg1)) {
            return false
        };
        let v0 = 0x2::table::borrow<u8, CircuitConfig>(&arg0.circuits, arg1);
        if (0x1::vector::length<u8>(&arg3) != (v0.n_public as u64) * 32) {
            return false
        };
        let v1 = 0x2::groth16::proof_points_from_bytes(arg2);
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(arg3);
        let v3 = 0x2::groth16::bn254();
        0x2::groth16::verify_groth16_proof(&v3, &v0.pvk, &v2, &v1)
    }

    // decompiled from Move bytecode v7
}

