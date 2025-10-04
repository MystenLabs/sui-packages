module 0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::aB {
    public fun dC<T0, T1>(arg0: &mut 0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::cB::AC, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            dD<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        } else {
            eF<T0, T1>(arg0, arg1, arg2, arg4, arg5);
        };
    }

    fun dD<T0, T1>(arg0: &mut 0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::cB::AC, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::cB::gO<T0>(arg0);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg1, arg2, v0, 0x2::balance::zero<T1>(), true, true, v1, 0, 4295048017);
        0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::cB::gH<T0>(v2, arg4);
        0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::cB::eA<T1>(arg0, v3);
    }

    fun eF<T0, T1>(arg0: &mut 0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::cB::AC, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::cB::gO<T1>(arg0);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, T1>(arg3, arg1, arg2, 0x2::balance::zero<T0>(), v0, false, true, v1, 0, 79226673515401279992447579054);
        0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::cB::gH<T1>(v3, arg4);
        0xa022fe0b6638c3083b30b043f7abddb3fd3a5245a4ec1b2899f84d245b288e67::cB::eA<T0>(arg0, v2);
    }

    // decompiled from Move bytecode v6
}

