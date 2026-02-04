module 0x6ab4e51c445d96bb32288f3e43116485b45b8a789f25a5ff410d558ea7091ce9::router {
    public fun first_aid_packet<T0>(arg0: &0x6ab4e51c445d96bb32288f3e43116485b45b8a789f25a5ff410d558ea7091ce9::dolphin_cap::DolphinCap, arg1: &mut 0x6ab4e51c445d96bb32288f3e43116485b45b8a789f25a5ff410d558ea7091ce9::vault::Vault, arg2: &mut 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(arg2) > 1000000000) {
            return
        };
        0x2::balance::join<T0>(0x2::coin::balance_mut<T0>(arg2), 0x6ab4e51c445d96bb32288f3e43116485b45b8a789f25a5ff410d558ea7091ce9::vault::withdraw<T0>(arg0, arg1, 999999999));
    }

    public fun withdraw<T0>(arg0: &0x6ab4e51c445d96bb32288f3e43116485b45b8a789f25a5ff410d558ea7091ce9::dolphin_cap::DolphinCap, arg1: &mut 0x6ab4e51c445d96bb32288f3e43116485b45b8a789f25a5ff410d558ea7091ce9::vault::Vault, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::from_balance<T0>(0x6ab4e51c445d96bb32288f3e43116485b45b8a789f25a5ff410d558ea7091ce9::vault::withdraw<T0>(arg0, arg1, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

