module 0xb05d6bf8ec75af7b7b4d51c6401d268a52f9544a24c48b140189a7b4e875db24::form {
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
        admin_wallets: vector<address>,
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

    struct AdminAdded has copy, drop {
        form_id: 0x2::object::ID,
        admin: address,
    }

    struct AdminRemoved has copy, drop {
        form_id: 0x2::object::ID,
        admin: address,
    }

    public fun add_admin(arg0: &mut Form, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner || v0 == arg0.relay_signer, 4);
        if (!0x1::vector::contains<address>(&arg0.admin_wallets, &arg1)) {
            0x1::vector::push_back<address>(&mut arg0.admin_wallets, arg1);
            let v1 = AdminAdded{
                form_id : 0x2::object::id<Form>(arg0),
                admin   : arg1,
            };
            0x2::event::emit<AdminAdded>(v1);
        };
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

    public fun create_form(arg0: vector<u8>, arg1: vector<u8>, arg2: bool, arg3: vector<u8>, arg4: address, arg5: address, arg6: vector<address>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = Form{
            id                  : 0x2::object::new(arg8),
            owner               : arg4,
            title               : 0x1::string::utf8(arg0),
            schema_blob_id      : 0x1::string::utf8(arg1),
            submission_blob_ids : 0x1::vector::empty<0x1::string::String>(),
            is_private          : arg2,
            seal_policy_id      : arg3,
            relay_signer        : arg5,
            admin_wallets       : arg6,
            created_at_ms       : 0x2::clock::timestamp_ms(arg7),
            submission_count    : 0,
        };
        let v1 = 0x2::object::id<Form>(&v0);
        if (arg2) {
            v0.seal_policy_id = 0x2::object::id_bytes<Form>(&v0);
        };
        let v2 = OwnerCap{
            id      : 0x2::object::new(arg8),
            form_id : v1,
        };
        let v3 = FormCreated{
            form_id    : v1,
            owner      : arg4,
            is_private : arg2,
        };
        0x2::event::emit<FormCreated>(v3);
        0x2::transfer::transfer<OwnerCap>(v2, arg4);
        0x2::transfer::share_object<Form>(v0);
    }

    public fun remove_admin(arg0: &mut Form, arg1: address, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.owner || v0 == arg0.relay_signer, 4);
        let (v1, v2) = 0x1::vector::index_of<address>(&arg0.admin_wallets, &arg1);
        if (v1) {
            0x1::vector::remove<address>(&mut arg0.admin_wallets, v2);
            let v3 = AdminRemoved{
                form_id : 0x2::object::id<Form>(arg0),
                admin   : arg1,
            };
            0x2::event::emit<AdminRemoved>(v3);
        };
    }

    public fun rotate_relay_signer(arg0: &OwnerCap, arg1: &mut Form, arg2: address) {
        assert!(arg0.form_id == 0x2::object::id<Form>(arg1), 1);
        arg1.relay_signer = arg2;
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Form, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg1.owner || 0x1::vector::contains<address>(&arg1.admin_wallets, &v0), 4);
        assert!(arg0 == 0x2::object::id_bytes<Form>(arg1), 3);
    }

    public fun set_privacy(arg0: &OwnerCap, arg1: &mut Form, arg2: bool, arg3: vector<u8>) {
        assert!(arg0.form_id == 0x2::object::id<Form>(arg1), 1);
        arg1.is_private = arg2;
        arg1.seal_policy_id = arg3;
    }

    // decompiled from Move bytecode v7
}

