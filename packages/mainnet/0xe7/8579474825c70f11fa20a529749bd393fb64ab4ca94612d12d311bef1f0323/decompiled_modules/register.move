module 0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::register {
    public entry fun internal_register(arg0: &0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::registry::RegistryCap, arg1: &mut 0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::registry::Registry, arg2: 0x1::ascii::String, arg3: address, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::registry::registry_cap(arg1) == 0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::registry::cap_id(arg0), 1);
        0x2::transfer::public_transfer<0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::domain::Domain>(0x3e75d430e1493c40ad6998170f4ec5dd05e30c46db7a8050776990a239495c50::registry::create_domain(arg1, arg2, arg4, arg5), arg3);
    }

    // decompiled from Move bytecode v6
}

