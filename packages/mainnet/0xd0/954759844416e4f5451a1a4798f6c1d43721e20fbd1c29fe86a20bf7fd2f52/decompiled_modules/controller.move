module 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::controller {
    public entry fun pause(arg0: &mut 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::is_emergency(arg0), 202);
        assert!(0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::is_emergency(arg0), 203);
        assert!(0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0xd0954759844416e4f5451a1a4798f6c1d43721e20fbd1c29fe86a20bf7fd2f52::factory::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

