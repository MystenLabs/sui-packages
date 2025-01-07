module 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::controller {
    public entry fun modify_controller(arg0: &mut 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::Global, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::controller(arg0) == 0x2::tx_context::sender(arg2), 201);
        0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::modify_controller(arg0, arg1);
    }

    public entry fun pause(arg0: &mut 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::is_emergency(arg0), 202);
        assert!(0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::is_emergency(arg0), 203);
        assert!(0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xacf4c9044f910a421e0e3e8885e3052f0586930db366a81808974455ccf88d32::swap::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

