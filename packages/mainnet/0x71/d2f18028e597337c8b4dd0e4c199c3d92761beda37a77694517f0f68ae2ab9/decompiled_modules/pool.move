module 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::pool {
    struct Pool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance1: 0x2::balance::Balance<T0>,
        balance2: 0x2::balance::Balance<T1>,
    }

    public fun swap<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: &0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::oracle::Oracle, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: &0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::game_ticket::NewAction, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        if (arg4) {
            if (0x2::coin::value<T1>(&arg3) != 0) {
                err_invalid_input_coin_amount();
            };
            0x2::coin::destroy_zero<T1>(arg3);
            0x2::balance::join<T0>(&mut arg0.balance1, 0x2::coin::into_balance<T0>(arg2));
            let v2 = (((0x2::coin::value<T0>(&arg2) as u256) * (0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::oracle::get_price<T0>(arg1) as u256) / (0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::oracle::get_price<T1>(arg1) as u256)) as u64);
            if (v2 > 0x2::balance::value<T1>(&arg0.balance2)) {
                err_pool_balance_not_enough();
            };
            (0x2::coin::zero<T0>(arg6), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut arg0.balance2, v2), arg6))
        } else {
            if (0x2::coin::value<T0>(&arg2) != 0) {
                err_invalid_input_coin_amount();
            };
            0x2::coin::destroy_zero<T0>(arg2);
            0x2::balance::join<T1>(&mut arg0.balance2, 0x2::coin::into_balance<T1>(arg3));
            let v3 = (((0x2::coin::value<T1>(&arg3) as u256) * (0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::oracle::get_price<T1>(arg1) as u256) / (0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::oracle::get_price<T0>(arg1) as u256)) as u64);
            if (v3 > 0x2::balance::value<T0>(&arg0.balance1)) {
                err_pool_balance_not_enough();
            };
            (0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.balance1, v3), arg6), 0x2::coin::zero<T1>(arg6))
        }
    }

    public(friend) fun add_liquidity<T0, T1>(arg0: &mut Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x2::balance::Balance<T1>) {
        0x2::balance::join<T0>(&mut arg0.balance1, arg1);
        0x2::balance::join<T1>(&mut arg0.balance2, arg2);
    }

    fun err_invalid_input_coin_amount() {
        abort 1
    }

    fun err_pool_balance_not_enough() {
        abort 0
    }

    public(friend) fun new_pool<T0, T1>(arg0: &mut 0x2::tx_context::TxContext) : Pool<T0, T1> {
        Pool<T0, T1>{
            id       : 0x2::object::new(arg0),
            balance1 : 0x2::balance::zero<T0>(),
            balance2 : 0x2::balance::zero<T1>(),
        }
    }

    // decompiled from Move bytecode v6
}

