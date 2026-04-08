module 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::winner_selection {
    public(friend) fun add_winner_claim<T0>(arg0: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg1: address, arg2: u64) {
        let v0 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_winner_claims_mut(0x2::dynamic_object_field::borrow_mut<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id_mut<T0>(arg0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key()));
        if (0x2::table::contains<address, u64>(v0, arg1)) {
            let v1 = 0x2::table::borrow_mut<address, u64>(v0, arg1);
            *v1 = *v1 + arg2;
        } else {
            0x2::table::add<address, u64>(v0, arg1, arg2);
        };
    }

    public(friend) fun finalize_winner_selection<T0>(arg0: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg1: &0x2::random::Random, arg2: &mut 0x2::tx_context::TxContext) : 0x2::vec_set::VecSet<address> {
        let v0 = 0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>>(arg0);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id_mut<T0>(arg0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key());
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_selection_in_progress(v1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_winner_selection_not_in_progress_error());
        let v2 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_bucket_metadata(v1);
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_buckets_processed(v1) == 0x1::vector::length<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::BucketMetadata>(&v2), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_winner_selection_not_in_progress_error());
        let v3 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_num_winners(v1);
        let v4 = if (0x2::vec_set::length<address>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_unique_participants(v1)) <= v3) {
            *0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_unique_participants(v1)
        } else {
            let v5 = 0x2::random::new_generator(arg1, arg2);
            let v6 = 0x2::vec_set::empty<address>();
            let v7 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_winner_candidates(v1);
            while (0x2::vec_set::length<address>(&v6) < v3) {
                let v8 = 0x2::random::generate_u64_in_range(&mut v5, 0, 0x1::vector::length<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::WinnerCandidate>(v7) - 1);
                let v9 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::candidate_winner(0x1::vector::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::WinnerCandidate>(v7, v8));
                let v10 = !0x2::vec_set::contains<address>(&v6, &v9);
                if (v10) {
                    0x2::vec_set::insert<address>(&mut v6, v9);
                };
                0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_winner_selected(v0, v9, v8, v10);
            };
            v6
        };
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::set_game_winners(v1, v4);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::set_game_selection_completed(v1);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_final_winners_selected(v0, v4);
        v4
    }

    public(friend) fun get_winner_claim_amount<T0>(arg0: &0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg1: address) : u64 {
        *0x2::table::borrow<address, u64>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_winner_claims(0x2::dynamic_object_field::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id<T0>(arg0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key())), arg1)
    }

    public(friend) fun has_winner_claim<T0>(arg0: &0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg1: address) : bool {
        0x2::table::contains<address, u64>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_winner_claims(0x2::dynamic_object_field::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id<T0>(arg0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key())), arg1)
    }

    public(friend) fun remove_winner_claim<T0>(arg0: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg1: address) : u64 {
        0x2::table::remove<address, u64>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_winner_claims_mut(0x2::dynamic_object_field::borrow_mut<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id_mut<T0>(arg0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key())), arg1)
    }

    public(friend) fun select_winners_from_bucket<T0>(arg0: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg1: &0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::ParticipantBucket, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>>(arg0);
        let v1 = 0x2::dynamic_object_field::borrow_mut<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id_mut<T0>(arg0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key());
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_selection_in_progress(v1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_winner_selection_not_in_progress_error());
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_index(arg1) == 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_buckets_processed(v1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_bucket_index_error());
        let v2 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_bucket_metadata(v1);
        assert!(0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::ParticipantBucket>(arg1) == 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::metadata_bucket_id(0x1::vector::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::BucketMetadata>(&v2, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_index(arg1))), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_bucket_index_error());
        let v3 = 0x2::random::new_generator(arg2, arg3);
        let v4 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_range_starts(arg1);
        let v5 = 0x1::vector::length<u64>(v4);
        if (v5 == 0) {
            0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::increment_game_buckets_processed(v1);
            return
        };
        let v6 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_num_winners(v1);
        if (0x2::vec_set::length<address>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_unique_participants(v1)) <= v6) {
            let v7 = 0;
            while (v7 < v5) {
                let v8 = 0x2::dynamic_field::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::TicketRangeKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::TicketRange>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_id(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_ticket_range_key(*0x1::vector::borrow<u64>(v4, v7)));
                let v9 = 0x2::random::generate_u64_in_range(&mut v3, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::range_start(v8), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::range_end(v8));
                let v10 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::range_owner(v8);
                0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_winner_candidate_drawn(v0, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_index(arg1), v9, v10);
                0x1::vector::push_back<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::WinnerCandidate>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_winner_candidates_mut(v1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_winner_candidate(v10, v9, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_index(arg1)));
                v7 = v7 + 1;
            };
            let v11 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_bucket_metadata(v1);
            0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_bucket_winners_selected(v0, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_index(arg1), 0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::ParticipantBucket>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_ticket_range_start(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_ticket_range_end(arg1), v5, 0x1::vector::length<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::BucketMetadata>(&v11), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_buckets_processed(v1) + 1);
            0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::increment_game_buckets_processed(v1);
            return
        };
        let v12 = 0;
        while (v12 < 0x1::u64::max((0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_ticket_range_end(arg1) - 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_ticket_range_start(arg1) + 1) * v6 * 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_candidate_multiplier() / 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_total_tickets_sold(v1), 0x1::u64::min(v5, 3))) {
            let v13 = 0x2::random::generate_u64_in_range(&mut v3, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_ticket_range_start(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_ticket_range_end(arg1));
            let v14 = 0;
            let v15 = v5 - 1;
            let v16 = 0;
            while (v14 <= v15) {
                let v17 = (v14 + v15) / 2;
                let v18 = *0x1::vector::borrow<u64>(v4, v17);
                if (v18 <= v13) {
                    v16 = v18;
                    if (v17 == v5 - 1) {
                        break
                    };
                    if (*0x1::vector::borrow<u64>(v4, v17 + 1) > v13) {
                        break
                    };
                    v14 = v17 + 1;
                    continue
                };
                if (v17 == 0) {
                    break
                };
                v15 = v17 - 1;
            };
            let v19 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::range_owner(0x2::dynamic_field::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::TicketRangeKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::TicketRange>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_id(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_ticket_range_key(v16)));
            0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_winner_candidate_drawn(v0, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_index(arg1), v13, v19);
            0x1::vector::push_back<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::WinnerCandidate>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_winner_candidates_mut(v1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_winner_candidate(v19, v13, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_index(arg1)));
            v12 = v12 + 1;
        };
        let v20 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_bucket_metadata(v1);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_bucket_winners_selected(v0, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_index(arg1), 0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::ParticipantBucket>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_ticket_range_start(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_ticket_range_end(arg1), v12, 0x1::vector::length<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::BucketMetadata>(&v20), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_buckets_processed(v1) + 1);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::increment_game_buckets_processed(v1);
    }

    public(friend) fun start_winner_selection<T0>(arg0: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id_mut<T0>(arg0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key());
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_selection_not_started(v0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_winner_selection_in_progress_error());
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::set_game_selection_in_progress(v0);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::set_game_buckets_processed(v0, 0);
        *0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_winner_candidates_mut(v0) = 0x1::vector::empty<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::WinnerCandidate>();
    }

    // decompiled from Move bytecode v6
}

