module 0x56d0c64c632b581c6efc3fa7b6f058f3d1cdbd1d83fb7399a9da2cac48267e3f::walform {
    struct Form has store, key {
        id: 0x2::object::UID,
        form_id: 0x1::string::String,
        blob_id: 0x1::string::String,
        owner: address,
        created_at: u64,
        submission_count: u64,
    }

    struct Submission has store, key {
        id: 0x2::object::UID,
        form_id: 0x1::string::String,
        walrus_blob_id: 0x1::string::String,
        created_at: u64,
        status: 0x1::string::String,
        submitter: address,
    }

    public entry fun create_form(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Form{
            id               : 0x2::object::new(arg3),
            form_id          : arg0,
            blob_id          : arg1,
            owner            : 0x2::tx_context::sender(arg3),
            created_at       : arg2,
            submission_count : 0,
        };
        0x2::transfer::public_transfer<Form>(v0, 0x2::tx_context::sender(arg3));
    }

    public entry fun register_submission(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Submission{
            id             : 0x2::object::new(arg5),
            form_id        : arg0,
            walrus_blob_id : arg1,
            created_at     : arg2,
            status         : arg3,
            submitter      : 0x2::tx_context::sender(arg5),
        };
        0x2::transfer::public_transfer<Submission>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

