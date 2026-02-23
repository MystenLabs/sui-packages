module 0xc3a1a2527790b5e1bcf7eb1fc12b1c10b85abbd31df6afbef60d10e85e1df8eb::lock_order {
    entry fun lock_order(arg0: &mut 0xc3a1a2527790b5e1bcf7eb1fc12b1c10b85abbd31df6afbef60d10e85e1df8eb::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0xc3a1a2527790b5e1bcf7eb1fc12b1c10b85abbd31df6afbef60d10e85e1df8eb::fulfill_message::unpack(0xc3a1a2527790b5e1bcf7eb1fc12b1c10b85abbd31df6afbef60d10e85e1df8eb::fulfill_message::deserialize(0xc3a1a2527790b5e1bcf7eb1fc12b1c10b85abbd31df6afbef60d10e85e1df8eb::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0xc3a1a2527790b5e1bcf7eb1fc12b1c10b85abbd31df6afbef60d10e85e1df8eb::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

