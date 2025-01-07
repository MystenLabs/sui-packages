module 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::create_wrapped {
    struct WrappedAssetSetup<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<T0>,
    }

    public fun complete_registration<T0: drop, T1>(arg0: &mut 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::state::State, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: WrappedAssetSetup<T0, T1>, arg3: 0x2::package::UpgradeCap, arg4: 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::vaa::TokenBridgeMessage) {
        let v0 = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::state::assert_latest_only_specified<T1>(arg0);
        let WrappedAssetSetup {
            id           : v1,
            treasury_cap : v2,
        } = arg2;
        0x2::object::delete(v1);
        0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::token_registry::add_new_wrapped<T0>(0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::state::borrow_mut_token_registry(&v0, arg0), 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::asset_meta::deserialize(0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::vaa::take_payload(arg4)), arg1, v2, arg3);
    }

    public fun incomplete_metadata<T0>(arg0: &0x2::coin::CoinMetadata<T0>) : bool {
        let v0 = 0x2::coin::get_symbol<T0>(arg0);
        let v1 = if (0x1::vector::is_empty<u8>(0x1::ascii::as_bytes(&v0))) {
            let v2 = 0x2::coin::get_name<T0>(arg0);
            0x1::vector::is_empty<u8>(0x1::string::bytes(&v2))
        } else {
            false
        };
        let v3 = if (v1) {
            let v4 = 0x2::coin::get_description<T0>(arg0);
            0x1::vector::is_empty<u8>(0x1::string::bytes(&v4))
        } else {
            false
        };
        if (v3) {
            let v6 = 0x2::coin::get_icon_url<T0>(arg0);
            0x1::option::is_none<0x2::url::Url>(&v6)
        } else {
            false
        }
    }

    public fun prepare_registration<T0: drop, T1>(arg0: T0, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : WrappedAssetSetup<T0, T1> {
        let v0 = 0x1::type_name::get<T0>();
        assert!(0x1::ascii::into_bytes(0x1::type_name::get_module(&v0)) == b"coin", 1);
        prepare_registration_internal<T0, T1>(arg0, arg1, arg2)
    }

    fun prepare_registration_internal<T0: drop, T1>(arg0: T0, arg1: u8, arg2: &mut 0x2::tx_context::TxContext) : WrappedAssetSetup<T0, T1> {
        assert!(0x2::types::is_one_time_witness<T0>(&arg0), 0);
        assert!(arg1 <= 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::normalized_amount::max_decimals(), 2);
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, arg1, b"", b"", b"", 0x1::option::none<0x2::url::Url>(), arg2);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T0>>(v1);
        WrappedAssetSetup<T0, T1>{
            id           : 0x2::object::new(arg2),
            treasury_cap : v0,
        }
    }

    public fun update_attestation<T0>(arg0: &mut 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::state::State, arg1: &mut 0x2::coin::CoinMetadata<T0>, arg2: 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::vaa::TokenBridgeMessage) {
        let v0 = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::state::assert_latest_only(arg0);
        let v1 = 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::state::borrow_mut_token_registry(&v0, arg0);
        0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::token_registry::assert_has<T0>(v1);
        0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::wrapped_asset::update_metadata<T0>(0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::token_registry::borrow_mut_wrapped<T0>(v1), arg1, 0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::asset_meta::deserialize(0xa9c942e6916e3d03c1ec8e57a2f48834db83a9e6f53884b4ccfc14f14ee411d3::vaa::take_payload(arg2)));
    }

    // decompiled from Move bytecode v6
}

