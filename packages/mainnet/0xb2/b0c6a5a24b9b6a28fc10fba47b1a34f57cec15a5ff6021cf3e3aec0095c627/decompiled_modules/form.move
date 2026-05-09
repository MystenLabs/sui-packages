module 0xb2b0c6a5a24b9b6a28fc10fba47b1a34f57cec15a5ff6021cf3e3aec0095c627::form {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
    }

    struct Form has store, key {
        id: 0x2::object::UID,
        owner: address,
        title: 0x1::string::String,
        schema_blob_id: 0x1::string::String,
        submission_blob_ids: vector<0x1::string::String>,
        is_private: bool,
        seal_policy_id: vector<u8>,
        relay_signer: address,
        created_at_ms: u64,
        submission_count: u64,
    }

    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        owner: address,
        is_private: bool,
    }

    struct SubmissionAdded has copy, drop {
        form_id: 0x2::object::ID,
        blob_id: 0x1::string::String,
        index: u64,
        ts_ms: u64,
    }

    public fun append_submission(arg0: &mut Form, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.relay_signer, 0);
        let v0 = 0x1::string::utf8(arg1);
        0x1::vector::push_back<0x1::string::String>(&mut arg0.submission_blob_ids, v0);
        let v1 = arg0.submission_count;
        arg0.submission_count = v1 + 1;
        let v2 = SubmissionAdded{
            form_id : 0x2::object::id<Form>(arg0),
            blob_id : v0,
            index   : v1,
            ts_ms   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<SubmissionAdded>(v2);
    }

    public fun create_form(arg0: vector<u8>, arg1: vector<u8>, arg2: bool, arg3: vector<u8>, arg4: address, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = Form{
            id                  : 0x2::object::new(arg6),
            owner               : v0,
            title               : 0x1::string::utf8(arg0),
            schema_blob_id      : 0x1::string::utf8(arg1),
            submission_blob_ids : 0x1::vector::empty<0x1::string::String>(),
            is_private          : arg2,
            seal_policy_id      : arg3,
            relay_signer        : arg4,
            created_at_ms       : 0x2::clock::timestamp_ms(arg5),
            submission_count    : 0,
        };
        let v2 = 0x2::object::id<Form>(&v1);
        let v3 = OwnerCap{
            id      : 0x2::object::new(arg6),
            form_id : v2,
        };
        let v4 = FormCreated{
            form_id    : v2,
            owner      : v0,
            is_private : arg2,
        };
        0x2::event::emit<FormCreated>(v4);
        0x2::transfer::transfer<OwnerCap>(v3, v0);
        0x2::transfer::share_object<Form>(v1);
    }

    public fun rotate_relay_signer(arg0: &OwnerCap, arg1: &mut Form, arg2: address) {
        assert!(arg0.form_id == 0x2::object::id<Form>(arg1), 1);
        arg1.relay_signer = arg2;
    }

    public fun set_privacy(arg0: &OwnerCap, arg1: &mut Form, arg2: bool, arg3: vector<u8>) {
        assert!(arg0.form_id == 0x2::object::id<Form>(arg1), 1);
        arg1.is_private = arg2;
        arg1.seal_policy_id = arg3;
    }

    // decompiled from Move bytecode v7
}

