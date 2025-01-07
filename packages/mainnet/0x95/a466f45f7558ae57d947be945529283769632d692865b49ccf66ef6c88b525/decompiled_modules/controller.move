module 0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::controller {
    public entry fun pause(arg0: &mut 0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::factory::is_emergency(arg0), 202);
        assert!(0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::factory::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::factory::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::factory::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::factory::is_emergency(arg0), 203);
        assert!(0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::factory::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x95a466f45f7558ae57d947be945529283769632d692865b49ccf66ef6c88b525::factory::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

