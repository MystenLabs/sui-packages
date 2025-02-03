module 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot_put_up_candidate_logic {
    public(friend) fun mutate(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUp, arg1: &mut 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::Slot, arg2: &0x2::tx_context::TxContext) {
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_candidate_inscription_id(arg1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::candidate_inscription_put_up::candidate_inscription_id(arg0));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_candidate_hash(arg1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::candidate_inscription_put_up::candidate_hash(arg0));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_candidate_inscriber(arg1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::candidate_inscription_put_up::candidate_inscriber(arg0));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_candidate_timestamp(arg1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::candidate_inscription_put_up::candidate_timestamp(arg0));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_candidate_amount(arg1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::candidate_inscription_put_up::candidate_amount(arg0));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_candidate_nonce(arg1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::candidate_inscription_put_up::candidate_nonce(arg0));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_candidate_difference(arg1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::candidate_inscription_put_up::candidate_difference(arg0));
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::set_candidate_content(arg1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::candidate_inscription_put_up::candidate_content(arg0));
    }

    public(friend) fun verify(arg0: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::Inscription, arg1: &0x2::clock::Clock, arg2: &0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::Slot, arg3: &0x2::tx_context::TxContext) : 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::CandidateInscriptionPutUp {
        assert!(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::round(arg2) == 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::round(arg0), 100);
        assert!(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::slot_number(arg2) == 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::slot_number(arg0), 101);
        assert!(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::amount(arg0) <= 385802469, 103);
        assert!(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::slot_max_amount(arg2) >= 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::minted_amount(arg2) + 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::amount(arg0), 103);
        let v0 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::round(arg2);
        let v1 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::genesis_timestamp(arg2);
        assert!(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::timestamp(arg0) >= 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::time_util::round_started_at(v1, v0), 105);
        let v2 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::time_util::count_rounds(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::genesis_timestamp(arg2), 0x2::clock::timestamp_ms(arg1));
        assert!(v2 <= v0 || 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_id(arg2) == 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::id_util::id_placeholder(), 104);
        let v3 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::qualified_difference(arg2);
        let v4 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::qualified_hash(arg2);
        let v5 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::qualified_timestamp(arg2);
        if (v0 == 0 || 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::qualified_inscription_id(arg2) == 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::id_util::id_placeholder() || 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::qualified_hash(arg2) == 0x1::vector::empty<u8>() || 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::qualified_timestamp(arg2) == 0) {
            v3 = 256 * 1000000;
            v4 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::id_util::hash_placeholder();
            v5 = v1 + 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::time_util::round_duration_ms() / 2;
        };
        let v6 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::time_util::elapsed_time_after_round(v1, v5, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::qualified_round(arg2));
        let v7 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::hash(arg0);
        let v8 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::time_util::elapsed_time_after_round(v1, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::timestamp(arg0), v0);
        let v9 = v8;
        let v10 = if (v8 > v6) {
            v8 - v6
        } else {
            v6 - v8
        };
        if (v10 > 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::time_util::round_duration_ms()) {
            v9 = v8 + 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::time_util::round_duration_ms();
        };
        let v11 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::qualified_inscription_id(arg2);
        let v12 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::id(arg0);
        let v13 = 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::diff::calculate_difference(0x1::hash::sha3_256(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::byte_util::concat(&v4, 0x2::bcs::to_bytes<0x2::object::ID>(&v11))), 0x1::hash::sha3_256(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::byte_util::concat(&v7, 0x2::bcs::to_bytes<0x2::object::ID>(&v12))), v6, v9);
        let v14 = if (v2 > v0) {
            v2 - v0
        } else {
            0
        };
        if (0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_inscription_id(arg2) == 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::id_util::id_placeholder()) {
            assert!(0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::diff::major_difference_equals_or_less_than(v13, v3 + v14 * 1000000), 102);
        } else {
            assert!(v13 < 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::candidate_difference(arg2) + v14 * 1000000, 102);
        };
        0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::slot::new_candidate_inscription_put_up(arg2, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::id(arg0), v0, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::hash(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::inscriber(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::timestamp(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::amount(arg0), 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::nonce(arg0), v13, 0x776fbac3115141986702630edf576b42adbcf60dc86a56a5875703fe817b670e::inscription::content(arg0))
    }

    // decompiled from Move bytecode v6
}

