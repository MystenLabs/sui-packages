module 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan_query {
    struct QueryResult has drop {
        plans: vector<0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>,
        cursor: 0x1::option::Option<u64>,
        has_nex_page: bool,
        total: u64,
    }

    public fun cursor(arg0: &QueryResult) : &0x1::option::Option<u64> {
        &arg0.cursor
    }

    public fun has_nex_page(arg0: &QueryResult) : bool {
        arg0.has_nex_page
    }

    public fun plans(arg0: &QueryResult) : &vector<0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan> {
        &arg0.plans
    }

    public fun query_plans(arg0: &0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::auto_invest::Investment, arg1: address, arg2: 0x1::option::Option<u64>, arg3: 0x1::option::Option<u64>, arg4: 0x1::option::Option<bool>) : QueryResult {
        let v0 = 0x1::option::destroy_with_default<bool>(arg4, true);
        let v1 = 0x1::option::destroy_with_default<u64>(arg3, 100);
        assert!(v1 <= 100, 0);
        let v2 = 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::auto_invest::get_user_plans(arg0, arg1);
        let v3 = QueryResult{
            plans        : 0x1::vector::empty<0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>(),
            cursor       : 0x1::option::none<u64>(),
            has_nex_page : false,
            total        : 0x2::linked_table::length<u64, bool>(v2),
        };
        if (v3.total > 0) {
            let (v4, v5) = if (0x1::option::is_some<u64>(&arg2)) {
                (0, 0x1::option::destroy_some<u64>(arg2))
            } else {
                let v6 = if (v0) {
                    *0x1::option::borrow<u64>(0x2::linked_table::back<u64, bool>(v2))
                } else {
                    *0x1::option::borrow<u64>(0x2::linked_table::front<u64, bool>(v2))
                };
                0x1::vector::push_back<0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>(&mut v3.plans, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::clone(0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::auto_invest::get_plan(arg0, v6)));
                (1, v6)
            };
            let v7 = v5;
            let v8 = v4;
            while (v8 < v1) {
                let v9 = if (v0) {
                    0x2::linked_table::prev<u64, bool>(v2, v7)
                } else {
                    0x2::linked_table::next<u64, bool>(v2, v7)
                };
                if (0x1::option::is_some<u64>(v9)) {
                    let v10 = *0x1::option::borrow<u64>(v9);
                    v7 = v10;
                    0x1::vector::push_back<0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::Plan>(&mut v3.plans, 0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::plan::clone(0xa96cd71ea7b5a9969bf5379114c41023ed1d468ce4aea1693c3fb886a6ed3894::auto_invest::get_plan(arg0, v10)));
                };
                v8 = v8 + 1;
            };
            let v11 = v0 && 0x1::option::is_some<u64>(0x2::linked_table::prev<u64, bool>(v2, v7)) || 0x1::option::is_some<u64>(0x2::linked_table::next<u64, bool>(v2, v7));
            v3.has_nex_page = v11;
            0x1::option::fill<u64>(&mut v3.cursor, v7);
        };
        v3
    }

    public fun total(arg0: &QueryResult) : u64 {
        arg0.total
    }

    // decompiled from Move bytecode v6
}

