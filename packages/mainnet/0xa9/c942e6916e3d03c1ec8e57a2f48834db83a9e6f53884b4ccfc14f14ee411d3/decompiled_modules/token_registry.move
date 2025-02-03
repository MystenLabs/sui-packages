module 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::token_registry {
    struct TokenRegistry has store, key {
        id: 0x2::object::UID,
        num_wrapped: u64,
        num_native: u64,
        coin_types: 0x2::table::Table<CoinTypeKey, 0x1::ascii::String>,
    }

    struct VerifiedAsset<phantom T0> has drop {
        is_wrapped: bool,
        chain: u16,
        addr: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress,
        coin_decimals: u8,
    }

    struct Key<phantom T0> has copy, drop, store {
        dummy_field: bool,
    }

    struct CoinTypeKey has copy, drop, store {
        chain: u16,
        addr: vector<u8>,
    }

    public(friend) fun new(arg0: &mut 0x2::tx_context::TxContext) : TokenRegistry {
        TokenRegistry{
            id          : 0x2::object::new(arg0),
            num_wrapped : 0,
            num_native  : 0,
            coin_types  : 0x2::table::new<CoinTypeKey, 0x1::ascii::String>(arg0),
        }
    }

    public fun token_address<T0>(arg0: &VerifiedAsset<T0>) : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress {
        arg0.addr
    }

    public fun token_chain<T0>(arg0: &VerifiedAsset<T0>) : u16 {
        arg0.chain
    }

    public(friend) fun add_new_native<T0>(arg0: &mut TokenRegistry, arg1: &0x2::coin::CoinMetadata<T0>) : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress {
        let v0 = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::native_asset::new<T0>(arg1);
        let v1 = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::native_asset::token_address<T0>(&v0);
        let v2 = Key<T0>{dummy_field: false};
        0x2::dynamic_field::add<Key<T0>, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::native_asset::NativeAsset<T0>>(&mut arg0.id, v2, v0);
        arg0.num_native = arg0.num_native + 1;
        let v3 = CoinTypeKey{
            chain : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::state::chain_id(),
            addr  : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::to_bytes(v1),
        };
        0x2::table::add<CoinTypeKey, 0x1::ascii::String>(&mut arg0.coin_types, v3, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        v1
    }

    public(friend) fun add_new_wrapped<T0>(arg0: &mut TokenRegistry, arg1: 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::asset_meta::AssetMeta, arg2: &mut 0x2::coin::CoinMetadata<T0>, arg3: 0x2::coin::TreasuryCap<T0>, arg4: 0x2::package::UpgradeCap) : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress {
        let v0 = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::asset_meta::token_address(&arg1);
        let v1 = &mut arg0.coin_types;
        let v2 = CoinTypeKey{
            chain : 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::asset_meta::token_chain(&arg1),
            addr  : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::to_bytes(v0),
        };
        assert!(!0x2::table::contains<CoinTypeKey, 0x1::ascii::String>(v1, v2), 1);
        0x2::table::add<CoinTypeKey, 0x1::ascii::String>(v1, v2, 0x1::type_name::into_string(0x1::type_name::get<T0>()));
        let v3 = Key<T0>{dummy_field: false};
        0x2::dynamic_field::add<Key<T0>, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::wrapped_asset::WrappedAsset<T0>>(&mut arg0.id, v3, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::wrapped_asset::new<T0>(arg1, arg2, arg3, arg4));
        arg0.num_wrapped = arg0.num_wrapped + 1;
        v0
    }

    public fun assert_has<T0>(arg0: &TokenRegistry) {
        assert!(has<T0>(arg0), 0);
    }

    public(friend) fun borrow_mut_native<T0>(arg0: &mut TokenRegistry) : &mut 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::native_asset::NativeAsset<T0> {
        let v0 = Key<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Key<T0>, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::native_asset::NativeAsset<T0>>(&mut arg0.id, v0)
    }

    public(friend) fun borrow_mut_wrapped<T0>(arg0: &mut TokenRegistry) : &mut 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::wrapped_asset::WrappedAsset<T0> {
        let v0 = Key<T0>{dummy_field: false};
        0x2::dynamic_field::borrow_mut<Key<T0>, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::wrapped_asset::WrappedAsset<T0>>(&mut arg0.id, v0)
    }

    public fun borrow_native<T0>(arg0: &TokenRegistry) : &0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::native_asset::NativeAsset<T0> {
        let v0 = Key<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<Key<T0>, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::native_asset::NativeAsset<T0>>(&arg0.id, v0)
    }

    public fun borrow_wrapped<T0>(arg0: &TokenRegistry) : &0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::wrapped_asset::WrappedAsset<T0> {
        let v0 = Key<T0>{dummy_field: false};
        0x2::dynamic_field::borrow<Key<T0>, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::wrapped_asset::WrappedAsset<T0>>(&arg0.id, v0)
    }

    public fun coin_decimals<T0>(arg0: &VerifiedAsset<T0>) : u8 {
        arg0.coin_decimals
    }

    public fun has<T0>(arg0: &TokenRegistry) : bool {
        let v0 = Key<T0>{dummy_field: false};
        0x2::dynamic_field::exists_<Key<T0>>(&arg0.id, v0)
    }

    public fun is_wrapped<T0>(arg0: &VerifiedAsset<T0>) : bool {
        arg0.is_wrapped
    }

    public fun verified_asset<T0>(arg0: &TokenRegistry) : VerifiedAsset<T0> {
        let v0 = Key<T0>{dummy_field: false};
        let v1 = 0x2::dynamic_field::exists_with_type<Key<T0>, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::wrapped_asset::WrappedAsset<T0>>(&arg0.id, v0);
        if (v1) {
            let v3 = borrow_wrapped<T0>(arg0);
            let (v4, v5) = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::wrapped_asset::canonical_info<T0>(v3);
            VerifiedAsset<T0>{is_wrapped: v1, chain: v4, addr: v5, coin_decimals: 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::wrapped_asset::decimals<T0>(v3)}
        } else {
            let v6 = borrow_native<T0>(arg0);
            let (v7, v8) = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::native_asset::canonical_info<T0>(v6);
            VerifiedAsset<T0>{is_wrapped: v1, chain: v7, addr: v8, coin_decimals: 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::native_asset::decimals<T0>(v6)}
        }
    }

    // decompiled from Move bytecode v6
}

