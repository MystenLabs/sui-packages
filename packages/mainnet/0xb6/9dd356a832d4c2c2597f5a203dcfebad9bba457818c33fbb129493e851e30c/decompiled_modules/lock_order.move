module 0xb69dd356a832d4c2c2597f5a203dcfebad9bba457818c33fbb129493e851e30c::lock_order {
    entry fun lock_order(arg0: &mut 0xb69dd356a832d4c2c2597f5a203dcfebad9bba457818c33fbb129493e851e30c::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0xb69dd356a832d4c2c2597f5a203dcfebad9bba457818c33fbb129493e851e30c::fulfill_message::unpack(0xb69dd356a832d4c2c2597f5a203dcfebad9bba457818c33fbb129493e851e30c::fulfill_message::deserialize(0xb69dd356a832d4c2c2597f5a203dcfebad9bba457818c33fbb129493e851e30c::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0xb69dd356a832d4c2c2597f5a203dcfebad9bba457818c33fbb129493e851e30c::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

