module 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::suilotto {
    struct LottoCap has key {
        id: 0x2::object::UID,
    }

    entry fun buy_tickets<T0>(arg0: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg1: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::ParticipantBucket, arg2: u64, arg3: 0x2::coin::Coin<T0>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_lotto_version<T0>(arg0);
        assert!(arg2 > 0, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_num_tickets_error());
        assert!(0x2::clock::timestamp_ms(arg4) < 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_end_time<T0>(arg0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_lotto_ended_error());
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_active<T0>(arg0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_lotto_ended_error());
        let v0 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_ticket_price<T0>(arg0) * arg2;
        assert!(0x2::coin::value<T0>(&arg3) >= v0, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_insufficient_funds_error());
        let v1 = 0x2::coin::into_balance<T0>(arg3);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::add_to_balance<T0>(arg0, 0x2::balance::split<T0>(&mut v1, v0));
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::handle_excess_balance<T0>(v1, arg5);
        let v2 = 0x2::tx_context::sender(arg5);
        let (v3, v4) = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::tickets::add_participant<T0>(arg0, arg1, v2, arg2, arg5);
        let v5 = 0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>>(arg0);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::tickets::create_and_transfer_receipt(v5, arg2, v2, arg5);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_tickets_bought(v5, v2, arg2, v3, v4, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_total_tickets_sold<T0>(arg0));
    }

    entry fun claim_prize<T0>(arg0: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_lotto_version<T0>(arg0);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_raffle_game_version(0x2::dynamic_object_field::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id<T0>(arg0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key()));
        assert!(!0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_active<T0>(arg0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_lotto_not_ended_error());
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::winner_selection::has_winner_claim<T0>(arg0, v0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_not_a_winner_error());
        let v1 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::winner_selection::remove_winner_claim<T0>(arg0, v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::take_from_balance<T0>(arg0, v1), arg1), v0);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_prize_claimed(0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>>(arg0), v0, v1);
    }

    fun create_and_transfer_proof_of_lotto<T0>(arg0: &0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::transfer_proof_of_lotto(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_proof_of_lotto<T0>(arg0, arg1, arg2, arg3), 0x2::tx_context::sender(arg3));
    }

    entry fun create_genesis_lotto<T0>(arg0: &LottoCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_ticket_price_error());
        assert!(arg5 > 0x2::clock::timestamp_ms(arg8), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_end_time_error());
        assert!(arg3 > 0 && arg3 <= 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_max_winners(), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_num_winners_error());
        let v0 = 0x2::coin::into_balance<T0>(arg6);
        assert!(0x2::balance::value<T0>(&v0) >= arg7, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_insufficient_funds_error());
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::handle_excess_balance<T0>(v0, arg9);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = create_lotto_struct<T0>(arg1, arg2, v1, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_type_genesis(), arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg7), arg5, arg9);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_lotto_created<T0>(&v2);
        create_and_transfer_proof_of_lotto<T0>(&v2, arg3, arg4, arg9);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::share_lotto<T0>(v2);
    }

    entry fun create_lotto<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: u8, arg3: u64, arg4: u64, arg5: u64, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        assert!(arg4 > 0, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_ticket_price_error());
        assert!(arg5 > 0x2::clock::timestamp_ms(arg8), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_end_time_error());
        assert!(arg2 == 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_type_fixed_prize() || arg2 == 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_type_pooled_prize(), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_lotto_type_error());
        assert!(arg3 > 0 && arg3 <= 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_max_winners(), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_num_winners_error());
        let v0 = 0x2::coin::into_balance<T0>(arg6);
        assert!(0x2::balance::value<T0>(&v0) >= arg7, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_insufficient_funds_error());
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::handle_excess_balance<T0>(v0, arg9);
        let v1 = 0x2::tx_context::sender(arg9);
        let v2 = create_lotto_struct<T0>(arg0, arg1, v1, arg2, arg3, arg4, 0x2::balance::split<T0>(&mut v0, arg7), arg5, arg9);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_lotto_created<T0>(&v2);
        create_and_transfer_proof_of_lotto<T0>(&v2, arg3, arg4, arg9);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::share_lotto<T0>(v2);
    }

    fun create_lotto_struct<T0>(arg0: 0x1::string::String, arg1: 0x1::string::String, arg2: address, arg3: u8, arg4: u64, arg5: u64, arg6: 0x2::balance::Balance<T0>, arg7: u64, arg8: &mut 0x2::tx_context::TxContext) : 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0> {
        let v0 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_participant_bucket(0, 0, arg8);
        let v1 = 0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::ParticipantBucket>(&v0);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::share_bucket(v0);
        let v2 = 0x1::vector::empty<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::BucketMetadata>();
        0x1::vector::push_back<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::BucketMetadata>(&mut v2, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_bucket_metadata(v1, 0, 0));
        let v3 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_lotto<T0>(arg0, arg1, arg3, arg2, arg6, arg7, arg8);
        0x2::dynamic_object_field::add<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id_mut<T0>(&mut v3), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key(), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_raffle_game(arg4, arg5, v2, v1, arg8));
        v3
    }

    entry fun end_lotto_continue<T0>(arg0: &LottoCap, arg1: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg2: &0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::ParticipantBucket, arg3: &0x2::random::Random, arg4: &mut 0x2::tx_context::TxContext) {
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_lotto_version<T0>(arg1);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_raffle_game_version(0x2::dynamic_object_field::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key()));
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::winner_selection::select_winners_from_bucket<T0>(arg1, arg2, arg3, arg4);
    }

    entry fun end_lotto_finalize<T0>(arg0: &LottoCap, arg1: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_lotto_version<T0>(arg1);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_raffle_game_version(0x2::dynamic_object_field::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key()));
        let v0 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_lotto_type<T0>(arg1);
        if (v0 == 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_type_genesis()) {
            0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::genesis_prize::finalize_end_lotto<T0>(arg1, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::winner_selection::finalize_winner_selection<T0>(arg1, arg2, arg3), arg3);
        } else if (v0 == 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_type_fixed_prize()) {
            0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::fixed_prize::finalize_end_lotto<T0>(arg1, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::winner_selection::finalize_winner_selection<T0>(arg1, arg2, arg3), arg3);
        } else {
            assert!(v0 == 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_type_pooled_prize(), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_lotto_type_error());
            0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::pooled_prize::finalize_end_lotto<T0>(arg1, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::winner_selection::finalize_winner_selection<T0>(arg1, arg2, arg3), arg3);
        };
    }

    entry fun end_lotto_start<T0>(arg0: &LottoCap, arg1: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg2: &0x2::clock::Clock) {
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_lotto_version<T0>(arg1);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_raffle_game_version(0x2::dynamic_object_field::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key()));
        assert!(0x2::clock::timestamp_ms(arg2) >= 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_end_time<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_end_time_error());
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_active<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_lotto_ended_error());
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::winner_selection::start_winner_selection<T0>(arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = LottoCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<LottoCap>(v0, 0x2::tx_context::sender(arg0));
    }

    entry fun migrate_lotto<T0>(arg0: &LottoCap, arg1: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>) {
        let v0 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_version<T0>(arg1);
        let v1 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::raffle_game_version(0x2::dynamic_object_field::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id_unchecked<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key()));
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::migrate_lotto_to_current<T0>(arg1);
        let v2 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_version<T0>(arg1);
        let v3 = 0x2::dynamic_object_field::borrow_mut<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id_mut_unchecked<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key());
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::migrate_raffle_game_to_current(v3);
        let v4 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::raffle_game_version(v3);
        if (v0 != v2 || v1 != v4) {
            0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_lotto_migrated(0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>>(arg1), v0, v2, v1, v4);
        };
    }

    entry fun refund_lotto_continue<T0>(arg0: &LottoCap, arg1: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg2: &0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::ParticipantBucket, arg3: &mut 0x2::tx_context::TxContext) {
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_lotto_version<T0>(arg1);
        let v0 = 0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>>(arg1);
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_active<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_lotto_ended_error());
        let v1 = 0x2::dynamic_object_field::borrow_mut<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id_mut<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key());
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_raffle_game_version(v1);
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_refund_in_progress(v1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_refund_not_in_progress_error());
        let v2 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_refund_buckets_processed(v1);
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_index(arg2) == v2, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_bucket_index_error());
        let v3 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_bucket_metadata(v1);
        assert!(0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::ParticipantBucket>(arg2) == 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::metadata_bucket_id(0x1::vector::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::BucketMetadata>(&v3, v2)), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_invalid_bucket_index_error());
        let v4 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_range_starts(arg2);
        let v5 = 0;
        let v6 = 0;
        let v7 = 0;
        while (v7 < 0x1::vector::length<u64>(v4)) {
            let v8 = 0x2::dynamic_field::borrow<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::TicketRangeKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::TicketRange>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::bucket_id(arg2), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_ticket_range_key(*0x1::vector::borrow<u64>(v4, v7)));
            let v9 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::range_owner(v8);
            let v10 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::range_end(v8) - 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::range_start(v8) + 1;
            let v11 = v10 * 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_ticket_price<T0>(arg1);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::take_from_balance<T0>(arg1, v11), arg3), v9);
            0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_participant_refunded(v0, v9, v11, v10);
            v5 = v5 + 1;
            v6 = v6 + v11;
            v7 = v7 + 1;
        };
        let v12 = 0x2::dynamic_object_field::borrow_mut<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id_mut<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key());
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::increment_game_refund_buckets_processed(v12);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_bucket_refunded(v0, v2, 0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::ParticipantBucket>(arg2), v5, v6, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_refund_buckets_processed(v12), 0x1::vector::length<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::BucketMetadata>(&v3));
    }

    entry fun refund_lotto_finalize<T0>(arg0: &LottoCap, arg1: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_lotto_version<T0>(arg1);
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_active<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_lotto_ended_error());
        let v0 = 0x2::dynamic_object_field::borrow_mut<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id_mut<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key());
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_raffle_game_version(v0);
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_refund_in_progress(v0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_refund_not_in_progress_error());
        let v1 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_bucket_metadata(v0);
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_refund_buckets_processed(v0) == 0x1::vector::length<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::BucketMetadata>(&v1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_refund_buckets_not_processed_error());
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::set_game_refund_completed(v0);
        let v2 = 0x2::vec_set::length<address>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_unique_participants(v0));
        let v3 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_balance_value<T0>(arg1);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::take_from_balance<T0>(arg1, v3), arg2), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_creator<T0>(arg1));
        };
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::set_lotto_state_refunded<T0>(arg1);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_lotto_refunded<T0>(0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>>(arg1), v3, v2, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::get_balance_value<T0>(arg1));
    }

    entry fun refund_lotto_start<T0>(arg0: &LottoCap, arg1: &mut 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>) {
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_lotto_version<T0>(arg1);
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_active<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_lotto_ended_error());
        let v0 = 0x2::dynamic_object_field::borrow_mut<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::GameKey, 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::RaffleGame>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::lotto_id_mut<T0>(arg1), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::new_game_key());
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::assert_raffle_game_version(v0);
        assert!(!0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_selection_not_started(v0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_refund_selection_not_started_error());
        assert!(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::is_refund_not_started(v0), 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::errors::get_refund_already_in_progress_error());
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::set_game_refund_in_progress(v0);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::set_game_refund_buckets_processed(v0, 0);
        let v1 = 0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_bucket_metadata(v0);
        0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::events::emit_refund_started(0x2::object::id<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::Lotto<T0>>(arg1), 0x1::vector::length<0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::BucketMetadata>(&v1), 0x2::vec_set::length<address>(0xf9726b51db60cf45580b97265ae81af6a20d02b05f8392214cfc5444eb122f3d::types::game_unique_participants(v0)));
    }

    // decompiled from Move bytecode v6
}

