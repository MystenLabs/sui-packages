module 0xdcd191465c256b584e493dd27d80b472bc8de4a46bb8e11418df4c6063ee5eaa::lock_order {
    entry fun lock_order(arg0: &mut 0xdcd191465c256b584e493dd27d80b472bc8de4a46bb8e11418df4c6063ee5eaa::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0xdcd191465c256b584e493dd27d80b472bc8de4a46bb8e11418df4c6063ee5eaa::fulfill_message::unpack(0xdcd191465c256b584e493dd27d80b472bc8de4a46bb8e11418df4c6063ee5eaa::fulfill_message::deserialize(0xdcd191465c256b584e493dd27d80b472bc8de4a46bb8e11418df4c6063ee5eaa::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0xdcd191465c256b584e493dd27d80b472bc8de4a46bb8e11418df4c6063ee5eaa::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

