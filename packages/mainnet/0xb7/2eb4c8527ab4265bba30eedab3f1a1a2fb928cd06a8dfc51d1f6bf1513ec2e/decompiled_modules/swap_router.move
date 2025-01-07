module 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_router {
    public entry fun entry_swap_abc<T0, T1, T2, T3>(arg0: &0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::GlobalConfig, arg1: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T1, T3>, arg2: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T1, T2, T3>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::utils::split_coin_to_balance<T0>(arg3, arg4, arg6);
        let v1 = swap_abc<T0, T1, T2, T3>(arg0, arg1, arg2, v0, arg5, arg6);
        0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::utils::send_balance<T2>(v1, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun entry_swap_acb<T0, T1, T2, T3>(arg0: &0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::GlobalConfig, arg1: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T2, T3>, arg2: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T1, T2, T3>, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::utils::split_coin_to_balance<T0>(arg3, arg4, arg6);
        let v1 = swap_acb<T0, T1, T2, T3>(arg0, arg1, arg2, v0, arg5, arg6);
        0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::utils::send_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun entry_swap_bac<T0, T1, T2, T3>(arg0: &0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::GlobalConfig, arg1: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T1, T3>, arg2: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T2, T3>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::utils::split_coin_to_balance<T1>(arg3, arg4, arg6);
        let v1 = swap_bac<T0, T1, T2, T3>(arg0, arg1, arg2, v0, arg5, arg6);
        0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::utils::send_balance<T2>(v1, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun entry_swap_bca<T0, T1, T2, T3>(arg0: &0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::GlobalConfig, arg1: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T1, T2, T3>, arg2: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T2, T3>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::utils::split_coin_to_balance<T1>(arg3, arg4, arg6);
        let v1 = swap_bca<T0, T1, T2, T3>(arg0, arg1, arg2, v0, arg5, arg6);
        0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::utils::send_balance<T0>(v1, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun entry_swap_cab<T0, T1, T2, T3>(arg0: &0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::GlobalConfig, arg1: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T2, T3>, arg2: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T1, T3>, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::utils::split_coin_to_balance<T2>(arg3, arg4, arg6);
        let v1 = swap_cab<T0, T1, T2, T3>(arg0, arg1, arg2, v0, arg5, arg6);
        0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::utils::send_balance<T1>(v1, 0x2::tx_context::sender(arg6), arg6);
    }

    public entry fun entry_swap_cba<T0, T1, T2, T3>(arg0: &0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::GlobalConfig, arg1: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T1, T2, T3>, arg2: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T1, T3>, arg3: 0x2::coin::Coin<T2>, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::utils::split_coin_to_balance<T2>(arg3, arg4, arg6);
        let v1 = swap_cba<T0, T1, T2, T3>(arg0, arg1, arg2, v0, arg5, arg6);
        0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::utils::send_balance<T0>(v1, 0x2::tx_context::sender(arg6), arg6);
    }

    public fun swap_abc<T0, T1, T2, T3>(arg0: &0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::GlobalConfig, arg1: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T1, T3>, arg2: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T1, T2, T3>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::base_swap_ab<T1, T2, T3>(arg0, arg2, 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::base_swap_ab<T0, T1, T3>(arg0, arg1, arg3, 0, arg5), arg4, arg5)
    }

    public fun swap_acb<T0, T1, T2, T3>(arg0: &0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::GlobalConfig, arg1: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T2, T3>, arg2: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T1, T2, T3>, arg3: 0x2::balance::Balance<T0>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::base_swap_ba<T1, T2, T3>(arg0, arg2, 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::base_swap_ab<T0, T2, T3>(arg0, arg1, arg3, 0, arg5), arg4, arg5)
    }

    public fun swap_bac<T0, T1, T2, T3>(arg0: &0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::GlobalConfig, arg1: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T1, T3>, arg2: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T2, T3>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T2> {
        0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::base_swap_ab<T0, T2, T3>(arg0, arg2, 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::base_swap_ba<T0, T1, T3>(arg0, arg1, arg3, 0, arg5), arg4, arg5)
    }

    public fun swap_bca<T0, T1, T2, T3>(arg0: &0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::GlobalConfig, arg1: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T1, T2, T3>, arg2: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T2, T3>, arg3: 0x2::balance::Balance<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::base_swap_ba<T0, T2, T3>(arg0, arg2, 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::base_swap_ab<T1, T2, T3>(arg0, arg1, arg3, 0, arg5), arg4, arg5)
    }

    public fun swap_cab<T0, T1, T2, T3>(arg0: &0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::GlobalConfig, arg1: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T2, T3>, arg2: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T1, T3>, arg3: 0x2::balance::Balance<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::base_swap_ab<T0, T1, T3>(arg0, arg2, 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::base_swap_ba<T0, T2, T3>(arg0, arg1, arg3, 0, arg5), arg4, arg5)
    }

    public fun swap_cba<T0, T1, T2, T3>(arg0: &0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::GlobalConfig, arg1: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T1, T2, T3>, arg2: &mut 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::Pool<T0, T1, T3>, arg3: 0x2::balance::Balance<T2>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::base_swap_ba<T0, T1, T3>(arg0, arg2, 0xb72eb4c8527ab4265bba30eedab3f1a1a2fb928cd06a8dfc51d1f6bf1513ec2e::swap_core::base_swap_ba<T1, T2, T3>(arg0, arg1, arg3, 0, arg5), arg4, arg5)
    }

    // decompiled from Move bytecode v6
}

