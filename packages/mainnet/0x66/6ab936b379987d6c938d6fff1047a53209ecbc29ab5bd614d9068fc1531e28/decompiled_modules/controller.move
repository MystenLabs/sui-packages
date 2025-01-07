module 0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::controller {
    public entry fun modify_admin(arg0: &mut 0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::modify_admin(arg0, arg1);
    }

    public entry fun modify_burn(arg0: &mut 0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::modify_burn(arg0, arg1);
    }

    public entry fun modify_config(arg0: &mut 0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::Global, arg1: address, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::admin(arg0) == 0x2::tx_context::sender(arg3), 201);
        0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::modify_config(arg0, arg1, arg2);
    }

    public entry fun modify_controller(arg0: &mut 0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::admin(arg0) == 0x2::tx_context::sender(arg2), 201);
        0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::is_emergency(arg0), 202);
        assert!(0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::is_emergency(arg0), 203);
        assert!(0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x666ab936b379987d6c938d6fff1047a53209ecbc29ab5bd614d9068fc1531e28::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

