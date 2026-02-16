module 0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::lock_order {
    entry fun lock_order(arg0: &mut 0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::fulfill_message::unpack(0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::fulfill_message::deserialize(0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0x18b927f562211421f488c190e3bd053e3d13d0091668954ab303b82deebb1e7f::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

