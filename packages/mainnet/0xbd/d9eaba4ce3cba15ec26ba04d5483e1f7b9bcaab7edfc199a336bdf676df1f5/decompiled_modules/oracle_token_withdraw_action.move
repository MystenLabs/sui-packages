module 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_token_withdraw_action {
    fun actuate<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::OracleQueue<T0>, arg1: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::OracleToken, arg2: &mut 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::escrow_balance<T0>(arg2, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::oracle_queue_address<T0>(arg0));
        let v1 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::reward<T0>(arg0);
        let v2 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::rewards_owed_to_oracle(arg1, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(arg2)) * v1;
        let v3 = if (v0 < v2) {
            v0
        } else {
            v2
        };
        let v4 = 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::friend_key();
        let v5 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::escrow_withdraw<T0, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::FriendKey>(arg2, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::oracle_queue_address<T0>(arg0), v3, &v4, arg3);
        let v6 = 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::escrow_balance<T0>(arg2, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::oracle_queue_address<T0>(arg0));
        if (v6 < v1 * (0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::batch_size(arg2) + 1) && 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::crank_row_count(arg2) == 1) {
            0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::sub_crank_row_count<0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::aggregator_utils::FriendKey>(arg2, &v4);
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::evict_aggregator<T0>(arg0, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(arg2));
            0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::events::emit_aggregator_crank_eviction_event(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(arg2), 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::oracle_queue_address<T0>(arg0));
        };
        0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::events::emit_aggregator_escrow_withdraw_event(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::aggregator_address(arg2), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::authority(arg2), v6 + 0x2::coin::value<T0>(&v5), v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v5, 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::authority(arg2));
    }

    public entry fun run<T0>(arg0: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::OracleQueue<T0>, arg1: &mut 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle::OracleToken, arg2: &mut 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator, arg3: &mut 0x2::tx_context::TxContext) {
        validate<T0>(arg0, arg2);
        actuate<T0>(arg0, arg1, arg2, arg3);
    }

    public fun validate<T0>(arg0: &0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::OracleQueue<T0>, arg1: &0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::Aggregator) {
        assert!(0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::aggregator::escrow_balance<T0>(arg1, 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::oracle_queue_address<T0>(arg0)) >= 0xfd2e0f4383df3ec9106326dcd9a20510cdce72146754296deed15403fcd3df8b::oracle_queue::reward<T0>(arg0), 0x8d79f4d920b03d88faca1e421af023a87fbb1e4a6fd200248e6e9998d09e470::errors::PermissionDenied());
    }

    // decompiled from Move bytecode v6
}

