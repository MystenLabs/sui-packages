module 0xfa458cad5cf076b46d1e3088bb5661e43b95f081b050281a2312e75dc84fab0f::ma28e2911293d9308a821a43c {
    public fun f238b9dd9bd1b5aa53c28100c<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: &mut 0x2::balance::Balance<T0>, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::mint_shares_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    public fun fe10d3d2f940a0aeb48e35a93<T0, T1>(arg0: &mut 0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::Vault<T0, T1>, arg1: &0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::admin::ProtocolConfig, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xc83d5406fd355f34d3ce87b35ab2c0b099af9d309ba96c17e40309502a49976f::vault::deposit_asset_v2<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5)
    }

    // decompiled from Move bytecode v7
}

