module 0x80f9b6215ae18ed1a77f5d5153c4327fd48e17dbbcd12cde06b94dd2b95e3b18::price_supporter {
    struct MoomePriceSupporter has store, key {
        id: 0x2::object::UID,
        support_price_k: u256,
        last_time_support_price_hit: u64,
        last_time_support_price_not_hit: u64,
        adjust_support_interval: u64,
        meta: vector<u8>,
    }

    public(friend) fun adjust_support_price_to_current_pool<T0, T1>(arg0: &mut MoomePriceSupporter, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg2: &0x2::clock::Clock) {
        arg0.support_price_k = get_pool_price_k<T0, 0x2::sui::SUI, T1>(arg1);
        arg0.last_time_support_price_hit = 0x2::clock::timestamp_ms(arg2);
        arg0.last_time_support_price_not_hit = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun current_support_price(arg0: &MoomePriceSupporter) : u256 {
        arg0.support_price_k
    }

    fun get_pool_price_k<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>) : u256 {
        let (v0, v1) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_balance<T0, T1, T2>(arg0);
        (v0 as u256) * 1000000000000 / (v1 as u256)
    }

    public(friend) fun is_pool_in_expected_price_scope<T0, T1>(arg0: &mut MoomePriceSupporter, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, 0x2::sui::SUI, T1>, arg2: &0x2::clock::Clock) : bool {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.last_time_support_price_hit == 0) {
            arg0.last_time_support_price_hit = v0;
        };
        if (arg0.last_time_support_price_not_hit == 0) {
            arg0.last_time_support_price_not_hit = v0;
        };
        if (arg0.support_price_k >= get_pool_price_k<T0, 0x2::sui::SUI, T1>(arg1)) {
            if (v0 > arg0.last_time_support_price_hit + arg0.adjust_support_interval && v0 < arg0.last_time_support_price_not_hit + arg0.adjust_support_interval) {
                arg0.support_price_k = arg0.support_price_k * 97 / 100;
                arg0.last_time_support_price_hit = v0;
            };
            arg0.last_time_support_price_not_hit = v0;
            return true
        };
        if (v0 > arg0.last_time_support_price_not_hit + arg0.adjust_support_interval && v0 < arg0.last_time_support_price_hit + arg0.adjust_support_interval) {
            arg0.support_price_k = arg0.support_price_k * 100 / 99;
            arg0.last_time_support_price_not_hit = v0;
        };
        arg0.last_time_support_price_hit = v0;
        false
    }

    public(friend) fun make(arg0: &mut 0x2::tx_context::TxContext) : MoomePriceSupporter {
        MoomePriceSupporter{
            id                              : 0x2::object::new(arg0),
            support_price_k                 : 100000000000000,
            last_time_support_price_hit     : 0,
            last_time_support_price_not_hit : 0,
            adjust_support_interval         : 86400000,
            meta                            : 0x1::vector::empty<u8>(),
        }
    }

    // decompiled from Move bytecode v6
}

