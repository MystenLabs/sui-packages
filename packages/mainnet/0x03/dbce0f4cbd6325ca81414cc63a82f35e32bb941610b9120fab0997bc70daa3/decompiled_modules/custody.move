module 0x3dbce0f4cbd6325ca81414cc63a82f35e32bb941610b9120fab0997bc70daa3::custody {
    public(friend) fun value<T0>(arg0: &0x2::balance::Balance<T0>) : u64 {
        0x2::balance::value<T0>(arg0)
    }

    public(friend) fun deposit<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::balance::Balance<T0>) {
        0x2::balance::join<T0>(arg0, arg1);
    }

    public(friend) fun withdraw<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::balance::split<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

