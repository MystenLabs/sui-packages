module 0xc6bcd916531e4b10f10ea3b72aa4d5f9a62f1777333f4f0b5b0cfc05b0eb1b8e::fee_distributor {
    public(friend) fun distribute<T0>(arg0: &mut 0xc6bcd916531e4b10f10ea3b72aa4d5f9a62f1777333f4f0b5b0cfc05b0eb1b8e::incentives::Reserve, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        0xc6bcd916531e4b10f10ea3b72aa4d5f9a62f1777333f4f0b5b0cfc05b0eb1b8e::incentives::deposit<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

