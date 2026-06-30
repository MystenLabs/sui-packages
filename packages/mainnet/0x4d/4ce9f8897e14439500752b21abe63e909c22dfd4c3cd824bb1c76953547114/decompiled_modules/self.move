module 0x4d4ce9f8897e14439500752b21abe63e909c22dfd4c3cd824bb1c76953547114::self {
    struct StableQuote has copy, drop, store {
        steamm_cpmm_a2b_out: u64,
        steamm_cpmm_b2a_out: u64,
        deepbook_a2b_out: u64,
        deepbook_b2a_out: u64,
    }

    struct DlmmQuote has copy, drop, store {
        cetus_dlmm_probe_in: u64,
        cetus_dlmm_mid_out: u64,
        cetus_dlmm_end_out: u64,
    }

    public fun db_borrow_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan) {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::borrow_flashloan_base<T0, T1>(arg0, arg1, arg2)
    }

    public fun db_repay_base<T0, T1>(arg0: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg1: u64, arg2: 0x2::coin::Coin<T0>, arg3: 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::vault::FlashLoan, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::return_flashloan_base<T0, T1>(arg0, 0x2::coin::split<T0>(&mut arg2, arg1, arg4), arg3);
        arg2
    }

    public fun expect<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg0);
        if (v0 < arg1) {
            abort v0 << 8 | 1
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
    }

    public fun max_sqrt_price() : u128 {
        79226673515401279992447579055
    }

    public fun min_sqrt_price() : u128 {
        4295048016
    }

    public fun probe_dlmm<T0, T1>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (DlmmQuote, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T1>(&arg0);
        let (v1, v2, v3) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, false, true, v0, arg2, arg3, arg4, arg5);
        let v4 = v1;
        let v5 = 0x2::balance::value<T0>(&v4);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg1, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg0), v3, arg3);
        transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v2, arg5), arg5);
        let (v6, v7, v8) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T0, T1>(arg1, true, true, v5, arg2, arg3, arg4, arg5);
        let v9 = v7;
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T0, T1>(arg1, 0x2::coin::into_balance<T0>(0x2::coin::from_balance<T0>(v4, arg5)), 0x2::balance::zero<T1>(), v8, arg3);
        transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v6, arg5), arg5);
        let v10 = DlmmQuote{
            cetus_dlmm_probe_in : v0,
            cetus_dlmm_mid_out  : v5,
            cetus_dlmm_end_out  : 0x2::balance::value<T1>(&v9),
        };
        (v10, 0x2::coin::from_balance<T1>(v9, arg5))
    }

    public fun probe_stable<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T1, T2>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock) : StableQuote {
        let v0 = 0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::quote_cpmm_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, true, arg5, arg7);
        let v1 = 0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::quote_cpmm_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, false, arg6, arg7);
        let (_, v3, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T1, T2>(arg4, arg5, 0, arg7);
        let (v5, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T1, T2>(arg4, 0, arg6, arg7);
        StableQuote{
            steamm_cpmm_a2b_out : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v0),
            steamm_cpmm_b2a_out : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1),
            deepbook_a2b_out    : v3,
            deepbook_b2a_out    : v5,
        }
    }

    public fun probe_value<T0>(arg0: &0x2::coin::Coin<T0>, arg1: u64) : u64 {
        let v0 = 0x2::coin::value<T0>(arg0);
        if (v0 < arg1) {
            abort v0 << 8 | 1
        };
        v0
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

