module 0x61bfcc57b805141914dd6bdbe72954fe18ff3085867c9dec09a8b87af9cde032::cetus_swap_wrapper {
    struct TreasuryCap has store, key {
        id: 0x2::object::UID,
        owner: address,
    }

    struct Treasury<phantom T0> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
    }

    public fun swap<T0, T1>(arg0: &TreasuryCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_treasury_cap_owner(arg0, arg11);
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg1, arg2, arg5, arg6, arg7, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        if (arg5) {
        };
        let (v6, v7) = if (arg5) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg11)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3), arg11)))
        };
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v4, arg11));
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v5, arg11));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg1, arg2, v6, v7, v3);
    }

    public fun check_treasury_cap_owner(arg0: &TreasuryCap, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 1);
    }

    public entry fun create_sui_treasury(arg0: &mut 0x2::tx_context::TxContext) {
        create_treasury<0x2::sui::SUI>(arg0);
    }

    public entry fun create_treasury<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Treasury<T0>{
            id      : 0x2::object::new(arg0),
            balance : 0x2::balance::zero<T0>(),
        };
        0x2::transfer::transfer<Treasury<T0>>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun create_treasury_cap(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = TreasuryCap{
            id    : 0x2::object::new(arg0),
            owner : v0,
        };
        0x2::transfer::transfer<TreasuryCap>(v1, v0);
    }

    public fun deposit<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::put<T0>(arg0, arg1);
    }

    public entry fun deposit_entry<T0>(arg0: &TreasuryCap, arg1: &mut Treasury<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        check_treasury_cap_owner(arg0, arg3);
        let v0 = &mut arg1.balance;
        deposit<T0>(v0, arg2);
    }

    public fun deposit_sui(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        deposit<0x2::sui::SUI>(arg0, arg1);
    }

    public entry fun deposit_sui_entry(arg0: &TreasuryCap, arg1: &mut Treasury<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        deposit_entry<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    public fun deposit_sui_with_cap(arg0: &TreasuryCap, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: &0x2::tx_context::TxContext) {
        deposit_with_cap<0x2::sui::SUI>(arg0, arg1, arg2, arg3);
    }

    public fun deposit_with_cap<T0>(arg0: &TreasuryCap, arg1: &mut 0x2::balance::Balance<T0>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::tx_context::TxContext) {
        check_treasury_cap_owner(arg0, arg3);
        deposit<T0>(arg1, arg2);
    }

    public fun is_treasury_cap_owner(arg0: &TreasuryCap, arg1: &0x2::tx_context::TxContext) : bool {
        0x2::tx_context::sender(arg1) == arg0.owner
    }

    public entry fun swap_entry<T0, T1>(arg0: &TreasuryCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: bool, arg6: bool, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        check_treasury_cap_owner(arg0, arg11);
        swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11);
    }

    public fun treasury_balance<T0>(arg0: &Treasury<T0>) : &0x2::balance::Balance<T0> {
        &arg0.balance
    }

    public fun withdraw<T0>(arg0: &mut 0x2::balance::Balance<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::take<T0>(arg0, arg1, arg2)
    }

    public entry fun withdraw_entry<T0>(arg0: &TreasuryCap, arg1: &mut Treasury<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_treasury_cap_owner(arg0, arg4);
        let v0 = &mut arg1.balance;
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(withdraw<T0>(v0, arg2, arg4), arg3);
    }

    public fun withdraw_sui(arg0: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        withdraw<0x2::sui::SUI>(arg0, arg1, arg2)
    }

    public entry fun withdraw_sui_entry(arg0: &TreasuryCap, arg1: &mut Treasury<0x2::sui::SUI>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        withdraw_entry<0x2::sui::SUI>(arg0, arg1, arg2, arg3, arg4);
    }

    public fun withdraw_sui_with_cap(arg0: &TreasuryCap, arg1: &mut 0x2::balance::Balance<0x2::sui::SUI>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        withdraw_with_cap<0x2::sui::SUI>(arg0, arg1, arg2, arg3)
    }

    public fun withdraw_with_cap<T0>(arg0: &TreasuryCap, arg1: &mut 0x2::balance::Balance<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        check_treasury_cap_owner(arg0, arg3);
        withdraw<T0>(arg1, arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

