module 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::onchain_asset_lane_manager {
    public fun exact_type_bytes_for<T0>() : vector<u8> {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        *0x1::ascii::as_bytes(0x1::type_name::as_string(&v0))
    }

    public fun is_sui_type<T0>() : bool {
        same_exact_type<T0, 0x2::sui::SUI>()
    }

    public fun is_sui_usdc_order_typed_asset<T0>() : bool {
        matches_sui_usdc_testnet_type<T0>() || matches_sui_usdc_mainnet_type<T0>()
    }

    public fun is_supported_dispute_bond_typed_non_sui_asset<T0>() : bool {
        is_supported_order_typed_non_sui_asset<T0>()
    }

    public fun is_supported_order_typed_non_sui_asset<T0>() : bool {
        !is_sui_type<T0>()
    }

    public fun matches_exact_type_bytes<T0>(arg0: &vector<u8>) : bool {
        let v0 = exact_type_bytes_for<T0>();
        arg0 == &v0
    }

    public fun matches_sui_usdc_mainnet_type<T0>() : bool {
        let v0 = sui_usdc_mainnet_type_bytes();
        matches_exact_type_bytes<T0>(&v0)
    }

    public fun matches_sui_usdc_testnet_type<T0>() : bool {
        let v0 = sui_usdc_testnet_type_bytes();
        matches_exact_type_bytes<T0>(&v0)
    }

    public fun matches_supported_order_typed_non_sui_asset_bytes<T0>(arg0: &vector<u8>) : bool {
        if (is_sui_type<T0>()) {
            return false
        };
        matches_exact_type_bytes<T0>(arg0)
    }

    public fun same_exact_type<T0, T1>() : bool {
        let v0 = exact_type_bytes_for<T1>();
        matches_exact_type_bytes<T0>(&v0)
    }

    public fun same_supported_order_typed_non_sui_asset<T0, T1>() : bool {
        if (!is_sui_type<T0>()) {
            if (!is_sui_type<T1>()) {
                same_exact_type<T0, T1>()
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun sui_usdc_mainnet_type_bytes() : vector<u8> {
        b"dba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC"
    }

    public fun sui_usdc_testnet_type_bytes() : vector<u8> {
        b"a1ec7fc00a6f40db9693ad1415d0c193ad3906494428cf252621037bd7117e29::usdc::USDC"
    }

    public fun supported_dispute_bond_typed_non_sui_asset_bytes<T0>() : 0x1::option::Option<vector<u8>> {
        supported_order_typed_non_sui_asset_bytes<T0>()
    }

    public fun supported_order_typed_non_sui_asset_bytes<T0>() : 0x1::option::Option<vector<u8>> {
        if (is_sui_type<T0>()) {
            return 0x1::option::none<vector<u8>>()
        };
        0x1::option::some<vector<u8>>(exact_type_bytes_for<T0>())
    }

    // decompiled from Move bytecode v7
}

