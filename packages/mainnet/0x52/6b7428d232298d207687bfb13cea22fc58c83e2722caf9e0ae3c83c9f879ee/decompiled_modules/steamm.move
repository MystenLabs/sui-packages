module 0x526b7428d232298d207687bfb13cea22fc58c83e2722caf9e0ae3c83c9f879ee::steamm {
    struct CpmmQuote has copy, drop, store {
        a2b_out: u64,
        b2a_out: u64,
    }

    public fun a2b_cpmm<T0, T1, T2, T3, T4, T5: drop>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::zero<T2>(arg6);
        0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::cpmm_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, &mut arg0, &mut v0, true, 0x2::coin::value<T1>(&arg0), 0, arg5, arg6);
        0x526b7428d232298d207687bfb13cea22fc58c83e2722caf9e0ae3c83c9f879ee::helpers::transfer_or_destroy_coin<T1>(arg0, arg6);
        v0
    }

    public fun a2b_omm<T0, T1, T2, T3, T4, T5: drop>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::zero<T2>(arg8);
        0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::omm_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, &mut arg0, &mut v0, true, 0x2::coin::value<T1>(&arg0), 0, arg7, arg8);
        0x526b7428d232298d207687bfb13cea22fc58c83e2722caf9e0ae3c83c9f879ee::helpers::transfer_or_destroy_coin<T1>(arg0, arg8);
        v0
    }

    public fun a2b_omm_v2<T0, T1, T2, T3, T4, T5: drop>(arg0: 0x2::coin::Coin<T1>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let v0 = 0x2::coin::zero<T2>(arg8);
        0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::omm_v2_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, &mut arg0, &mut v0, true, 0x2::coin::value<T1>(&arg0), 0, arg7, arg8);
        0x526b7428d232298d207687bfb13cea22fc58c83e2722caf9e0ae3c83c9f879ee::helpers::transfer_or_destroy_coin<T1>(arg0, arg8);
        v0
    }

    public fun b2a_cpmm<T0, T1, T2, T3, T4, T5: drop>(arg0: 0x2::coin::Coin<T2>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg6);
        0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::cpmm_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, &mut v0, &mut arg0, false, 0x2::coin::value<T2>(&arg0), 0, arg5, arg6);
        0x526b7428d232298d207687bfb13cea22fc58c83e2722caf9e0ae3c83c9f879ee::helpers::transfer_or_destroy_coin<T2>(arg0, arg6);
        v0
    }

    public fun b2a_omm<T0, T1, T2, T3, T4, T5: drop>(arg0: 0x2::coin::Coin<T2>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm::OracleQuoter, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg8);
        0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::omm_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, &mut v0, &mut arg0, false, 0x2::coin::value<T2>(&arg0), 0, arg7, arg8);
        0x526b7428d232298d207687bfb13cea22fc58c83e2722caf9e0ae3c83c9f879ee::helpers::transfer_or_destroy_coin<T2>(arg0, arg8);
        v0
    }

    public fun b2a_omm_v2<T0, T1, T2, T3, T4, T5: drop>(arg0: 0x2::coin::Coin<T2>, arg1: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::omm_v2::OracleQuoterV2, T5>, arg2: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg3: &mut 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg4: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg6: 0xe84b649199654d18c38e727212f5d8dacfc3cf78d60d0a7fc85fd589f280eb2b::oracles::OraclePriceUpdate, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::zero<T1>(arg8);
        0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::omm_v2_swap<T0, T1, T2, T3, T4, T5>(arg1, arg2, arg3, arg4, arg5, arg6, &mut v0, &mut arg0, false, 0x2::coin::value<T2>(&arg0), 0, arg7, arg8);
        0x526b7428d232298d207687bfb13cea22fc58c83e2722caf9e0ae3c83c9f879ee::helpers::transfer_or_destroy_coin<T2>(arg0, arg8);
        v0
    }

    public fun probe_cpmm<T0, T1, T2, T3, T4, T5: drop>(arg0: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::pool::Pool<T3, T4, 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::cpmm::CpQuoter, T5>, arg1: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T1, T3>, arg2: &0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::bank::Bank<T0, T2, T4>, arg3: &0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: u64, arg5: u64, arg6: &0x2::clock::Clock) : CpmmQuote {
        let v0 = 0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::quote_cpmm_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, true, arg4, arg6);
        let v1 = 0x13bfc09cfc1bd922d3aa53fcf7b2cd510727ee65068ce136e2ebd5f3b213fdd2::pool_script_v2::quote_cpmm_swap<T0, T1, T2, T3, T4, T5>(arg0, arg1, arg2, arg3, false, arg5, arg6);
        CpmmQuote{
            a2b_out : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v0),
            b2a_out : 0x4fb1cf45dffd6230305f1d269dd1816678cc8e3ba0b747a813a556921219f261::quote::amount_out(&v1),
        }
    }

    // decompiled from Move bytecode v7
}

