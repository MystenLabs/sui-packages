module 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::swap {
    public fun execute_swap<T0, T1>(arg0: &0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::AgentCap, arg1: &mut 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault, arg2: 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::SwapRequest, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::agent_cap_owner(arg0) == 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::swap_request_owner(&arg2), 0);
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::vault::deposit_internal<T1>(arg1, arg3);
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::destroy_swap_request(arg2);
    }

    public fun request_swap<T0, T1>(arg0: &mut 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: vector<u8>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg6);
        assert!(0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::vault_owner(arg0) == v0, 0);
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::vault::deposit_internal<T0>(arg0, 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::vault::withdraw_internal<T0>(arg0, arg1, arg6));
        0x2::transfer::public_transfer<0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::SwapRequest>(0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::new_swap_request(v0, arg1, arg2, arg3, arg4, arg5, arg6), v0);
        0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::events::emit_swap<T0, T1>(v0, arg1, arg5);
    }

    // decompiled from Move bytecode v7
}

