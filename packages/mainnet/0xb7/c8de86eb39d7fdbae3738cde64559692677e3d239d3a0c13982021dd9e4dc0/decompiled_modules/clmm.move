module 0xb7c8de86eb39d7fdbae3738cde64559692677e3d239d3a0c13982021dd9e4dc0::clmm {
    public fun cetus_router_swap_a_to_b<T0, T1, T2, T3>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let (v0, v1) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<T2, T3>(arg3, arg4, arg5, 0x2::coin::zero<T3>(arg7), true, true, arg2, 4295048017, false, arg6, arg7);
        let v2 = v1;
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4);
        refund_and_record<T0, T1, T2, T3>(arg0, arg1, 8, 0x2::object::id_to_address(&v3), arg2, v0, &v2);
        v2
    }

    public fun cetus_router_swap_b_to_a<T0, T1, T2, T3>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg5: 0x2::coin::Coin<T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0x996c4d9480708fb8b92aa7acf819fb0497b5ec8e65ba06601cae2fb6db3312c3::router::swap<T2, T3>(arg3, arg4, 0x2::coin::zero<T2>(arg7), arg5, false, true, arg2, 79226673515401279992447579050, false, arg6, arg7);
        let v2 = v0;
        let v3 = 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>>(arg4);
        refund_and_record<T0, T1, T3, T2>(arg0, arg1, 8, 0x2::object::id_to_address(&v3), arg2, v1, &v2);
        v2
    }

    public fun fullsail_router_swap_a_to_b<T0, T1, T2, T3>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T2, T3>, arg6: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg7: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg8: 0x2::coin::Coin<T2>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let (v0, v1) = 0xac5e1b3e144973cd41e3adf78799ce9a2817dadfeafa1fda095c88bfee3a8cc9::router::swap<T2, T3>(arg3, arg4, arg5, arg8, 0x2::coin::zero<T3>(arg10), true, true, arg2, 4295048017, false, arg6, arg7, arg9, arg10);
        let v2 = v1;
        let v3 = 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T2, T3>>(arg5);
        refund_and_record<T0, T1, T2, T3>(arg0, arg1, 10, 0x2::object::id_to_address(&v3), arg2, v0, &v2);
        v2
    }

    public fun fullsail_router_swap_b_to_a<T0, T1, T2, T3>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg4: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg5: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T2, T3>, arg6: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg7: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg8: 0x2::coin::Coin<T3>, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0xac5e1b3e144973cd41e3adf78799ce9a2817dadfeafa1fda095c88bfee3a8cc9::router::swap<T2, T3>(arg3, arg4, arg5, 0x2::coin::zero<T2>(arg10), arg8, false, true, arg2, 79226673515401279992447579050, false, arg6, arg7, arg9, arg10);
        let v2 = v0;
        let v3 = 0x2::object::id<0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T2, T3>>(arg5);
        refund_and_record<T0, T1, T3, T2>(arg0, arg1, 10, 0x2::object::id_to_address(&v3), arg2, v1, &v2);
        v2
    }

    public fun magma_router_swap_a_to_b<T0, T1, T2, T3>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T2, T3>, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T3> {
        let (v0, v1) = 0xc9f008794e70543443bb49bc9719120a6d43bb2cf6b522ec924f495a36b7e69e::router::swap<T2, T3>(arg3, arg4, arg5, 0x2::coin::zero<T3>(arg7), true, true, arg2, 4295048017, false, arg6, arg7);
        let v2 = v1;
        let v3 = 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T2, T3>>(arg4);
        refund_and_record<T0, T1, T2, T3>(arg0, arg1, 11, 0x2::object::id_to_address(&v3), arg2, v0, &v2);
        v2
    }

    public fun magma_router_swap_b_to_a<T0, T1, T2, T3>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, T1>, arg1: u64, arg2: u64, arg3: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig, arg4: &mut 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T2, T3>, arg5: 0x2::coin::Coin<T3>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        let (v0, v1) = 0xc9f008794e70543443bb49bc9719120a6d43bb2cf6b522ec924f495a36b7e69e::router::swap<T2, T3>(arg3, arg4, 0x2::coin::zero<T2>(arg7), arg5, false, true, arg2, 79226673515401279992447579050, false, arg6, arg7);
        let v2 = v0;
        let v3 = 0x2::object::id<0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T2, T3>>(arg4);
        refund_and_record<T0, T1, T3, T2>(arg0, arg1, 11, 0x2::object::id_to_address(&v3), arg2, v1, &v2);
        v2
    }

    fun record_output<T0, T1, T2, T3>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, T1>, arg1: u64, arg2: u8, arg3: address, arg4: u64, arg5: &0x2::coin::Coin<T3>) {
        0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::record_leg<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, 0x2::coin::value<T3>(arg5));
    }

    fun refund_and_record<T0, T1, T2, T3>(arg0: &mut 0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::Session<T0, T1>, arg1: u64, arg2: u8, arg3: address, arg4: u64, arg5: 0x2::coin::Coin<T2>, arg6: &0x2::coin::Coin<T3>) {
        0x7f5dd4a0881b6016f904d74f736d482ec32364f8a4d1d93d98437b200d37fd03::execution::refund_aux<T0, T1, T2>(arg0, arg5);
        record_output<T0, T1, T2, T3>(arg0, arg1, arg2, arg3, arg4, arg6);
    }

    // decompiled from Move bytecode v6
}

