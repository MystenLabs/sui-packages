module 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::deposit {
    struct DepositReceipt {
        index_id: address,
        value: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        desired_value: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        amount: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        fee_applied: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        metadata: 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata,
    }

    struct PredepositEvent has copy, drop {
        desired_value: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        amount_to_cover_payment: u64,
        asset_allocation: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        payment_amount: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
    }

    public(friend) fun value(arg0: &DepositReceipt) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        arg0.value
    }

    public(friend) fun metadata(arg0: &DepositReceipt) : 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata {
        arg0.metadata
    }

    public(friend) fun deposit<T0, T1>(arg0: &0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata::IndexMetadata<T0>, arg1: &mut 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::Asset<T0, T1>, arg2: u64, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal, arg6: &mut 0x2::tx_context::TxContext) : (DepositReceipt, 0x2::coin::Coin<T1>) {
        let v0 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata::mint_access<T0>(arg0) == 1 || 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata::mint_access<T0>(arg0) == 2;
        let v1 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64(arg2, 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::price_decimals(0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::data<T0, T1>(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::metadata<T0, T1>(arg1))));
        let v2 = *0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::data<T0, T1>(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::metadata<T0, T1>(arg1));
        let v3 = 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::price(&v2, arg4);
        let (v4, v5) = if (v0) {
            let v6 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::to_u64(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::div(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::mul(v1, 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::allocation(&v2, 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata::nav<T0>(arg0, arg4))), v3), 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::decimals(&v2));
            assert!(0x2::coin::value<T1>(&arg3) >= v6, 170);
            let v7 = 0x2::coin::into_balance<T1>(arg3);
            0x2::balance::destroy_zero<T1>(v7);
            (0x2::balance::split<T1>(&mut v7, v6), 0x2::balance::split<T1>(&mut v7, 0x2::balance::value<T1>(&v7) - v6))
        } else {
            (0x2::coin::into_balance<T1>(arg3), 0x2::balance::zero<T1>())
        };
        let (v8, v9) = 0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::vault::deposit_with_fees<T1, T0>(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::vault_mut<T0, T1>(arg1), v4, arg5, arg4);
        let v10 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64(v8, 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::decimals(&v2));
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::refresh_nav_only<T0, T1>(arg1, arg4);
        let v11 = DepositReceipt{
            index_id      : 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata::index_id<T0>(arg0),
            value         : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::mul(v10, v3),
            desired_value : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::sub(v1, 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::mul(v1, v9)),
            amount        : v10,
            fee_applied   : arg5,
            metadata      : *0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::data<T0, T1>(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::metadata<T0, T1>(arg1)),
        };
        (v11, 0x2::coin::from_balance<T1>(v5, arg6))
    }

    public(friend) fun amount(arg0: &DepositReceipt) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        arg0.amount
    }

    public(friend) fun desired_value(arg0: &DepositReceipt) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        arg0.desired_value
    }

    public(friend) fun destroy(arg0: DepositReceipt) {
        let DepositReceipt {
            index_id      : _,
            value         : _,
            desired_value : _,
            amount        : _,
            fee_applied   : _,
            metadata      : _,
        } = arg0;
    }

    public(friend) fun index_id(arg0: &DepositReceipt) : address {
        arg0.index_id
    }

    public(friend) fun pre_deposit<T0, T1>(arg0: &0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata::IndexMetadata<T0>, arg1: &0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::Asset<T0, T1>, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64(arg2, 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::price_decimals(0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::data<T0, T1>(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::metadata<T0, T1>(arg1))));
        let v1 = *0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::data<T0, T1>(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset::metadata<T0, T1>(arg1));
        let v2 = 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::allocation(&v1, 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata::nav<T0>(arg0, arg3));
        let v3 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::mul(v0, v2);
        let v4 = PredepositEvent{
            desired_value           : v0,
            amount_to_cover_payment : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::to_u64(0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::div(v3, 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::price(&v1, arg3)), 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::decimals(&v1)),
            asset_allocation        : v2,
            payment_amount          : v3,
        };
        0x2::event::emit<PredepositEvent>(v4);
    }

    // decompiled from Move bytecode v6
}

