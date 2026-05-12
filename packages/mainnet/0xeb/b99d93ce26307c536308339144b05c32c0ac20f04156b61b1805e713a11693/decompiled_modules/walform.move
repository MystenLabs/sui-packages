module 0xebb99d93ce26307c536308339144b05c32c0ac20f04156b61b1805e713a11693::walform {
    struct Form has store, key {
        id: 0x2::object::UID,
        form_id: 0x1::string::String,
        config_json: 0x1::string::String,
        created_at: u64,
    }

    struct Submission has store, key {
        id: 0x2::object::UID,
        form_id: 0x1::string::String,
        payload_json: 0x1::string::String,
        submitter: address,
        timestamp: u64,
        status: 0x1::string::String,
    }

    public fun create_form(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Form{
            id          : 0x2::object::new(arg3),
            form_id     : arg0,
            config_json : arg1,
            created_at  : arg2,
        };
        0x2::transfer::transfer<Form>(v0, 0x2::tx_context::sender(arg3));
    }

    public fun register_submission(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u64, arg3: 0x1::string::String, arg4: address, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Submission{
            id           : 0x2::object::new(arg5),
            form_id      : arg0,
            payload_json : arg1,
            submitter    : 0x2::tx_context::sender(arg5),
            timestamp    : arg2,
            status       : arg3,
        };
        0x2::transfer::transfer<Submission>(v0, arg4);
    }

    // decompiled from Move bytecode v6
}

