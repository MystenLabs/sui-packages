module 0xa4296450a1facf8cfe9868702927820212eba3500cd386f00cc8a36cb98177f3::lock_order {
    entry fun lock_order(arg0: &mut 0xa4296450a1facf8cfe9868702927820212eba3500cd386f00cc8a36cb98177f3::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0xa4296450a1facf8cfe9868702927820212eba3500cd386f00cc8a36cb98177f3::fulfill_message::unpack(0xa4296450a1facf8cfe9868702927820212eba3500cd386f00cc8a36cb98177f3::fulfill_message::deserialize(0xa4296450a1facf8cfe9868702927820212eba3500cd386f00cc8a36cb98177f3::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0xa4296450a1facf8cfe9868702927820212eba3500cd386f00cc8a36cb98177f3::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

