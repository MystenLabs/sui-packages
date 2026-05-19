module 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::cetus_adapter {
    public fun swap_a2b<T0, T1>(arg0: &0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::AgentCap, arg1: &mut 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault, arg2: address, arg3: 0x2::coin::Coin<T0>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::agent_cap_owner(arg0) == 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::vault_owner(arg1), 0);
        let v0 = 0x2::coin::zero<T1>(arg6);
        assert!(0x2::coin::value<T1>(&v0) >= arg4, 1);
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::vault::deposit_internal<T1>(arg1, v0);
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::events::emit_swap<T0, T1>(0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::vault::vault_owner(arg1), 0x2::coin::value<T0>(&arg3), b"cetus_swap_a2b");
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg6));
    }

    public fun swap_b2a<T0, T1>(arg0: &0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::AgentCap, arg1: &mut 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault, arg2: address, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::agent_cap_owner(arg0) == 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::vault_owner(arg1), 0);
        let v0 = 0x2::coin::zero<T0>(arg6);
        assert!(0x2::coin::value<T0>(&v0) >= arg4, 1);
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::vault::deposit_internal<T0>(arg1, v0);
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::events::emit_swap<T1, T0>(0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::vault::vault_owner(arg1), 0x2::coin::value<T1>(&arg3), b"cetus_swap_b2a");
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg3, 0x2::tx_context::sender(arg6));
    }

    // decompiled from Move bytecode v7
}

