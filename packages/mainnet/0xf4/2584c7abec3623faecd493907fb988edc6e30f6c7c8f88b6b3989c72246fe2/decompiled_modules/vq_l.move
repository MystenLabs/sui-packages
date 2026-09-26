module 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::vq_l {
    fun bps_fee(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            ((((arg0 as u128) * (arg1 as u128) + 10000 - 1) / 10000) as u64)
        }
    }

    public fun la<T0: drop>(arg0: &mut 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::Ht, arg1: &0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>, arg2: &0x3::sui_system::SuiSystemState, arg3: bool) {
        let v0 = 0;
        while (v0 < 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::cn(arg0)) {
            let v1 = 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::ra(arg0, v0);
            if (v1 > 0) {
                let v2 = if (arg3) {
                    0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::sui_to_lst_mint_price<T0>(arg1, v1)
                } else {
                    0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::lst_to_sui_redemption_price<T0>(arg1, v1)
                };
                0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::sr(arg0, v0, v2);
            };
            v0 = v0 + 1;
        };
        0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::np(arg0, 0x2::object::id<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>>(arg1), arg3);
    }

    public fun ls<T0: drop>(arg0: &mut 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::Ht, arg1: &0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>, arg2: &0x3::sui_system::SuiSystemState, arg3: bool) {
        let v0 = (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T0>(arg1) as u128);
        let v1 = (0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T0>(arg1) as u128);
        let v2 = if (arg3) {
            0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::sui_mint_fee_bps(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::fee_config<T0>(arg1))
        } else {
            0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::redeem_fee_bps(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::fee_config<T0>(arg1))
        };
        let v3 = 0;
        while (v3 < 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::cn(arg0)) {
            let v4 = 0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::ra(arg0, v3);
            if (v4 > 0) {
                let v5 = if (arg3) {
                    if (v0 == 0 || v1 == 0) {
                        v4 - bps_fee(v4, v2)
                    } else {
                        ((v1 * ((v4 - bps_fee(v4, v2)) as u128) / v0) as u64)
                    }
                } else {
                    let v6 = ((v0 * (v4 as u128) / v1) as u64);
                    v6 - bps_fee(v6, v2)
                };
                0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::sr(arg0, v3, v5);
            };
            v3 = v3 + 1;
        };
        0xf42584c7abec3623faecd493907fb988edc6e30f6c7c8f88b6b3989c72246fe2::hz::np(arg0, 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T0>>(arg1), arg3);
    }

    // decompiled from Move bytecode v7
}

