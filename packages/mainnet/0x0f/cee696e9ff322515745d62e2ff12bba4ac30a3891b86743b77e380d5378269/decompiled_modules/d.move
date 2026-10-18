module 0xfcee696e9ff322515745d62e2ff12bba4ac30a3891b86743b77e380d5378269::d {
    public fun ab<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg4);
        let (v0, v1, v2) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048016, arg3, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        settle<T0>(repay_a<T0, T1>(arg0, arg1, arg2, v2), arg4);
        v1
    }

    public fun ba<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg4);
        let (v0, v1, v2) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), 79226673515401279992447579055, arg3, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        settle<T1>(repay_b<T0, T1>(arg0, arg1, arg2, v2), arg4);
        v0
    }

    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    fun repay_a<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T0> {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::swap_pay_amount<T0, T1>(&arg3)), 0x2::balance::zero<T1>(), arg3);
        arg2
    }

    fun repay_b<T0, T1>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::FlashSwapReceipt<T0, T1>) : 0x2::balance::Balance<T1> {
        0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::swap_pay_amount<T0, T1>(&arg3)), arg3);
        arg2
    }

    fun settle<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun sx<T0>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg4);
        let (v0, v1, v2) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, true, 0x2::balance::value<0x2::sui::SUI>(&arg2), 79226673515401279992447579055, arg3, arg4);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        settle<0x2::sui::SUI>(repay_b<T0, 0x2::sui::SUI>(arg0, arg1, arg2, v2), arg4);
        v0
    }

    public fun xs<T0>(arg0: &0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::config::GlobalConfig, arg1: &mut 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        own(arg4);
        let (v0, v1, v2) = 0x6615ce71ab4f4a9119cc612c04a9daf77206e23201ec5efedd6bf873b2a16fd2::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048016, arg3, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        settle<T0>(repay_a<T0, 0x2::sui::SUI>(arg0, arg1, arg2, v2), arg4);
        v1
    }

    // decompiled from Move bytecode v7
}

