module 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset_metadata_collector {
    struct AssetMetadataCollector<phantom T0> {
        assets_metadata: vector<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>,
        assets_count: u64,
        cursor: u64,
    }

    public fun add_asset_metadata<T0>(arg0: &mut AssetMetadataCollector<T0>, arg1: 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata) {
        assert!(!completed<T0>(arg0), 9223372191473598463);
        0x1::vector::push_back<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>(&mut arg0.assets_metadata, arg1);
        arg0.cursor = arg0.cursor + 1;
    }

    public(friend) fun assets_metadata<T0>(arg0: &AssetMetadataCollector<T0>) : vector<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata> {
        arg0.assets_metadata
    }

    public fun collect<T0, T1>(arg0: &mut AssetMetadataCollector<T0>, arg1: &0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::Asset<T0, T1>) {
        assert!(!completed<T0>(arg0), 9223372152818892799);
        0x1::vector::push_back<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>(&mut arg0.assets_metadata, *0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::data<T0, T1>(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::metadata<T0, T1>(arg1)));
        arg0.cursor = arg0.cursor + 1;
    }

    public(friend) fun completed<T0>(arg0: &AssetMetadataCollector<T0>) : bool {
        arg0.cursor == arg0.assets_count
    }

    public(friend) fun destroy<T0>(arg0: AssetMetadataCollector<T0>) {
        let AssetMetadataCollector {
            assets_metadata : _,
            assets_count    : _,
            cursor          : _,
        } = arg0;
    }

    public fun new<T0>(arg0: u64) : AssetMetadataCollector<T0> {
        AssetMetadataCollector<T0>{
            assets_metadata : 0x1::vector::empty<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>(),
            assets_count    : arg0,
            cursor          : 0,
        }
    }

    // decompiled from Move bytecode v6
}

