module 0x16495316af1a11f6b93a06193f9bca08d26a203421c0167b7ccaad17fd342de1::test {
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
        0x16495316af1a11f6b93a06193f9bca08d26a203421c0167b7ccaad17fd342de1::signature::verify_signature<Request>(arg0, arg1, &v2);
    }

    // decompiled from Move bytecode v6
}

