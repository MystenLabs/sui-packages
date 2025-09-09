module 0x9e51154d4d28e579538b62a7303e8e46645ec1f925b3c5b07019c2d946b644d0::kevin {
    struct KevinCap has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KevinCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<KevinCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public fun kevin_s<T0, T1>(arg0: &KevinCap, arg1: &0x2::clock::Clock, arg2: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg4: 0x2::balance::Balance<T0>, arg5: 0x2::balance::Balance<T1>, arg6: bool, arg7: bool, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0;
        if (arg10 == 123) {
            v0 = 4295048016;
        } else if (arg10 == 321) {
            v0 = 79226673515401279992447579055;
        };
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, v0)
    }

    // decompiled from Move bytecode v6
}

