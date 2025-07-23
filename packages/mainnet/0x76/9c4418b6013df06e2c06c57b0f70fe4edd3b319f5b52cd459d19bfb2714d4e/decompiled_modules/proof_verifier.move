module 0x769c4418b6013df06e2c06c57b0f70fe4edd3b319f5b52cd459d19bfb2714d4e::proof_verifier {
    struct Proof has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        sender: address,
        proving_system: 0x1::string::String,
        proof_data_blob_id: 0x1::string::String,
        vk_blob_id: 0x1::string::String,
        verification_result: 0x1::option::Option<bool>,
        signature: 0x1::option::Option<vector<u8>>,
        signer_pk: 0x1::option::Option<vector<u8>>,
    }

    struct ProofData has drop, store {
        path: 0x1::string::String,
        blob_id: 0x1::string::String,
        blob_hash: u256,
    }

    struct CommitteeCap has key {
        id: 0x2::object::UID,
    }

    struct ProofCreated has copy, drop {
        proof_id: 0x2::object::ID,
        name: 0x1::string::String,
        sender: address,
        proving_system: 0x1::string::String,
        proof_data_blob_id: 0x1::string::String,
        vk_blob_id: 0x1::string::String,
        created_at: u64,
    }

    struct ProofVerified has copy, drop {
        proof: 0x2::object::ID,
        verification_result: bool,
        verified_at: u64,
        committee_address: address,
    }

    struct ProofTransferred has copy, drop {
        proof_id: 0x2::object::ID,
        from: address,
        to: address,
        transferred_at: u64,
    }

    struct ProofDataAdded has copy, drop {
        proof_id: 0x2::object::ID,
        path: 0x1::string::String,
        blob_id: 0x1::string::String,
        blob_hash: u256,
        added_at: u64,
        added_by: address,
    }

    struct CommitteeCapCreated has copy, drop {
        committee_id: 0x2::object::ID,
        committee_address: address,
        created_at: u64,
    }

    public fun add_proof_data(arg0: &mut Proof, arg1: ProofData, arg2: &0x2::tx_context::TxContext) {
        let v0 = arg1.path;
        let v1 = arg1.blob_id;
        let v2 = arg1.blob_hash;
        0x1::string::append(&mut v0, 0x1::string::utf8(b"#blob_id"));
        0x1::string::append(&mut v0, 0x1::string::utf8(b"#blob_hash"));
        0x2::dynamic_field::add<0x1::string::String, 0x1::string::String>(&mut arg0.id, v0, v1);
        0x2::dynamic_field::add<0x1::string::String, u256>(&mut arg0.id, v0, v2);
        0x2::dynamic_field::add<0x1::string::String, ProofData>(&mut arg0.id, v0, arg1);
        let v3 = ProofDataAdded{
            proof_id  : 0x2::object::id<Proof>(arg0),
            path      : v0,
            blob_id   : v1,
            blob_hash : v2,
            added_at  : 0x2::tx_context::epoch_timestamp_ms(arg2),
            added_by  : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<ProofDataAdded>(v3);
    }

    public fun borrow_proof_data(arg0: &Proof, arg1: 0x1::string::String) : &ProofData {
        0x2::dynamic_field::borrow<0x1::string::String, ProofData>(&arg0.id, arg1)
    }

    public fun create_proof(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) : Proof {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = Proof{
            id                  : v0,
            name                : arg0,
            sender              : v1,
            proving_system      : arg1,
            proof_data_blob_id  : arg2,
            vk_blob_id          : arg3,
            verification_result : 0x1::option::none<bool>(),
            signature           : 0x1::option::none<vector<u8>>(),
            signer_pk           : 0x1::option::none<vector<u8>>(),
        };
        let v3 = ProofCreated{
            proof_id           : 0x2::object::uid_to_inner(&v0),
            name               : arg0,
            sender             : v1,
            proving_system     : arg1,
            proof_data_blob_id : arg2,
            vk_blob_id         : arg3,
            created_at         : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<ProofCreated>(v3);
        v2
    }

    public fun create_proof_2(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = Proof{
            id                  : v0,
            name                : arg0,
            sender              : v1,
            proving_system      : arg1,
            proof_data_blob_id  : arg2,
            vk_blob_id          : arg3,
            verification_result : 0x1::option::none<bool>(),
            signature           : 0x1::option::none<vector<u8>>(),
            signer_pk           : 0x1::option::none<vector<u8>>(),
        };
        let v3 = ProofCreated{
            proof_id           : 0x2::object::uid_to_inner(&v0),
            name               : arg0,
            sender             : v1,
            proving_system     : arg1,
            proof_data_blob_id : arg2,
            vk_blob_id         : arg3,
            created_at         : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<ProofCreated>(v3);
        0x2::transfer::transfer<Proof>(v2, v1);
    }

    public fun get_proof_sender(arg0: &Proof) : address {
        arg0.sender
    }

    public fun get_verification_result(arg0: &Proof) : &0x1::option::Option<bool> {
        &arg0.verification_result
    }

    public fun has_proof_data(arg0: &Proof, arg1: &0x1::string::String) : bool {
        0x2::dynamic_field::exists_<0x1::string::String>(&arg0.id, *arg1)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CommitteeCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::tx_context::sender(arg0);
        let v2 = CommitteeCapCreated{
            committee_id      : 0x2::object::uid_to_inner(&v0.id),
            committee_address : v1,
            created_at        : 0x2::tx_context::epoch_timestamp_ms(arg0),
        };
        0x2::event::emit<CommitteeCapCreated>(v2);
        0x2::transfer::transfer<CommitteeCap>(v0, v1);
    }

    public fun is_verified(arg0: &Proof) : bool {
        0x1::option::is_some<bool>(&arg0.verification_result) && *0x1::option::borrow<bool>(&arg0.verification_result)
    }

    public entry fun new_proof(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg4);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = Proof{
            id                  : v0,
            name                : arg0,
            sender              : v1,
            proving_system      : arg1,
            proof_data_blob_id  : arg2,
            vk_blob_id          : arg3,
            verification_result : 0x1::option::none<bool>(),
            signature           : 0x1::option::none<vector<u8>>(),
            signer_pk           : 0x1::option::none<vector<u8>>(),
        };
        let v3 = ProofCreated{
            proof_id           : 0x2::object::uid_to_inner(&v0),
            name               : arg0,
            sender             : v1,
            proving_system     : arg1,
            proof_data_blob_id : arg2,
            vk_blob_id         : arg3,
            created_at         : 0x2::tx_context::epoch_timestamp_ms(arg4),
        };
        0x2::event::emit<ProofCreated>(v3);
        0x2::transfer::transfer<Proof>(v2, v1);
    }

    public fun new_proof_data(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u256) : ProofData {
        ProofData{
            path      : arg0,
            blob_id   : arg1,
            blob_hash : arg2,
        }
    }

    public fun transfer_proof(arg0: Proof, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = ProofTransferred{
            proof_id       : 0x2::object::id<Proof>(&arg0),
            from           : 0x2::tx_context::sender(arg2),
            to             : arg1,
            transferred_at : 0x2::tx_context::epoch_timestamp_ms(arg2),
        };
        0x2::event::emit<ProofTransferred>(v0);
        0x2::transfer::public_transfer<Proof>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun update_proof_verification_result(arg0: &mut Proof, arg1: bool, arg2: vector<u8>, arg3: vector<u8>) {
        assert!(0x1::option::is_none<bool>(&arg0.verification_result), 0);
        0x1::option::fill<bool>(&mut arg0.verification_result, arg1);
        0x1::option::fill<vector<u8>>(&mut arg0.signature, arg2);
        0x1::option::fill<vector<u8>>(&mut arg0.signer_pk, arg3);
    }

    // decompiled from Move bytecode v6
}

