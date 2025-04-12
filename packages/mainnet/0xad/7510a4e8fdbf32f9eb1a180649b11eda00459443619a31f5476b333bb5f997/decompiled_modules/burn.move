module 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::burn {
    struct ClaimCertificate<phantom T0> {
        balance: 0x2::balance::Balance<T0>,
        assets_count: u64,
        asset_collector: 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset_metadata_collector::AssetMetadataCollector<T0>,
        cursor: u64,
    }

    struct IndexBurned has copy, drop {
        total_value: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        index_price: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        amount: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        assets_metadata: vector<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>,
    }

    public fun burn<T0>(arg0: &0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: 0x2::coin::Coin<T0>) : ClaimCertificate<T0> {
        let v0 = 0x2::coin::into_balance<T0>(arg1);
        let v1 = ClaimCertificate<T0>{
            balance         : 0x2::balance::withdraw_all<T0>(&mut v0),
            assets_count    : 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::assets_count<T0>(arg0),
            asset_collector : 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset_metadata_collector::new<T0>(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::assets_count<T0>(arg0)),
            cursor          : 0,
        };
        0x2::balance::destroy_zero<T0>(v0);
        v1
    }

    public fun claim_with_pyth<T0, T1>(arg0: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: &mut ClaimCertificate<T0>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = *0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::metadata<T0>(arg0);
        let v1 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::asset_mut<T0, T1>(arg0, arg1.cursor);
        let (_, _) = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::refresh_asset_price_with_pyth<T0, T1>(v1, arg2, arg3, arg4);
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset_metadata_collector::add_asset_metadata<T0>(&mut arg1.asset_collector, *0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::data<T0, T1>(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::metadata<T0, T1>(v1)));
        arg1.cursor = arg1.cursor + 1;
        0x2::coin::from_balance<T1>(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::withdraw::withdraw<T0, T1>(v1, &arg1.balance, &v0, arg2, 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::burn_fee<T0>(arg0)), arg5)
    }

    public fun complete<T0>(arg0: ClaimCertificate<T0>, arg1: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = *0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::metadata<T0>(arg1);
        let v1 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata::price<T0>(&v0, arg2);
        let ClaimCertificate {
            balance         : v2,
            assets_count    : v3,
            asset_collector : v4,
            cursor          : v5,
        } = arg0;
        let v6 = v2;
        assert!(v3 == v5, 150);
        let v7 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64(0x2::balance::value<T0>(&v6), 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata::decimals<T0>(&v0));
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::burn_coin<T0>(arg1, 0x2::coin::from_balance<T0>(v6, arg3));
        let v8 = IndexBurned{
            total_value     : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::mul(v1, v7),
            index_price     : v1,
            amount          : v7,
            assets_metadata : 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset_metadata_collector::assets_metadata<T0>(&arg0.asset_collector),
        };
        0x2::event::emit<IndexBurned>(v8);
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::refresh_price<T0>(arg1, v4, arg2);
    }

    // decompiled from Move bytecode v6
}

