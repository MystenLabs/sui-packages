module 0x409338efedc619eac97f06d0407138ae7b5e105b08ea6432c347edb781b3943e::fee_distributor {
    public(friend) fun distribute<T0>(arg0: &mut 0x409338efedc619eac97f06d0407138ae7b5e105b08ea6432c347edb781b3943e::incentives::Reserve, arg1: 0x2::object::ID, arg2: 0x2::balance::Balance<T0>) {
        0x409338efedc619eac97f06d0407138ae7b5e105b08ea6432c347edb781b3943e::incentives::deposit<T0>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v7
}

