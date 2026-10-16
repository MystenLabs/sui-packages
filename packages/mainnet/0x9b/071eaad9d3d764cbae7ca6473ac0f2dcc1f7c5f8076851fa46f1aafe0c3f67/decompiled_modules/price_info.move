module 0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::price_info {
    struct PriceInfo<phantom T0: drop> {
        aggregator_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        sy_index: u128,
        updated_at: u64,
        created_at: u64,
        max_staleness_ms: u64,
    }

    struct PriceInfoConsumedEvent has copy, drop {
        aggregator_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        sy_index: u128,
        updated_at: u64,
    }

    public fun aggregator_id<T0: drop>(arg0: &PriceInfo<T0>) : 0x2::object::ID {
        arg0.aggregator_id
    }

    public fun consume<T0: drop>(arg0: PriceInfo<T0>, arg1: &0xddfba63318efacd9023198b4b2129abdd09ccd080796df86405ec51ac2ee4516::global_config::GlobalConfig, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: &0x2::clock::Clock) : u128 {
        0x9b071eaad9d3d764cbae7ca6473ac0f2dcc1f7c5f8076851fa46f1aafe0c3f67::package_version::assert_current(arg1);
        let PriceInfo {
            aggregator_id    : v0,
            market_id        : v1,
            sy_index         : v2,
            updated_at       : v3,
            created_at       : _,
            max_staleness_ms : v5,
        } = arg0;
        let v6 = 0x2::clock::timestamp_ms(arg4);
        assert!(v1 == arg2, 902);
        assert!(v0 == arg3, 904);
        assert!(v3 <= v6 && v6 - v3 <= v5, 900);
        let v7 = PriceInfoConsumedEvent{
            aggregator_id : v0,
            market_id     : v1,
            sy_index      : v2,
            updated_at    : v3,
        };
        0x2::event::emit<PriceInfoConsumedEvent>(v7);
        v2
    }

    public(friend) fun create<T0: drop>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u128, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) : PriceInfo<T0> {
        assert!(arg2 > 0, 901);
        assert!(arg4 > 0, 903);
        PriceInfo<T0>{
            aggregator_id    : arg0,
            market_id        : arg1,
            sy_index         : arg2,
            updated_at       : arg3,
            created_at       : 0x2::clock::timestamp_ms(arg5),
            max_staleness_ms : arg4,
        }
    }

    public fun created_at<T0: drop>(arg0: &PriceInfo<T0>) : u64 {
        arg0.created_at
    }

    public fun destroy<T0: drop>(arg0: PriceInfo<T0>) {
        let PriceInfo {
            aggregator_id    : _,
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

