module 0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::test {
    struct Request has drop {
        sender: vector<u8>,
        collection_id: 0x1::string::String,
        recipient: vector<u8>,
    }

    entry fun test(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = 0x2::tx_context::sender(arg3);
        let v2 = Request{
            sender        : 0x2::bcs::to_bytes<address>(&v0),
            collection_id : arg2,
            recipient     : 0x2::bcs::to_bytes<address>(&v1),
        };
        0x27e5600fdaafb38c7717c06b8129298d602e1a490ac18d6ce94db09cb1432036::signature::verify_signature<Request>(arg0, arg1, &v2);
    }

    // decompiled from Move bytecode v6
}

