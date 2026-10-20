module 0x2eca55120e3a724f7a13fba0cba72ad9aa00157c8d666c880c43ced0368413b2::r {
    public fun ab<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        abm<T0, T1>(arg0, arg1, arg2, 4295048016, arg3, arg4)
    }

    public fun abm<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg5);
        let (v0, v1, v2) = 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::balance::value<T0>(&arg2), arg3, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        settle<T0>(repay_a<T0, T1>(arg0, arg1, arg2, v2, arg5), arg5);
        v1
    }

    public fun ba<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        bam<T0, T1>(arg0, arg1, arg2, 79226673515401279992447579055, arg3, arg4)
    }

    public fun bam<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg5);
        let (v0, v1, v2) = 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::flash_swap<T0, T1>(arg0, arg1, false, true, 0x2::balance::value<T1>(&arg2), arg3, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        settle<T1>(repay_b<T0, T1>(arg0, arg1, arg2, v2, arg5), arg5);
        v0
    }

    public fun cab<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, T1>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        own(arg5);
        to_sender<T0>(repay_a<T0, T1>(arg0, arg1, arg2, arg3, arg5), arg4, arg5);
    }

    public fun cba<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, T1>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        own(arg5);
        to_sender<T1>(repay_b<T0, T1>(arg0, arg1, arg2, arg3, arg5), arg4, arg5);
    }

    public fun csx<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        cab<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun cxs<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>, arg4: u64, arg5: &0x2::tx_context::TxContext) {
        cba<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun gsb<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<0x2::sui::SUI, T0>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<0x2::sui::SUI, T0>, arg4: u64, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::tx_context::TxContext) {
        own(arg6);
        to_gas(repay_a<0x2::sui::SUI, T0>(arg0, arg1, arg2, arg3, arg6), arg4, arg5);
    }

    public fun gxs<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>, arg4: u64, arg5: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::tx_context::TxContext) {
        own(arg6);
        to_gas(repay_b<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg6), arg4, arg5);
    }

    public fun oab<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, T1>) {
        oabm<T0, T1>(arg0, arg1, arg2, 4295048016, arg3, arg4)
    }

    public fun oabm<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, T1>) {
        own(arg5);
        let (v0, v1, v2) = 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::flash_swap<T0, T1>(arg0, arg1, true, true, arg2, arg3, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        (v1, v2)
    }

    public fun oba<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, T1>) {
        obam<T0, T1>(arg0, arg1, arg2, 79226673515401279992447579055, arg3, arg4)
    }

    public fun obam<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, T1>) {
        own(arg5);
        let (v0, v1, v2) = 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::flash_swap<T0, T1>(arg0, arg1, false, true, arg2, arg3, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        (v0, v2)
    }

    public fun osx<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>) {
        oabm<T0, 0x2::sui::SUI>(arg0, arg1, arg2, 4295048016, arg3, arg4)
    }

    public fun osxm<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>) {
        oabm<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun own(arg0: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x57f118d56fe158c8bd5966fd87eb106545fd5628528af42f6a05eebdf9aa3380, 0);
    }

    public fun oxs<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>) {
        obam<T0, 0x2::sui::SUI>(arg0, arg1, arg2, 79226673515401279992447579055, arg3, arg4)
    }

    public fun oxsm<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>) {
        obam<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun pab<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, T1>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        own(arg4);
        repay_a<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun pba<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, T1>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        own(arg4);
        repay_b<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun psx<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        pab<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4)
    }

    public fun pxs<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        pba<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4)
    }

    fun repay_a<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, T1>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg2, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::swap_pay_amount<T0, T1>(&arg3)), 0x2::balance::zero<T1>(), arg3);
        arg2
    }

    fun repay_b<T0, T1>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::FlashSwapReceipt<T0, T1>, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::swap_pay_amount<T0, T1>(&arg3)), arg3);
        arg2
    }

    fun settle<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
        } else {
            0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg1));
        };
    }

    public fun sx<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        bam<T0, 0x2::sui::SUI>(arg0, arg1, arg2, 79226673515401279992447579055, arg3, arg4)
    }

    public fun sxm<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<0x2::sui::SUI>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        bam<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    fun to_gas(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0) >= arg1, 1);
        0x2::balance::join<0x2::sui::SUI>(0x2::coin::balance_mut<0x2::sui::SUI>(arg2), arg0);
    }

    fun to_sender<T0>(arg0: 0x2::balance::Balance<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        assert!(0x2::balance::value<T0>(&arg0) >= arg1, 1);
        0x2::balance::send_funds<T0>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun xs<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        abm<T0, 0x2::sui::SUI>(arg0, arg1, arg2, 4295048016, arg3, arg4)
    }

    public fun xsm<T0>(arg0: &0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::config::GlobalConfig, arg1: &mut 0x8e1144ad9fbc388c61ac30d74ebef4eb741d213e3a086da48124256290233723::pool::Pool<T0, 0x2::sui::SUI>, arg2: 0x2::balance::Balance<T0>, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : 0x2::balance::Balance<0x2::sui::SUI> {
        abm<T0, 0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

