module 0x344d0737a77258d1fe49ac7d2bb5977568321e4eea4dfabdccd1a82fef2b3379::ilyeman {
    struct FrontRunEvent has copy, drop {
        label: 0x1::string::String,
    }

    public fun frontrun_label(arg0: 0x1::option::Option<0x1::string::String>) {
        if (0x1::option::is_some<0x1::string::String>(&arg0)) {
            let v0 = FrontRunEvent{label: *0x1::option::borrow<0x1::string::String>(&arg0)};
            0x2::event::emit<FrontRunEvent>(v0);
        };
    }

    // decompiled from Move bytecode v6
}

