module 0xa7c6f5f70f49c48a043515fed399712c0ca146427a886f2f5763771a59db53d2::swap {
    public fun swap<T0, T1>(arg0: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u64, arg7: u128, arg8: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg9: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool::flash_swap<T0, T1>(arg0, arg3, arg4, arg5, arg7, arg8, arg9, arg10, arg11);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg3) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg4) {
            assert!(v6 == arg5, 13835058811196407809);
            assert!(v7 >= arg6, 13835340290468216835);
        } else {
            assert!(v7 == arg5, 13835058824081309697);
            assert!(v6 <= arg6, 13835621778329960453);
        };
        let (v8, v9) = if (arg3) {
            0x2::balance::destroy_zero<T0>(v5);
            0x2::coin::join<T1>(arg2, 0x2::coin::from_balance<T1>(v4, arg11));
            assert!(0x2::coin::value<T0>(arg1) >= v6, 13835903279076605959);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v6, arg11)), 0x2::balance::zero<T1>())
        } else {
            0x2::balance::destroy_zero<T1>(v4);
            0x2::coin::join<T0>(arg1, 0x2::coin::from_balance<T0>(v5, arg11));
            assert!(0x2::coin::value<T1>(arg2) >= v6, 13835903300551442439);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v6, arg11)))
        };
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool::repay_flash_swap<T0, T1>(arg0, v8, v9, v3, arg9);
    }

    public fun swap_a2b<T0, T1>(arg0: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: bool, arg3: u64, arg4: u64, arg5: u128, arg6: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg7: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg9);
        let v1 = &mut v0;
        swap<T0, T1>(arg0, arg1, v1, true, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg9));
    }

    public fun swap_a2b_with_partner<T0, T1>(arg0: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool::Pool<T0, T1>, arg1: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::Partner, arg2: &mut 0x2::coin::Coin<T0>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg8: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T1>(0x2::balance::zero<T1>(), arg10);
        let v1 = &mut v0;
        swap_with_partner<T0, T1>(arg0, arg1, arg2, v1, true, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v0, 0x2::tx_context::sender(arg10));
    }

    public fun swap_b2a<T0, T1>(arg0: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: bool, arg3: u64, arg4: u64, arg5: u128, arg6: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg7: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg9);
        let v1 = &mut v0;
        swap<T0, T1>(arg0, v1, arg1, false, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg9));
    }

    public fun swap_b2a_with_partner<T0, T1>(arg0: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool::Pool<T0, T1>, arg1: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::Partner, arg2: &mut 0x2::coin::Coin<T1>, arg3: bool, arg4: u64, arg5: u64, arg6: u128, arg7: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg8: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::from_balance<T0>(0x2::balance::zero<T0>(), arg10);
        let v1 = &mut v0;
        swap_with_partner<T0, T1>(arg0, arg1, v1, arg2, false, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, 0x2::tx_context::sender(arg10));
    }

    public fun swap_with_partner<T0, T1>(arg0: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool::Pool<T0, T1>, arg1: &mut 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::partner::Partner, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u64, arg8: u128, arg9: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::config::GlobalConfig, arg10: &0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::versioned::Versioned, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool::flash_swap_with_partner<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg8, arg9, arg10, arg11, arg12);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool::swap_pay_amount<T0, T1>(&v3);
        let v7 = if (arg4) {
            0x2::balance::value<T1>(&v4)
        } else {
            0x2::balance::value<T0>(&v5)
        };
        if (arg5) {
            assert!(v6 == arg6, 13835059064599478273);
            assert!(v7 >= arg7, 13835340543871287299);
        } else {
            assert!(v7 == arg6, 13835059077484380161);
            assert!(v6 <= arg7, 13835622031733030917);
        };
        let (v8, v9) = if (arg4) {
            0x2::balance::destroy_zero<T0>(v5);
            0x2::coin::join<T1>(arg3, 0x2::coin::from_balance<T1>(v4, arg12));
            assert!(0x2::coin::value<T0>(arg2) >= v6, 13835903532479676423);
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v6, arg12)), 0x2::balance::zero<T1>())
        } else {
            0x2::balance::destroy_zero<T1>(v4);
            0x2::coin::join<T0>(arg2, 0x2::coin::from_balance<T0>(v5, arg12));
            assert!(0x2::coin::value<T1>(arg3) >= v6, 13835903553954512903);
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v6, arg12)))
        };
        0x5ea056534edb5d54fe5c25007aef9d8489cb4d5b792179a35f735723496ec4f1::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, v8, v9, v3, arg10);
    }

    // decompiled from Move bytecode v6
}

