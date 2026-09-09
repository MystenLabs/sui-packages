module 0x807dd1660c8c04f6f06b1c4f9abc045f3bfd2d1a46f6092c5e78149e751e2fb3::m1cd3c508c7c0ce6a8091da74 {
    public fun f88adcb5043ec8ee4fba42835<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::deposit_asset_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    public fun ffb71464f8c74109c269c0812<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::mint_shares_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

