module 0x262b236973e9080f0b8d0a329e7ebbf97b4b4a102e6ed5dece28e9d64cb99dc4::ilyeman {
    struct FrontRunEvent has copy, drop {
        label: 0x1::string::String,
    }

    public fun frontrun_label(arg0: 0x1::string::String) {
        let v0 = FrontRunEvent{label: arg0};
        0x2::event::emit<FrontRunEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

