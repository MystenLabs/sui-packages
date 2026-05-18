module 0x2cd53cd2943ae126a56dc94542036128c7e8b01d13c6e3ca5db0878effdbf59c::form_registry {
    struct Form has store, key {
        id: 0x2::object::UID,
        owner: address,
        form_blob_id: 0x1::string::String,
        submissions: vector<0x1::string::String>,
    }

    struct FormAdminCap has store, key {
        id: 0x2::object::UID,
        form_id: 0x2::object::ID,
    }

    struct FormCreated has copy, drop {
        form_id: 0x2::object::ID,
        owner: address,
        form_blob_id: 0x1::string::String,
    }

    struct SubmissionAdded has copy, drop {
        form_id: 0x2::object::ID,
        submission_blob_id: 0x1::string::String,
    }

    public entry fun add_submission(arg0: &mut Form, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) {
        0x1::vector::push_back<0x1::string::String>(&mut arg0.submissions, arg1);
        let v0 = SubmissionAdded{
            form_id            : 0x2::object::id<Form>(arg0),
            submission_blob_id : arg1,
        };
        0x2::event::emit<SubmissionAdded>(v0);
    }

    public entry fun create_form(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Form{
            id           : 0x2::object::new(arg1),
            owner        : 0x2::tx_context::sender(arg1),
            form_blob_id : arg0,
            submissions  : 0x1::vector::empty<0x1::string::String>(),
        };
        let v1 = 0x2::object::id<Form>(&v0);
        let v2 = FormAdminCap{
            id      : 0x2::object::new(arg1),
            form_id : v1,
        };
        0x2::transfer::public_transfer<FormAdminCap>(v2, 0x2::tx_context::sender(arg1));
        let v3 = FormCreated{
            form_id      : v1,
            owner        : 0x2::tx_context::sender(arg1),
            form_blob_id : arg0,
        };
        0x2::event::emit<FormCreated>(v3);
        0x2::transfer::share_object<Form>(v0);
    }

    // decompiled from Move bytecode v7
}

