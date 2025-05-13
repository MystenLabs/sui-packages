module 0x7741c478a91176bd6ed6a112f09d48cb21131165e862cc45293949eb3c2c0ad4::cetus_adaptor {
    public fun calculate_cetus_position_value<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position, arg2: &0x7741c478a91176bd6ed6a112f09d48cb21131165e862cc45293949eb3c2c0ad4::vault_oracle::OracleConfig, arg3: &0x2::clock::Clock) : u256 {
        let (v0, v1) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1));
        0x7741c478a91176bd6ed6a112f09d48cb21131165e862cc45293949eb3c2c0ad4::vault_utils::mul_with_oracle_price((v0 as u256), 0x7741c478a91176bd6ed6a112f09d48cb21131165e862cc45293949eb3c2c0ad4::vault_oracle::get_asset_price(arg2, arg3, 0x1::type_name::into_string(0x1::type_name::get<T0>()))) + 0x7741c478a91176bd6ed6a112f09d48cb21131165e862cc45293949eb3c2c0ad4::vault_utils::mul_with_oracle_price((v1 as u256), 0x7741c478a91176bd6ed6a112f09d48cb21131165e862cc45293949eb3c2c0ad4::vault_oracle::get_asset_price(arg2, arg3, 0x1::type_name::into_string(0x1::type_name::get<T1>())))
    }

    public fun parse_cetus_position<T0, T1>(arg0: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position) : (u64, u64) {
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::get_position_amounts<T0, T1>(arg0, 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::position::Position>(arg1))
    }

    // decompiled from Move bytecode v6
}

