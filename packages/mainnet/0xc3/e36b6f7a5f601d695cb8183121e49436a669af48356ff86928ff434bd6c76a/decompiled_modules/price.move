module 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::price {
    struct RawPrice has copy, drop, store {
        value: 0x1::uq32_32::UQ32_32,
    }

    struct AssetPrice<phantom T0> has copy, drop, store {
        inner: RawPrice,
    }

    struct RawAssetPrice has copy, drop, store {
        asset: 0x1::type_name::TypeName,
        value: RawPrice,
    }

    public fun calc_value(arg0: &RawPrice, arg1: u64) : u64 {
        0x1::uq32_32::int_mul(arg1, arg0.value)
    }

    public fun into_asset_price<T0>(arg0: RawPrice) : AssetPrice<T0> {
        AssetPrice<T0>{inner: arg0}
    }

    public fun into_inner(arg0: RawPrice) : 0x1::uq32_32::UQ32_32 {
        arg0.value
    }

    public fun into_parts(arg0: RawAssetPrice) : (0x1::type_name::TypeName, RawPrice) {
        let RawAssetPrice {
            asset : v0,
            value : v1,
        } = arg0;
        (v0, v1)
    }

    public fun into_raw<T0>(arg0: AssetPrice<T0>) : RawAssetPrice {
        RawAssetPrice{
            asset : 0x1::type_name::get<T0>(),
            value : arg0.inner,
        }
    }

    public fun new_asset_price<T0>(arg0: 0x1::uq32_32::UQ32_32) : AssetPrice<T0> {
        AssetPrice<T0>{inner: new_raw_price(arg0)}
    }

    public fun new_raw_asset_price(arg0: 0x1::type_name::TypeName, arg1: 0x1::uq32_32::UQ32_32) : RawAssetPrice {
        RawAssetPrice{
            asset : arg0,
            value : new_raw_price(arg1),
        }
    }

    public fun new_raw_price(arg0: 0x1::uq32_32::UQ32_32) : RawPrice {
        RawPrice{value: arg0}
    }

    // decompiled from Move bytecode v6
}

