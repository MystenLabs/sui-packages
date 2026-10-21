module 0x62d04f4056e0fc3cb282f6c4f59bb3f1e365e3edd878a31ab8c4676fee9007fc::ve {
    struct L<phantom T0, phantom T1> {
        a: 0x2::balance::Balance<T0>,
        b: 0x2::balance::Balance<T1>,
        owed: u64,
        receipt: 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::FlashSwapReceipt<T0, T1>,
    }

    public fun e_short_repay() : u64 {
        30
    }

    public fun op<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: bool, arg6: u64, arg7: &0x2::clock::Clock) : L<T0, T1> {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, arg5, true, arg6, 0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::n::lm(arg5), arg3, arg4, arg7);
        let v3 = v2;
        L<T0, T1>{
            a       : v0,
            b       : v1,
            owed    : 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::swap_pay_amount<T0, T1>(&v3),
            receipt : v3,
        }
    }

    public fun qo<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: bool, arg3: u64) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculate_swap_result<T0, T1>(arg0, arg1, arg2, true, arg3);
        if (0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_is_exceed(&v0)) {
            return 0
        };
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_out(&v0)
    }

    public fun qs<T0, T1>(arg0: &mut 0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::p::P, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: bool) {
        0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::p::fd(arg0, qo<T0, T1>(arg1, arg2, arg3, 0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::p::cy(arg0)));
    }

    public fun ra<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: L<T0, T1>, arg3: 0x2::balance::Balance<T0>) : 0x2::balance::Balance<T0> {
        let L {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T0>(&arg3) >= v2, 30);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::split<T0>(&mut arg3, v2), 0x2::balance::zero<T1>(), v3);
        arg3
    }

    public fun rb<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: L<T0, T1>, arg3: 0x2::balance::Balance<T1>) : 0x2::balance::Balance<T1> {
        let L {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg2;
        0x2::balance::destroy_zero<T0>(v0);
        0x2::balance::destroy_zero<T1>(v1);
        assert!(0x2::balance::value<T1>(&arg3) >= v2, 30);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg3, v2), v3);
        arg3
    }

    public fun sa<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: 0x2::balance::Balance<T0>, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, true, 0x2::balance::value<T0>(&arg5), 0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::n::lm(true), arg3, arg4, arg6);
        0x2::balance::destroy_zero<T0>(v0);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg2, arg5, 0x2::balance::zero<T1>(), v2);
        v1
    }

    public fun sb<T0, T1>(arg0: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg1: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::rewarder::RewarderGlobalVault, arg2: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: &mut 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::stats::Stats, arg4: &0xb49be008cf304b1dae7e7ece661b5f1b0e15324bc1422ec8c73b10eb4a6dcb19::price_provider::PriceProvider, arg5: 0x2::balance::Balance<T1>, arg6: &0x2::clock::Clock) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::flash_swap<T0, T1>(arg0, arg1, arg2, false, true, 0x2::balance::value<T1>(&arg5), 0xf7b2b6161a8dae665177efc44d3f0fd3e0131b612237548fca7180097bb3da75::n::lm(false), arg3, arg4, arg6);
        0x2::balance::destroy_zero<T1>(v1);
        0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), arg5, v2);
        v0
    }

    public fun ta<T0, T1>(arg0: L<T0, T1>) : (L<T0, T1>, 0x2::balance::Balance<T0>) {
        let L {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = L<T0, T1>{
            a       : 0x2::balance::zero<T0>(),
            b       : v1,
            owed    : v2,
            receipt : v3,
        };
        (v4, v0)
    }

    public fun tb<T0, T1>(arg0: L<T0, T1>) : (L<T0, T1>, 0x2::balance::Balance<T1>) {
        let L {
            a       : v0,
            b       : v1,
            owed    : v2,
            receipt : v3,
        } = arg0;
        let v4 = L<T0, T1>{
            a       : v0,
            b       : 0x2::balance::zero<T1>(),
            owed    : v2,
            receipt : v3,
        };
        (v4, v1)
    }

    // decompiled from Move bytecode v7
}

