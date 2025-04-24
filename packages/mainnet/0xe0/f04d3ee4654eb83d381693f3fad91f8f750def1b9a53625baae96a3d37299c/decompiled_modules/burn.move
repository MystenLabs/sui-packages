module 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::burn {
    struct ClaimCertificate<phantom T0> {
        balance: 0x2::balance::Balance<T0>,
        assets_count: u64,
        asset_collector: 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset_metadata_collector::AssetMetadataCollector<T0>,
        cursor: u64,
    }

    struct IndexBurned has copy, drop {
        total_value: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        index_price: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        amount: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        assets_metadata: vector<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>,
    }

    struct PreBurned has copy, drop {
        total_value: 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal,
        amounts: vector<u64>,
    }

    public fun burn<T0>(arg0: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: 0x2::coin::Coin<T0>) : ClaimCertificate<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = ClaimCertificate<T0>{
            balance         : 0x2::balance::withdraw_all<T0>(&mut v0),
            assets_count    : 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::assets_count<T0>(arg0),
            asset_collector : 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset_metadata_collector::new<T0>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::assets_count<T0>(arg0)),
            cursor          : 0,
        };
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    public fun claim_with_pyth<T0, T1>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: &mut ClaimCertificate<T0>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = *0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::metadata<T0>(arg0);
        let v1 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::asset_mut<T0, T1>(arg0, arg1.cursor);
        let (_, _) = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::refresh_asset_price_with_pyth<T0, T1>(v1, arg2, arg3, arg4);
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset_metadata_collector::add_asset_metadata<T0>(&mut arg1.asset_collector, *0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::data<T0, T1>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::metadata<T0, T1>(v1)));
        arg1.cursor = arg1.cursor + 1;
        0x2::coin::from_balance<T1>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::withdraw::withdraw<T0, T1>(v1, &arg1.balance, &v0, arg2, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::burn_fee<T0>(arg0)), arg5)
    }

    public fun complete<T0>(arg0: ClaimCertificate<T0>, arg1: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = *0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::metadata<T0>(arg1);
        let v1 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::price<T0>(&v0, arg2);
        let ClaimCertificate {
            balance         : v2,
            assets_count    : v3,
            asset_collector : v4,
            cursor          : v5,
        } = arg0;
        let v6 = v2;
        assert!(v3 == v5, 150);
        let v7 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_u64(0x2::balance::value<T0>(&v6), 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::decimals<T0>(&v0));
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::burn_coin<T0>(arg1, 0x2::coin::from_balance<T0>(v6, arg3));
        let v8 = IndexBurned{
            total_value     : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(v1, v7),
            index_price     : v1,
            amount          : v7,
            assets_metadata : 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset_metadata_collector::assets_metadata<T0>(&arg0.asset_collector),
        };
        0x2::event::emit<IndexBurned>(v8);
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::refresh_price<T0>(arg1, v4, arg2);
    }

    public fun pre_burn<T0>(arg0: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::Index<T0>, arg1: vector<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>, arg2: u64, arg3: &0x2::clock::Clock) : vector<u64> {
        let v0 = 0;
        let v1 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index::metadata<T0>(arg0);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_u64(arg2, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::decimals<T0>(v1));
        while (v0 < 0x1::vector::length<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>(&arg1)) {
            let v4 = 0x1::vector::borrow<0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata>(&arg1, v0);
            let v5 = 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul_div(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(v3, 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::allocation(v4, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::nav<T0>(v1, arg3))), 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::price<T0>(v1, arg3), 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::price(v4, arg3));
            0x1::vector::push_back<u64>(&mut v2, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::to_u64(0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::sub(v5, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(v5, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::burn_fee<T0>(v1))), 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::decimals(v4)));
            v0 = v0 + 1;
        };
        let v6 = PreBurned{
            total_value : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::mul(v3, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::price<T0>(v1, arg3)),
            amounts     : v2,
        };
        0x2::event::emit<PreBurned>(v6);
        v2
    }

    // decompiled from Move bytecode v6
}

