module 0x79e36857c4a392aa8396025274eaa77867c8c1aeed2b30b0d8b2d50f01bd3863::lock_order {
    entry fun lock_order(arg0: &mut 0x79e36857c4a392aa8396025274eaa77867c8c1aeed2b30b0d8b2d50f01bd3863::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0x79e36857c4a392aa8396025274eaa77867c8c1aeed2b30b0d8b2d50f01bd3863::fulfill_message::unpack(0x79e36857c4a392aa8396025274eaa77867c8c1aeed2b30b0d8b2d50f01bd3863::fulfill_message::deserialize(0x79e36857c4a392aa8396025274eaa77867c8c1aeed2b30b0d8b2d50f01bd3863::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0x79e36857c4a392aa8396025274eaa77867c8c1aeed2b30b0d8b2d50f01bd3863::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

