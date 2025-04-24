module 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset_metadata_collector {
    struct AssetMetadataCollector<phantom T0> {
        assets_metadata: vector<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>,
        assets_count: u64,
        cursor: u64,
    }

    public fun add_asset_metadata<T0>(arg0: &mut AssetMetadataCollector<T0>, arg1: 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata) {
        assert!(!completed<T0>(arg0), 9223372191473598463);
        0x1::vector::push_back<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>(&mut arg0.assets_metadata, arg1);
        arg0.cursor = arg0.cursor + 1;
    }

    public(friend) fun assets_metadata<T0>(arg0: &AssetMetadataCollector<T0>) : vector<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata> {
        arg0.assets_metadata
    }

    public fun collect<T0, T1>(arg0: &mut AssetMetadataCollector<T0>, arg1: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1>) {
        assert!(!completed<T0>(arg0), 9223372152818892799);
        0x1::vector::push_back<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>(&mut arg0.assets_metadata, *0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::data<T0, T1>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::metadata<T0, T1>(arg1)));
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
            assets_metadata : 0x1::vector::empty<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>(),
            assets_count    : arg0,
            cursor          : 0,
        }
    }

    // decompiled from Move bytecode v6
}

