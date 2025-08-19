module 0x54fee6938b3da3a35cadf26f88788b9d8bebe01ef2caeadb0089eb66672e69a3::mmt {
    public fun calculate<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        let v0 = if (arg1) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg1, true, v0, arg2);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v1)
    }

    // decompiled from Move bytecode v6
}

