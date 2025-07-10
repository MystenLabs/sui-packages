module 0x10388615012961110b6e44621969c21d107c64ce4493080bd611549464bb4d8::pool_creator_v2 {
    fun build_init_position_arg<T0, T1>(arg0: u128, arg1: u32, arg2: u32, arg3: &mut 0x2::coin::Coin<T0>, arg4: &mut 0x2::coin::Coin<T1>, arg5: bool, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let v0 = 0x2::coin::value<T0>(arg3);
        let v1 = 0x2::coin::value<T1>(arg4);
        let v2 = if (arg5) {
            v0
        } else {
            v1
        };
        let (_, v4, v5) = 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::clmm_math::get_liquidity_by_amount(0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::i32::from_u32(arg1), 0x4e212a95eb24d6273e334bf3460f675acd9e371691c4c824bc895e056fc4bae0::i32::from_u32(arg2), 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::tick_math::get_tick_at_sqrt_price(arg0), arg0, v2, arg5);
        assert!(v4 <= v0, 1);
        assert!(v5 <= v1, 1);
        (0x2::coin::split<T0>(arg3, v4, arg6), 0x2::coin::split<T1>(arg4, v5, arg6))
    }

    public entry fun create_pool_v2<T0, T1>(arg0: &0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::config::GlobalConfig, arg1: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::rewarder::RewarderGlobalVault, arg2: &mut 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::factory::Pools, arg3: u32, arg4: u128, arg5: 0x1::string::String, arg6: u32, arg7: u32, arg8: &mut 0x2::coin::Coin<T0>, arg9: &mut 0x2::coin::Coin<T1>, arg10: &0x2::coin::CoinMetadata<T0>, arg11: &0x2::coin::CoinMetadata<T1>, arg12: bool, arg13: address, arg14: address, arg15: bool, arg16: &0x2::clock::Clock, arg17: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = build_init_position_arg<T0, T1>(arg4, arg6, arg7, arg8, arg9, arg12, arg17);
        let v2 = v1;
        let v3 = v0;
        let (v4, v5, v6) = 0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::factory::create_pool_with_liquidity<T0, T1>(arg2, arg0, arg1, arg3, arg4, arg5, arg6, arg7, v3, v2, 0x2::coin::value<T0>(&v3), 0x2::coin::value<T1>(&v2), arg12, arg13, arg14, arg15, arg16, arg17);
        0x2::coin::destroy_zero<T0>(v5);
        0x2::coin::destroy_zero<T1>(v6);
        0x2::transfer::public_transfer<0x91657507890f065ad5ac9ad5f585ad54cce127f51d893ada7a18fa331a88af3c::position::Position>(v4, 0x2::tx_context::sender(arg17));
    }

    // decompiled from Move bytecode v6
}

