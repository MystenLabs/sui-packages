module 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::price_request {
    struct Price has copy, drop, store {
        value: u64,
        decimals: u8,
        updated_at: u64,
    }

    struct PriceRequest<phantom T0> {
        for: 0x2::object::ID,
        price: 0x1::option::Option<Price>,
    }

    public fun burn<T0>(arg0: PriceRequest<T0>) : Price {
        let PriceRequest {
            for   : _,
            price : v1,
        } = arg0;
        0x1::option::destroy_some<Price>(v1)
    }

    public fun new_price(arg0: u64, arg1: u8, arg2: u64) : Price {
        Price{
            value      : arg0,
            decimals   : arg1,
            updated_at : arg2,
        }
    }

    public fun new_price_request<T0>(arg0: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig) : PriceRequest<T0> {
        PriceRequest<T0>{
            for   : 0x2::object::id<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig>(arg0),
            price : 0x1::option::none<Price>(),
        }
    }

    public fun price_decimals(arg0: &Price) : u8 {
        arg0.decimals
    }

    public fun price_updated_at(arg0: &Price) : u64 {
        arg0.updated_at
    }

    public fun price_value(arg0: &Price) : u64 {
        arg0.value
    }

    public fun set_price<T0, T1: drop>(arg0: T1, arg1: &mut PriceRequest<T0>, arg2: &0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig, arg3: Price) : &mut PriceRequest<T0> {
        assert!(0x2::object::id<0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::SourceConfig>(arg2) == arg1.for, 0);
        assert!(0x1::type_name::get<T1>() == 0xab18b56de907f598c61c837f217eafa0aa89a8facce7ec21ba0d5c608b7f8670::source::source(arg2), 1);
        0x1::option::fill<Price>(&mut arg1.price, arg3);
        arg1
    }

    // decompiled from Move bytecode v6
}

