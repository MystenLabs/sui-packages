module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_init_action {
    fun actuate<T0>(arg0: vector<u8>, arg1: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::OracleQueue<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::SwitchboardDecimal, arg7: u64, arg8: bool, arg9: u64, arg10: u64, arg11: address, arg12: vector<address>, arg13: bool, arg14: u64, arg15: address, arg16: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::oracle_queue_address<T0>(arg1);
        let v1 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::friend_key();
        let v2 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::new<0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::FriendKey>(arg0, v0, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, &v1, arg16);
        let v3 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::new_aggregator_token(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(&v2), v0, arg2, arg3, arg5, arg10, arg11, arg12, arg13, arg14, arg16);
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::set_aggregator_token(&mut v2, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::aggregator_token_address(&v3), arg16);
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::freeze_aggregator_token(v3);
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::transfer_authority(&mut v2, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::new_authority(&v2, arg16), arg15, arg16);
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::events::emit_aggregator_init_event(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(&v2));
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::share_aggregator(v2);
    }

    public entry fun run<T0>(arg0: vector<u8>, arg1: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::OracleQueue<T0>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u128, arg7: u8, arg8: u64, arg9: bool, arg10: u64, arg11: u64, arg12: address, arg13: vector<address>, arg14: bool, arg15: &0x2::clock::Clock, arg16: address, arg17: &mut 0x2::tx_context::TxContext) {
        validate<T0>(arg2, arg3, arg4, arg5);
        actuate<T0>(arg0, arg1, arg2, arg3, arg4, arg5, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::new(arg6, arg7, false), arg8, arg9, arg10, arg11, arg12, arg13, arg14, 0x2::clock::timestamp_ms(arg15) / 1000, arg16, arg17);
    }

    public fun validate<T0>(arg0: u64, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg0 > 0 && arg0 <= 10, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::AggregatorInvalidBatchSize());
        assert!(arg1 > 0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::AggregatorInvalidMinOracleResults());
        assert!(arg2 > 0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::AggregatorInvalidMinJobs());
        assert!(arg1 <= arg0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::AggregatorInvalidBatchSize());
        assert!(arg3 >= 5, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::AggregatorInvalidUpdateDelay());
    }

    // decompiled from Move bytecode v6
}

