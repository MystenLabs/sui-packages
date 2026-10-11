module 0x35ec320d8bfac6aa9d3ad76d46e33b5b1024141af5c0a415cb2b6dbe99293cf8::guards {
    public fun assert_bluefin_sqrt<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: u128, arg2: bool) {
        if (arg2) {
            assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0) > arg1, 0x35ec320d8bfac6aa9d3ad76d46e33b5b1024141af5c0a415cb2b6dbe99293cf8::errors::guard_bluefin());
        } else {
            assert!(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0) < arg1, 0x35ec320d8bfac6aa9d3ad76d46e33b5b1024141af5c0a415cb2b6dbe99293cf8::errors::guard_bluefin());
        };
    }

    // decompiled from Move bytecode v7
}

