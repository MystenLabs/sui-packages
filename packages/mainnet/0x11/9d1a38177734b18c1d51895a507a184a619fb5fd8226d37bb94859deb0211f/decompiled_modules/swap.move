module 0x119d1a38177734b18c1d51895a507a184a619fb5fd8226d37bb94859deb0211f::swap {
    struct AToB has drop {
        dummy_field: bool,
    }

    struct BToA has drop {
        dummy_field: bool,
    }

    public fun configure_a_to_b<T0, T1>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = AToB{dummy_field: false};
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::configure_protected<T0, T1, AToB>(v0, arg0, arg1, arg2, arg3, arg4);
    }

    public fun configure_b_to_a<T0, T1>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T1>, arg1: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        let v0 = BToA{dummy_field: false};
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::configure_protected<T1, T0, BToA>(v0, arg0, arg1, arg2, arg3, arg4);
    }

    public fun execute_a_to_b<T0, T1>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T0>, arg1: 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::SpendRequest, arg2: u64, arg3: u64, arg4: u128, arg5: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::request_amount(&arg1);
        let v1 = AToB{dummy_field: false};
        let (v2, v3) = 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::confirm_protected<T0, T1, AToB>(v1, arg0, arg1, arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg7), arg3, arg5, arg8, arg9);
        let v4 = 0x2::coin::into_balance<T0>(v2);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg6, arg7, true, true, v0, arg4, arg8);
        let v8 = v7;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8);
        assert!(v9 <= v0, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg6, arg7, 0x2::balance::split<T0>(&mut v4, v9), 0x2::balance::zero<T1>(), v8);
        0x2::balance::join<T0>(&mut v4, v5);
        let v10 = AToB{dummy_field: false};
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::settle_protected<T0, T1, AToB>(v10, arg0, v3, 0x2::coin::from_balance<T1>(v6, arg9), 0x2::coin::from_balance<T0>(v4, arg9), arg9);
    }

    public fun execute_b_to_a<T0, T1>(arg0: &mut 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::AgentWallet<T1>, arg1: 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::SpendRequest, arg2: u64, arg3: u64, arg4: u128, arg5: &0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::version::Version, arg6: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg7: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::request_amount(&arg1);
        let v1 = BToA{dummy_field: false};
        let (v2, v3) = 0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::confirm_protected<T1, T0, BToA>(v1, arg0, arg1, arg2, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg7), arg3, arg5, arg8, arg9);
        let v4 = 0x2::coin::into_balance<T1>(v2);
        let (v5, v6, v7) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg6, arg7, false, true, v0, arg4, arg8);
        let v8 = v7;
        let v9 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v8);
        assert!(v9 <= v0, 0);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg6, arg7, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut v4, v9), v8);
        0x2::balance::join<T1>(&mut v4, v6);
        let v10 = BToA{dummy_field: false};
        0xb8b95f9b43381693c72e3b0b0bae9c52c392492f5a1ce49bbea3ca393b694429::agent_wallet::settle_protected<T1, T0, BToA>(v10, arg0, v3, 0x2::coin::from_balance<T0>(v5, arg9), 0x2::coin::from_balance<T1>(v4, arg9), arg9);
    }

    // decompiled from Move bytecode v7
}

