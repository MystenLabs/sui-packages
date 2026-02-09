module 0xdaf29e48813bcd3d00eb372f1fcdcb208e6908bbb58cbbfdc3caa96d0ec78848::u128 {
    public fun safe_from_u256(arg0: u256) : u128 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 1);
        (arg0 as u128)
    }

    // decompiled from Move bytecode v6
}

