module 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::controller {
    public entry fun modify_controller(arg0: &mut 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::is_emergency(arg0), 202);
        assert!(0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::is_emergency(arg0), 203);
        assert!(0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xdd250dfa7be43f91126c8bf3ed6ee4c6d2a1a3a026593975256e3f5613d05d15::swap::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

