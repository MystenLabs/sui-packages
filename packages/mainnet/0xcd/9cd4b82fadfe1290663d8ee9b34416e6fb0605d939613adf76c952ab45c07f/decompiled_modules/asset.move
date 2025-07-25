module 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::asset {
    struct AssetMetadata has copy, drop, store {
        vault_amount: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        price: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
        index_decimals: u8,
        price_decimals: u8,
        last_update: u64,
        decimals: u8,
        nav: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal,
    }

    struct MetadataProvider<phantom T0, phantom T1> has store {
        active_provider: 0x1::string::String,
        providers: 0x2::bag::Bag,
        asset_coin_metadata: address,
        data: AssetMetadata,
    }

    public fun new<T0, T1>(arg0: &0x2::coin::CoinMetadata<T1>, arg1: &0x2::coin::CoinMetadata<T0>, arg2: u8, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : MetadataProvider<T0, T1> {
        let v0 = 0x2::object::id<0x2::coin::CoinMetadata<T1>>(arg0);
        let v1 = AssetMetadata{
            vault_amount   : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::zero(),
            price          : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::zero(),
            index_decimals : 0x2::coin::get_decimals<T0>(arg1),
            price_decimals : arg2,
            last_update    : 0x2::clock::timestamp_ms(arg3),
            decimals       : 0x2::coin::get_decimals<T1>(arg0),
            nav            : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::zero(),
        };
        MetadataProvider<T0, T1>{
            active_provider     : 0x1::string::utf8(b""),
            providers           : 0x2::bag::new(arg4),
            asset_coin_metadata : 0x2::object::id_to_address(&v0),
            data                : v1,
        }
    }

    public fun decimals(arg0: &AssetMetadata) : u8 {
        arg0.decimals
    }

    public fun add_pyth_provider<T0, T1>(arg0: &mut MetadataProvider<T0, T1>, arg1: 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::pyth::PythPriceProvider<T1>) {
        0x2::bag::add<0x1::string::String, 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::pyth::PythPriceProvider<T1>>(&mut arg0.providers, 0x1::string::utf8(b"PYTH"), arg1);
    }

    public fun allocation(arg0: &AssetMetadata, arg1: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        if (0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::is_zero(arg1)) {
            return 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::zero()
        };
        0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::div(arg0.nav, arg1)
    }

    public fun data<T0, T1>(arg0: &MetadataProvider<T0, T1>) : &AssetMetadata {
        &arg0.data
    }

    public fun index_decimals(arg0: &AssetMetadata) : u8 {
        arg0.index_decimals
    }

    public(friend) fun is_kind_supported(arg0: &0x1::string::String) : bool {
        let v0 = supported_kinds();
        0x1::vector::contains<0x1::string::String>(&v0, arg0)
    }

    public fun last_update(arg0: &AssetMetadata) : u64 {
        arg0.last_update
    }

    public fun nav(arg0: &AssetMetadata, arg1: &0x2::clock::Clock) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.last_update < 1000, 203);
        arg0.nav
    }

    public fun price(arg0: &AssetMetadata, arg1: &0x2::clock::Clock) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        assert!(0x2::clock::timestamp_ms(arg1) - arg0.last_update < 1000, 203);
        arg0.price
    }

    public fun price_decimals(arg0: &AssetMetadata) : u8 {
        arg0.price_decimals
    }

    public fun refresh_nav_only<T0, T1>(arg0: &mut MetadataProvider<T0, T1>, arg1: &0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::vault::Vault<T1, T0>, arg2: &0x2::clock::Clock) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        let v0 = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64(0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::vault::balance_without_fees<T1, T0>(arg1, arg2), arg0.data.decimals);
        arg0.data.nav = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::mul(v0, price(&arg0.data, arg2));
        arg0.data.vault_amount = v0;
        arg0.data.nav
    }

    public fun refresh_with_pyth<T0, T1>(arg0: &mut MetadataProvider<T0, T1>, arg1: &0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::vault::Vault<T1, T0>, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) : (0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal, u8) {
        let v0 = 0x1::string::utf8(b"PYTH");
        assert!(arg0.active_provider == v0, 202);
        let (v1, v2) = 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::pyth::get_price<T1>(0x2::bag::borrow_mut<0x1::string::String, 0xcd9cd4b82fadfe1290663d8ee9b34416e6fb0605d939613adf76c952ab45c07f::pyth::PythPriceProvider<T1>>(&mut arg0.providers, v0), arg2, arg3, arg4);
        update_metadata<T0, T1>(arg0, arg1, 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64(v1, v2), arg2);
        (arg0.data.price, arg0.data.decimals)
    }

    public(friend) fun supported_kinds() : vector<0x1::string::String> {
        let v0 = 0x1::vector::empty<0x1::string::String>();
        0x1::vector::push_back<0x1::string::String>(&mut v0, 0x1::string::utf8(b"PYTH"));
        v0
    }

    public fun switch_provider<T0, T1>(arg0: &mut MetadataProvider<T0, T1>, arg1: 0x1::string::String) {
        assert!(is_kind_supported(&arg1), 201);
        arg0.active_provider = arg1;
    }

    fun update_metadata<T0, T1>(arg0: &mut MetadataProvider<T0, T1>, arg1: &0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::vault::Vault<T1, T0>, arg2: 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal, arg3: &0x2::clock::Clock) {
        arg0.data.price = arg2;
        arg0.data.last_update = 0x2::clock::timestamp_ms(arg3);
        arg0.data.vault_amount = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::from_u64(0x5591505a373f2cf8320653162c2d04d118db65ef7560f81a8dc028bb5ad11340::vault::balance_without_fees<T1, T0>(arg1, arg3), arg0.data.decimals);
        arg0.data.nav = 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::mul(arg0.data.vault_amount, arg2);
    }

    public fun vault_amount(arg0: &AssetMetadata) : 0x806d9fb3ce205fdd1a94bfb9a7f4b8373a6674a7e7161af0fb5ac19e5271fdcd::decimals::Decimal {
        arg0.vault_amount
    }

    // decompiled from Move bytecode v6
}

