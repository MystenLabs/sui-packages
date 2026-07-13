module 0xd80fa995336dd3ac589807aae8ff837bd74f96d1e1193d2047904812f16d1f27::verifier {
    struct Verified has copy, drop {
        ok: bool,
    }

    public entry fun assert_verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) {
        assert!(verify(arg0, arg1, arg2), 57005);
        let v0 = Verified{ok: true};
        0x2::event::emit<Verified>(v0);
    }

    public fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>) : bool {
        let v0 = 0x2::groth16::bn254();
        let v1 = 0x2::groth16::prepare_verifying_key(&v0, &arg0);
        let v2 = 0x2::groth16::public_proof_inputs_from_bytes(arg1);
        let v3 = 0x2::groth16::proof_points_from_bytes(arg2);
        0x2::groth16::verify_groth16_proof(&v0, &v1, &v2, &v3)
    }

    // decompiled from Move bytecode v7
}

