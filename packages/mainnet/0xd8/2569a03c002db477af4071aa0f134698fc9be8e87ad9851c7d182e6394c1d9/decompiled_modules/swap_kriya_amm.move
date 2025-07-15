module 0xd82569a03c002db477af4071aa0f134698fc9be8e87ad9851c7d182e6394c1d9::swap_kriya_amm {
    public fun swap_a2b<T0, T1, T2, T3>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &0xd82569a03c002db477af4071aa0f134698fc9be8e87ad9851c7d182e6394c1d9::swap_transaction::SwapTransaction<T2, T3>, arg3: &0xd82569a03c002db477af4071aa0f134698fc9be8e87ad9851c7d182e6394c1d9::state::State, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::coin::value<T0>(&arg1);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T0, T1>(arg0, arg1, v0, 0, arg4);
        let v2 = 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0);
        0xd82569a03c002db477af4071aa0f134698fc9be8e87ad9851c7d182e6394c1d9::swap_event::emit_common_swap<T0, T1>(0xd82569a03c002db477af4071aa0f134698fc9be8e87ad9851c7d182e6394c1d9::consts::DEX_KRIYA(), 0x2::object::id_to_address(&v2), true, v0, 0x2::coin::value<T1>(&v1), true);
        v1
    }

    public fun swap_b2a<T0, T1, T2, T3>(arg0: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>, arg1: 0x2::coin::Coin<T1>, arg2: &0xd82569a03c002db477af4071aa0f134698fc9be8e87ad9851c7d182e6394c1d9::swap_transaction::SwapTransaction<T2, T3>, arg3: &0xd82569a03c002db477af4071aa0f134698fc9be8e87ad9851c7d182e6394c1d9::state::State, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0x2::coin::value<T1>(&arg1);
        let v1 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T0, T1>(arg0, arg1, v0, 0, arg4);
        let v2 = 0x2::object::id<0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T0, T1>>(arg0);
        0xd82569a03c002db477af4071aa0f134698fc9be8e87ad9851c7d182e6394c1d9::swap_event::emit_common_swap<T0, T1>(0xd82569a03c002db477af4071aa0f134698fc9be8e87ad9851c7d182e6394c1d9::consts::DEX_KRIYA(), 0x2::object::id_to_address(&v2), false, v0, 0x2::coin::value<T0>(&v1), true);
        v1
    }

    // decompiled from Move bytecode v6
}

