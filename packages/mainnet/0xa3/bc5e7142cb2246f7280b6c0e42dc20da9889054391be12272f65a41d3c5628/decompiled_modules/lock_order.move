module 0xa3bc5e7142cb2246f7280b6c0e42dc20da9889054391be12272f65a41d3c5628::lock_order {
    entry fun lock_order(arg0: &mut 0xa3bc5e7142cb2246f7280b6c0e42dc20da9889054391be12272f65a41d3c5628::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0xa3bc5e7142cb2246f7280b6c0e42dc20da9889054391be12272f65a41d3c5628::fulfill_message::unpack(0xa3bc5e7142cb2246f7280b6c0e42dc20da9889054391be12272f65a41d3c5628::fulfill_message::deserialize(0xa3bc5e7142cb2246f7280b6c0e42dc20da9889054391be12272f65a41d3c5628::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0xa3bc5e7142cb2246f7280b6c0e42dc20da9889054391be12272f65a41d3c5628::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

