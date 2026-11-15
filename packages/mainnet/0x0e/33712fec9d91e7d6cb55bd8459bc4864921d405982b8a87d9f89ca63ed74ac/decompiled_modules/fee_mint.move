module 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fee_mint {
    public fun mint_on_loss<T0, T1, T2: drop>(arg0: T2, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::Config, arg3: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>, arg4: 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::LossTicket, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::object::ID, address, u64, u64, 0x2::coin::Coin<T1>) {
        let v0 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::reward_supply<T0, T1>(arg1);
        let v1 = 0x1::type_name::with_original_ids<T2>();
        let v2 = 0x1::type_name::with_original_ids<T1>();
        assert!(0x1::type_name::address_string(&v1) == 0x1::type_name::address_string(&v2), 13835621443322511365);
        let v3 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::auth::issue(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::uid<T0>(arg1));
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::assert_version<T0>(arg1);
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::assert_exchange<T0>(arg3, 0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>>(arg1));
        let v4 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::account_id(&arg4);
        assert!(0x2::object::id<0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::Account<T0>>(arg3) == v4, 13835058519138631681);
        let (v5, v6) = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::fees::settle_parked(arg4);
        let v7 = 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::account::owner<T0>(arg3);
        if (0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::category_paused(arg2, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::config::pause_fee_mint())) {
            if (v6) {
                0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::add_pending_basis<T0>(&v3, arg1, v4, v5);
            } else {
                park<T0>(&v3, arg1, v4, v5, 0x2::clock::timestamp_ms(arg5));
            };
            return (v4, v7, 0, 0, 0x2::coin::zero<T1>(arg6))
        };
        let v8 = (0x1::u256::min(ticket_mint(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::tail_progress<T0>(arg1), v5), ((18446744073709551615 - v0) as u256)) as u64);
        let v9 = 0x2::clock::timestamp_ms(arg5);
        if (v6) {
            let (v10, v11, v12) = 0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::reserve_chunk_epochs<T0>(arg1, v4, 0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::claim_epochs());
            let v13 = v10;
            if (!0x1::vector::is_empty<u64>(&v13) && !0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::prepare<T0, T1>(&v3, arg1, v7, v9, &v13)) {
                0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::add_pending_basis<T0>(&v3, arg1, v4, v5);
                0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::note_ledger_full<T0>(&v3, arg1, v7, 0x1::option::some<0x2::object::ID>(v4), v5, 0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::park_claim_kind());
                return (v4, v7, 0, 0, 0x2::coin::zero<T1>(arg6))
            };
            let v14 = if (0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::reserve_epochs<T0>(arg1, v4) <= 0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::claim_epochs()) {
                v5
            } else {
                0x1::u64::min(v12, v5)
            };
            if (0x1::u256::min(ticket_mint(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::tail_progress<T0>(arg1), v14), (v11 as u256)) > ((18446744073709551615 - v0) as u256)) {
                0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::add_pending_basis<T0>(&v3, arg1, v4, v5);
                return (v4, v7, 0, 0, 0x2::coin::zero<T1>(arg6))
            };
            let (v15, v16, v17) = 0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::take_reserve_chunk<T0>(&v3, arg1, v4, 0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::claim_epochs());
            let v18 = v16;
            let v19 = v5 - v14;
            0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::add_pending_basis<T0>(&v3, arg1, v4, v19);
            let v20 = 0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::cut_reserve<T0>(&v3, arg1, v15, (0x1::u256::min(ticket_mint(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::tail_progress<T0>(arg1), v14), (v11 as u256)) as u64));
            let v21 = 0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::locked_mint::parts_total(&v20);
            if (v21 > 0) {
                0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::locked_mint::lock_reserved<T0, T1>(&v3, arg1, v7, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::mint_reward<T0, T1>(&v3, arg1, v21, arg6), v14, v20, v18, v9, arg6);
            };
            0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::note_claim<T0>(&v3, arg1, v4, 0x1::vector::length<0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::EpochBasis>(&v18), v14, v21, v17, v19);
            return (v4, v7, v14, v21, 0x2::coin::zero<T1>(arg6))
        };
        if (v8 > 0) {
            let v22 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v22, v9 / 86400000);
            if (!0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::prepare<T0, T1>(&v3, arg1, v7, v9, &v22)) {
                park<T0>(&v3, arg1, v4, v5, v9);
                0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::note_ledger_full<T0>(&v3, arg1, v7, 0x1::option::some<0x2::object::ID>(v4), v5, 0xe5c797e7be1d7e69ed8f280dda2579611e929c82d62321d04630847f6cb7b134::locked_mint::park_loss_kind());
                return (v4, v7, 0, 0, 0x2::coin::zero<T1>(arg6))
            };
            0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::locked_mint::lock_loss<T0, T1>(&v3, arg1, v7, 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::mint_reward<T0, T1>(&v3, arg1, v8, arg6), v5, v9, arg6);
        };
        (v4, v7, v5, v8, 0x2::coin::zero<T1>(arg6))
    }

    public fun minted_out(arg0: u64, arg1: u64) : u64 {
        let v0 = minted_out_wide(arg0, arg1);
        assert!(v0 <= (18446744073709551615 as u256), 13835339719237566467);
        (v0 as u64)
    }

    fun minted_out_wide(arg0: u64, arg1: u64) : u256 {
        if (arg1 == 0) {
            return 0
        };
        if (arg0 == 0) {
            return (arg1 as u256) * (100000 as u256)
        };
        let v0 = (120000000000000 as u256);
        let v1 = v0 + (arg0 as u256);
        (arg1 as u256) * (100000 as u256) * v0 * v0 / v1 * v1
    }

    public(friend) fun park<T0>(arg0: &0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::access::Auth, arg1: &mut 0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::Exchange<T0>, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        if (arg3 == 0) {
            return
        };
        0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::add_pending_basis<T0>(arg0, arg1, arg2, arg3);
        0x5f87c8c6d06cf70c4dee302ca375ac337927064b0ed19b0fd13674512fedab4a::locked_mint::reserve<T0>(arg0, arg1, arg2, (0x1::u256::min(ticket_mint(0xb4d5d077a8997f8dcbfefe36dd61ec8f26dfa0f789ba83e81e55252fd30eb3a2::exchange::tail_progress<T0>(arg1), arg3), (18446744073709551615 as u256)) as u64), arg3, arg4);
    }

    fun ticket_mint(arg0: u64, arg1: u64) : u256 {
        minted_out_wide(arg0, arg1)
    }

    // decompiled from Move bytecode v7
}

