module 0x82db9671b88c5c66bf85b7ac13a4c9cbbbe4ed5b5b6cfb6865aa0e65d6b166c8::lock_order {
    entry fun lock_order(arg0: &mut 0x82db9671b88c5c66bf85b7ac13a4c9cbbbe4ed5b5b6cfb6865aa0e65d6b166c8::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0x82db9671b88c5c66bf85b7ac13a4c9cbbbe4ed5b5b6cfb6865aa0e65d6b166c8::fulfill_message::unpack(0x82db9671b88c5c66bf85b7ac13a4c9cbbbe4ed5b5b6cfb6865aa0e65d6b166c8::fulfill_message::deserialize(0x82db9671b88c5c66bf85b7ac13a4c9cbbbe4ed5b5b6cfb6865aa0e65d6b166c8::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0x82db9671b88c5c66bf85b7ac13a4c9cbbbe4ed5b5b6cfb6865aa0e65d6b166c8::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

