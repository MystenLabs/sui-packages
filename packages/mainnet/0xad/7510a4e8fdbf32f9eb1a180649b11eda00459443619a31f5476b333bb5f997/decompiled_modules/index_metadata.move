module 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::index_metadata {
    struct IndexMetadata<phantom T0> has copy, drop, store {
        price: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        decimals: u8,
        price_decimals: u8,
        index_coin_metadata: address,
        last_update: u64,
        index_id: address,
        nav: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        name: 0x1::string::String,
        description: 0x1::string::String,
        strategy: u64,
        frozen: bool,
        mint_fee: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        burn_fee: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        mint_access: u8,
        assets_count: u64,
        initial_price: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
    }

    public fun decimals<T0>(arg0: &IndexMetadata<T0>) : u8 {
        arg0.decimals
    }

    fun assert_data_expiration<T0>(arg0: &IndexMetadata<T0>, arg1: &0x2::clock::Clock) {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.last_update < 2000, 130);
    }

    public(friend) fun assets_count<T0>(arg0: &IndexMetadata<T0>) : u64 {
        arg0.assets_count
    }

    public(friend) fun burn_fee<T0>(arg0: &IndexMetadata<T0>) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        arg0.burn_fee
    }

    public(friend) fun freeze_index<T0>(arg0: &mut IndexMetadata<T0>) {
        arg0.frozen = true;
    }

    public(friend) fun frozen<T0>(arg0: &IndexMetadata<T0>) : bool {
        arg0.frozen
    }

    public(friend) fun increment_assets_count<T0>(arg0: &mut IndexMetadata<T0>) {
        arg0.assets_count = arg0.assets_count + 1;
    }

    public(friend) fun index_id<T0>(arg0: &IndexMetadata<T0>) : address {
        arg0.index_id
    }

    public fun last_update<T0>(arg0: &IndexMetadata<T0>) : u64 {
        arg0.last_update
    }

    public(friend) fun mint_access<T0>(arg0: &IndexMetadata<T0>) : u8 {
        arg0.mint_access
    }

    public(friend) fun mint_fee<T0>(arg0: &IndexMetadata<T0>) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        arg0.mint_fee
    }

    public fun nav<T0>(arg0: &IndexMetadata<T0>, arg1: &0x2::clock::Clock) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        assert_data_expiration<T0>(arg0, arg1);
        arg0.nav
    }

    public(friend) fun new<T0>(arg0: address, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u8, arg3: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal, arg4: bool, arg5: u64, arg6: u8, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal, arg11: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal, arg12: &0x2::clock::Clock) : IndexMetadata<T0> {
        let v0 = 0x2::object::id<0x2::coin::CoinMetadata<T0>>(arg1);
        IndexMetadata<T0>{
            price               : arg3,
            decimals            : 0x2::coin::get_decimals<T0>(arg1),
            price_decimals      : arg2,
            index_coin_metadata : 0x2::object::id_to_address(&v0),
            last_update         : 0x2::clock::timestamp_ms(arg12),
            index_id            : arg0,
            nav                 : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::zero(),
            name                : arg7,
            description         : arg8,
            strategy            : arg9,
            frozen              : arg4,
            mint_fee            : arg10,
            burn_fee            : arg11,
            mint_access         : arg6,
            assets_count        : arg5,
            initial_price       : arg3,
        }
    }

    public fun price<T0>(arg0: &IndexMetadata<T0>, arg1: &0x2::clock::Clock) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        assert_data_expiration<T0>(arg0, arg1);
        arg0.price
    }

    public fun price_decimals<T0>(arg0: &IndexMetadata<T0>) : u8 {
        arg0.price_decimals
    }

    public(friend) fun refresh_price<T0>(arg0: &mut IndexMetadata<T0>, arg1: 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset_metadata_collector::AssetMetadataCollector<T0>, arg2: &0x2::coin::TreasuryCap<T0>, arg3: &0x2::clock::Clock) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        if (0x2::coin::total_supply<T0>(arg2) == 0) {
            arg0.last_update = 0x2::clock::timestamp_ms(arg3);
            0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset_metadata_collector::destroy<T0>(arg1);
            arg0.price = arg0.initial_price;
            return arg0.initial_price
        };
        assert!(0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset_metadata_collector::completed<T0>(&arg1), 9223372487826341887);
        let v0 = 0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset_metadata_collector::assets_metadata<T0>(&arg1);
        let v1 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::zero();
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>(&v0)) {
            v1 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::add(v1, 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::nav(0x1::vector::borrow<0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset::AssetMetadata>(&v0, v2), arg3));
            v2 = v2 + 1;
        };
        let v3 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::div(v1, 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64(0x2::coin::total_supply<T0>(arg2), decimals<T0>(arg0)));
        arg0.nav = v1;
        arg0.price = v3;
        arg0.last_update = 0x2::clock::timestamp_ms(arg3);
        0xad7510a4e8fdbf32f9eb1a180649b11eda00459443619a31f5476b333bb5f997::asset_metadata_collector::destroy<T0>(arg1);
        v3
    }

    public(friend) fun set_burn_fee<T0>(arg0: &mut IndexMetadata<T0>, arg1: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal) {
        arg0.burn_fee = arg1;
    }

    public(friend) fun set_mint_access<T0>(arg0: &mut IndexMetadata<T0>, arg1: u8) {
        arg0.mint_access = arg1;
    }

    public(friend) fun set_mint_fee<T0>(arg0: &mut IndexMetadata<T0>, arg1: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal) {
        arg0.mint_fee = arg1;
    }

    // decompiled from Move bytecode v6
}

