module 0xad1c17a3407de7bda36143a627641cec72278328b8cad1a91dbd250c1aa3eeb0::magma_clmm {
    public fun magma_clmm_flashswap_a2b<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg2, arg0, true, true, arg3, arg4, arg1);
        0x2::balance::destroy_zero<T0>(v0);
        (0x2::coin::from_balance<T1>(v1, arg5), v2)
    }

    public fun magma_clmm_flashswap_b2a<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: u64, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>) {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg2, arg0, false, true, arg3, arg4, arg1);
        0x2::balance::destroy_zero<T1>(v1);
        (0x2::coin::from_balance<T0>(v0, arg5), v2)
    }

    public fun magma_clmm_repay_flashswap_a2b<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: 0x2::coin::Coin<T0>, arg3: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>) {
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::coin::into_balance<T0>(arg2), 0x2::balance::zero<T1>(), arg3);
    }

    public fun magma_clmm_repay_flashswap_b2a<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg2: 0x2::coin::Coin<T1>, arg3: 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::FlashSwapReceipt<T0, T1>) {
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg1, arg0, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg2), arg3);
    }

    public fun magma_clmm_swap_a2b<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: 0x2::coin::Coin<T0>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg2, arg0, true, true, 0x2::coin::value<T0>(&arg3), arg4, arg1);
        0x2::balance::destroy_zero<T0>(v0);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg2, arg0, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), v2);
        0x2::coin::from_balance<T1>(v1, arg5)
    }

    public fun magma_clmm_swap_b2a<T0, T1>(arg0: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg3: 0x2::coin::Coin<T1>, arg4: u128, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1, v2) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::flash_swap<T0, T1>(arg2, arg0, false, true, 0x2::coin::value<T1>(&arg3), arg4, arg1);
        0x2::balance::destroy_zero<T1>(v1);
        0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::repay_flash_swap<T0, T1>(arg2, arg0, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(arg3), v2);
        0x2::coin::from_balance<T0>(v0, arg5)
    }

    // decompiled from Move bytecode v6
}

