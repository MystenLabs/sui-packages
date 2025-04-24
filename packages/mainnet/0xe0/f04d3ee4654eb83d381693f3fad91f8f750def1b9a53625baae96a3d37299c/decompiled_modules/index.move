module 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index {
    struct IndexCreated has copy, drop {
        index_id: 0x2::object::ID,
    }

    struct AssetAdded has copy, drop {
        index_id: 0x2::object::ID,
        asset_position: u64,
    }

    struct Index<phantom T0> has store, key {
        id: 0x2::object::UID,
        version: 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::version::Version,
        metadata: 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::IndexMetadata<T0>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    public fun withdraw_fees<T0, T1>(arg0: &mut Index<T0>, arg1: u64, arg2: &0x87c95bf6bf9c82cecd125a55034cd460bb1e8c42b1e792c19ca349533fa7b8f1::app::VaultAdminCap, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::version::assert_current_version(&arg0.version);
        0x2::coin::from_balance<T1>(0x87c95bf6bf9c82cecd125a55034cd460bb1e8c42b1e792c19ca349533fa7b8f1::vault::withdraw_fees<T1, T0>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::vault_mut<T0, T1>(0x2::dynamic_field::borrow_mut<u64, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1>>(&mut arg0.id, arg1)), arg3, arg2), arg4)
    }

    public(friend) fun asset<T0, T1>(arg0: &Index<T0>, arg1: u64) : &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1> {
        0x2::dynamic_field::borrow<u64, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1>>(&arg0.id, arg1)
    }

    public fun metadata<T0>(arg0: &Index<T0>) : &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::IndexMetadata<T0> {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::version::assert_current_version(&arg0.version);
        &arg0.metadata
    }

    public fun refresh_asset_price_with_pyth<T0, T1>(arg0: &mut Index<T0>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg4: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject) {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::version::assert_current_version(&arg0.version);
        let (_, _) = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::refresh_asset_price_with_pyth<T0, T1>(asset_mut<T0, T1>(arg0, arg1), arg2, arg3, arg4);
    }

    public fun add_new_asset<T0, T1>(arg0: &mut Index<T0>, arg1: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app::AdminCap, arg2: 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1>) {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::version::assert_current_version(&arg0.version);
        assert_index_is_not_locked<T0>(arg0);
        let v0 = 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::assets_count<T0>(&arg0.metadata);
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::increment_assets_count<T0>(&mut arg0.metadata);
        0x2::dynamic_field::add<u64, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1>>(&mut arg0.id, v0, arg2);
        let v1 = AssetAdded{
            index_id       : 0x2::object::uid_to_inner(&arg0.id),
            asset_position : v0,
        };
        0x2::event::emit<AssetAdded>(v1);
    }

    public(friend) fun assert_index_is_not_locked<T0>(arg0: &Index<T0>) {
        assert!(!0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::locked<T0>(&arg0.metadata), 111);
    }

    public(friend) fun assert_mint_is_open<T0>(arg0: &Index<T0>) {
        assert!(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::mint_access<T0>(metadata<T0>(arg0)) != 0, 110);
    }

    public(friend) fun assert_mint_is_public<T0>(arg0: &Index<T0>) {
        assert!(is_mint_public<T0>(arg0), 112);
    }

    public fun asset_metadata<T0, T1>(arg0: &Index<T0>, arg1: u64) : 0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::AssetMetadata {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::version::assert_current_version(&arg0.version);
        *0x8b0007279450d449c0a4d2021b208b78764a0ba09d8f94e65754091d04832aae::asset::data<T0, T1>(0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::metadata<T0, T1>(0x2::dynamic_field::borrow<u64, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1>>(&arg0.id, arg1)))
    }

    public(friend) fun asset_mut<T0, T1>(arg0: &mut Index<T0>, arg1: u64) : &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1> {
        0x2::dynamic_field::borrow_mut<u64, 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset::Asset<T0, T1>>(&mut arg0.id, arg1)
    }

    public(friend) fun assets_count<T0>(arg0: &Index<T0>) : u64 {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::assets_count<T0>(&arg0.metadata)
    }

    public(friend) fun burn_coin<T0>(arg0: &mut Index<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::coin::burn<T0>(&mut arg0.treasury_cap, arg1);
    }

    public(friend) fun burn_fee<T0>(arg0: &Index<T0>) : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::burn_fee<T0>(&arg0.metadata)
    }

    public fun close_mint<T0>(arg0: &mut Index<T0>, arg1: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app::AdminCap) {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::version::assert_current_version(&arg0.version);
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::set_mint_access<T0>(&mut arg0.metadata, 0);
    }

    public(friend) fun is_mint_public<T0>(arg0: &Index<T0>) : bool {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::mint_access<T0>(&arg0.metadata) == 2
    }

    public(friend) fun is_mint_whitelist_only<T0>(arg0: &Index<T0>) : bool {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::mint_access<T0>(&arg0.metadata) == 1
    }

    public fun lock_index<T0>(arg0: &mut Index<T0>, arg1: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app::AdminCap) {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::lock_index<T0>(&mut arg0.metadata);
    }

    public fun migrate_to_current_version<T0>(arg0: &mut Index<T0>, arg1: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::version::VersionCap) {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::version::migrate_to_current_version(&mut arg0.version, arg1);
    }

    public(friend) fun mint_coin<T0>(arg0: &mut Index<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x2::coin::mint<T0>(&mut arg0.treasury_cap, arg1, arg2)
    }

    public(friend) fun mint_fee<T0>(arg0: &Index<T0>) : 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::Decimal {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::mint_fee<T0>(&arg0.metadata)
    }

    public(friend) fun open_mint_public<T0>(arg0: &mut Index<T0>) {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::set_mint_access<T0>(&mut arg0.metadata, 2);
    }

    public(friend) fun open_mint_whitelist_only<T0>(arg0: &mut Index<T0>) {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::set_mint_access<T0>(&mut arg0.metadata, 1);
    }

    public fun refresh_price<T0>(arg0: &mut Index<T0>, arg1: 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::asset_metadata_collector::AssetMetadataCollector<T0>, arg2: &0x2::clock::Clock) {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::version::assert_current_version(&arg0.version);
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::refresh_price<T0>(&mut arg0.metadata, arg1, &arg0.treasury_cap, arg2);
    }

    public fun set_mint_fee<T0>(arg0: &mut Index<T0>, arg1: u64, arg2: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app::AdminCap) {
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::set_mint_fee<T0>(&mut arg0.metadata, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_percentage(arg1));
    }

    public fun setup<T0>(arg0: &0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app::AdminCap, arg1: &mut 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app::Registry, arg2: &0x2::coin::CoinMetadata<T0>, arg3: u8, arg4: 0x1::string::String, arg5: 0x1::string::String, arg6: u64, arg7: 0x2::coin::TreasuryCap<T0>, arg8: u64, arg9: u64, arg10: u64, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg12);
        let v1 = IndexCreated{index_id: 0x2::object::uid_to_inner(&v0)};
        0x2::event::emit<IndexCreated>(v1);
        let v2 = Index<T0>{
            id           : v0,
            version      : 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::version::new(),
            metadata     : 0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::index_metadata::new<T0>(0x2::object::uid_to_address(&v0), arg2, arg3, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_u64(arg8, arg3), false, 0, 0, arg4, arg5, arg6, 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_percentage(arg9), 0x66a2b85d2265cab9c3ddc8c1b0da94e5c2031c0a8df79f406439488efe579e2::decimals::from_percentage(arg10), arg11),
            treasury_cap : arg7,
        };
        0xe0f04d3ee4654eb83d381693f3fad91f8f750def1b9a53625baae96a3d37299c::app::add_index(arg1, 0x2::object::uid_to_address(&v2.id));
        0x2::transfer::public_share_object<Index<T0>>(v2);
    }

    // decompiled from Move bytecode v6
}

