module 0x938206cfaf61ac880aea76a6c82c75db07f4fdcc6d1391a88eeda6dfef10acbf::farm_utils {
    public fun add_reward<T0>(arg0: &mut 0xb554009beec31a2000ef31e38ca5ac3a248a4f0c9df131f35f9c0e4cf9745f88::interest_farm::InterestFarm<T0>, arg1: &0x2::clock::Clock, arg2: 0x2::coin::Coin<T0>) {
        0xb554009beec31a2000ef31e38ca5ac3a248a4f0c9df131f35f9c0e4cf9745f88::interest_farm::add_reward<T0, T0>(arg0, arg1, arg2);
    }

    public fun harvest<T0>(arg0: &mut 0xb554009beec31a2000ef31e38ca5ac3a248a4f0c9df131f35f9c0e4cf9745f88::interest_farm::InterestFarmAccount<T0>, arg1: &mut 0xb554009beec31a2000ef31e38ca5ac3a248a4f0c9df131f35f9c0e4cf9745f88::interest_farm::InterestFarm<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xb554009beec31a2000ef31e38ca5ac3a248a4f0c9df131f35f9c0e4cf9745f88::interest_farm::harvest<T0, T0>(arg0, arg1, arg2, arg3)
    }

    public fun set_end_time<T0, T1>(arg0: &mut 0xb554009beec31a2000ef31e38ca5ac3a248a4f0c9df131f35f9c0e4cf9745f88::interest_farm::InterestFarm<T0>, arg1: &0x2::clock::Clock, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<T1>, arg3: u64) {
        0xb554009beec31a2000ef31e38ca5ac3a248a4f0c9df131f35f9c0e4cf9745f88::interest_farm::set_end_time<T0, T0, T1>(arg0, arg1, arg2, arg3);
    }

    public fun set_rewards_per_second<T0, T1>(arg0: &mut 0xb554009beec31a2000ef31e38ca5ac3a248a4f0c9df131f35f9c0e4cf9745f88::interest_farm::InterestFarm<T0>, arg1: &0x2::clock::Clock, arg2: &0xb877fe150db8e9af55c399b4e49ba8afe658bd05317cb378c940344851125e9a::access_control::AdminWitness<T1>, arg3: u64) {
        0xb554009beec31a2000ef31e38ca5ac3a248a4f0c9df131f35f9c0e4cf9745f88::interest_farm::set_rewards_per_second<T0, T0, T1>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

