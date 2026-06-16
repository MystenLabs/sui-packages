module 0x8722790773958722225cf91f5a6762689dc13f97076534c05ebd3505d586f9bf::proof {
    struct Proof<phantom T0> has copy, drop, store {
        root: u256,
        points: 0x2::groth16::ProofPoints,
        input_nullifiers: vector<u256>,
        output_commitments: vector<u256>,
        public_value: u256,
        pool: address,
    }

    public(friend) fun account_public_inputs<T0>(arg0: Proof<T0>, arg1: u256) : 0x2::groth16::PublicProofInputs {
        make_public_inputs<T0>(arg0, to_field(arg1))
    }

    public(friend) fun input_nullifiers<T0>(arg0: Proof<T0>) : vector<u256> {
        arg0.input_nullifiers
    }

    fun make_public_inputs<T0>(arg0: Proof<T0>, arg1: vector<u8>) : 0x2::groth16::PublicProofInputs {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, to_field(0x2::address::to_u256(arg0.pool)));
        0x1::vector::push_back<vector<u8>>(v1, to_field(arg0.root));
        0x1::vector::push_back<vector<u8>>(v1, to_field(arg0.public_value));
        0x1::vector::push_back<vector<u8>>(v1, to_field(*0x1::vector::borrow<u256>(&arg0.input_nullifiers, 0)));
        0x1::vector::push_back<vector<u8>>(v1, to_field(*0x1::vector::borrow<u256>(&arg0.input_nullifiers, 1)));
        0x1::vector::push_back<vector<u8>>(v1, to_field(*0x1::vector::borrow<u256>(&arg0.output_commitments, 0)));
        0x1::vector::push_back<vector<u8>>(v1, to_field(*0x1::vector::borrow<u256>(&arg0.output_commitments, 1)));
        0x1::vector::push_back<vector<u8>>(v1, arg1);
        0x2::groth16::public_proof_inputs_from_bytes(0x1::vector::flatten<u8>(v0))
    }

    public fun new<T0>(arg0: address, arg1: vector<u8>, arg2: u256, arg3: u256, arg4: u256, arg5: u256, arg6: u256, arg7: u256) : Proof<T0> {
        assert!(arg4 < 21888242871839275222246405745257275088548364400416034343698204186575808495617, 809);
        assert!(arg5 < 21888242871839275222246405745257275088548364400416034343698204186575808495617, 809);
        assert!(arg6 < 21888242871839275222246405745257275088548364400416034343698204186575808495617, 809);
        assert!(arg7 < 21888242871839275222246405745257275088548364400416034343698204186575808495617, 809);
        let v0 = 0x1::vector::empty<u256>();
        let v1 = &mut v0;
        0x1::vector::push_back<u256>(v1, arg4);
        0x1::vector::push_back<u256>(v1, arg5);
        let v2 = 0x1::vector::empty<u256>();
        let v3 = &mut v2;
        0x1::vector::push_back<u256>(v3, arg6);
        0x1::vector::push_back<u256>(v3, arg7);
        Proof<T0>{
            root               : arg2,
            points             : 0x2::groth16::proof_points_from_bytes(arg1),
            input_nullifiers   : v0,
            output_commitments : v2,
            public_value       : arg3,
            pool               : arg0,
        }
    }

    public(friend) fun output_commitments<T0>(arg0: Proof<T0>) : vector<u256> {
        arg0.output_commitments
    }

    public(friend) fun points<T0>(arg0: Proof<T0>) : 0x2::groth16::ProofPoints {
        arg0.points
    }

    public(friend) fun pool<T0>(arg0: Proof<T0>) : address {
        arg0.pool
    }

    public(friend) fun public_inputs<T0>(arg0: Proof<T0>) : 0x2::groth16::PublicProofInputs {
        let v0 = 0;
        make_public_inputs<T0>(arg0, 0x2::bcs::to_bytes<u256>(&v0))
    }

    public(friend) fun public_value<T0>(arg0: Proof<T0>) : u256 {
        arg0.public_value
    }

    public(friend) fun root<T0>(arg0: Proof<T0>) : u256 {
        arg0.root
    }

    fun to_field(arg0: u256) : vector<u8> {
        let v0 = arg0 % 21888242871839275222246405745257275088548364400416034343698204186575808495617;
        0x2::bcs::to_bytes<u256>(&v0)
    }

    // decompiled from Move bytecode v7
}

