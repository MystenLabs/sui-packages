module 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::trusted_prices {
    struct TrustedPriceDataCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventNewTrustedPriceDataCap has copy, drop {
        id: 0x2::object::ID,
    }

    struct PriceAndExpiry has copy, drop, store {
        value: 0x1::uq32_32::UQ32_32,
        expiry_time_ms: u64,
    }

    struct TrustedPriceData {
        current_time_ms: u64,
        prices: 0x2::table::Table<0x1::type_name::TypeName, PriceAndExpiry>,
        cache: 0x2::table::Table<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>,
    }

    public fun new(arg0: &0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : TrustedPriceDataCap {
        let v0 = TrustedPriceDataCap{id: 0x2::object::new(arg1)};
        let v1 = EventNewTrustedPriceDataCap{id: 0x2::object::id<TrustedPriceDataCap>(&v0)};
        0x2::event::emit<EventNewTrustedPriceDataCap>(v1);
        v0
    }

    fun compute_price(arg0: &TrustedPriceData, arg1: 0x1::type_name::TypeName) : 0x1::uq32_32::UQ32_32 {
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceAndExpiry>(&arg0.prices, arg1), 1);
        let v0 = *0x2::table::borrow<0x1::type_name::TypeName, PriceAndExpiry>(&arg0.prices, arg1);
        assert!(v0.expiry_time_ms > arg0.current_time_ms, 0);
        v0.value
    }

    public fun create_empty_trusted_price_data(arg0: &TrustedPriceDataCap, arg1: &mut 0x2::tx_context::TxContext) : TrustedPriceData {
        TrustedPriceData{
            current_time_ms : 0,
            prices          : 0x2::table::new<0x1::type_name::TypeName, PriceAndExpiry>(arg1),
            cache           : 0x2::table::new<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(arg1),
        }
    }

    public fun create_trusted_price_data(arg0: 0x2::table::Table<0x1::type_name::TypeName, PriceAndExpiry>, arg1: &0x2::clock::Clock, arg2: &TrustedPriceDataCap, arg3: &mut 0x2::tx_context::TxContext) : TrustedPriceData {
        TrustedPriceData{
            current_time_ms : 0x2::clock::timestamp_ms(arg1),
            prices          : arg0,
            cache           : 0x2::table::new<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(arg3),
        }
    }

    public fun destroy(arg0: TrustedPriceDataCap) {
        let TrustedPriceDataCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_trusted_price_data(arg0: TrustedPriceData, arg1: &TrustedPriceDataCap) : 0x2::table::Table<0x1::type_name::TypeName, PriceAndExpiry> {
        let TrustedPriceData {
            current_time_ms : _,
            prices          : v1,
            cache           : v2,
        } = arg0;
        0x2::table::drop<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(v2);
        v1
    }

    public fun new_price_and_expiry(arg0: 0x1::uq32_32::UQ32_32, arg1: u64, arg2: &0x2::clock::Clock) : PriceAndExpiry {
        PriceAndExpiry{
            value          : arg0,
            expiry_time_ms : 0x2::clock::timestamp_ms(arg2) + arg1,
        }
    }

    public fun pull_price<T0>(arg0: &mut TrustedPriceData) : 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::price::AssetPrice<T0> {
        0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::price::new_asset_price<T0>(pull_price_internal(arg0, 0x1::type_name::get<T0>()))
    }

    fun pull_price_internal(arg0: &mut TrustedPriceData, arg1: 0x1::type_name::TypeName) : 0x1::uq32_32::UQ32_32 {
        if (0x2::table::contains<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(&arg0.cache, arg1)) {
            *0x2::table::borrow<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(&arg0.cache, arg1)
        } else {
            let v1 = compute_price(arg0, arg1);
            0x2::table::add<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(&mut arg0.cache, arg1, v1);
            v1
        }
    }

    public fun pull_raw_price(arg0: &mut TrustedPriceData, arg1: 0x1::type_name::TypeName) : 0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::price::RawPrice {
        0xc3e36b6f7a5f601d695cb8183121e49436a669af48356ff86928ff434bd6c76a::price::new_raw_price(pull_price_internal(arg0, arg1))
    }

    public fun set_price<T0>(arg0: &mut TrustedPriceData, arg1: 0x1::uq32_32::UQ32_32, arg2: &TrustedPriceDataCap) {
        set_price_raw(arg0, 0x1::type_name::get<T0>(), arg1, arg2);
    }

    public fun set_price_raw(arg0: &mut TrustedPriceData, arg1: 0x1::type_name::TypeName, arg2: 0x1::uq32_32::UQ32_32, arg3: &TrustedPriceDataCap) {
        0x2::table::add<0x1::type_name::TypeName, 0x1::uq32_32::UQ32_32>(&mut arg0.cache, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

