module 0xdd948da2ecf515c3403ec64a4a4c9aacf7ac5b27481b731d5eb54d065bf84c7b::fee_distributor {
    public(friend) fun distribute<T0>(arg0: &mut 0xdd948da2ecf515c3403ec64a4a4c9aacf7ac5b27481b731d5eb54d065bf84c7b::incentives::Reserve, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        0xdd948da2ecf515c3403ec64a4a4c9aacf7ac5b27481b731d5eb54d065bf84c7b::incentives::deposit<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

