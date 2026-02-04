module 0x29caafe30d07b9ea1df6ab9d55da2efe6088a3c246cebc3319fbbd3db228cffc::validation {
    struct ValidationRegistry has key {
        id: 0x2::object::UID,
        owner: address,
        workers: 0x2::table::Table<address, Worker>,
        validations: 0x2::table::Table<0x2::object::ID, ValidationRecord>,
        total_validations: u64,
    }

    struct Worker has store {
        address: address,
        reputation_score: u64,
        total_inferences: u64,
        successful_validations: u64,
        is_active: bool,
    }

    struct ValidationRecord has store, key {
        id: 0x2::object::UID,
        requester: address,
        prompt: 0x1::string::String,
        timestamp: u64,
        worker_responses: vector<WorkerResponse>,
        trust_score: u64,
        consensus_reached: bool,
        evidence_bundle_cid: 0x1::string::String,
    }

    struct WorkerResponse has copy, drop, store {
        worker: address,
        response_hash: vector<u8>,
        response_text: 0x1::string::String,
        inference_time_ms: u64,
        similarity_score: u64,
    }

    struct EvidenceBundle has store, key {
        id: 0x2::object::UID,
        validation_id: 0x2::object::ID,
        responses: vector<WorkerResponse>,
        trust_score: u64,
        semantic_similarity_matrix: vector<u64>,
        outlier_flags: vector<bool>,
        ipfs_cid: 0x1::string::String,
        timestamp: u64,
    }

    struct TrustCertificate has store, key {
        id: 0x2::object::UID,
        validation_id: 0x2::object::ID,
        trust_score: u64,
        issuer: address,
        timestamp: u64,
    }

    struct ValidationRequested has copy, drop {
        validation_id: 0x2::object::ID,
        requester: address,
        prompt: 0x1::string::String,
        timestamp: u64,
    }

    struct ValidationCompleted has copy, drop {
        validation_id: 0x2::object::ID,
        trust_score: u64,
        consensus_reached: bool,
        worker_count: u64,
    }

    struct WorkerRegistered has copy, drop {
        worker: address,
        timestamp: u64,
    }

    struct EvidenceBundleCreated has copy, drop {
        bundle_id: 0x2::object::ID,
        validation_id: 0x2::object::ID,
        ipfs_cid: 0x1::string::String,
    }

    fun calculate_weighted_trust_score(arg0: &vector<u64>, arg1: &vector<bool>, arg2: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < arg2) {
            if (!*0x1::vector::borrow<bool>(arg1, v2)) {
                v0 = v0 + *0x1::vector::borrow<u64>(arg0, v2);
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        if (v1 == 0) {
            return 0
        };
        let v3 = if (v1 >= arg2 * 2 / 3) {
            10
        } else {
            0
        };
        let v4 = v0 / v1 + v3;
        if (v4 > 100) {
            100
        } else {
            v4
        }
    }

    public fun compute_trust_score(arg0: &mut ValidationRegistry, arg1: 0x2::object::ID, arg2: vector<u64>, arg3: vector<bool>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, ValidationRecord>(&arg0.validations, arg1), 3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ValidationRecord>(&mut arg0.validations, arg1);
        let v1 = 0x1::vector::length<WorkerResponse>(&v0.worker_responses);
        assert!(v1 >= 3, 4);
        let v2 = 0;
        while (v2 < v1) {
            0x1::vector::borrow_mut<WorkerResponse>(&mut v0.worker_responses, v2).similarity_score = *0x1::vector::borrow<u64>(&arg2, v2);
            v2 = v2 + 1;
        };
        let v3 = calculate_weighted_trust_score(&arg2, &arg3, v1);
        v0.trust_score = v3;
        v0.consensus_reached = v3 >= 70;
        let v4 = ValidationCompleted{
            validation_id     : arg1,
            trust_score       : v3,
            consensus_reached : v0.consensus_reached,
            worker_count      : v1,
        };
        0x2::event::emit<ValidationCompleted>(v4);
    }

    public fun create_evidence_bundle(arg0: &mut ValidationRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: vector<u64>, arg4: vector<bool>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : EvidenceBundle {
        assert!(0x2::table::contains<0x2::object::ID, ValidationRecord>(&arg0.validations, arg1), 3);
        let v0 = 0x2::table::borrow_mut<0x2::object::ID, ValidationRecord>(&mut arg0.validations, arg1);
        v0.evidence_bundle_cid = arg2;
        let v1 = EvidenceBundle{
            id                         : 0x2::object::new(arg6),
            validation_id              : arg1,
            responses                  : v0.worker_responses,
            trust_score                : v0.trust_score,
            semantic_similarity_matrix : arg3,
            outlier_flags              : arg4,
            ipfs_cid                   : v0.evidence_bundle_cid,
            timestamp                  : 0x2::clock::timestamp_ms(arg5),
        };
        let v2 = EvidenceBundleCreated{
            bundle_id     : 0x2::object::uid_to_inner(&v1.id),
            validation_id : arg1,
            ipfs_cid      : v0.evidence_bundle_cid,
        };
        0x2::event::emit<EvidenceBundleCreated>(v2);
        v1
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ValidationRegistry{
            id                : 0x2::object::new(arg0),
            owner             : 0x2::tx_context::sender(arg0),
            workers           : 0x2::table::new<address, Worker>(arg0),
            validations       : 0x2::table::new<0x2::object::ID, ValidationRecord>(arg0),
            total_validations : 0,
        };
        0x2::transfer::share_object<ValidationRegistry>(v0);
    }

    public fun issue_trust_certificate(arg0: &ValidationRegistry, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : TrustCertificate {
        assert!(0x2::table::contains<0x2::object::ID, ValidationRecord>(&arg0.validations, arg1), 3);
        TrustCertificate{
            id            : 0x2::object::new(arg3),
            validation_id : arg1,
            trust_score   : 0x2::table::borrow<0x2::object::ID, ValidationRecord>(&arg0.validations, arg1).trust_score,
            issuer        : arg0.owner,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
        }
    }

    public fun register_worker(arg0: &mut ValidationRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(!0x2::table::contains<address, Worker>(&arg0.workers, v0), 5);
        let v1 = Worker{
            address                : v0,
            reputation_score       : 100,
            total_inferences       : 0,
            successful_validations : 0,
            is_active              : true,
        };
        0x2::table::add<address, Worker>(&mut arg0.workers, v0, v1);
        let v2 = WorkerRegistered{
            worker    : v0,
            timestamp : 0,
        };
        0x2::event::emit<WorkerRegistered>(v2);
    }

    public fun request_validation(arg0: &mut ValidationRegistry, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x2::object::new(arg3);
        let v1 = 0x2::object::uid_to_inner(&v0);
        let v2 = ValidationRecord{
            id                  : v0,
            requester           : 0x2::tx_context::sender(arg3),
            prompt              : arg1,
            timestamp           : 0x2::clock::timestamp_ms(arg2),
            worker_responses    : 0x1::vector::empty<WorkerResponse>(),
            trust_score         : 0,
            consensus_reached   : false,
            evidence_bundle_cid : 0x1::string::utf8(b""),
        };
        let v3 = ValidationRequested{
            validation_id : v1,
            requester     : 0x2::tx_context::sender(arg3),
            prompt        : v2.prompt,
            timestamp     : v2.timestamp,
        };
        0x2::event::emit<ValidationRequested>(v3);
        0x2::table::add<0x2::object::ID, ValidationRecord>(&mut arg0.validations, v1, v2);
        arg0.total_validations = arg0.total_validations + 1;
        v1
    }

    public fun submit_inference(arg0: &mut ValidationRegistry, arg1: 0x2::object::ID, arg2: 0x1::string::String, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::table::contains<0x2::object::ID, ValidationRecord>(&arg0.validations, arg1), 3);
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, Worker>(&arg0.workers, v0), 2);
        let v1 = WorkerResponse{
            worker            : v0,
            response_hash     : arg3,
            response_text     : arg2,
            inference_time_ms : arg4,
            similarity_score  : 0,
        };
        0x1::vector::push_back<WorkerResponse>(&mut 0x2::table::borrow_mut<0x2::object::ID, ValidationRecord>(&mut arg0.validations, arg1).worker_responses, v1);
        let v2 = 0x2::table::borrow_mut<address, Worker>(&mut arg0.workers, v0);
        v2.total_inferences = v2.total_inferences + 1;
    }

    public fun transfer_evidence_bundle(arg0: EvidenceBundle, arg1: address) {
        0x2::transfer::public_transfer<EvidenceBundle>(arg0, arg1);
    }

    public fun transfer_trust_certificate(arg0: TrustCertificate, arg1: address) {
        0x2::transfer::public_transfer<TrustCertificate>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

