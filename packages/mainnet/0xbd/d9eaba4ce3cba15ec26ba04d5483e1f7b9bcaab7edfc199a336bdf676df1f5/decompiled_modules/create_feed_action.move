module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::create_feed_action {
    public entry fun run<T0>(arg0: address, arg1: &0x2::clock::Clock, arg2: vector<u8>, arg3: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::OracleQueue<T0>, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: u8, arg10: u64, arg11: bool, arg12: u64, arg13: u64, arg14: address, arg15: vector<address>, arg16: bool, arg17: &mut 0x2::coin::Coin<T0>, arg18: u64, arg19: vector<u8>, arg20: vector<u8>, arg21: u8, arg22: vector<u8>, arg23: vector<u8>, arg24: u8, arg25: vector<u8>, arg26: vector<u8>, arg27: u8, arg28: vector<u8>, arg29: vector<u8>, arg30: u8, arg31: vector<u8>, arg32: vector<u8>, arg33: u8, arg34: vector<u8>, arg35: vector<u8>, arg36: u8, arg37: vector<u8>, arg38: vector<u8>, arg39: u8, arg40: vector<u8>, arg41: vector<u8>, arg42: u8, arg43: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::friend_key();
        let v1 = 0x2::clock::timestamp_ms(arg1) / 1000;
        let v2 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::oracle_queue_address<T0>(arg3);
        let v3 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::new<0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::FriendKey>(arg2, v2, arg4, arg5, arg6, arg7, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::math::new(arg8, arg9, false), arg10, arg11, arg12, arg13, arg14, arg15, arg16, v1, arg0, &v0, arg43);
        if (0x1::vector::length<u8>(&arg20) > 0) {
            let v4 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::new(arg19, arg20, v1, arg43);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_add_job_action::run(&mut v3, &v4, arg21, arg43);
            0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::freeze_job(v4);
        };
        if (0x1::vector::length<u8>(&arg23) > 0) {
            let v5 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::new(arg22, arg23, v1, arg43);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_add_job_action::run(&mut v3, &v5, arg24, arg43);
            0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::freeze_job(v5);
        };
        if (0x1::vector::length<u8>(&arg26) > 0) {
            let v6 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::new(arg25, arg26, v1, arg43);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_add_job_action::run(&mut v3, &v6, arg27, arg43);
            0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::freeze_job(v6);
        };
        if (0x1::vector::length<u8>(&arg29) > 0) {
            let v7 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::new(arg28, arg29, v1, arg43);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_add_job_action::run(&mut v3, &v7, arg30, arg43);
            0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::freeze_job(v7);
        };
        if (0x1::vector::length<u8>(&arg32) > 0) {
            let v8 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::new(arg31, arg32, v1, arg43);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_add_job_action::run(&mut v3, &v8, arg33, arg43);
            0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::freeze_job(v8);
        };
        if (0x1::vector::length<u8>(&arg35) > 0) {
            let v9 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::new(arg34, arg35, v1, arg43);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_add_job_action::run(&mut v3, &v9, arg36, arg43);
            0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::freeze_job(v9);
        };
        if (0x1::vector::length<u8>(&arg38) > 0) {
            let v10 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::new(arg37, arg38, v1, arg43);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_add_job_action::run(&mut v3, &v10, arg39, arg43);
            0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::freeze_job(v10);
        };
        if (0x1::vector::length<u8>(&arg41) > 0) {
            let v11 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::new(arg40, arg41, v1, arg43);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_add_job_action::run(&mut v3, &v11, arg42, arg43);
            0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::job::freeze_job(v11);
        };
        let v12 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::authority<T0>(arg3);
        let v13 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::new(v12, v2, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(&v3), v1, arg43);
        if (v12 == 0x2::tx_context::sender(arg43)) {
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::set(&mut v13, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::permission::PERMIT_ORACLE_QUEUE_USAGE(), v1);
        };
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::permission_create<T0>(arg3, v13);
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::escrow_deposit<T0, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::FriendKey>(&mut v3, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::oracle_queue_address<T0>(arg3), 0x2::coin::split<T0>(arg17, arg18, arg43), &v0);
        if (!arg11) {
            0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::add_crank_row_count<0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::FriendKey>(&mut v3, &v0);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::add_aggregator_to_crank<T0>(arg3, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(&v3));
        };
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::transfer_authority(&mut v3, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::new_authority(&v3, arg43), arg0, arg43);
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::events::emit_aggregator_init_event(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(&v3));
        let v14 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::new_aggregator_token(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(&v3), v2, arg4, arg5, arg7, arg13, arg14, arg15, arg16, v1, arg43);
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::set_aggregator_token(&mut v3, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::aggregator_token_address(&v14), arg43);
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::freeze_aggregator_token(v14);
        0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::share_aggregator(v3);
    }

    // decompiled from Move bytecode v6
}

