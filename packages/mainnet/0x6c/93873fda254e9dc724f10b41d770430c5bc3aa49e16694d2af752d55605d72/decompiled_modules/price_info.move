module 0x6c93873fda254e9dc724f10b41d770430c5bc3aa49e16694d2af752d55605d72::price_info {
    struct PriceInfo<phantom T0: drop> {
        market_id: 0x2::object::ID,
        sy_index: u128,
        updated_at: u64,
        created_at: u64,
        max_staleness_ms: u64,
    }

    struct PriceInfoConsumedEvent has copy, drop {
        market_id: 0x2::object::ID,
        sy_index: u128,
        updated_at: u64,
    }

    public fun consume<T0: drop>(arg0: PriceInfo<T0>, arg1: 0x2::object::ID, arg2: &0x2::clock::Clock) : u128 {
        let PriceInfo {
            market_id        : v0,
            sy_index         : v1,
            updated_at       : v2,
            created_at       : _,
            max_staleness_ms : v4,
        } = arg0;
        let v5 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 == arg1, 902);
        assert!(v2 <= v5 && v5 - v2 <= v4, 900);
        let v6 = PriceInfoConsumedEvent{
            market_id  : v0,
            sy_index   : v1,
            updated_at : v2,
        };
        0x2::event::emit<PriceInfoConsumedEvent>(v6);
        v1
    }

    public(friend) fun create<T0: drop>(arg0: 0x2::object::ID, arg1: u128, arg2: u64, arg3: u64, arg4: &0x2::clock::Clock) : PriceInfo<T0> {
        assert!(arg1 > 0, 901);
        assert!(arg3 > 0, 903);
        PriceInfo<T0>{
            market_id        : arg0,
            sy_index         : arg1,
            updated_at       : arg2,
            created_at       : 0x2::clock::timestamp_ms(arg4),
            max_staleness_ms : arg3,
        }
    }

    public fun created_at<T0: drop>(arg0: &PriceInfo<T0>) : u64 {
        arg0.created_at
    }

    public fun destroy<T0: drop>(arg0: PriceInfo<T0>) {
        let PriceInfo {
            market_id        : _,
            sy_index         : _,
            updated_at       : _,
            created_at       : _,
            max_staleness_ms : _,
        } = arg0;
    }

    public fun market_id<T0: drop>(arg0: &PriceInfo<T0>) : 0x2::object::ID {
        arg0.market_id
    }

    public fun max_staleness_ms<T0: drop>(arg0: &PriceInfo<T0>) : u64 {
        arg0.max_staleness_ms
    }

    public fun sy_index<T0: drop>(arg0: &PriceInfo<T0>) : u128 {
        arg0.sy_index
    }

    public fun updated_at<T0: drop>(arg0: &PriceInfo<T0>) : u64 {
        arg0.updated_at
    }

    // decompiled from Move bytecode v7
}

