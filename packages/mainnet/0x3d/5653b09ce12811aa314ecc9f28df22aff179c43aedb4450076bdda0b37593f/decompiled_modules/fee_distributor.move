module 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::fee_distributor {
    public(friend) fun distribute<T0>(arg0: &mut 0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::incentives::Reserve, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        0x3d5653b09ce12811aa314ecc9f28df22aff179c43aedb4450076bdda0b37593f::incentives::deposit<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

