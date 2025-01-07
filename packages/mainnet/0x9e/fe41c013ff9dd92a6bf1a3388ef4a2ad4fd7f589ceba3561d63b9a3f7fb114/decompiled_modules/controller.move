module 0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::controller {
    public entry fun modify_controller(arg0: &mut 0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::is_emergency(arg0), 202);
        assert!(0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::is_emergency(arg0), 203);
        assert!(0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x9efe41c013ff9dd92a6bf1a3388ef4a2ad4fd7f589ceba3561d63b9a3f7fb114::swap::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

