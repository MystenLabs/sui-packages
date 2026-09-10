module 0x3c2523b988f7d1ab9c919708c32aa74e5ba3d9cb84582599acabd80f50228111::reader {
    public fun current<T0>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>) : (u64, u64, u64, u64, bool) {
        let v0 = 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::fee_config<T0>(arg0);
        (0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_sui_supply<T0>(arg0), 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::total_lst_supply<T0>(arg0), 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::sui_mint_fee_bps(v0), 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::fees::redeem_fee_bps(v0), 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::is_paused<T0>(arg0))
    }

    public fun pool_bcs<T0>(arg0: &mut 0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>) : vector<u8> {
        0x1::bcs::to_bytes<0xc35ee7fee75782806890cf8ed8536b52b4ba0ace0fb46b944f1155cc5945baa3::liquid_staking::LiquidStakingInfo<T0>>(arg0)
    }

    // decompiled from Move bytecode v7
}

