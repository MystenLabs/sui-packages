module 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::harvest {
    public fun harvest<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0x2::clock::Clock, arg3: u64) : vector<u64> {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg1, arg0);
        let (v1, v2) = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::harvest<T0>(&v0, arg0, arg1, arg3);
        credit_rows<T0>(&v0, arg0, arg1, arg2, v2);
        v1
    }

    fun credit_rows<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0x2::clock::Clock, arg4: vector<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::HarvestFeeCredit>) {
        let v0 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::game_paused(arg2);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::HarvestFeeCredit>(&arg4)) {
            let v3 = 0x1::vector::borrow<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::HarvestFeeCredit>(&arg4, v2);
            let v4 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::fee_credit_amount(v3);
            let v5 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::fee_credit_owner(v3);
            if (v4 > 0) {
                0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::game_book::note_fee_credit(arg0, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(arg0, arg1), v5, v4);
            };
            let v6 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::fee_credit_refund(v3);
            if (v6 > 0) {
                0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::game_book::note_harvest_gain(arg0, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(arg0, arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg2), v5, v6, !v0, v1);
            };
            if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::fee_credit_settle(v3) && !v0) {
                0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::game_book::settle_fee_achievement(arg0, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(arg0, arg1), 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::uid(arg2), v5, v1);
            };
            v2 = v2 + 1;
        };
    }

    public fun emergency_drain<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::AuthorityCap<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::PACKAGE, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::authority::ADMIN>, arg3: &0x2::clock::Clock, arg4: u64) : vector<u64> {
        let v0 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg1, arg0);
        let (v1, v2) = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::emergency_drain<T0>(&v0, arg0, arg1, arg2, arg4);
        credit_rows<T0>(&v0, arg0, arg1, arg3, v2);
        v1
    }

    // decompiled from Move bytecode v7
}

