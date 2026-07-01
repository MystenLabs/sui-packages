module 0x2e3a4faab75a072a91682b221cac5f2e2693c72caf243ecc2fbb0b265e8d7614::forms {
    struct Form has key {
        id: 0x2::object::UID,
        creator: address,
        title: 0x1::string::String,
        schema_blob_id: 0x1::string::String,
        admins: vector<address>,
        submission_count: u64,
    }

    struct SubmissionRef has key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
        submitter: address,
        blob_id: 0x1::string::String,
        is_encrypted: bool,
    }

    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
    }

    public fun add_admin(arg0: &mut Form, arg1: address, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.creator, 0);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
    }

    public fun create_form(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<address>();
        0x1::vector::push_back<address>(&mut v0, 0x2::tx_context::sender(arg2));
        let v1 = Form{
            id               : 0x2::object::new(arg2),
            creator          : 0x2::tx_context::sender(arg2),
            title            : arg0,
            schema_blob_id   : arg1,
            admins           : v0,
            submission_count : 0,
        };
        let v2 = FormCreated{form_id: 0x2::object::id<Form>(&v1)};
        0x2::event::emit<FormCreated>(v2);
        0x2::transfer::share_object<Form>(v1);
    }

    entry fun seal_approve(arg0: vector<u8>, arg1: &Form, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(arg1.creator == v0 || 0x1::vector::contains<address>(&arg1.admins, &v0), 0);
    }

    public fun submit_response(arg0: &mut Form, arg1: 0x1::string::String, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        arg0.submission_count = arg0.submission_count + 1;
        let v0 = SubmissionRef{
            id           : 0x2::object::new(arg3),
            form_id      : 0x2::object::id<Form>(arg0),
            submitter    : 0x2::tx_context::sender(arg3),
            blob_id      : arg1,
            is_encrypted : arg2,
        };
        0x2::transfer::share_object<SubmissionRef>(v0);
    }

    // decompiled from Move bytecode v7
}

