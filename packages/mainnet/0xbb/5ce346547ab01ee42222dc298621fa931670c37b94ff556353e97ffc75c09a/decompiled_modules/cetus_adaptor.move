module 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::cetus_adaptor {
    public fun calculate_cetus_position_value<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u256 {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1));
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_utils::mul_with_oracle_price((v0 as u256), 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_oracle::get_normalized_asset_price(arg2, arg3, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) + 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_utils::mul_with_oracle_price((v1 as u256), 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_oracle::get_normalized_asset_price(arg2, arg3, 0x1::type_name::into_string(0x1::type_name::get<T1>())))
    }

    public fun parse_cetus_position<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : (u64, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1))
    }

    public fun update_cetus_position_value<T0, T1, T2>(arg0: &mut 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::Vault<T0>, arg1: &0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault_oracle::OracleConfig, arg2: &0x2::clock::Clock, arg3: 0x1::ascii::String, arg4: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>) {
        0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::finish_update_asset_value<T0>(arg0, arg3, calculate_cetus_position_value<T1, T2>(arg4, 0xbb5ce346547ab01ee42222dc298621fa931670c37b94ff556353e97ffc75c09a::vault::get_defi_asset<T0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg0, arg3), arg1, arg2), 0x2::clock::timestamp_ms(arg2));
    }

    // decompiled from Move bytecode v6
}

