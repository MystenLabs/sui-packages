module 0xa0fc18fbf8322044f7d8930d68b8c9354cb55069e4b81ff9bdebd15b49b01abf::cpmm {
    public fun flowx_swap_exact_input_direct<T0, T1, T2, T3>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg4: 0x2::coin::Coin<T2>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T2, T3>(arg3, arg4, arg5);
        let v1 = 0x2::object::id<0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container>(arg3);
        0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::record_leg<T0, T1, T2, T3>(arg0, arg1, 0, 0x2::object::id_to_address(&v1), arg2, 0x2::coin::value<T3>(&v0));
        v0
    }

    public fun steamm_swap_a_to_b<T0, T1, T2, T3, T4, T5, T6, T7: drop>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T7>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T4, T6>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg7: 0x2::coin::Coin<T3>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T4> {
        let v0 = 0x2::coin::zero<T4>(arg9);
        0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::cpmm_swap<T2, T3, T4, T5, T6, T7>(arg3, arg4, arg5, arg6, &mut arg7, &mut v0, true, arg2, 0, arg8, arg9);
        0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::refund_aux<T0, T1, T3>(arg0, arg7);
        let v1 = 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T7>>(arg3);
        0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::record_leg<T0, T1, T3, T4>(arg0, arg1, 2, 0x2::object::id_to_address(&v1), arg2, 0x2::coin::value<T4>(&v0));
        v0
    }

    public fun steamm_swap_b_to_a<T0, T1, T2, T3, T4, T5, T6, T7: drop>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T7>, arg4: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T3, T5>, arg5: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T2, T4, T6>, arg6: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T2>, arg7: 0x2::coin::Coin<T4>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let v0 = 0x2::coin::zero<T3>(arg9);
        0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::cpmm_swap<T2, T3, T4, T5, T6, T7>(arg3, arg4, arg5, arg6, &mut v0, &mut arg7, false, arg2, 0, arg8, arg9);
        0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::refund_aux<T0, T1, T4>(arg0, arg7);
        let v1 = 0x2::object::id<0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T5, T6, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T7>>(arg3);
        0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::record_leg<T0, T1, T4, T3>(arg0, arg1, 2, 0x2::object::id_to_address(&v1), arg2, 0x2::coin::value<T3>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

