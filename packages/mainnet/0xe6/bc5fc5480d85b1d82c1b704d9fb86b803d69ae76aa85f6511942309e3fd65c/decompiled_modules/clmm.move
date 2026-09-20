module 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::clmm {
    public fun bluefin<T0, T1>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool) {
        0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_tick(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg1), arg2);
    }

    public fun cetus<T0, T1>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) {
        if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::is_pause<T0, T1>(arg1)) {
            0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_closed(arg0);
            return
        };
        0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_tick(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::liquidity<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    public fun ferra<T0, T1>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: bool) {
        if (0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::is_pause<T0, T1>(arg1)) {
            0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_closed(arg0);
            return
        };
        0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_tick(arg0, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::liquidity<T0, T1>(arg1), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_sqrt_price<T0, T1>(arg1), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    public fun fullsail<T0, T1>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: bool) {
        if (0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::is_pause<T0, T1>(arg1)) {
            0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_closed(arg0);
            return
        };
        0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_tick(arg0, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::liquidity<T0, T1>(arg1), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg1), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    public fun magma<T0, T1>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: bool) {
        if (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::is_pause<T0, T1>(arg1)) {
            0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_closed(arg0);
            return
        };
        0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_tick(arg0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg1), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    public fun momentum<T0, T1>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool) {
        0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_tick(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg1), arg2);
    }

    public fun suidex_v3<T0, T1>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: bool) {
        0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_tick(arg0, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::liquidity<T0, T1>(arg1), 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg1), 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::swap_fee_rate<T0, T1>(arg1), arg2);
    }

    public fun turbos<T0, T1, T2>(arg0: &mut 0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::Probe, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: bool) {
        if (!0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_unlocked<T0, T1, T2>(arg1)) {
            0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_closed(arg0);
            return
        };
        0xe6bc5fc5480d85b1d82c1b704d9fb86b803d69ae76aa85f6511942309e3fd65c::probe::fold_tick(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg1), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg1), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg1) as u64), arg2);
    }

    // decompiled from Move bytecode v7
}

