module 0x4abb1860e3718443c4e5abf82dfb4eff9647f753fbeb0cc209da1fa522e4198b::para {
    struct Output has copy, drop {
        amount: u64,
    }

    struct SwapReceipt<phantom T0, phantom T1, T2> has store {
        flash_loan_receipt: T2,
        balance_a: 0x2::balance::Balance<T0>,
        balance_b: 0x2::balance::Balance<T1>,
        repay_amount: u64,
        a2b: bool,
    }

    public fun add_assert(arg0: u32, arg1: u32, arg2: u32, arg3: u32, arg4: u32, arg5: u32, arg6: u32, arg7: u32) {
        assert!(arg0 + arg1 + arg2 + arg3 >= (arg4 + arg5 + arg6 + arg7) / 100, 333);
    }

    public fun bf_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg3, arg4);
        0x2::balance::zero<T1>()
    }

    public fun bf_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg3, arg4);
        0x2::balance::zero<T0>()
    }

    public fun bl_a<T0, T1>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg1, arg2);
        0x2::balance::zero<T1>()
    }

    public fun bl_b<T0, T1>(arg0: address, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg1, arg2);
        0x2::balance::zero<T0>()
    }

    public fun d3a<T0, T1>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg1, arg3);
        0x2::balance::zero<T1>()
    }

    public fun d3b<T0, T1>(arg0: address, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg1, arg3);
        0x2::balance::zero<T0>()
    }

    public fun flash_loan_base<T0, T1>(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SwapReceipt<T0, T0, u64> {
        SwapReceipt<T0, T0, u64>{
            flash_loan_receipt : 0,
            balance_a          : 0x2::balance::zero<T0>(),
            balance_b          : 0x2::balance::zero<T0>(),
            repay_amount       : 0,
            a2b                : false,
        }
    }

    public fun flash_loan_quote<T0, T1>(arg0: address, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : SwapReceipt<T1, T1, u64> {
        SwapReceipt<T1, T1, u64>{
            flash_loan_receipt : 0,
            balance_a          : 0x2::balance::zero<T1>(),
            balance_b          : 0x2::balance::zero<T1>(),
            repay_amount       : 0,
            a2b                : false,
        }
    }

    public fun flash_swap_cetus<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: bool, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : SwapReceipt<T0, T1, u64> {
        SwapReceipt<T0, T1, u64>{
            flash_loan_receipt : 0,
            balance_a          : 0x2::balance::zero<T0>(),
            balance_b          : 0x2::balance::zero<T1>(),
            repay_amount       : 0,
            a2b                : false,
        }
    }

    public fun get_sqrt_price_limit(arg0: u128, arg1: bool) : u128 {
        if (arg1) {
            return arg0 * 3 / 5
        };
        arg0 * 5 / 3
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun ma<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg3, arg4);
        0x2::balance::zero<T1>()
    }

    public fun mb<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg3, arg4);
        0x2::balance::zero<T0>()
    }

    public fun me<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg1) > 0) {
            0x2::coin::join<T0>(arg0, 0x2::coin::from_balance<T0>(arg1, arg2));
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public fun mmt_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg3, arg4);
        0x2::balance::zero<T1>()
    }

    public fun mmt_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg3, arg4);
        0x2::balance::zero<T0>()
    }

    public fun move_balance_a_from_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        0x2::balance::withdraw_all<T0>(&mut arg0.balance_a)
    }

    public fun move_balance_b_from_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        0x2::balance::withdraw_all<T1>(&mut arg0.balance_b)
    }

    public fun r_c_f_s_a<T0, T1>(arg0: address, arg1: address, arg2: SwapReceipt<T0, T1, u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let SwapReceipt {
            flash_loan_receipt : _,
            balance_a          : v1,
            balance_b          : v2,
            repay_amount       : _,
            a2b                : _,
        } = arg2;
        0x2::balance::destroy_zero<T1>(v2);
        v1
    }

    public fun r_c_f_s_b<T0, T1>(arg0: address, arg1: address, arg2: SwapReceipt<T0, T1, u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let SwapReceipt {
            flash_loan_receipt : _,
            balance_a          : v1,
            balance_b          : v2,
            repay_amount       : _,
            a2b                : _,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v1);
        v2
    }

    public fun repay_cetus_flash_swap<T0, T1>(arg0: address, arg1: address, arg2: SwapReceipt<T0, T1, u64>, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        let SwapReceipt {
            flash_loan_receipt : _,
            balance_a          : v1,
            balance_b          : v2,
            repay_amount       : _,
            a2b                : v4,
        } = arg2;
        if (v4) {
            transfer_or_destroy_balance<T0>(v1, arg4);
            0x2::balance::destroy_zero<T1>(v2);
        } else {
            0x2::balance::destroy_zero<T0>(v1);
            transfer_or_destroy_balance<T1>(v2, arg4);
        };
    }

    public fun repay_loan_base<T0, T1>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: SwapReceipt<T0, T0, u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let SwapReceipt {
            flash_loan_receipt : _,
            balance_a          : v1,
            balance_b          : v2,
            repay_amount       : _,
            a2b                : _,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v1);
        0x2::balance::destroy_zero<T0>(v2);
        arg1
    }

    public fun repay_loan_quote<T0, T1>(arg0: address, arg1: 0x2::balance::Balance<T1>, arg2: SwapReceipt<T1, T1, u64>, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let SwapReceipt {
            flash_loan_receipt : _,
            balance_a          : v1,
            balance_b          : v2,
            repay_amount       : _,
            a2b                : _,
        } = arg2;
        0x2::balance::destroy_zero<T1>(v1);
        0x2::balance::destroy_zero<T1>(v2);
        arg1
    }

    public fun show_balance<T0>(arg0: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let v0 = Output{amount: 0x2::balance::value<T0>(&arg0)};
        0x2::event::emit<Output>(v0);
        arg0
    }

    public fun swap_aftermath_a_b<T0, T1, T2>(arg0: address, arg1: address, arg2: address, arg3: address, arg4: address, arg5: address, arg6: 0x2::balance::Balance<T0>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg6, arg9);
        0x2::balance::zero<T1>()
    }

    public fun swap_aftermath_b_a<T0, T1, T2>(arg0: address, arg1: address, arg2: address, arg3: address, arg4: address, arg5: address, arg6: 0x2::balance::Balance<T1>, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg6, arg9);
        0x2::balance::zero<T0>()
    }

    public fun swap_cetus_a_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg3, arg4);
        0x2::balance::zero<T1>()
    }

    public fun swap_cetus_b_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg3, arg4);
        0x2::balance::zero<T0>()
    }

    public fun swap_cetus_d_a_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: address, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg4, arg5);
        0x2::balance::zero<T1>()
    }

    public fun swap_cetus_d_b_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: address, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg4, arg5);
        0x2::balance::zero<T0>()
    }

    public fun swap_flowx_v2_a_b<T0, T1>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg1, arg2);
        0x2::balance::zero<T1>()
    }

    public fun swap_flowx_v2_b_a<T0, T1>(arg0: address, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg1, arg2);
        0x2::balance::zero<T0>()
    }

    public fun swap_flowx_v3_a_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: u64, arg3: address, arg4: 0x2::balance::Balance<T0>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg4, arg5);
        0x2::balance::zero<T1>()
    }

    public fun swap_flowx_v3_a_b_inner<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg3, arg4);
        0x2::balance::zero<T1>()
    }

    public fun swap_flowx_v3_b_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: u64, arg3: address, arg4: 0x2::balance::Balance<T1>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg4, arg5);
        0x2::balance::zero<T0>()
    }

    public fun swap_flowx_v3_b_a_inner<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg3, arg4);
        0x2::balance::zero<T0>()
    }

    public fun swap_kriya_v3_a_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg3, arg4);
        0x2::balance::zero<T1>()
    }

    public fun swap_kriya_v3_b_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: address, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg3, arg4);
        0x2::balance::zero<T0>()
    }

    public fun swap_kriyaswap_a_b<T0, T1>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg1, arg2);
        0x2::balance::zero<T1>()
    }

    public fun swap_kriyaswap_b_a<T0, T1>(arg0: address, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg1, arg2);
        0x2::balance::zero<T0>()
    }

    public fun swap_suiswap_a_b<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg2, arg4);
        0x2::balance::zero<T1>()
    }

    public fun swap_suiswap_b_a<T0, T1>(arg0: &0x2::clock::Clock, arg1: address, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg2, arg4);
        0x2::balance::zero<T0>()
    }

    public fun swap_turbos_a_b<T0, T1, T2>(arg0: address, arg1: 0x2::balance::Balance<T0>, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        transfer_or_destroy_balance<T0>(arg1, arg4);
        0x2::balance::zero<T1>()
    }

    public fun swap_turbos_b_a<T0, T1, T2>(arg0: address, arg1: 0x2::balance::Balance<T1>, arg2: &0x2::clock::Clock, arg3: address, arg4: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        transfer_or_destroy_balance<T1>(arg1, arg4);
        0x2::balance::zero<T0>()
    }

    public fun take_balance_a_to_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.balance_a, arg1);
    }

    public fun take_balance_b_to_receipt<T0, T1, T2>(arg0: &mut SwapReceipt<T0, T1, T2>, arg1: 0x2::balance::Balance<T1>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T1>(&mut arg0.balance_b, arg1);
    }

    public fun tick_bl<T0, T1>(arg0: address, arg1: bool) : (u32, u32) {
        if (arg1) {
            (0, 0)
        } else {
            (4294967295, 0)
        }
    }

    public fun tick_ce<T0, T1>(arg0: address, arg1: bool) : (u32, u32) {
        if (!arg1) {
            (4294967295, 0)
        } else {
            (0, 0)
        }
    }

    public fun tick_f3<T0, T1>(arg0: address, arg1: u64, arg2: bool) : (u32, u32) {
        if (arg2) {
            (0, 0)
        } else {
            (4294967295, 0)
        }
    }

    public fun tick_k3<T0, T1>(arg0: address, arg1: bool) : (u32, u32) {
        if (arg1) {
            (0, 0)
        } else {
            (4294967295, 0)
        }
    }

    public fun tick_tu<T0, T1, T2>(arg0: address, arg1: bool) : (u32, u32) {
        if (arg1) {
            (0, 0)
        } else {
            (4294967295, 0)
        }
    }

    public fun tr<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

