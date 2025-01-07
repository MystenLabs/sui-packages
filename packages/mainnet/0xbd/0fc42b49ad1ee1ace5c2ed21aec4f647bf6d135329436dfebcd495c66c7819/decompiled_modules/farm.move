module 0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::farm {
    struct MangroveFarm<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        farm: 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::farm::Farm<T1>,
        farm_admin_cap: 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::farm::AdminCap,
        lp_treasury: 0x2::coin::TreasuryCap<T0>,
    }

    public fun new<T0, T1>(arg0: 0x2::coin::TreasuryCap<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::zero<T1>(arg1);
        let (v1, v2) = new_farm<T1>(v0, arg1);
        let v3 = MangroveFarm<T0, T1>{
            id             : 0x2::object::new(arg1),
            farm           : v1,
            farm_admin_cap : v2,
            lp_treasury    : arg0,
        };
        0x2::transfer::share_object<MangroveFarm<T0, T1>>(v3);
    }

    public fun collect_incentive_rewards<T0, T1>(arg0: &mut 0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::incentivized_vault::IncentivizedVault<T0, T1>, arg1: &mut MangroveFarm<T0, T1>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::incentivized_vault::collect_incentive_rewards<T0, T1>(arg0, &mut arg1.farm, arg2, arg3);
    }

    public fun create_incentivized_vault<T0, T1, T2>(arg0: &mut MangroveFarm<T0, T1>, arg1: 0x2::coin::Coin<T2>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::incentivized_vault::IncentivizedVault<T0, T1> {
        let v0 = 0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::incentivized_vault::new<T0, T1>(arg3);
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::incentivized_vault::deposit<T2, T0, T1>(&mut v0, arg1, arg3);
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::incentivized_vault::add_to_farm<T0, T1>(&mut v0, &mut arg0.farm, &arg0.farm_admin_cap, arg2);
        0xbd0fc42b49ad1ee1ace5c2ed21aec4f647bf6d135329436dfebcd495c66c7819::incentivized_vault::top_up<T0, T1>(&mut v0, &mut arg0.farm, 0x2::coin::into_balance<T0>(0x2::coin::mint<T0>(&mut arg0.lp_treasury, 0x2::coin::value<T2>(&arg1), arg3)), arg2, arg3);
        v0
    }

    public fun new_farm<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) : (0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::farm::Farm<T0>, 0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::farm::AdminCap) {
        0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::farm::create<T0>(0x2::coin::into_balance<T0>(arg0), 10, arg1)
    }

    public fun set_unlock_rate<T0, T1>(arg0: &mut MangroveFarm<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::farm::change_unlock_per_second<T1>(&arg0.farm_admin_cap, &mut arg0.farm, arg1, arg2);
    }

    public fun top_up_incentives<T0, T1>(arg0: &mut MangroveFarm<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0x2::clock::Clock) {
        0x4886096f232e823a0fe4eaf7a0f1ae06e03d660aeb1368dc669cbd1f1a2d5ef2::farm::top_up<T1>(&arg0.farm_admin_cap, &mut arg0.farm, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

