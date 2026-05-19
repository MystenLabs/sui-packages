module 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::deepbook_adapter {
    public fun cancel_order<T0, T1>(arg0: &0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::AgentCap, arg1: &mut 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::agent_cap_owner(arg0) == 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::vault_owner(arg1), 0);
    }

    public fun place_limit_order<T0, T1>(arg0: &0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::AgentCap, arg1: &mut 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::Vault, arg2: address, arg3: bool, arg4: u64, arg5: u64, arg6: u64, arg7: 0x2::coin::Coin<T1>, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::agent_cap_owner(arg0) == 0xd675dd0004fcef1d3c57115d11ecc87a11d8f3d0cc7af77b6fb003117452ce6::types::vault_owner(arg1), 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(arg7, 0x2::tx_context::sender(arg8));
    }

    // decompiled from Move bytecode v7
}

