module 0xd6b38879f3d81c437d58efb4b163cb85d71a449139660672ff0011e9c648835f::calculator {
    struct Calculate has copy, drop {
        out: u64,
    }

    public entry fun calc_swap_exact_in<T0, T1, T2>(arg0: &0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::pool::Pool<T0>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = Calculate{out: 0xefe170ec0be4d762196bedecd7a065816576198a6527c99282a2551aaa7da38c::math::calc_swap_exact_in<T0, T1, T2>(arg0, arg1, arg2, arg3)};
        0x2::event::emit<Calculate>(v0);
    }

    // decompiled from Move bytecode v6
}

