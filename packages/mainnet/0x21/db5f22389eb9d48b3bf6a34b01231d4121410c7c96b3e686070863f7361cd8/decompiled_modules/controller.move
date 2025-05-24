module 0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::controller {
    public entry fun modify_controller(arg0: &mut 0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::implements::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::implements::is_emergency(arg0), 202);
        assert!(0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::implements::is_emergency(arg0), 203);
        assert!(0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x21db5f22389eb9d48b3bf6a34b01231d4121410c7c96b3e686070863f7361cd8::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

