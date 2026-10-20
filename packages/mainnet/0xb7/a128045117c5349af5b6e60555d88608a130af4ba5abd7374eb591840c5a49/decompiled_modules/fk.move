module 0xb7a128045117c5349af5b6e60555d88608a130af4ba5abd7374eb591840c5a49::fk {
    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun sx<T0>(arg0: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg1: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg4);
        let v0 = 0x2::coin::from_balance<0x2::sui::SUI>(arg2, arg4);
        let (v1, v2) = 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::buy_<T0>(arg0, &mut v0, true, 0, arg3, arg1, arg4);
        0x2::coin::destroy_zero<0x2::sui::SUI>(v0);
        0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::locked_coin::destroy_zero<T0>(v2);
        0x2::coin::into_balance<T0>(v1)
    }

    public fun xs<T0>(arg0: &mut 0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::Configuration, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg2);
        let v0 = 0x2::coin::from_balance<T0>(arg1, arg2);
        0x2::coin::destroy_zero<T0>(v0);
        0x2::coin::into_balance<0x2::sui::SUI>(0xc42fd2cde04281a5d2659e5c96c89ba625ddeef9b622713c3d6aa1efd5ea21ab::fun_7k::sell_<T0>(arg0, &mut v0, true, 0, arg2))
    }

    // decompiled from Move bytecode v7
}

