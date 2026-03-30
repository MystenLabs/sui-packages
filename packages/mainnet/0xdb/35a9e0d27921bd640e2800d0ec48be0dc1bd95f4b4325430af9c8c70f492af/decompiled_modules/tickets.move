module 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::tickets {
    public(friend) fun add_participant<T0>(arg0: &mut 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::Lotto<T0>, arg1: &mut 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::ParticipantBucket, arg2: address, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : (u64, u64) {
        let v0 = 0x2::dynamic_object_field::borrow_mut<0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::GameKey, 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::RaffleGame>(0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::lotto_id_mut<T0>(arg0), 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::new_game_key());
        assert!(0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::bucket_num_ranges(arg1) < 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::get_max_ranges_per_bucket(), 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::errors::get_bucket_full_error());
        if (0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::bucket_num_ranges(arg1) + 1 >= 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::get_max_ranges_per_bucket()) {
            let v1 = 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::game_bucket_metadata(v0);
            let v2 = 0x1::vector::length<0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::BucketMetadata>(&v1);
            let v3 = 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::game_total_tickets_sold(v0) + arg3;
            let v4 = 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::new_participant_bucket(v2, v3, arg4);
            let v5 = 0x2::object::id<0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::ParticipantBucket>(&v4);
            0x1::vector::push_back<0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::BucketMetadata>(0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::game_bucket_metadata_mut(v0), 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::new_bucket_metadata(v5, v2, v3));
            0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::set_game_current_bucket_id(v0, v5);
            0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::share_bucket(v4);
        };
        let v6 = 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::game_total_tickets_sold(v0);
        let v7 = v6 + arg3 - 1;
        0x2::dynamic_field::add<0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::TicketRangeKey, 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::TicketRange>(0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::bucket_id_mut(arg1), 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::new_ticket_range_key(v6), 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::new_ticket_range(arg2, v6, v7));
        0x1::vector::push_back<u64>(0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::bucket_range_starts_mut(arg1), v6);
        0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::set_bucket_num_ranges(arg1, 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::bucket_num_ranges(arg1) + 1);
        0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::set_bucket_ticket_range_end(arg1, v7);
        0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::increment_game_total_tickets_sold(v0, arg3);
        0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::increment_game_total_ticket_purchases(v0);
        if (!0x2::vec_set::contains<address>(0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::game_unique_participants(v0), &arg2)) {
            0x2::vec_set::insert<address>(0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::game_unique_participants_mut(v0), arg2);
        };
        let v8 = 0x1::vector::borrow_mut<0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::BucketMetadata>(0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::game_bucket_metadata_mut(v0), 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::bucket_index(arg1));
        0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::set_metadata_ticket_range_end(v8, v7);
        0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::set_metadata_num_ranges(v8, 0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::bucket_num_ranges(arg1));
        (v6, v7)
    }

    public(friend) fun create_and_transfer_receipt(arg0: 0x2::object::ID, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::transfer_receipt(0xdb35a9e0d27921bd640e2800d0ec48be0dc1bd95f4b4325430af9c8c70f492af::types::new_receipt(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

