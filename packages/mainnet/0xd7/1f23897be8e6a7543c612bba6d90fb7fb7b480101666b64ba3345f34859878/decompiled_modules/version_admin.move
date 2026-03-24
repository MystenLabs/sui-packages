module 0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::version_admin {
    public fun migrate(arg0: &0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::app::AdminCap, arg1: &mut 0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::app::ProtocolApp) : u64 {
        0xd71f23897be8e6a7543c612bba6d90fb7fb7b480101666b64ba3345f34859878::app::migrate(arg1)
    }

    // decompiled from Move bytecode v6
}

