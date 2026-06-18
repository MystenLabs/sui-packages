module 0x69f77a0611125c2dec3b75eba583157b0c0d3d582e0eb01d2dff4469b778bf5a::collector {
    struct SourceQuote has copy, drop, store {
        sy_index: u128,
        updated_at: u64,
    }

    struct PriceCollector<phantom T0: drop> has drop {
        market_id: 0x2::object::ID,
        quotes: 0x2::vec_map::VecMap<0x1::type_name::TypeName, SourceQuote>,
    }

    public fun assert_market_id<T0: drop>(arg0: &PriceCollector<T0>, arg1: 0x2::object::ID) {
        assert!(arg0.market_id == arg1, 921);
    }

    public fun collect<T0: drop, T1: drop>(arg0: &mut PriceCollector<T0>, arg1: T1, arg2: u128, arg3: u64) {
        assert!(arg2 > 0, 920);
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        let v1 = SourceQuote{
            sy_index   : arg2,
            updated_at : arg3,
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, SourceQuote>(&arg0.quotes, &v0)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, SourceQuote>(&mut arg0.quotes, &v0) = v1;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, SourceQuote>(&mut arg0.quotes, v0, v1);
        };
    }

    public fun contains_source<T0: drop, T1: drop>(arg0: &PriceCollector<T0>) : bool {
        let v0 = 0x1::type_name::with_defining_ids<T1>();
        0x2::vec_map::contains<0x1::type_name::TypeName, SourceQuote>(&arg0.quotes, &v0)
    }

    public fun contents<T0: drop>(arg0: &PriceCollector<T0>) : &0x2::vec_map::VecMap<0x1::type_name::TypeName, SourceQuote> {
        &arg0.quotes
    }

    public fun market_id<T0: drop>(arg0: &PriceCollector<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun new<T0: drop>(arg0: 0x2::object::ID) : PriceCollector<T0> {
        PriceCollector<T0>{
            market_id : arg0,
            quotes    : 0x2::vec_map::empty<0x1::type_name::TypeName, SourceQuote>(),
        }
    }

    public fun sy_index(arg0: &SourceQuote) : u128 {
        arg0.sy_index
    }

    public fun updated_at(arg0: &SourceQuote) : u64 {
        arg0.updated_at
    }

    // decompiled from Move bytecode v7
}

