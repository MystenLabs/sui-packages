module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::proof {
    struct Proof has store, key {
        id: 0x2::object::UID,
        task_id: address,
        submitter: address,
        proof_hash: vector<u8>,
        metadata_url: vector<u8>,
        verified: bool,
        verifier: address,
        submitted_at: u64,
        verified_at: u64,
    }

    struct ProofSubmitted has copy, drop {
        proof_id: address,
        task_id: address,
        submitter: address,
        proof_hash: vector<u8>,
    }

    struct ProofVerified has copy, drop {
        proof_id: address,
        task_id: address,
        verifier: address,
    }

    public fun is_verified(arg0: &Proof) : bool {
        arg0.verified
    }

    public fun proof_hash(arg0: &Proof) : &vector<u8> {
        &arg0.proof_hash
    }

    entry fun submit_proof(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg1) == 32, 302);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = Proof{
            id           : 0x2::object::new(arg4),
            task_id      : arg0,
            submitter    : v0,
            proof_hash   : arg1,
            metadata_url : arg2,
            verified     : false,
            verifier     : @0x0,
            submitted_at : 0x2::clock::timestamp_ms(arg3),
            verified_at  : 0,
        };
        let v2 = ProofSubmitted{
            proof_id   : 0x2::object::uid_to_address(&v1.id),
            task_id    : arg0,
            submitter  : v0,
            proof_hash : v1.proof_hash,
        };
        0x2::event::emit<ProofSubmitted>(v2);
        0x2::transfer::share_object<Proof>(v1);
    }

    public fun submitter(arg0: &Proof) : address {
        arg0.submitter
    }

    public fun task_id(arg0: &Proof) : address {
        arg0.task_id
    }

    entry fun verify_proof(arg0: &mut Proof, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.verified, 301);
        let v0 = 0x2::tx_context::sender(arg2);
        arg0.verified = true;
        arg0.verifier = v0;
        arg0.verified_at = 0x2::clock::timestamp_ms(arg1);
        let v1 = ProofVerified{
            proof_id : 0x2::object::uid_to_address(&arg0.id),
            task_id  : arg0.task_id,
            verifier : v0,
        };
        0x2::event::emit<ProofVerified>(v1);
    }

    // decompiled from Move bytecode v6
}

