module 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::mmt {
    public(friend) fun ma<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, arg1, arg2, arg3, arg4, arg5);
        (v1, v0, v2)
    }

    public(friend) fun ma_<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1, v2) = ma<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T0>(arg5, v1);
        (v0, v2)
    }

    public(friend) fun ma__<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg6: 0x2::balance::Balance<T1>, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1) = ma_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let v2 = v0;
        if (0x2::balance::value<T1>(&arg6) == 0) {
            0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::destroy_zero_balance<T1>(arg6);
        } else {
            0x2::balance::join<T1>(&mut v2, arg6);
        };
        (v2, v1)
    }

    public(friend) fun ma_coins<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x2::coin::Coin<T0>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1, v2) = ma<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        (0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T1>(v0, arg5), 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T0>(v1, arg5), v2)
    }

    public(friend) fun ma_coins_<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1) = ma_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        (0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T1>(v0, arg6), v1)
    }

    public(friend) fun ma_from_coins__<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T0>, arg6: 0x2::coin::Coin<T1>, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        ma__<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T1>(arg6), arg7)
    }

    public(friend) fun mb<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, arg1, arg2, arg3, arg4, arg5)
    }

    public(friend) fun mb_<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg6: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1, v2) = mb<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg6);
        0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::destroy_or_deposit_balance<T1>(arg5, v1);
        (v0, v2)
    }

    public(friend) fun mb__<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg6: 0x2::balance::Balance<T0>, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1) = mb_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg7);
        let v2 = v0;
        if (0x2::balance::value<T0>(&arg6) == 0) {
            0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::destroy_zero_balance<T0>(arg6);
        } else {
            0x2::balance::join<T0>(&mut v2, arg6);
        };
        (v2, v1)
    }

    public(friend) fun mb_coins<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1, v2) = mb<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
        (0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T0>(v0, arg5), 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T1>(v1, arg5), v2)
    }

    public(friend) fun mb_coins_<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1) = mb_<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        (0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_from_balance<T0>(v0, arg6), v1)
    }

    public(friend) fun mb_from_coins__<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::wallet::Vault<T1>, arg6: 0x2::coin::Coin<T0>, arg7: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        mb__<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T0>(arg6), arg7)
    }

    public(friend) fun repay_f_s<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::tx_context::TxContext) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public(friend) fun repay_f_s_x<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg2: 0x2::balance::Balance<T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) {
        repay_f_s<T0, T1>(arg0, arg1, arg2, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::zero_balance<T1>(), arg3, arg4);
    }

    public(friend) fun repay_f_s_x_from_coin<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) {
        repay_f_s_x<T0, T1>(arg0, arg1, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T0>(arg2), arg3, arg4);
    }

    public(friend) fun repay_f_s_y<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg2: 0x2::balance::Balance<T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) {
        repay_f_s<T0, T1>(arg0, arg1, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::zero_balance<T0>(), arg2, arg3, arg4);
    }

    public(friend) fun repay_f_s_y_from_coin<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg2: 0x2::coin::Coin<T1>, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) {
        repay_f_s_y<T0, T1>(arg0, arg1, 0x2d9c7ab317ce7940443a148117444387c3998bebe606857a59347647c1d1a1d9::tools::coin_to_balance<T1>(arg2), arg3, arg4);
    }

    // decompiled from Move bytecode v7
}

