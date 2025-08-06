module 0x1751db26a0fd0091bdb1454591fbdd1e9d67e002e1ee7164f6973967b8258f67::check {
    public entry fun ensure_borrow_amount(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg0, arg1, arg2, arg4) >= arg3, 101);
    }

    // decompiled from Move bytecode v6
}

