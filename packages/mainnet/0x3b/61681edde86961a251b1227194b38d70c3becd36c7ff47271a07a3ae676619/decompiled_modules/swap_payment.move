module 0x3b61681edde86961a251b1227194b38d70c3becd36c7ff47271a07a3ae676619::swap_payment {
    public fun split<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>) {
        assert!(arg1 <= 0x2::balance::value<T0>(&arg0), 905);
        (0x2::balance::split<T0>(&mut arg0, arg1), arg0)
    }

    // decompiled from Move bytecode v7
}

