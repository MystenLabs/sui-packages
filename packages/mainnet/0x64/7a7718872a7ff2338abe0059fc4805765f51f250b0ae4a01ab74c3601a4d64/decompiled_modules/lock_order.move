module 0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::lock_order {
    entry fun lock_order(arg0: &mut 0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::fulfill_message::unpack(0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::fulfill_message::deserialize(0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0x647a7718872a7ff2338abe0059fc4805765f51f250b0ae4a01ab74c3601a4d64::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

