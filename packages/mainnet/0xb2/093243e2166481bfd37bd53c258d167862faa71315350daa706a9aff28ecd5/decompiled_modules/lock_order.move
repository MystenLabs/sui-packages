module 0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::lock_order {
    entry fun lock_order(arg0: &mut 0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::fulfill_message::unpack(0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::fulfill_message::deserialize(0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0xb2093243e2166481bfd37bd53c258d167862faa71315350daa706a9aff28ecd5::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

