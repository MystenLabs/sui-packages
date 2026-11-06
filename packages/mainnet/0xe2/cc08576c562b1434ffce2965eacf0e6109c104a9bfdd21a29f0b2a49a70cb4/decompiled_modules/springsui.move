module 0xe2cc08576c562b1434ffce2965eacf0e6109c104a9bfdd21a29f0b2a49a70cb4::springsui {
    public fun mint<T0, T1: drop>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<0x2::sui::SUI>) {
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3) > 0, 1);
        let v0 = 0x2::coin::into_balance<T1>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::mint<T1>(arg1, arg2, 0x2::coin::from_balance<0x2::sui::SUI>(arg3, arg4), arg4));
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>>(arg1), true, 0x2::balance::value<T1>(&v0));
        (v0, 0x2::balance::zero<0x2::sui::SUI>())
    }

    public fun redeem<T0, T1: drop>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: 0x2::balance::Balance<T1>, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x2::sui::SUI>, 0x2::balance::Balance<T1>) {
        assert!(0x2::balance::value<T1>(&arg3) > 0, 1);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::redeem<T1>(arg1, 0x2::coin::from_balance<T1>(arg3, arg4), arg2, arg4));
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_leg<T0>(arg0, 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>>(arg1), false, 0x2::balance::value<0x2::sui::SUI>(&v0));
        (v0, 0x2::balance::zero<T1>())
    }

    fun fee(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            0
        } else {
            ((((arg0 as u128) * (arg1 as u128) + 9999) / 10000) as u64)
        }
    }

    fun mint_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg1 == 0 || arg2 == 0) {
            arg0 - fee(arg0, arg3)
        } else {
            (((arg2 as u128) * ((arg0 - fee(arg0, arg3)) as u128) / (arg1 as u128)) as u64)
        }
    }

    public fun quote<T0, T1>(arg0: &mut 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::Session<T0>, arg1: &mut 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::refresh<T1>(arg1, arg2, arg4);
        let v0 = if (arg3) {
            0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::sui_mint_fee_bps(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::fee_config<T1>(arg1))
        } else {
            0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::fees::redeem_fee_bps(0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::fee_config<T1>(arg1))
        };
        let v1 = vector[];
        let v2 = 0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::quote_inputs<T0>(arg0);
        0x1::vector::reverse<u64>(&mut v2);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&v2)) {
            let v4 = if (arg3) {
                mint_out(0x1::vector::pop_back<u64>(&mut v2), 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T1>(arg1), 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T1>(arg1), v0)
            } else {
                redeem_out(0x1::vector::pop_back<u64>(&mut v2), 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_sui_supply<T1>(arg1), 0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::total_lst_supply<T1>(arg1), v0)
            };
            0x1::vector::push_back<u64>(&mut v1, v4);
            v3 = v3 + 1;
        };
        0x1::vector::destroy_empty<u64>(v2);
        0x50073087118545d6414016ed2652566b783cfb5c35dcae7751165d087a74324::session::record_quote<T0>(arg0, 0x2::object::id<0xb0575765166030556a6eafd3b1b970eba8183ff748860680245b9edd41c716e7::liquid_staking::LiquidStakingInfo<T1>>(arg1), arg3, v1, vector[], vector[]);
    }

    fun redeem_out(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        if (arg2 == 0) {
            return 0
        };
        let v0 = (((arg1 as u128) * (arg0 as u128) / (arg2 as u128)) as u64);
        v0 - fee(v0, arg3)
    }

    // decompiled from Move bytecode v7
}

