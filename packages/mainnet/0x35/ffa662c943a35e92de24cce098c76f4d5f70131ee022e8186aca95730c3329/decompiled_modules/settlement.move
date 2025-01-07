module 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::settlement {
    struct FirstSubmissionEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        node_id: 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId,
    }

    struct DisputeEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        timeout: 0x1::option::Option<TimeoutInfo>,
    }

    struct NewlySampledNodesEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        new_nodes: vector<MapNodeToChunk>,
    }

    struct MapNodeToChunk has copy, drop, store {
        node_id: 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId,
        order: u64,
    }

    struct SettledEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        oracle_node_id: 0x1::option::Option<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>,
    }

    struct RetrySettlementEvent has copy, drop {
        ticket_id: 0x2::object::ID,
        how_many_nodes_in_echelon: u64,
    }

    struct SettlementTicket has store, key {
        id: 0x2::object::UID,
        model_name: 0x1::ascii::String,
        echelon_id: 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::EchelonId,
        all: vector<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>,
        completed: vector<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>,
        merkle_root: vector<u8>,
        merkle_leaves: vector<u8>,
        input_fee_per_token: u64,
        output_fee_per_token: u64,
        collected_fee_in_protocol_token: u64,
        payer: address,
        input_tokens_count: 0x1::option::Option<u64>,
        output_tokens_count: 0x1::option::Option<u64>,
        is_being_disputed: bool,
        token_counts_disputed_by: 0x1::option::Option<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>,
        timeout: TimeoutInfo,
        cross_validation: 0x1::option::Option<CrossValidation>,
    }

    struct CrossValidation has copy, drop, store {
        probability_permille: u64,
        how_many_extra_nodes: u64,
    }

    struct TimeoutInfo has copy, drop, store {
        timed_out_count: u64,
        timeout_ms: u64,
        started_in_epoch: u64,
        started_at_epoch_timestamp_ms: u64,
    }

    fun did_timeout(arg0: &SettlementTicket, arg1: &0x2::tx_context::TxContext) : bool {
        let v0 = 0x2::tx_context::epoch(arg1);
        let TimeoutInfo {
            timed_out_count               : _,
            timeout_ms                    : v2,
            started_in_epoch              : v3,
            started_at_epoch_timestamp_ms : v4,
        } = arg0.timeout;
        max_timeout_attempts_reached(arg0) || v0 == v3 && 0x2::tx_context::epoch_timestamp_ms(arg1) - v4 > v2 || v0 == v3 + 1 && 0x2::tx_context::epoch_timestamp_ms(arg1) > v2 || true
    }

    fun get_settlement_ticket_mut(arg0: &mut 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::AtomaDb, arg1: 0x2::object::ID) : &mut SettlementTicket {
        0x2::dynamic_object_field::borrow_mut<0x2::object::ID, SettlementTicket>(0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::get_tickets_uid_mut(arg0), arg1)
    }

    fun max_timeout_attempts_reached(arg0: &SettlementTicket) : bool {
        arg0.timeout.timed_out_count >= 3
    }

    public(friend) fun new_ticket(arg0: 0x1::ascii::String, arg1: 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::EchelonId, arg2: vector<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : SettlementTicket {
        assert!(!0x1::vector::is_empty<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&arg2), 312012206);
        let v0 = TimeoutInfo{
            timed_out_count               : 0,
            timeout_ms                    : arg6,
            started_in_epoch              : 0x2::tx_context::epoch(arg7),
            started_at_epoch_timestamp_ms : 0x2::tx_context::epoch_timestamp_ms(arg7),
        };
        SettlementTicket{
            id                              : 0x2::object::new(arg7),
            model_name                      : arg0,
            echelon_id                      : arg1,
            all                             : arg2,
            completed                       : 0x1::vector::empty<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(),
            merkle_root                     : 0x1::vector::empty<u8>(),
            merkle_leaves                   : 0x1::vector::empty<u8>(),
            input_fee_per_token             : arg3,
            output_fee_per_token            : arg4,
            collected_fee_in_protocol_token : arg5,
            payer                           : 0x2::tx_context::sender(arg7),
            input_tokens_count              : 0x1::option::none<u64>(),
            output_tokens_count             : 0x1::option::none<u64>(),
            is_being_disputed               : false,
            token_counts_disputed_by        : 0x1::option::none<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(),
            timeout                         : v0,
            cross_validation                : 0x1::option::none<CrossValidation>(),
        }
    }

    fun remove_settlement_ticket(arg0: &mut 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::AtomaDb, arg1: 0x2::object::ID) : SettlementTicket {
        0x2::dynamic_object_field::remove<0x2::object::ID, SettlementTicket>(0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::get_tickets_uid_mut(arg0), arg1)
    }

    fun replace_timed_out_nodes(arg0: &mut SettlementTicket, arg1: &mut 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::AtomaDb, arg2: &mut 0x2::random::RandomGenerator) : vector<MapNodeToChunk> {
        let v0 = 0x1::vector::empty<MapNodeToChunk>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&arg0.all)) {
            let v2 = *0x1::vector::borrow<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&arg0.all, v1);
            if (!0x1::vector::contains<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&arg0.completed, &v2)) {
                0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::deposit_to_communal_treasury(arg1, 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::slash_node_on_timeout(arg1, v2));
                let v3 = 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::sample_node_by_echelon_id(arg1, arg0.model_name, arg0.echelon_id, arg2);
                if (0x1::option::is_none<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v3)) {
                    break
                };
                let v4 = 0x1::option::extract<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&mut v3);
                let v5 = MapNodeToChunk{
                    node_id : v4,
                    order   : v1,
                };
                0x1::vector::push_back<MapNodeToChunk>(&mut v0, v5);
                *0x1::vector::borrow_mut<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&mut arg0.all, v1) = v4;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun request_cross_validation(arg0: &mut SettlementTicket, arg1: u64, arg2: u64) {
        assert!(0x1::vector::length<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&arg0.all) == 1, 312012207);
        let v0 = CrossValidation{
            probability_permille : arg1,
            how_many_extra_nodes : arg2,
        };
        arg0.cross_validation = 0x1::option::some<CrossValidation>(v0);
    }

    public(friend) fun return_settlement_ticket(arg0: &mut 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::AtomaDb, arg1: SettlementTicket) {
        0x2::dynamic_object_field::add<0x2::object::ID, SettlementTicket>(0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::get_tickets_uid_mut(arg0), 0x2::object::id<SettlementTicket>(&arg1), arg1);
    }

    fun sample_extra_nodes_for_cross_validation(arg0: &mut 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::AtomaDb, arg1: SettlementTicket, arg2: u64, arg3: &mut 0x2::random::RandomGenerator, arg4: &0x2::tx_context::TxContext) {
        arg1.timeout.started_in_epoch = 0x2::tx_context::epoch(arg4);
        arg1.timeout.started_at_epoch_timestamp_ms = 0x2::tx_context::epoch_timestamp_ms(arg4);
        let v0 = 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::sample_unique_nodes_by_echelon_id(arg0, arg1.model_name, arg1.echelon_id, arg2 + 1, arg3);
        let (v1, v2) = 0x1::vector::index_of<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v0, 0x1::vector::borrow<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&arg1.all, 0));
        if (v1) {
            0x1::vector::swap_remove<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&mut v0, v2);
        } else if (0x1::vector::length<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v0) == arg2 + 1) {
            0x1::vector::pop_back<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&mut v0);
        };
        if (arg2 > 0x1::vector::length<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v0)) {
            let v3 = CrossValidation{
                probability_permille : 1000,
                how_many_extra_nodes : arg2,
            };
            arg1.cross_validation = 0x1::option::some<CrossValidation>(v3);
            let v4 = RetrySettlementEvent{
                ticket_id                 : 0x2::object::id<SettlementTicket>(&arg1),
                how_many_nodes_in_echelon : arg2,
            };
            0x2::event::emit<RetrySettlementEvent>(v4);
        } else {
            let v5 = 0x1::vector::empty<MapNodeToChunk>();
            let v6 = 0;
            while (!0x1::vector::is_empty<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v0)) {
                let v7 = MapNodeToChunk{
                    node_id : 0x1::vector::pop_back<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&mut v0),
                    order   : v6 + 1,
                };
                0x1::vector::push_back<MapNodeToChunk>(&mut v5, v7);
                v6 = v6 + 1;
            };
            let v8 = NewlySampledNodesEvent{
                ticket_id : 0x2::object::id<SettlementTicket>(&arg1),
                new_nodes : v5,
            };
            0x2::event::emit<NewlySampledNodesEvent>(v8);
        };
        return_settlement_ticket(arg0, arg1);
    }

    public entry fun settle_dispute(arg0: &mut 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::AtomaDb, arg1: &0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::NodeBadge, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::get_node_id(arg1);
        let v1 = remove_settlement_ticket(arg0, arg2);
        assert!(v1.is_being_disputed, 312012202);
        assert!(did_timeout(&v1, arg7), 312012202);
        let v2 = 0x1::vector::length<u8>(&v1.merkle_leaves);
        assert!(v2 == 0x1::vector::length<u8>(&arg6), 312012204);
        assert!(0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::is_oracle(arg0, v1.model_name, v1.echelon_id, v0), 312012205);
        let SettlementTicket {
            id                              : v3,
            model_name                      : _,
            echelon_id                      : _,
            all                             : v6,
            completed                       : v7,
            merkle_root                     : v8,
            merkle_leaves                   : v9,
            input_fee_per_token             : v10,
            output_fee_per_token            : v11,
            collected_fee_in_protocol_token : v12,
            payer                           : v13,
            input_tokens_count              : v14,
            output_tokens_count             : v15,
            is_being_disputed               : _,
            token_counts_disputed_by        : v17,
            timeout                         : _,
            cross_validation                : _,
        } = v1;
        let v20 = v17;
        let v21 = v15;
        let v22 = v14;
        let v23 = v9;
        let v24 = v7;
        let v25 = v6;
        0x2::object::delete(v3);
        let v26 = 0x2::balance::zero<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>();
        let v27 = 0x1::vector::empty<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>();
        let v28 = 0x1::option::extract<u64>(&mut v22) == arg3 && 0x1::option::extract<u64>(&mut v21) == arg4;
        let v29 = if (!(v8 == arg5) || !v28) {
            let v30 = *0x1::vector::borrow<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v24, 0);
            0x2::balance::join<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&mut v26, 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::slash_node_on_dispute(arg0, v30));
            0x1::vector::push_back<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&mut v27, v30);
            32
        } else {
            0
        };
        let v31 = v29;
        while (v31 < v2) {
            if (!(*0x1::vector::borrow<u8>(&arg6, v31) == *0x1::vector::borrow<u8>(&v23, v31))) {
                let v32 = v31 / 32;
                let v33 = *0x1::vector::borrow<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v25, v32);
                let v34 = if (!0x1::vector::contains<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v24, &v33)) {
                    0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::slash_node_on_timeout(arg0, v33)
                } else {
                    0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::slash_node_on_dispute(arg0, v33)
                };
                0x2::balance::join<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&mut v26, v34);
                0x1::vector::push_back<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&mut v27, v33);
                v31 = (v32 + 1) * 32;
                continue
            };
            v31 = v31 + 1;
        };
        if (0x1::option::is_some<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v20)) {
            let v35 = 0x1::option::extract<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&mut v20);
            if (v28 && !0x1::vector::contains<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v27, &v35)) {
                0x2::balance::join<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&mut v26, 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::slash_node_on_dispute(arg0, v35));
                0x1::vector::push_back<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&mut v27, v35);
            };
        };
        0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::deposit_fee_to_node(arg0, v0, 0x2::balance::split<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&mut v26, 0x1::u64::divide_and_round_up(0x2::balance::value<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&v26) * 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::get_permille_for_oracle_on_dispute(arg0), 1000)), arg7);
        let v36 = 0x2::balance::value<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&v26) * 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::get_permille_for_honest_nodes_on_dispute(arg0) / 1000;
        0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::deposit_to_fee_treasury(arg0, 0x2::balance::split<0x26a9c0517dd43d7a4496dcf5d2de1b9bd6156b50cdef1248364635f1bbc77477::toma::TOMA>(&mut v26, v36));
        0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::deposit_to_communal_treasury(arg0, v26);
        let v37 = 0x1::vector::length<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v25) * (v10 * 0x1::option::extract<u64>(&mut v22) + v11 * 0x1::option::extract<u64>(&mut v21));
        let v38 = if (v37 >= v12) {
            v12
        } else {
            0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::refund_to_user(arg0, v13, v12 - v37, arg7);
            v37
        };
        let v39 = 0x1::vector::length<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v24) - 0x1::vector::length<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v27);
        if (v39 == 0) {
            0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::attribute_fee_to_node(arg0, v0, v36 + v38, arg7);
        } else {
            while (!0x1::vector::is_empty<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v24)) {
                let v40 = 0x1::vector::pop_back<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&mut v24);
                if (!0x1::vector::contains<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v27, &v40)) {
                    0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::attribute_fee_to_node(arg0, v40, (v36 + v38) / v39, arg7);
                };
            };
        };
        let v41 = SettledEvent{
            ticket_id      : arg2,
            oracle_node_id : 0x1::option::some<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(v0),
        };
        0x2::event::emit<SettledEvent>(v41);
    }

    public entry fun submit_commitment(arg0: &mut 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::AtomaDb, arg1: &0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::NodeBadge, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: vector<u8>, arg6: vector<u8>, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg5) == 32, 312012203);
        assert!(0x1::vector::length<u8>(&arg6) == 32, 312012203);
        let v0 = get_settlement_ticket_mut(arg0, arg2);
        let v1 = 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::get_node_id(arg1);
        assert!(!0x1::vector::contains<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v0.completed, &v1), 312012201);
        let (v2, v3) = 0x1::vector::index_of<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v0.all, &v1);
        assert!(v2, 312012200);
        if (0x1::vector::is_empty<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v0.completed)) {
            v0.input_tokens_count = 0x1::option::some<u64>(arg3);
            v0.output_tokens_count = 0x1::option::some<u64>(arg4);
            let v4 = FirstSubmissionEvent{
                ticket_id : arg2,
                node_id   : v1,
            };
            0x2::event::emit<FirstSubmissionEvent>(v4);
        } else if (!v0.is_being_disputed) {
            if (!(0x1::option::borrow<u64>(&v0.input_tokens_count) == &arg3) || !(0x1::option::borrow<u64>(&v0.output_tokens_count) == &arg4)) {
                v0.token_counts_disputed_by = 0x1::option::some<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(v1);
                v0.is_being_disputed = true;
                let v5 = DisputeEvent{
                    ticket_id : arg2,
                    timeout   : 0x1::option::some<TimeoutInfo>(v0.timeout),
                };
                0x2::event::emit<DisputeEvent>(v5);
            };
        };
        if (0x1::vector::is_empty<u8>(&v0.merkle_root)) {
            v0.merkle_root = arg5;
        } else if (!v0.is_being_disputed && v0.merkle_root != arg5) {
            v0.is_being_disputed = true;
            let v6 = DisputeEvent{
                ticket_id : arg2,
                timeout   : 0x1::option::some<TimeoutInfo>(v0.timeout),
            };
            0x2::event::emit<DisputeEvent>(v6);
        };
        let v7 = v3 * 32;
        while (v7 + 31 >= 0x1::vector::length<u8>(&v0.merkle_leaves)) {
            0x1::vector::push_back<u8>(&mut v0.merkle_leaves, 0);
        };
        let v8 = 0;
        while (v8 < 32) {
            *0x1::vector::borrow_mut<u8>(&mut v0.merkle_leaves, v7 + v8) = *0x1::vector::borrow<u8>(&arg6, v8);
            v8 = v8 + 1;
        };
        0x1::vector::push_back<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&mut v0.completed, v1);
        try_to_settle(arg0, arg2, arg7, arg8);
    }

    fun ticket_ok_so_distribute_fees(arg0: &mut 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::AtomaDb, arg1: SettlementTicket, arg2: &mut 0x2::tx_context::TxContext) {
        let SettlementTicket {
            id                              : v0,
            model_name                      : _,
            echelon_id                      : _,
            all                             : _,
            completed                       : v4,
            merkle_root                     : _,
            merkle_leaves                   : _,
            input_fee_per_token             : v7,
            output_fee_per_token            : v8,
            collected_fee_in_protocol_token : v9,
            payer                           : v10,
            input_tokens_count              : v11,
            output_tokens_count             : v12,
            is_being_disputed               : _,
            token_counts_disputed_by        : _,
            timeout                         : _,
            cross_validation                : _,
        } = arg1;
        let v17 = v12;
        let v18 = v11;
        let v19 = v4;
        let v20 = v0;
        0x2::object::delete(v20);
        let v21 = 0x1::vector::length<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v19) * (v7 * 0x1::option::extract<u64>(&mut v18) + v8 * 0x1::option::extract<u64>(&mut v17));
        let v22 = if (v21 >= v9) {
            v9 / 0x1::vector::length<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v19)
        } else {
            0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::refund_to_user(arg0, v10, v9 - v21, arg2);
            v21 / 0x1::vector::length<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v19)
        };
        while (!0x1::vector::is_empty<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v19)) {
            0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::attribute_fee_to_node(arg0, 0x1::vector::pop_back<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&mut v19), v22, arg2);
        };
        let v23 = SettledEvent{
            ticket_id      : 0x2::object::uid_to_inner(&v20),
            oracle_node_id : 0x1::option::none<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(),
        };
        0x2::event::emit<SettledEvent>(v23);
    }

    public(friend) fun ticket_uid(arg0: &mut SettlementTicket) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public entry fun try_to_settle(arg0: &mut 0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::AtomaDb, arg1: 0x2::object::ID, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::random::new_generator(arg2, arg3);
        let v1 = remove_settlement_ticket(arg0, arg1);
        if (!v1.is_being_disputed && 0x1::vector::length<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v1.completed) == 0x1::vector::length<0x35ffa662c943a35e92de24cce098c76f4d5f70131ee022e8186aca95730c3329::db::SmallId>(&v1.all)) {
            if (0x1::option::is_some<CrossValidation>(&v1.cross_validation)) {
                let CrossValidation {
                    probability_permille : v2,
                    how_many_extra_nodes : v3,
                } = 0x1::option::extract<CrossValidation>(&mut v1.cross_validation);
                if (v2 < 0x2::random::generate_u64(&mut v0) % 1000) {
                    let v4 = &mut v0;
                    sample_extra_nodes_for_cross_validation(arg0, v1, v3, v4, arg3);
                } else {
                    ticket_ok_so_distribute_fees(arg0, v1, arg3);
                };
            } else if (v1.merkle_root == 0x2::hash::blake2b256(&v1.merkle_leaves)) {
                ticket_ok_so_distribute_fees(arg0, v1, arg3);
            } else {
                v1.is_being_disputed = true;
                return_settlement_ticket(arg0, v1);
                let v5 = DisputeEvent{
                    ticket_id : arg1,
                    timeout   : 0x1::option::none<TimeoutInfo>(),
                };
                0x2::event::emit<DisputeEvent>(v5);
            };
        } else if (did_timeout(&v1, arg3) && !v1.is_being_disputed) {
            if (max_timeout_attempts_reached(&v1)) {
                v1.is_being_disputed = true;
                return_settlement_ticket(arg0, v1);
                let v6 = DisputeEvent{
                    ticket_id : arg1,
                    timeout   : 0x1::option::none<TimeoutInfo>(),
                };
                0x2::event::emit<DisputeEvent>(v6);
            } else {
                let v7 = &mut v1;
                let v8 = &mut v0;
                let v9 = replace_timed_out_nodes(v7, arg0, v8);
                if (0x1::vector::is_empty<MapNodeToChunk>(&v9)) {
                    v1.is_being_disputed = true;
                    return_settlement_ticket(arg0, v1);
                    let v10 = DisputeEvent{
                        ticket_id : arg1,
                        timeout   : 0x1::option::none<TimeoutInfo>(),
                    };
                    0x2::event::emit<DisputeEvent>(v10);
                } else {
                    v1.timeout.started_in_epoch = 0x2::tx_context::epoch(arg3);
                    v1.timeout.started_at_epoch_timestamp_ms = 0x2::tx_context::epoch_timestamp_ms(arg3);
                    return_settlement_ticket(arg0, v1);
                    let v11 = NewlySampledNodesEvent{
                        ticket_id : arg1,
                        new_nodes : v9,
                    };
                    0x2::event::emit<NewlySampledNodesEvent>(v11);
                };
            };
        } else {
            return_settlement_ticket(arg0, v1);
        };
    }

    // decompiled from Move bytecode v6
}

