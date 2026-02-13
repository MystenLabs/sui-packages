module 0x840b5bf797b41baf3dc7bb61e6cfc073b01c53dbf197cca2da46924c8c1c1046::lock_order {
    entry fun lock_order(arg0: &mut 0x840b5bf797b41baf3dc7bb61e6cfc073b01c53dbf197cca2da46924c8c1c1046::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0x840b5bf797b41baf3dc7bb61e6cfc073b01c53dbf197cca2da46924c8c1c1046::fulfill_message::unpack(0x840b5bf797b41baf3dc7bb61e6cfc073b01c53dbf197cca2da46924c8c1c1046::fulfill_message::deserialize(0x840b5bf797b41baf3dc7bb61e6cfc073b01c53dbf197cca2da46924c8c1c1046::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0x840b5bf797b41baf3dc7bb61e6cfc073b01c53dbf197cca2da46924c8c1c1046::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

