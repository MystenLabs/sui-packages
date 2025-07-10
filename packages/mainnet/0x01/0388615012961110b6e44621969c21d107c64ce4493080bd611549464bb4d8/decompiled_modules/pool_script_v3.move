module 0x10388615012961110b6e44621969c21d107c64ce4493080bd611549464bb4d8::pool_script_v3 {
    public entry fun collect_fee<T0, T1>(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T0, T1>, arg2: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::position::Position, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::collect_fee<T0, T1>(arg0, arg1, arg2, true);
        0x2::coin::join<T0>(arg3, 0x2::coin::from_balance<T0>(v0, arg5));
        0x2::coin::join<T1>(arg4, 0x2::coin::from_balance<T1>(v1, arg5));
    }

    public entry fun collect_reward<T0, T1, T2>(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T0, T1>, arg2: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::position::Position, arg3: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::RewarderGlobalVault, arg4: &mut 0x2::coin::Coin<T2>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<T2>(arg4, 0x2::coin::from_balance<T2>(0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::collect_reward<T0, T1, T2>(arg0, arg1, arg2, arg3, true, arg5), arg6));
    }

    public entry fun update_rewarder_emission<T0, T1, T2>(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::Pool<T0, T1>, arg2: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::RewarderGlobalVault, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::pool::update_emission<T0, T1, T2>(arg0, arg1, arg2, 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::full_math_u128::mul_div_floor((arg3 as u128), 18446744073709551616, (arg4 as u128)), arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

