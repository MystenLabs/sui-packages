module 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::account_transfer {
    public fun transfer_account<T0>(arg0: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg1: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg2: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg3: 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::AccountCap, arg4: address, arg5: &0x2::tx_context::TxContext) {
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::assert_unpaused(arg1, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::pause_accounts());
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg0);
        let v0 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg0);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_exchange<T0>(arg2, v0);
        assert!(arg4 != @0x0, 13835058261440593921);
        let v1 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue_on<T0>(arg1, arg0);
        let v2 = 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg2);
        let (v3, v4) = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::transfer_owner<T0>(&v1, arg2, arg3, arg4);
        let v5 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid_mut<T0>(&v1, arg0);
        let v6 = vector[];
        let v7 = v4;
        0x1::vector::reverse<address>(&mut v7);
        let v8 = 0;
        while (v8 < 0x1::vector::length<address>(&v7)) {
            let v9 = 0x1::vector::pop_back<address>(&mut v7);
            0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::holder_book::remove_delegate(v5, v2, v9);
            if (!0x1::vector::contains<address>(&v6, &v9)) {
                0x1::vector::push_back<address>(&mut v6, v9);
            };
            v8 = v8 + 1;
        };
        0x1::vector::destroy_empty<address>(v7);
        0xa12d32dd4380fba21a9892cfef1288dc30717ced46f3558df00549906f8c8a26::holder_book::move_holder(v5, v2, v3, arg4);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::referral_book::move_bind(&v1, v5, v3, arg4);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::fold_parked<T0>(&v1, arg0, arg4, v2);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::events::emit_account_transferred_event(&v1, v0, v2, v3, arg4, v6);
    }

    // decompiled from Move bytecode v7
}

