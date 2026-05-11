module 0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::order_payment_assets {
    public fun is_supported_order_payment_native_type<T0>() : bool {
        is_supported_order_payment_sui_type<T0>()
    }

    public fun is_supported_order_payment_sui_type<T0>() : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        let v1 = 0x1::type_name::with_original_ids<0x2::sui::SUI>();
        0x1::ascii::as_bytes(0x1::type_name::as_string(&v0)) == 0x1::ascii::as_bytes(0x1::type_name::as_string(&v1))
    }

    public fun is_supported_order_payment_typed_coin_type<T0>() : bool {
        is_supported_order_payment_usdc_coin_type<T0>()
    }

    public fun is_supported_order_payment_usdc_coin_type<T0>() : bool {
        0x7ead5ff2093ddb6ac652823846ef4c50343329b5ee82e7bf0c7f984ef5931b72::onchain_asset_lane_manager::is_sui_usdc_order_typed_asset<T0>()
    }

    // decompiled from Move bytecode v7
}

