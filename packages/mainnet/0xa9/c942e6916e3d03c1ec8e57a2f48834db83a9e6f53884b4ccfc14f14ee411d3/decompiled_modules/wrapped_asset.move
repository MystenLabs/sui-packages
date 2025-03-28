module 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::wrapped_asset {
    struct ForeignInfo<phantom T0> has store {
        token_chain: u16,
        token_address: 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress,
        native_decimals: u8,
        symbol: 0x1::string::String,
    }

    struct WrappedAsset<phantom T0> has store {
        info: ForeignInfo<T0>,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
        decimals: u8,
        upgrade_cap: 0x2::package::UpgradeCap,
    }

    public fun total_supply<T0>(arg0: &WrappedAsset<T0>) : u64 {
        0x2::coin::total_supply<T0>(&arg0.treasury_cap)
    }

    public(friend) fun burn<T0>(arg0: &mut WrappedAsset<T0>, arg1: 0x2::balance::Balance<T0>) : u64 {
        0x2::balance::decrease_supply<T0>(0x2::coin::supply_mut<T0>(&mut arg0.treasury_cap), arg1)
    }

    public fun canonical_info<T0>(arg0: &WrappedAsset<T0>) : (u16, 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress) {
        (arg0.info.token_chain, arg0.info.token_address)
    }

    public fun decimals<T0>(arg0: &WrappedAsset<T0>) : u8 {
        arg0.decimals
    }

    public fun info<T0>(arg0: &WrappedAsset<T0>) : &ForeignInfo<T0> {
        &arg0.info
    }

    public(friend) fun mint<T0>(arg0: &mut WrappedAsset<T0>, arg1: u64) : 0x2::balance::Balance<T0> {
        0x2::coin::mint_balance<T0>(&mut arg0.treasury_cap, arg1)
    }

    public fun native_decimals<T0>(arg0: &ForeignInfo<T0>) : u8 {
        arg0.native_decimals
    }

    public(friend) fun new<T0>(arg0: 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::asset_meta::AssetMeta, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0x2::coin::TreasuryCap<T0>, arg3: 0x2::package::UpgradeCap) : WrappedAsset<T0> {
        0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::package_utils::assert_package_upgrade_cap<T0>(&arg3, 0x2::package::compatible_policy(), 1);
        let (v0, v1, v2, v3, v4) = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::asset_meta::unpack(arg0);
        let v5 = v3;
        assert!(v1 != 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::state::chain_id(), 0);
        0x2::coin::update_name<T0>(&mut arg2, arg1, v4);
        0x2::coin::update_symbol<T0>(&mut arg2, arg1, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::string_utils::to_ascii(&v5));
        let v6 = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount::cap_decimals(v2);
        assert!(v6 == 0x2::coin::get_decimals<T0>(arg1), 2);
        let v7 = ForeignInfo<T0>{
            token_chain     : v1,
            token_address   : v0,
            native_decimals : v2,
            symbol          : v5,
        };
        WrappedAsset<T0>{
            info         : v7,
            treasury_cap : arg2,
            decimals     : v6,
            upgrade_cap  : arg3,
        }
    }

    public fun symbol<T0>(arg0: &ForeignInfo<T0>) : 0x1::string::String {
        arg0.symbol
    }

    public fun token_address<T0>(arg0: &ForeignInfo<T0>) : 0x3ab442fe7bdf90fcb990f72a4df4ed786d49f7dc5d907a47db27d8599b795e31::external_address::ExternalAddress {
        arg0.token_address
    }

    public fun token_chain<T0>(arg0: &ForeignInfo<T0>) : u16 {
        arg0.token_chain
    }

    public(friend) fun update_metadata<T0>(arg0: &mut WrappedAsset<T0>, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::asset_meta::AssetMeta) {
        let (v0, v1, _, v3, v4) = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::asset_meta::unpack(arg2);
        let v5 = v3;
        let (v6, v7) = canonical_info<T0>(arg0);
        assert!(v1 == v6 && v0 == v7, 1);
        arg0.info.symbol = v5;
        0x2::coin::update_name<T0>(&mut arg0.treasury_cap, arg1, v4);
        0x2::coin::update_symbol<T0>(&mut arg0.treasury_cap, arg1, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::string_utils::to_ascii(&v5));
    }

    // decompiled from Move bytecode v6
}

