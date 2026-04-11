module 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::cts {
    public(friend) fun ca<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg0, true, true, arg1, arg2, arg3);
        (v1, v0, v2)
    }

    public(friend) fun ca_<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>) : (0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = ca<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg5, v1);
        (v0, v2)
    }

    public(friend) fun ca__<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg6: 0x2::balance::Balance<T1>) : (0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1) = ca_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = v0;
        if (0x2::balance::value<T1>(&arg6) == 0) {
            0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::destroy_zero_balance<T1>(arg6);
        } else {
            0x2::balance::join<T1>(&mut v2, arg6);
        };
        (v2, v1)
    }

    public(friend) fun ca_coins<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = ca<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        (0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T1>(v0, arg5), 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T0>(v1, arg5), v2)
    }

    public(friend) fun ca_coins_<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1) = ca_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        (0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T1>(v0, arg6), v1)
    }

    public(friend) fun ca_from_coins__<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg6: 0x2::coin::Coin<T1>) : (0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        ca__<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T1>(arg6))
    }

    public(friend) fun cb<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg4, arg0, false, true, arg1, arg2, arg3)
    }

    public(friend) fun cb_<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = cb<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg5, v1);
        (v0, v2)
    }

    public(friend) fun cb__<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg6: 0x2::balance::Balance<T0>) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1) = cb_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        let v2 = v0;
        if (0x2::balance::value<T0>(&arg6) == 0) {
            0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::destroy_zero_balance<T0>(arg6);
        } else {
            0x2::balance::join<T0>(&mut v2, arg6);
        };
        (v2, v1)
    }

    public(friend) fun cb_coins<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = cb<T0, T1>(arg0, arg1, arg2, arg3, arg4);
        (0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T0>(v0, arg5), 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T1>(v1, arg5), v2)
    }

    public(friend) fun cb_coins_<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1) = cb_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        (0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T0>(v0, arg6), v1)
    }

    public(friend) fun cb_from_coins__<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg6: 0x2::coin::Coin<T0>) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>) {
        cb__<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T0>(arg6))
    }

    public(friend) fun repay_f_s<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg4, arg0, arg2, arg3, arg1);
    }

    public(friend) fun repay_f_s_x<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        repay_f_s<T0, T1>(arg0, arg1, arg2, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::zero_balance<T1>(), arg3);
    }

    public(friend) fun repay_f_s_x_from_coin<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        repay_f_s_x<T0, T1>(arg0, arg1, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T0>(arg2), arg3);
    }

    public(friend) fun repay_f_s_y<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        repay_f_s<T0, T1>(arg0, arg1, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::zero_balance<T0>(), arg2, arg3);
    }

    public(friend) fun repay_f_s_y_from_coin<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig) {
        repay_f_s_y<T0, T1>(arg0, arg1, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T1>(arg2), arg3);
    }

    // decompiled from Move bytecode v7
}

