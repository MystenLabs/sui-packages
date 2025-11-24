module 0x981c0994df832f2a334ea7bcbb1ead7dd25794ed18fdb8b636b4f5557d5b96dd::verification_session {
    struct ValidatorCap has store, key {
        id: 0x2::object::UID,
    }

    struct StageTimestamp has copy, drop, store {
        stage: u8,
        started_at_epoch: u64,
        completed_at_epoch: u64,
        progress_percent: u8,
    }

    struct VerificationSession has store, key {
        id: 0x2::object::UID,
        owner: address,
        submission_id: 0x1::option::Option<0x2::object::ID>,
        status: u8,
        current_stage: u8,
        stage_timestamps: vector<StageTimestamp>,
        plaintext_cid: 0x1::option::Option<0x1::string::String>,
        plaintext_size_bytes: u64,
        encrypted_cid: 0x1::option::Option<0x1::string::String>,
        preview_cid: 0x1::option::Option<0x1::string::String>,
        seal_policy_id: 0x1::option::Option<0x1::string::String>,
        duration_seconds: u64,
        file_format: 0x1::string::String,
        transcript_hash: 0x1::option::Option<vector<u8>>,
        quality_metrics_hash: 0x1::option::Option<vector<u8>>,
        quality_score: u8,
        safety_passed: bool,
        approved: bool,
        deletion_receipt_hash: 0x1::option::Option<vector<u8>>,
        deleted_at_epoch: u64,
        created_at_epoch: u64,
        finalized_at_epoch: u64,
    }

    struct SessionRegistry has key {
        id: 0x2::object::UID,
        total_sessions: u64,
        active_sessions: u64,
        completed_sessions: u64,
        failed_sessions: u64,
        owner_sessions: 0x2::vec_map::VecMap<address, vector<0x2::object::ID>>,
    }

    struct SessionCreated has copy, drop {
        session_id: 0x2::object::ID,
        owner: address,
        plaintext_cid: 0x1::string::String,
        plaintext_size_bytes: u64,
        created_at_epoch: u64,
    }

    struct StageUpdated has copy, drop {
        session_id: 0x2::object::ID,
        owner: address,
        old_stage: u8,
        new_stage: u8,
        progress_percent: u8,
        current_epoch: u64,
    }

    struct VerificationCompleted has copy, drop {
        session_id: 0x2::object::ID,
        owner: address,
        quality_score: u8,
        safety_passed: bool,
        approved: bool,
        transcript_hash: vector<u8>,
        quality_metrics_hash: vector<u8>,
        completed_at_epoch: u64,
    }

    struct DeletionConfirmed has copy, drop {
        session_id: 0x2::object::ID,
        owner: address,
        plaintext_cid: 0x1::string::String,
        deletion_receipt_hash: vector<u8>,
        deleted_at_epoch: u64,
    }

    struct EncryptedUploaded has copy, drop {
        session_id: 0x2::object::ID,
        owner: address,
        encrypted_cid: 0x1::string::String,
        seal_policy_id: 0x1::string::String,
        uploaded_at_epoch: u64,
    }

    struct SessionFinalized has copy, drop {
        session_id: 0x2::object::ID,
        owner: address,
        submission_id: 0x2::object::ID,
        status: u8,
        finalized_at_epoch: u64,
    }

    struct SessionFailed has copy, drop {
        session_id: 0x2::object::ID,
        owner: address,
        stage: u8,
        reason: 0x1::string::String,
        failed_at_epoch: u64,
    }

    struct RegistryInitialized has copy, drop {
        registry_id: 0x2::object::ID,
    }

    public fun active_sessions(arg0: &SessionRegistry) : u64 {
        arg0.active_sessions
    }

    public fun approved(arg0: &VerificationSession) : bool {
        arg0.approved
    }

    public fun completed_sessions(arg0: &SessionRegistry) : u64 {
        arg0.completed_sessions
    }

    public entry fun create_session(arg0: &mut SessionRegistry, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: 0x1::string::String, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        let v1 = 0x2::tx_context::epoch(arg5);
        let v2 = VerificationSession{
            id                    : 0x2::object::new(arg5),
            owner                 : v0,
            submission_id         : 0x1::option::none<0x2::object::ID>(),
            status                : 0,
            current_stage         : 0,
            stage_timestamps      : 0x1::vector::empty<StageTimestamp>(),
            plaintext_cid         : 0x1::option::some<0x1::string::String>(arg1),
            plaintext_size_bytes  : arg2,
            encrypted_cid         : 0x1::option::none<0x1::string::String>(),
            preview_cid           : 0x1::option::none<0x1::string::String>(),
            seal_policy_id        : 0x1::option::none<0x1::string::String>(),
            duration_seconds      : arg3,
            file_format           : arg4,
            transcript_hash       : 0x1::option::none<vector<u8>>(),
            quality_metrics_hash  : 0x1::option::none<vector<u8>>(),
            quality_score         : 0,
            safety_passed         : false,
            approved              : false,
            deletion_receipt_hash : 0x1::option::none<vector<u8>>(),
            deleted_at_epoch      : 0,
            created_at_epoch      : v1,
            finalized_at_epoch    : 0,
        };
        let v3 = 0x2::object::uid_to_inner(&v2.id);
        arg0.total_sessions = arg0.total_sessions + 1;
        arg0.active_sessions = arg0.active_sessions + 1;
        if (0x2::vec_map::contains<address, vector<0x2::object::ID>>(&arg0.owner_sessions, &v0)) {
            0x1::vector::push_back<0x2::object::ID>(0x2::vec_map::get_mut<address, vector<0x2::object::ID>>(&mut arg0.owner_sessions, &v0), v3);
        } else {
            0x2::vec_map::insert<address, vector<0x2::object::ID>>(&mut arg0.owner_sessions, v0, 0x1::vector::singleton<0x2::object::ID>(v3));
        };
        let v4 = SessionCreated{
            session_id           : v3,
            owner                : v0,
            plaintext_cid        : arg1,
            plaintext_size_bytes : arg2,
            created_at_epoch     : v1,
        };
        0x2::event::emit<SessionCreated>(v4);
        0x2::transfer::transfer<VerificationSession>(v2, v0);
    }

    public fun current_stage(arg0: &VerificationSession) : u8 {
        arg0.current_stage
    }

    public fun duration_seconds(arg0: &VerificationSession) : u64 {
        arg0.duration_seconds
    }

    public fun encrypted_cid(arg0: &VerificationSession) : 0x1::option::Option<0x1::string::String> {
        arg0.encrypted_cid
    }

    public entry fun fail_session(arg0: &ValidatorCap, arg1: &mut VerificationSession, arg2: 0x1::string::String, arg3: &mut SessionRegistry, arg4: &mut 0x2::tx_context::TxContext) {
        arg1.status = 5;
        arg1.current_stage = 8;
        if (arg3.active_sessions > 0) {
            arg3.active_sessions = arg3.active_sessions - 1;
        };
        arg3.failed_sessions = arg3.failed_sessions + 1;
        let v0 = SessionFailed{
            session_id      : 0x2::object::uid_to_inner(&arg1.id),
            owner           : arg1.owner,
            stage           : arg1.current_stage,
            reason          : arg2,
            failed_at_epoch : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<SessionFailed>(v0);
    }

    public fun failed_sessions(arg0: &SessionRegistry) : u64 {
        arg0.failed_sessions
    }

    public entry fun finalize_verification(arg0: &ValidatorCap, arg1: &mut VerificationSession, arg2: u8, arg3: bool, arg4: bool, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 1, 8001);
        arg1.quality_score = arg2;
        arg1.safety_passed = arg3;
        arg1.approved = arg4;
        arg1.transcript_hash = 0x1::option::some<vector<u8>>(arg5);
        arg1.quality_metrics_hash = 0x1::option::some<vector<u8>>(arg6);
        arg1.current_stage = 7;
        let v0 = VerificationCompleted{
            session_id           : 0x2::object::uid_to_inner(&arg1.id),
            owner                : arg1.owner,
            quality_score        : arg2,
            safety_passed        : arg3,
            approved             : arg4,
            transcript_hash      : arg5,
            quality_metrics_hash : arg6,
            completed_at_epoch   : 0x2::tx_context::epoch(arg7),
        };
        0x2::event::emit<VerificationCompleted>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SessionRegistry{
            id                 : 0x2::object::new(arg0),
            total_sessions     : 0,
            active_sessions    : 0,
            completed_sessions : 0,
            failed_sessions    : 0,
            owner_sessions     : 0x2::vec_map::empty<address, vector<0x2::object::ID>>(),
        };
        let v1 = RegistryInitialized{registry_id: 0x2::object::uid_to_inner(&v0.id)};
        0x2::event::emit<RegistryInitialized>(v1);
        0x2::transfer::share_object<SessionRegistry>(v0);
        let v2 = ValidatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<ValidatorCap>(v2, 0x2::tx_context::sender(arg0));
    }

    public fun is_approved(arg0: &VerificationSession) : bool {
        arg0.approved
    }

    public fun is_encrypted(arg0: &VerificationSession) : bool {
        arg0.status == 3
    }

    public fun is_failed(arg0: &VerificationSession) : bool {
        arg0.status == 5
    }

    public fun link_submission(arg0: &mut VerificationSession, arg1: 0x2::object::ID, arg2: &mut SessionRegistry, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg3);
        assert!(arg0.status == 3, 8006);
        arg0.submission_id = 0x1::option::some<0x2::object::ID>(arg1);
        arg0.finalized_at_epoch = v0;
        if (arg2.active_sessions > 0) {
            arg2.active_sessions = arg2.active_sessions - 1;
        };
        arg2.completed_sessions = arg2.completed_sessions + 1;
        let v1 = SessionFinalized{
            session_id         : 0x2::object::uid_to_inner(&arg0.id),
            owner              : arg0.owner,
            submission_id      : arg1,
            status             : arg0.status,
            finalized_at_epoch : v0,
        };
        0x2::event::emit<SessionFinalized>(v1);
    }

    public fun owner(arg0: &VerificationSession) : address {
        arg0.owner
    }

    public fun plaintext_size_bytes(arg0: &VerificationSession) : u64 {
        arg0.plaintext_size_bytes
    }

    public fun preview_cid(arg0: &VerificationSession) : 0x1::option::Option<0x1::string::String> {
        arg0.preview_cid
    }

    public fun quality_score(arg0: &VerificationSession) : u8 {
        arg0.quality_score
    }

    public fun safety_passed(arg0: &VerificationSession) : bool {
        arg0.safety_passed
    }

    public fun seal_policy_id(arg0: &VerificationSession) : 0x1::option::Option<0x1::string::String> {
        arg0.seal_policy_id
    }

    public fun status(arg0: &VerificationSession) : u8 {
        arg0.status
    }

    public entry fun submit_deletion_receipt(arg0: &mut VerificationSession, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg2);
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 8004);
        assert!(arg0.status == 1, 8001);
        assert!(arg0.approved, 8007);
        arg0.deletion_receipt_hash = 0x1::option::some<vector<u8>>(arg1);
        arg0.deleted_at_epoch = v0;
        arg0.status = 2;
        let v1 = DeletionConfirmed{
            session_id            : 0x2::object::uid_to_inner(&arg0.id),
            owner                 : arg0.owner,
            plaintext_cid         : *0x1::option::borrow<0x1::string::String>(&arg0.plaintext_cid),
            deletion_receipt_hash : arg1,
            deleted_at_epoch      : v0,
        };
        0x2::event::emit<DeletionConfirmed>(v1);
    }

    public entry fun submit_encrypted_upload(arg0: &mut VerificationSession, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg4), 8004);
        assert!(arg0.status == 2, 8001);
        arg0.encrypted_cid = 0x1::option::some<0x1::string::String>(arg1);
        arg0.preview_cid = 0x1::option::some<0x1::string::String>(arg2);
        arg0.seal_policy_id = 0x1::option::some<0x1::string::String>(arg3);
        arg0.status = 3;
        let v0 = EncryptedUploaded{
            session_id        : 0x2::object::uid_to_inner(&arg0.id),
            owner             : arg0.owner,
            encrypted_cid     : arg1,
            seal_policy_id    : arg3,
            uploaded_at_epoch : 0x2::tx_context::epoch(arg4),
        };
        0x2::event::emit<EncryptedUploaded>(v0);
    }

    public fun total_sessions(arg0: &SessionRegistry) : u64 {
        arg0.total_sessions
    }

    public entry fun update_stage(arg0: &ValidatorCap, arg1: &mut VerificationSession, arg2: &mut SessionRegistry, arg3: u8, arg4: u8, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch(arg5);
        assert!(arg3 <= 8, 8008);
        if (arg3 == 8) {
            arg1.status = 5;
            arg1.current_stage = arg3;
            if (arg2.active_sessions > 0) {
                arg2.active_sessions = arg2.active_sessions - 1;
            };
            arg2.failed_sessions = arg2.failed_sessions + 1;
            let v1 = SessionFailed{
                session_id      : 0x2::object::uid_to_inner(&arg1.id),
                owner           : arg1.owner,
                stage           : arg1.current_stage,
                reason          : 0x1::string::utf8(b"Stage failed during verification"),
                failed_at_epoch : v0,
            };
            0x2::event::emit<SessionFailed>(v1);
            return
        };
        arg1.current_stage = arg3;
        let v2 = StageTimestamp{
            stage              : arg3,
            started_at_epoch   : v0,
            completed_at_epoch : v0,
            progress_percent   : arg4,
        };
        0x1::vector::push_back<StageTimestamp>(&mut arg1.stage_timestamps, v2);
        if (arg3 >= 1 && arg1.status == 0) {
            arg1.status = 1;
        };
        let v3 = StageUpdated{
            session_id       : 0x2::object::uid_to_inner(&arg1.id),
            owner            : arg1.owner,
            old_stage        : arg1.current_stage,
            new_stage        : arg3,
            progress_percent : arg4,
            current_epoch    : v0,
        };
        0x2::event::emit<StageUpdated>(v3);
    }

    // decompiled from Move bytecode v6
}

