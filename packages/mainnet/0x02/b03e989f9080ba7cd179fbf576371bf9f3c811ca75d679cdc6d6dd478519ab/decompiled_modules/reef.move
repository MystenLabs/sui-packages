module 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::reef {
    public fun on_query_settled<T0, T1>(arg0: &0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::query::Query<T0>, arg1: 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::callback::QuerySettled, arg2: &mut 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market::Market<T1>, arg3: &0x2::clock::Clock) {
        assert!(0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::callback::settled_query_id(&arg1) == 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::query::id<T0>(arg0), 1);
        assert!(0x1::option::some<0x2::object::ID>(0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::callback::settled_query_id(&arg1)) == 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market::reef_query_id<T1>(arg2), 1);
        let v0 = 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market::outcome_values<T1>(arg2);
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<vector<u8>>(v0)) {
            let v3 = 0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::callback::settled_data(&arg1);
            if (0x1::vector::borrow<vector<u8>>(v0, v1) == &v3) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 11 */
                assert!(0x1::option::is_some<u64>(&v2), 2);
                0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::market::resolve<T1>(arg2, 0x1::option::destroy_some<u64>(v2), arg3);
                0x74355104dc60857523e4367650df08c7fef8cfb08629f84ab3385d34fa063041::callback::verify_query_settled<0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::CORAL_XCH>(arg1, 0x2b03e989f9080ba7cd179fbf576371bf9f3c811ca75d679cdc6d6dd478519ab::coral::make_witness());
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 11 */
    }

    // decompiled from Move bytecode v6
}

