module 0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::lock_order {
    entry fun lock_order(arg0: &mut 0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::state::State, arg1: vector<u8>, arg2: vector<u8>, arg3: u8) {
        let (v0, _, _, _) = 0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::fulfill_message::unpack(0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::fulfill_message::deserialize(0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::verify_ir::verify_and_extract_payload(arg1, arg2, arg3)));
        0x7a6f82a3d0940342e0dcea39f5e12758853a74870d1698f80622a27b301586eb::state::add_locked_order(arg0, v0);
    }

    // decompiled from Move bytecode v6
}

