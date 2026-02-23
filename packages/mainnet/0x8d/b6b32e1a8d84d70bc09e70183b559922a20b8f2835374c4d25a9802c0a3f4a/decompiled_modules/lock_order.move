module 0x8db6b32e1a8d84d70bc09e70183b559922a20b8f2835374c4d25a9802c0a3f4a::lock_order {
    entry fun lock_order(arg0: &mut 0x8db6b32e1a8d84d70bc09e70183b559922a20b8f2835374c4d25a9802c0a3f4a::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0x8db6b32e1a8d84d70bc09e70183b559922a20b8f2835374c4d25a9802c0a3f4a::fulfill_message::unpack(0x8db6b32e1a8d84d70bc09e70183b559922a20b8f2835374c4d25a9802c0a3f4a::fulfill_message::deserialize(0x8db6b32e1a8d84d70bc09e70183b559922a20b8f2835374c4d25a9802c0a3f4a::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0x8db6b32e1a8d84d70bc09e70183b559922a20b8f2835374c4d25a9802c0a3f4a::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

