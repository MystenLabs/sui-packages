module 0x1362fa28ba2e539474edbac54ad6f7571e4a17f5796cec4017609b2ff01afa60::lock_order {
    entry fun lock_order(arg0: &mut 0x1362fa28ba2e539474edbac54ad6f7571e4a17f5796cec4017609b2ff01afa60::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0x1362fa28ba2e539474edbac54ad6f7571e4a17f5796cec4017609b2ff01afa60::fulfill_message::unpack(0x1362fa28ba2e539474edbac54ad6f7571e4a17f5796cec4017609b2ff01afa60::fulfill_message::deserialize(0x1362fa28ba2e539474edbac54ad6f7571e4a17f5796cec4017609b2ff01afa60::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0x1362fa28ba2e539474edbac54ad6f7571e4a17f5796cec4017609b2ff01afa60::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

