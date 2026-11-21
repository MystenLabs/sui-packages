module 0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::fee_distributor {
    public(friend) fun distribute<T0>(arg0: &mut 0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::incentives::Reserve, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        0x8a2f10f89aa108238f35bdb9e1ffde6178d68c49dd2acc4bfaf6736cadaffe1a::incentives::deposit<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

