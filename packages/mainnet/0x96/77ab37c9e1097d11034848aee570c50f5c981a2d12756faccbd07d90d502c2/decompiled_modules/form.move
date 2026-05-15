module 0x9677ab37c9e1097d11034848aee570c50f5c981a2d12756faccbd07d90d502c2::form {
    struct Form has key {
        id: 0x2::object::UID,
        schema_blob_id: 0x1::string::String,
        schema_version: u64,
        metadata_blob_id: 0x1::string::String,
        owner: address,
        privacy_tier: u8,
        threshold_n: u8,
        threshold_m: u8,
        unlock_ms: u64,
        conditional_policy_id: 0x1::string::String,
        status: u8,
        submission_count: u64,
        created_ms: u64,
        commitments_used: 0x2::table::Table<vector<u8>, bool>,
    }

    struct FormOwnerCap has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
    }

    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        owner: address,
        privacy_tier: u8,
    }

    struct FormSchemaUpdated has copy, drop {
        form_id: 0x2::object::ID,
        new_version: u64,
    }

    struct FormStatusChanged has copy, drop {
        form_id: 0x2::object::ID,
        new_status: u8,
    }

    struct ApprovalWitness has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        identity: vector<u8>,
        signer: address,
        created_ms: u64,
    }

    struct ApprovalPosted has copy, drop {
        form_id: 0x2::object::ID,
        identity_hash: vector<u8>,
        signer: address,
        witness_id: 0x2::object::ID,
        created_ms: u64,
    }

    public fun id(arg0: &Form) : 0x2::object::ID {
        0x2::object::id<Form>(arg0)
    }

    public fun archive_form(arg0: &FormOwnerCap, arg1: &mut Form) {
        assert_owns(arg0, arg1);
        arg1.status = 3;
        let v0 = FormStatusChanged{
            form_id    : 0x2::object::id<Form>(arg1),
            new_status : 3,
        };
        0x2::event::emit<FormStatusChanged>(v0);
    }

    public(friend) fun assert_open(arg0: &Form) {
        assert!(arg0.status == 1, 1);
    }

    fun assert_owns(arg0: &FormOwnerCap, arg1: &Form) {
        assert!(arg0.form_id == 0x2::object::id<Form>(arg1), 2);
    }

    public(friend) fun bump_submission_count(arg0: &mut Form) {
        arg0.submission_count = arg0.submission_count + 1;
    }

    public fun cap_form_id(arg0: &FormOwnerCap) : 0x2::object::ID {
        arg0.form_id
    }

    public fun close_form(arg0: &FormOwnerCap, arg1: &mut Form) {
        assert_owns(arg0, arg1);
        arg1.status = 2;
        let v0 = FormStatusChanged{
            form_id    : 0x2::object::id<Form>(arg1),
            new_status : 2,
        };
        0x2::event::emit<FormStatusChanged>(v0);
    }

    public fun commitment_used(arg0: &Form, arg1: vector<u8>) : bool {
        0x2::table::contains<vector<u8>, bool>(&arg0.commitments_used, arg1)
    }

    public fun create_form(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: u8, arg4: u8, arg5: u64, arg6: 0x1::string::String, arg7: vector<address>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : FormOwnerCap {
        assert!(arg2 <= 4, 0);
        if (arg2 == 2) {
            assert!(arg3 > 0 && arg3 <= arg4, 3);
        };
        let v0 = Form{
            id                    : 0x2::object::new(arg9),
            schema_blob_id        : arg0,
            schema_version        : 1,
            metadata_blob_id      : arg1,
            owner                 : 0x2::tx_context::sender(arg9),
            privacy_tier          : arg2,
            threshold_n           : arg3,
            threshold_m           : arg4,
            unlock_ms             : arg5,
            conditional_policy_id : arg6,
            status                : 1,
            submission_count      : 0,
            created_ms            : 0x2::clock::timestamp_ms(arg8),
            commitments_used      : 0x2::table::new<vector<u8>, bool>(arg9),
        };
        let v1 = 0x2::object::id<Form>(&v0);
        let v2 = FormOwnerCap{
            id      : 0x2::object::new(arg9),
            form_id : v1,
        };
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg7)) {
            let v4 = FormOwnerCap{
                id      : 0x2::object::new(arg9),
                form_id : v1,
            };
            0x2::transfer::transfer<FormOwnerCap>(v4, *0x1::vector::borrow<address>(&arg7, v3));
            v3 = v3 + 1;
        };
        let v5 = FormCreated{
            form_id      : v1,
            owner        : 0x2::tx_context::sender(arg9),
            privacy_tier : arg2,
        };
        0x2::event::emit<FormCreated>(v5);
        0x2::transfer::share_object<Form>(v0);
        v2
    }

    public fun owner(arg0: &Form) : address {
        arg0.owner
    }

    public fun post_approval(arg0: &FormOwnerCap, arg1: &Form, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.form_id == 0x2::object::id<Form>(arg1), 2);
        assert!(arg1.privacy_tier == 2, 6);
        assert!(seal_id_matches_form(&arg2, arg1), 4);
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = 0x2::object::id<Form>(arg1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = 0x2::object::new(arg4);
        let v4 = ApprovalWitness{
            id         : v3,
            form_id    : v1,
            identity   : arg2,
            signer     : v0,
            created_ms : v2,
        };
        let v5 = ApprovalPosted{
            form_id       : v1,
            identity_hash : 0x2::hash::keccak256(&arg2),
            signer        : v0,
            witness_id    : 0x2::object::uid_to_inner(&v3),
            created_ms    : v2,
        };
        0x2::event::emit<ApprovalPosted>(v5);
        0x2::transfer::share_object<ApprovalWitness>(v4);
    }

    public fun privacy_admin_only() : u8 {
        1
    }

    public fun privacy_conditional() : u8 {
        4
    }

    public fun privacy_public() : u8 {
        0
    }

    public fun privacy_threshold() : u8 {
        2
    }

    public fun privacy_tier(arg0: &Form) : u8 {
        arg0.privacy_tier
    }

    public fun privacy_time_locked() : u8 {
        3
    }

    public(friend) fun record_commitment(arg0: &mut Form, arg1: vector<u8>) {
        assert!(!0x2::table::contains<vector<u8>, bool>(&arg0.commitments_used, arg1), 7);
        0x2::table::add<vector<u8>, bool>(&mut arg0.commitments_used, arg1, true);
    }

    public fun schema_blob_id(arg0: &Form) : 0x1::string::String {
        arg0.schema_blob_id
    }

    public fun schema_version(arg0: &Form) : u64 {
        arg0.schema_version
    }

    public fun seal_approve_admin_only(arg0: vector<u8>, arg1: &Form, arg2: &FormOwnerCap) {
        assert!(seal_id_matches_form(&arg0, arg1), 4);
        assert!(arg1.privacy_tier == 1, 6);
        assert!(arg2.form_id == 0x2::object::id<Form>(arg1), 2);
    }

    public fun seal_approve_conditional(arg0: vector<u8>, arg1: &Form, arg2: &FormOwnerCap) {
        assert!(seal_id_matches_form(&arg0, arg1), 4);
        assert!(arg1.privacy_tier == 4, 6);
        assert!(arg2.form_id == 0x2::object::id<Form>(arg1), 2);
    }

    public fun seal_approve_threshold(arg0: vector<u8>, arg1: &Form, arg2: &FormOwnerCap) {
        assert!(seal_id_matches_form(&arg0, arg1), 4);
        assert!(arg1.privacy_tier == 2, 6);
        assert!(arg2.form_id == 0x2::object::id<Form>(arg1), 2);
    }

    public fun seal_approve_threshold_m_of_n(arg0: vector<u8>, arg1: &Form, arg2: vector<ApprovalWitness>) {
        assert!(seal_id_matches_form(&arg0, arg1), 4);
        assert!(arg1.privacy_tier == 2, 6);
        let v0 = 0x1::vector::length<ApprovalWitness>(&arg2);
        assert!(v0 >= (arg1.threshold_n as u64), 8);
        let v1 = 0x2::vec_set::empty<address>();
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x1::vector::borrow<ApprovalWitness>(&arg2, v2);
            assert!(v3.form_id == 0x2::object::id<Form>(arg1), 9);
            assert!(&v3.identity == &arg0, 10);
            assert!(!0x2::vec_set::contains<address>(&v1, &v3.signer), 11);
            0x2::vec_set::insert<address>(&mut v1, v3.signer);
            v2 = v2 + 1;
        };
        while (!0x1::vector::is_empty<ApprovalWitness>(&arg2)) {
            let ApprovalWitness {
                id         : v4,
                form_id    : _,
                identity   : _,
                signer     : _,
                created_ms : _,
            } = 0x1::vector::pop_back<ApprovalWitness>(&mut arg2);
            0x2::object::delete(v4);
        };
        0x1::vector::destroy_empty<ApprovalWitness>(arg2);
    }

    public fun seal_approve_time_locked(arg0: vector<u8>, arg1: &Form, arg2: &0x2::clock::Clock) {
        assert!(seal_id_matches_form(&arg0, arg1), 4);
        assert!(arg1.privacy_tier == 3, 6);
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.unlock_ms, 5);
    }

    fun seal_id_matches_form(arg0: &vector<u8>, arg1: &Form) : bool {
        if (0x1::vector::length<u8>(arg0) < 33) {
            return false
        };
        let v0 = 0x2::object::id<Form>(arg1);
        let v1 = 0x2::object::id_to_bytes(&v0);
        let v2 = 0;
        while (v2 < 32) {
            if (*0x1::vector::borrow<u8>(arg0, v2) != *0x1::vector::borrow<u8>(&v1, v2)) {
                return false
            };
            v2 = v2 + 1;
        };
        true
    }

    public fun status(arg0: &Form) : u8 {
        arg0.status
    }

    public fun status_archived() : u8 {
        3
    }

    public fun status_closed() : u8 {
        2
    }

    public fun status_open() : u8 {
        1
    }

    public fun submission_count(arg0: &Form) : u64 {
        arg0.submission_count
    }

    public fun threshold(arg0: &Form) : (u8, u8) {
        (arg0.threshold_n, arg0.threshold_m)
    }

    public fun unlock_ms(arg0: &Form) : u64 {
        arg0.unlock_ms
    }

    public fun update_metadata(arg0: &FormOwnerCap, arg1: &mut Form, arg2: 0x1::string::String) {
        assert_owns(arg0, arg1);
        arg1.metadata_blob_id = arg2;
    }

    public fun update_schema(arg0: &FormOwnerCap, arg1: &mut Form, arg2: 0x1::string::String) {
        assert_owns(arg0, arg1);
        arg1.schema_blob_id = arg2;
        arg1.schema_version = arg1.schema_version + 1;
        let v0 = FormSchemaUpdated{
            form_id     : 0x2::object::id<Form>(arg1),
            new_version : arg1.schema_version,
        };
        0x2::event::emit<FormSchemaUpdated>(v0);
    }

    public fun witness_created_ms(arg0: &ApprovalWitness) : u64 {
        arg0.created_ms
    }

    public fun witness_form_id(arg0: &ApprovalWitness) : 0x2::object::ID {
        arg0.form_id
    }

    public fun witness_signer(arg0: &ApprovalWitness) : address {
        arg0.signer
    }

    // decompiled from Move bytecode v6
}

