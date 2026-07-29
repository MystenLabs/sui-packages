module 0x21321599d80e64a78bb0348d7f510b5d0dc3c9d437e553196e82f6356ef084c1::guard {
    public fun assert_debt_at_least(arg0: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::clock::Clock) {
        assert!(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::get_borrow_amount(arg0, arg1, arg2, arg4) >= arg3, 901);
    }

    // decompiled from Move bytecode v7
}

