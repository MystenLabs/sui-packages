module 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::mint {
    struct MintCertificate<phantom T0> {
        total_value: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        assets_metadata: vector<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>,
    }

    struct IndexMinted has copy, drop {
        total_value: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        index_price: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        amount: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        assets_metadata: vector<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>,
    }

    struct MintDiscountBadge<phantom T0> has store, key {
        id: 0x2::object::UID,
        percentage: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        exp_ts_seconds: u64,
    }

    public fun open_mint_public<T0>(arg0: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: MintCertificate<T0>, arg2: &0x2::clock::Clock, arg3: &0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::app::AdminCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::open_mint_public<T0>(arg0);
        mint_internal<T0>(arg0, arg1, arg2, arg4)
    }

    public fun open_mint_whitelist_only<T0>(arg0: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: MintCertificate<T0>, arg2: &0x2::clock::Clock, arg3: &0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::app::AdminCap, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::open_mint_whitelist_only<T0>(arg0);
        mint_internal<T0>(arg0, arg1, arg2, arg4)
    }

    public fun mint<T0>(arg0: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: MintCertificate<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::assert_mint_is_public<T0>(arg0);
        mint_internal<T0>(arg0, arg1, arg2, arg3)
    }

    public fun check_allocation_coverage<T0>(arg0: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: vector<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>, arg2: &0x2::clock::Clock, arg3: &0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::app::AdminCap) : MintCertificate<T0> {
        assert!(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::assets_count<T0>(arg0) == 0x1::vector::length<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(&arg1), 9223372870078431231);
        assert!(0x2::clock::timestamp_ms(arg2) - 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata::last_update<T0>(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::metadata<T0>(arg0)) < 10, 9223372874373398527);
        let v0 = 0;
        let v1 = 0;
        let v2 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::desired_value(0x1::vector::borrow<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(&arg1, 0));
        while (v0 < 0x1::vector::length<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(&arg1)) {
            let v3 = 0x1::vector::borrow<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(&arg1, v0);
            v1 = v1 + 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::to_u64(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::div(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::value(v3), v2), 4);
            assert!(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::eq(v2, 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::desired_value(v3)), 143);
            v0 = v0 + 1;
        };
        assert!(v1 >= 10000, 141);
        let v4 = 0x1::vector::empty<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>();
        0x1::vector::reverse<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(&mut arg1);
        let v5 = 0;
        while (v5 < 0x1::vector::length<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(&arg1)) {
            let v6 = 0x1::vector::pop_back<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(&mut arg1);
            0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::destroy(v6);
            0x1::vector::push_back<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>(&mut v4, 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::metadata(&v6));
            v5 = v5 + 1;
        };
        0x1::vector::destroy_empty<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(arg1);
        MintCertificate<T0>{
            total_value     : v2,
            assets_metadata : v4,
        }
    }

    public fun claim_mint_certificate<T0>(arg0: &0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: vector<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>) : MintCertificate<T0> {
        let v0 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::zero();
        let v1 = 0x1::vector::empty<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>();
        0x1::vector::reverse<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(&mut arg1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(&arg1)) {
            let v3 = &mut v1;
            let v4 = 0x1::vector::pop_back<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(&mut arg1);
            let v5 = 0x2::object::id<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>>(arg0);
            assert!(0x2::object::id_to_address(&v5) == 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::index_id(&v4), 142);
            assert!(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::eq(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::desired_value(0x1::vector::borrow<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(&arg1, 0)), 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::desired_value(&v4)), 143);
            v0 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::add(v0, 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::value(&v4));
            0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::destroy(v4);
            0x1::vector::push_back<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>(v3, 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::metadata(&v4));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt>(arg1);
        MintCertificate<T0>{
            total_value     : v0,
            assets_metadata : v1,
        }
    }

    fun deposit_internal<T0, T1>(arg0: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x2::tx_context::TxContext) : (0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt, 0x2::coin::Coin<T1>) {
        let v0 = *0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::metadata<T0>(arg0);
        let v1 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::asset_mut<T0, T1>(arg0, arg1);
        let (_, _) = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::refresh_asset_price_with_pyth<T0, T1>(v1, arg4, arg6, arg7);
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::deposit<T0, T1>(&v0, v1, arg2, arg3, arg4, arg5, arg8)
    }

    public fun deposit_with_pyth<T0, T1>(arg0: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg6: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg7: &mut 0x2::tx_context::TxContext) : (0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt, 0x2::coin::Coin<T1>) {
        let v0 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::mint_fee<T0>(arg0);
        deposit_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, v0, arg5, arg6, arg7)
    }

    public fun deposit_with_pyth_with_discount<T0, T1>(arg0: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: u64, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg6: &MintDiscountBadge<T0>, arg7: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg8: &mut 0x2::tx_context::TxContext) : (0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::DepositReceipt, 0x2::coin::Coin<T1>) {
        assert!(arg6.exp_ts_seconds > 0x2::clock::timestamp_ms(arg4) / 1000, 144);
        let v0 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::mint_fee<T0>(arg0);
        deposit_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::sub(v0, 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::mul(v0, arg6.percentage)), arg5, arg7, arg8)
    }

    public fun mint_discount_badge<T0>(arg0: &0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: &0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::app::AdminCap, arg2: u64, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : MintDiscountBadge<T0> {
        MintDiscountBadge<T0>{
            id             : 0x2::object::new(arg4),
            percentage     : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_percentage(arg3),
            exp_ts_seconds : arg2,
        }
    }

    fun mint_internal<T0>(arg0: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: MintCertificate<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let MintCertificate {
            total_value     : v0,
            assets_metadata : v1,
        } = arg1;
        let v2 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::metadata<T0>(arg0);
        let v3 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata::price<T0>(v2, arg2);
        let v4 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::div(v0, v3);
        let v5 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::mint_coin<T0>(arg0, 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::to_u64(v4, 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata::decimals<T0>(v2)), arg3);
        let v6 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset_metadata_collector::new<T0>(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::assets_count<T0>(arg0));
        let v7 = v1;
        0x1::vector::reverse<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>(&mut v7);
        let v8 = 0;
        while (v8 < 0x1::vector::length<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>(&v7)) {
            0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset_metadata_collector::add_asset_metadata<T0>(&mut v6, 0x1::vector::pop_back<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>(&mut v7));
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>(v7);
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::refresh_price<T0>(arg0, v6, arg2);
        let v9 = IndexMinted{
            total_value     : v0,
            index_price     : v3,
            amount          : v4,
            assets_metadata : v1,
        };
        0x2::event::emit<IndexMinted>(v9);
        v5
    }

    public fun mint_whitelist<T0>(arg0: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: MintCertificate<T0>, arg2: &0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::whitelist::WhitelistCertificate<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::assert_mint_is_open<T0>(arg0);
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::whitelist::assert_expiration<T0>(arg2, arg3);
        mint_internal<T0>(arg0, arg1, arg3, arg4)
    }

    fun pre_deposit_internal<T0, T1>(arg0: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        let v0 = *0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::metadata<T0>(arg0);
        let v1 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::asset_mut<T0, T1>(arg0, arg1);
        let (_, _) = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::refresh_asset_price_with_pyth<T0, T1>(v1, arg3, arg4, arg5);
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit::pre_deposit<T0, T1>(&v0, v1, arg2, arg3);
    }

    public fun pre_deposit_with_pyth<T0, T1>(arg0: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index::Index<T0>, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        pre_deposit_internal<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    // decompiled from Move bytecode v6
}

