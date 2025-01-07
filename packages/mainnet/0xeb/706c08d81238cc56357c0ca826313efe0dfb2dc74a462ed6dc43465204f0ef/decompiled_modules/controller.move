module 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::controller {
    public entry fun pause(arg0: &mut 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::is_emergency(arg0), 202);
        assert!(0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::is_emergency(arg0), 203);
        assert!(0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xeb706c08d81238cc56357c0ca826313efe0dfb2dc74a462ed6dc43465204f0ef::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

