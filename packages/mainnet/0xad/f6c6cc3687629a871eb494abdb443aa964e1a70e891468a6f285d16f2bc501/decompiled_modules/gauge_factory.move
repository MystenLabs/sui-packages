module 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge_factory {
    struct GAUGE_FACTORY has drop {
        dummy_field: bool,
    }

    struct GaugeFactory has key {
        id: 0x2::object::UID,
        gauges: 0x2::linked_table::LinkedTable<0x2::object::ID, GaugeInfo>,
    }

    struct GaugeInfo has copy, drop, store {
        gauge_id: 0x2::object::ID,
        gauge_key: 0x2::object::ID,
        pool_id: 0x2::object::ID,
    }

    public fun all_gauges(arg0: &GaugeFactory, arg1: vector<0x2::object::ID>, arg2: u64) : vector<GaugeInfo> {
        all_gauges_(arg0, arg1, arg2)
    }

    fun all_gauges_(arg0: &GaugeFactory, arg1: vector<0x2::object::ID>, arg2: u64) : vector<GaugeInfo> {
        let v0 = 0x1::vector::empty<GaugeInfo>();
        let v1 = if (0x1::vector::is_empty<0x2::object::ID>(&arg1)) {
            0x2::linked_table::front<0x2::object::ID, GaugeInfo>(&arg0.gauges)
        } else {
            0x2::linked_table::next<0x2::object::ID, GaugeInfo>(&arg0.gauges, *0x1::vector::borrow<0x2::object::ID>(&arg1, 0))
        };
        let v2 = v1;
        let v3 = 0;
        while (0x1::option::is_some<0x2::object::ID>(v2) && v3 < arg2) {
            let v4 = 0x2::linked_table::borrow<0x2::object::ID, GaugeInfo>(&arg0.gauges, *0x1::option::borrow<0x2::object::ID>(v2));
            v2 = 0x2::linked_table::next<0x2::object::ID, GaugeInfo>(&arg0.gauges, v4.gauge_key);
            0x1::vector::push_back<GaugeInfo>(&mut v0, *v4);
            v3 = v3 + 1;
        };
        v0
    }

    public fun create_gauge<T0, T1, T2>(arg0: &mut GaugeFactory, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = create_gauge_internal<T0, T1, T2>(arg0, arg1, arg2);
        0x2::transfer::public_share_object<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::Gauge<T0, T1, T2>>(v0);
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::id<T0, T1, T2>(&v0)
    }

    fun create_gauge_internal<T0, T1, T2>(arg0: &mut GaugeFactory, arg1: &mut 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::Pool<T0, T1, T2>, arg2: &mut 0x2::tx_context::TxContext) : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::Gauge<T0, T1, T2> {
        let v0 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::new_pool_key<T0, T1>(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::is_stable<T2>());
        let v1 = 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::init_gauge<T0, T1, T2>(arg2);
        0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::set_gauge_active<T0, T1, T2>(arg1, true);
        let v2 = GaugeInfo{
            gauge_id  : 0x2::object::id<0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::gauge::Gauge<T0, T1, T2>>(&v1),
            gauge_key : v0,
            pool_id   : 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::pool::id<T0, T1, T2>(arg1),
        };
        0x2::linked_table::push_back<0x2::object::ID, GaugeInfo>(&mut arg0.gauges, v0, v2);
        v1
    }

    public fun gauge_info<T0, T1, T2>(arg0: &GaugeFactory) : &GaugeInfo {
        0x2::linked_table::borrow<0x2::object::ID, GaugeInfo>(&arg0.gauges, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::new_pool_key<T0, T1>(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::is_stable<T2>()))
    }

    public fun has_gauge<T0, T1, T2>(arg0: &GaugeFactory) : bool {
        0x2::linked_table::contains<0x2::object::ID, GaugeInfo>(&arg0.gauges, 0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::new_pool_key<T0, T1>(0x41efa3f778f47ad4938643e7f45a8cb0d78d4338ecd2c872e054d98b9a87af67::utils::is_stable<T2>()))
    }

    fun init(arg0: GAUGE_FACTORY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GaugeFactory{
            id     : 0x2::object::new(arg1),
            gauges : 0x2::linked_table::new<0x2::object::ID, GaugeInfo>(arg1),
        };
        0x2::transfer::share_object<GaugeFactory>(v0);
    }

    // decompiled from Move bytecode v6
}

