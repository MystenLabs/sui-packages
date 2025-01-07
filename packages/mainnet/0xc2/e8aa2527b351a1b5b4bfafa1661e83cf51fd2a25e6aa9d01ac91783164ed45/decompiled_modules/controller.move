module 0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::controller {
    public entry fun pause(arg0: &mut 0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::is_emergency(arg0), 202);
        assert!(0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::is_emergency(arg0), 203);
        assert!(0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xc2e8aa2527b351a1b5b4bfafa1661e83cf51fd2a25e6aa9d01ac91783164ed45::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

