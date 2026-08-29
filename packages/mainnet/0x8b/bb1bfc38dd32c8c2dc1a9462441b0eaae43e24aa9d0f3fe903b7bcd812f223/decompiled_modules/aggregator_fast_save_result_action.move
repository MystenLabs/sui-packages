module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_fast_save_result_action {
    public entry fun initialize_result(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::OracleToken, arg1: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::AggregatorToken, arg2: u128, arg3: u8, arg4: bool, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, _) = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::oracle_token_data(arg0);
        let (v4, v5, _, v7, v8, _) = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::aggregator_token_data(arg1);
        assert!(v1 == v5, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        assert!(v2 > arg5, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::PermissionDenied());
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::can_update(arg0, v4, v8, arg5), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::PermissionDenied());
        let v10 = v7 == 1;
        let v11 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::new_result(arg1, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::new(arg2, arg3, arg4), v0, arg5, v10, arg6);
        if (v10) {
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::events::emit_aggregator_fast_update_event(v4, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::aggregator_token_address(arg1), 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::result_address(&v11), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::zero(), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::new(arg2, arg3, arg4));
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::update_aggregator(arg0, v4, arg5);
        };
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::events::emit_aggregator_result_event(v4, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::result_address(&v11));
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::freeze_result(v11);
    }

    public entry fun run(arg0: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::Result, arg1: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::OracleToken, arg2: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::AggregatorToken, arg3: u128, arg4: u8, arg5: bool, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, _) = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::oracle_token_data(arg1);
        let (v4, v5, v6, v7, v8, _) = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::aggregator_token_data(arg2);
        assert!(v4 == 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::result_address(arg0), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        let (v10, v11) = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::result(arg0);
        assert!(v1 == v5, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::InvalidArgument());
        assert!(v2 > arg6, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::PermissionDenied());
        assert!(v11 < arg6, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::PermissionDenied());
        assert!(0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::can_update(arg1, v4, v8, arg6), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::PermissionDenied());
        let v12 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::new(arg3, arg4, arg5);
        let (v13, v14) = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::extend_result(arg0, v12, v0, v6, v7, arg6, arg7);
        let v15 = v14;
        if (v13) {
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::events::emit_aggregator_fast_update_event(v4, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::aggregator_token_address(arg2), 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::result_address(&v15), v10, v12);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::update_aggregator(arg1, v4, arg6);
        };
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::events::emit_aggregator_result_event(v4, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::result_address(&v15));
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::freeze_result(v15);
    }

    // decompiled from Move bytecode v6
}

