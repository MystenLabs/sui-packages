module 0x717456fc7540e02f1893fd671ea6eb272249519058f7866ad604f299ef1a73d6::m59c5eddc1580d075704510fd {
    public fun f6020693f625201f2e259014a<T0, T1>(arg0: &0x2::clock::Clock, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9)
    }

    // decompiled from Move bytecode v7
}

