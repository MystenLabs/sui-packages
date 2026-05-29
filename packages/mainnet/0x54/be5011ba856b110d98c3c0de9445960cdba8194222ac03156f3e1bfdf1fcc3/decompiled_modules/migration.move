module 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::migration {
    public entry fun migrate_cap_to_admin(arg0: 0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::Cap<0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::seal_policy::MAILGATE>, arg1: &mut 0x2::tx_context::TxContext) {
        0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::enclave::burn_cap<0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::seal_policy::MAILGATE>(arg0);
        0x2::transfer::public_transfer<0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::AdminCap<0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::seal_policy::MAILGATE>>(0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::caps::mint_admin<0x50ab30e6fb02425e856e2d0c7919875f285d1e12a1d747f29a130ddd22af8e83::seal_policy::MAILGATE>(arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

