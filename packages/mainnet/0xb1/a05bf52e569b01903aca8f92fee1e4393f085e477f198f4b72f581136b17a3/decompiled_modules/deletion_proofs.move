module 0xb1a05bf52e569b01903aca8f92fee1e4393f085e477f198f4b72f581136b17a3::deletion_proofs {
    struct VerifierCap has store, key {
        id: 0x2::object::UID,
        verifier_address: address,
    }

    struct DeletionReceipt has store, key {
        id: 0x2::object::UID,
        session_id: 0x2::object::ID,
        owner: address,
        plaintext_cid: 0x1::string::String,
        deletion_proof_hash: vector<u8>,
        verifier_signature: vector<u8>,
        verifier_address: address,
        deleted_at_epoch: u64,
        proof_expires_at_epoch: u64,
        walrus_deletion_timestamp: u64,
        verified: bool,
    }

    struct ProofRegistry has key {
        id: 0x2::object::UID,
        total_proofs: u64,
        verified_proofs: u64,
        expired_proofs: u64,
        session_proofs: 0x2::vec_map::VecMap<0x2::object::ID, 0x2::object::ID>,
        authorized_verifiers: vector<address>,
    }

    struct ProofSubmitted has copy, drop {
        receipt_id: 0x2::object::ID,
        session_id: 0x2::object::ID,
        owner: address,
        plaintext_cid: 0x1::string::String,
        deletion_proof_hash: vector<u8>,
        verifier_address: address,
        deleted_at_epoch: u64,
    }

    struct ProofVerified has copy, drop {
        receipt_id: 0x2::object::ID,
        session_id: 0x2::object::ID,
        verified_at_epoch: u64,
    }

    struct ProofExpired has copy, drop {
        receipt_id: 0x2::object::ID,
        session_id: 0x2::object::ID,
        expired_at_epoch: u64,
    }

    struct VerifierAuthorized has copy, drop {
        verifier_address: address,
        authorized_at_epoch: u64,
    }

    struct VerifierRevoked has copy, drop {
        verifier_address: address,
        revoked_at_epoch: u64,
    }

    struct RegistryInitialized has copy, drop {
        registry_id: 0x2::object::ID,
    }

    public fun authorize_verifier(arg0: &VerifierCap, arg1: &mut ProofRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        if (!0x1::vector::contains<address>(&arg1.authorized_verifiers, &arg2)) {
            0x1::vector::push_back<address>(&mut arg1.authorized_verifiers, arg2);
            let v0 = VerifierAuthorized{
                verifier_address    : arg2,
                authorized_at_epoch : 0x2::tx_context::epoch(arg3),
            };
            0x2::event::emit<VerifierAuthorized>(v0);
        };
    }

    public fun check_expiry(arg0: &mut ProofRegistry, arg1: &DeletionReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        if (v0 >= arg1.proof_expires_at_epoch && !arg1.verified) {
            arg0.expired_proofs = arg0.expired_proofs + 1;
            let v1 = ProofExpired{
                receipt_id       : 0x2::object::uid_to_inner(&arg1.id),
                session_id       : arg1.session_id,
                expired_at_epoch : v0,
            };
            0x2::event::emit<ProofExpired>(v1);
        };
    }

    public fun deleted_at_epoch(arg0: &DeletionReceipt) : u64 {
        arg0.deleted_at_epoch
    }

    public fun deletion_proof_hash(arg0: &DeletionReceipt) : vector<u8> {
        arg0.deletion_proof_hash
    }

    public fun expired_proofs(arg0: &ProofRegistry) : u64 {
        arg0.expired_proofs
    }

    public fun generate_proof_hash(arg0: 0x1::string::String, arg1: u64, arg2: 0x2::object::ID) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, *0x1::string::as_bytes(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<0x2::object::ID>(&arg2));
        0x2::hash::keccak256(&v0)
    }

    public fun get_receipt_id(arg0: &ProofRegistry, arg1: 0x2::object::ID) : 0x1::option::Option<0x2::object::ID> {
        if (0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.session_proofs, &arg1)) {
            0x1::option::some<0x2::object::ID>(*0x2::vec_map::get<0x2::object::ID, 0x2::object::ID>(&arg0.session_proofs, &arg1))
        } else {
            0x1::option::none<0x2::object::ID>()
        }
    }

    public fun has_deletion_receipt(arg0: &ProofRegistry, arg1: 0x2::object::ID) : bool {
        0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg0.session_proofs, &arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ProofRegistry{
            id                   : 0x2::object::new(arg0),
            total_proofs         : 0,
            verified_proofs      : 0,
            expired_proofs       : 0,
            session_proofs       : 0x2::vec_map::empty<0x2::object::ID, 0x2::object::ID>(),
            authorized_verifiers : 0x1::vector::empty<address>(),
        };
        let v1 = RegistryInitialized{registry_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<RegistryInitialized>(v1);
        0x2::transfer::share_object<ProofRegistry>(v0);
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = VerifierCap{
            id               : 0x2::object::new(arg0),
            verifier_address : v2,
        };
        0x2::transfer::transfer<VerifierCap>(v3, v2);
    }

    public fun is_authorized_verifier(arg0: &ProofRegistry, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.authorized_verifiers, &arg1)
    }

    public fun is_valid_proof(arg0: &DeletionReceipt, arg1: &0x2::tx_context::TxContext) : bool {
        arg0.verified && 0x2::tx_context::epoch(arg1) < arg0.proof_expires_at_epoch
    }

    public fun owner(arg0: &DeletionReceipt) : address {
        arg0.owner
    }

    public fun plaintext_cid(arg0: &DeletionReceipt) : 0x1::string::String {
        arg0.plaintext_cid
    }

    public fun proof_expires_at_epoch(arg0: &DeletionReceipt) : u64 {
        arg0.proof_expires_at_epoch
    }

    public fun revoke_verifier(arg0: &VerifierCap, arg1: &mut ProofRegistry, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x1::vector::index_of<address>(&arg1.authorized_verifiers, &arg2);
        if (v0) {
            0x1::vector::remove<address>(&mut arg1.authorized_verifiers, v1);
            let v2 = VerifierRevoked{
                verifier_address : arg2,
                revoked_at_epoch : 0x2::tx_context::epoch(arg3),
            };
            0x2::event::emit<VerifierRevoked>(v2);
        };
    }

    public fun session_id(arg0: &DeletionReceipt) : 0x2::object::ID {
        arg0.session_id
    }

    public fun submit_deletion_receipt(arg0: &VerifierCap, arg1: &mut ProofRegistry, arg2: 0x2::object::ID, arg3: address, arg4: 0x1::string::String, arg5: vector<u8>, arg6: vector<u8>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg8);
        let v1 = 0x2::tx_context::sender(arg8);
        assert!(0x1::vector::contains<address>(&arg1.authorized_verifiers, &v1), 9003);
        assert!(0x1::vector::length<u8>(&arg5) >= 32, 9001);
        assert!(!0x2::vec_map::contains<0x2::object::ID, 0x2::object::ID>(&arg1.session_proofs, &arg2), 9004);
        let v2 = DeletionReceipt{
            id                        : 0x2::object::new(arg8),
            session_id                : arg2,
            owner                     : arg3,
            plaintext_cid             : arg4,
            deletion_proof_hash       : arg5,
            verifier_signature        : arg6,
            verifier_address          : v1,
            deleted_at_epoch          : v0,
            proof_expires_at_epoch    : v0 + 7,
            walrus_deletion_timestamp : arg7,
            verified                  : false,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        0x2::vec_map::insert<0x2::object::ID, 0x2::object::ID>(&mut arg1.session_proofs, arg2, v3);
        arg1.total_proofs = arg1.total_proofs + 1;
        let v4 = ProofSubmitted{
            receipt_id          : v3,
            session_id          : arg2,
            owner               : arg3,
            plaintext_cid       : arg4,
            deletion_proof_hash : arg5,
            verifier_address    : v1,
            deleted_at_epoch    : v0,
        };
        0x2::event::emit<ProofSubmitted>(v4);
        0x2::transfer::transfer<DeletionReceipt>(v2, arg3);
    }

    public fun total_proofs(arg0: &ProofRegistry) : u64 {
        arg0.total_proofs
    }

    public fun verified(arg0: &DeletionReceipt) : bool {
        arg0.verified
    }

    public fun verified_proofs(arg0: &ProofRegistry) : u64 {
        arg0.verified_proofs
    }

    public fun verifier_address(arg0: &DeletionReceipt) : address {
        arg0.verifier_address
    }

    public fun verify_receipt(arg0: &mut ProofRegistry, arg1: &mut DeletionReceipt, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        assert!(v0 < arg1.proof_expires_at_epoch, 9002);
        arg1.verified = true;
        arg0.verified_proofs = arg0.verified_proofs + 1;
        let v1 = ProofVerified{
            receipt_id        : 0x2::object::uid_to_inner(&arg1.id),
            session_id        : arg1.session_id,
            verified_at_epoch : v0,
        };
        0x2::event::emit<ProofVerified>(v1);
    }

    // decompiled from Move bytecode v6
}

