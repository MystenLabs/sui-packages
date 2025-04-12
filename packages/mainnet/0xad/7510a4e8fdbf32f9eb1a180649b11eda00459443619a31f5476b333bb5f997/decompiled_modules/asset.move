module 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset {
    struct Asset<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        vault: 0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::vault::Vault<T1, T0>,
        metadata: 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::MetadataProvider<T0, T1>,
    }

    public fun new<T0, T1>(arg0: 0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::vault::Vault<T1, T0>, arg1: 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::MetadataProvider<T0, T1>, arg2: &mut 0x2::tx_context::TxContext) : Asset<T0, T1> {
        Asset<T0, T1>{
            id       : 0x2::object::new(arg2),
            vault    : arg0,
            metadata : arg1,
        }
    }

    public(friend) fun vault<T0, T1>(arg0: &Asset<T0, T1>) : &0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::vault::Vault<T1, T0> {
        &arg0.vault
    }

    public fun metadata<T0, T1>(arg0: &Asset<T0, T1>) : &0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::MetadataProvider<T0, T1> {
        &arg0.metadata
    }

    public(friend) fun metadata_mut<T0, T1>(arg0: &mut Asset<T0, T1>) : &mut 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::MetadataProvider<T0, T1> {
        &mut arg0.metadata
    }

    public fun refresh_asset_price_with_pyth<T0, T1>(arg0: &mut Asset<T0, T1>, arg1: &0x2::clock::Clock, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal, u8) {
        0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::refresh_with_pyth<T0, T1>(&mut arg0.metadata, &arg0.vault, arg1, arg2, arg3)
    }

    public(friend) fun refresh_nav_only<T0, T1>(arg0: &mut Asset<T0, T1>, arg1: &0x2::clock::Clock) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::refresh_nav_only<T0, T1>(&mut arg0.metadata, &arg0.vault, arg1)
    }

    public(friend) fun vault_mut<T0, T1>(arg0: &mut Asset<T0, T1>) : &mut 0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::vault::Vault<T1, T0> {
        &mut arg0.vault
    }

    // decompiled from Move bytecode v6
}

