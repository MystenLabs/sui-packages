module 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset {
    struct Asset<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        vault: 0x87c95bf6bf9c82cecd125a55034cd460bb1e8c42b1e792c19ca349533fa7b8f1::vault::Vault<T1, T0>,
        metadata: 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::MetadataProvider<T0, T1>,
    }

    public fun new<T0, T1>(arg0: 0x87c95bf6bf9c82cecd125a55034cd460bb1e8c42b1e792c19ca349533fa7b8f1::vault::Vault<T1, T0>, arg1: 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::MetadataProvider<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : Asset<T0, T1> {
        Asset<T0, T1>{
            id       : 0x2::object::new(arg2),
            vault    : arg0,
            metadata : arg1,
        }
    }

    public(friend) fun vault<T0, T1>(arg0: &Asset<T0, T1>) : &0x87c95bf6bf9c82cecd125a55034cd460bb1e8c42b1e792c19ca349533fa7b8f1::vault::Vault<T1, T0> {
        &arg0.vault
    }

    public(friend) fun refresh_nav_only<T0, T1>(arg0: &mut Asset<T0, T1>, arg1: &0x2::clock::Clock) : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal {
        0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::refresh_nav_only<T0, T1>(&mut arg0.metadata, &arg0.vault, arg1)
    }

    public fun metadata<T0, T1>(arg0: &Asset<T0, T1>) : &0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::MetadataProvider<T0, T1> {
        &arg0.metadata
    }

    public(friend) fun metadata_mut<T0, T1>(arg0: &mut Asset<T0, T1>) : &mut 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::MetadataProvider<T0, T1> {
        &mut arg0.metadata
    }

    public fun refresh_asset_price_with_pyth<T0, T1>(arg0: &mut Asset<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal, u8) {
        0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::refresh_with_pyth<T0, T1>(&mut arg0.metadata, &arg0.vault, arg1, arg2, arg3)
    }

    public(friend) fun vault_mut<T0, T1>(arg0: &mut Asset<T0, T1>) : &mut 0x87c95bf6bf9c82cecd125a55034cd460bb1e8c42b1e792c19ca349533fa7b8f1::vault::Vault<T1, T0> {
        &mut arg0.vault
    }

    // decompiled from Move bytecode v6
}

