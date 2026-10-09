module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdraw {
    struct RequestApprovalMessage has copy, drop, store {
        request_id: address,
    }

    struct WithdrawalCommitmentMessage has copy, drop, store {
        request_ids: vector<address>,
        selected_utxos: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>,
        outputs: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::OutputUtxo>,
        txid: address,
    }

    struct WithdrawalSignedMessage has copy, drop, store {
        withdrawal_id: address,
        signatures: vector<vector<u8>>,
        guardian_signatures: vector<vector<u8>>,
    }

    struct MpcInputSignaturesMessage has copy, drop, store {
        withdrawal_id: address,
        indices: vector<u64>,
        signatures: vector<vector<u8>>,
    }

    struct WithdrawalConfirmationMessage has copy, drop, store {
        withdrawal_id: address,
    }

    entry fun approve_request(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg3: &0x2::clock::Clock) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_unpaused(arg0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_not_reconfiguring(arg0);
        let v0 = RequestApprovalMessage{request_id: arg1};
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::verify<RequestApprovalMessage>(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::intent::withdrawal_request_approval(), v0, arg2);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::approve_withdrawal(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), arg1, arg2, arg3);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::emit_withdrawal_approved(arg1);
    }

    entry fun archive_confirmed_withdrawals(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: vector<address>) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0x1::vector::reverse<address>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::archive_withdrawal_txn(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), 0x1::vector::pop_back<address>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    entry fun archive_withdrawal_requests(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: vector<address>) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::archive_withdrawal_requests(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), arg1, &arg2);
    }

    entry fun cancel_withdrawal(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC> {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        assert!(!0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::is_request_processing(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), arg1), 13906834861538672649);
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::borrow_request(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), arg1);
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::request_sender(v0) == 0x2::tx_context::sender(arg3), 13906834887308214277);
        assert!(0x2::clock::timestamp_ms(arg2) >= 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::request_created_timestamp_ms(v0) + 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config::withdrawal_cancellation_cooldown_ms(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config(arg0)), 13906834913078149127);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::emit_withdrawal_cancelled(v0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::unindex_user_request(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0), 0x2::tx_context::sender(arg3), arg1);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::cancel_withdrawal(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), arg1)
    }

    entry fun cleanup_spent_utxos(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0x1::vector::reverse<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&arg1)) {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::cleanup_spent(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::utxo_pool_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), 0x1::vector::pop_back<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(arg1);
    }

    entry fun commit_input_signatures(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: vector<u64>, arg3: vector<vector<u8>>, arg4: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_unpaused(arg0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_not_reconfiguring(arg0);
        let v0 = MpcInputSignaturesMessage{
            withdrawal_id : arg1,
            indices       : arg2,
            signatures    : arg3,
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::verify<MpcInputSignaturesMessage>(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::intent::mpc_input_signatures(), v0, arg4);
        let MpcInputSignaturesMessage {
            withdrawal_id : _,
            indices       : v2,
            signatures    : v3,
        } = v0;
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::record_input_signatures(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), arg1, v2, v3);
    }

    entry fun commit_withdrawal_tx(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: vector<address>, arg2: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>, arg3: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::OutputUtxo>, arg4: address, arg5: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg6: &0x2::clock::Clock, arg7: &0x2::random::Random, arg8: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_unpaused(arg0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_not_reconfiguring(arg0);
        let v0 = WithdrawalCommitmentMessage{
            request_ids    : arg1,
            selected_utxos : arg2,
            outputs        : arg3,
            txid           : arg4,
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::verify<WithdrawalCommitmentMessage>(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::intent::withdrawal_commitment(), v0, arg5);
        let WithdrawalCommitmentMessage {
            request_ids    : _,
            selected_utxos : _,
            outputs        : v3,
            txid           : v4,
        } = v0;
        let v5 = 0x1::vector::empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>();
        0x1::vector::reverse<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&mut arg2);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&arg2)) {
            0x1::vector::push_back<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(&mut v5, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::get_utxo(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::utxo_pool(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), 0x1::vector::pop_back<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&mut arg2)));
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(arg2);
        let v7 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::extract_request_infos(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), &arg1);
        let v8 = 0x2::random::new_generator(arg7, arg8);
        let v9 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::new_withdrawal_txn(arg8, arg1, &v7, v5, v3, v4, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::allocate_presigs(arg0, 0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(&v5)), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::epoch(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0)), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config(arg0), arg6, 0x2::random::generate_bytes(&mut v8, 32));
        let v10 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::withdrawal_txn_id(&v9);
        let v11 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::withdrawal_txn_inputs(&v9);
        let v12 = 0;
        while (v12 < 0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(v11)) {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::lock(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::utxo_pool_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::id(0x1::vector::borrow<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(v11, v12)), v10);
            v12 = v12 + 1;
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::treasury::burn<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::treasury_mut(arg0), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::commit_requests(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), &v9));
        let v13 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::build_change_utxos(&v9);
        0x1::vector::reverse<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(&mut v13);
        let v14 = 0;
        while (v14 < 0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(&v13)) {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::insert_pending(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::utxo_pool_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), 0x1::vector::pop_back<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(&mut v13), v10);
            v14 = v14 + 1;
        };
        0x1::vector::destroy_empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(v13);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::emit_withdrawal_picked_for_processing(&v9);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::insert_withdrawal_txn(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), v9);
    }

    entry fun confirm_withdrawal(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg3: &0x2::clock::Clock) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_unpaused(arg0);
        let v0 = WithdrawalConfirmationMessage{withdrawal_id: arg1};
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::verify<WithdrawalConfirmationMessage>(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::intent::withdrawal_confirmation(), v0, arg2);
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::withdrawal_txn_is_fully_signed(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), arg1), 13906835784956772363);
        let v1 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::borrow_withdrawal_txn(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), arg1);
        let v2 = *0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::withdrawal_txn_inputs(v1);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::mark_txn_confirmed(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), arg1, arg3);
        let v3 = &v2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(v3)) {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::mark_spent(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::utxo_pool_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::id(0x1::vector::borrow<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(v3, v4)), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::epoch(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0)));
            v4 = v4 + 1;
        };
        let v5 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::change_utxo_ids(v1);
        0x1::vector::reverse<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&mut v5);
        let v6 = 0;
        while (v6 < 0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&v5)) {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::confirm_pending(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::utxo_pool_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), 0x1::vector::pop_back<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&mut v5));
            v6 = v6 + 1;
        };
        0x1::vector::destroy_empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(v5);
    }

    entry fun finalize_withdrawal(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: vector<vector<u8>>, arg3: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg4: &0x2::clock::Clock) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_unpaused(arg0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_not_reconfiguring(arg0);
        let v0 = WithdrawalSignedMessage{
            withdrawal_id       : arg1,
            signatures          : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::withdrawal_txn_mpc_signatures(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), arg1),
            guardian_signatures : arg2,
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::verify<WithdrawalSignedMessage>(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::intent::withdrawal_signed(), v0, arg3);
        let WithdrawalSignedMessage {
            withdrawal_id       : _,
            signatures          : _,
            guardian_signatures : v3,
        } = v0;
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::finalize_withdrawal_txn(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), arg1, v3, arg4);
    }

    entry fun finish_archive_withdrawal_txns(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: vector<address>) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0x1::vector::reverse<address>(&mut arg1);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::finish_archive_withdrawal_txn(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), 0x1::vector::pop_back<address>(&mut arg1));
            v0 = v0 + 1;
        };
        0x1::vector::destroy_empty<address>(arg1);
    }

    public(friend) fun new_mpc_input_signatures_message(arg0: address, arg1: vector<u64>, arg2: vector<vector<u8>>) : MpcInputSignaturesMessage {
        MpcInputSignaturesMessage{
            withdrawal_id : arg0,
            indices       : arg1,
            signatures    : arg2,
        }
    }

    public(friend) fun new_request_approval_message(arg0: address) : RequestApprovalMessage {
        RequestApprovalMessage{request_id: arg0}
    }

    public(friend) fun new_withdrawal_commitment_message(arg0: vector<address>, arg1: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>, arg2: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::OutputUtxo>, arg3: address) : WithdrawalCommitmentMessage {
        WithdrawalCommitmentMessage{
            request_ids    : arg0,
            selected_utxos : arg1,
            outputs        : arg2,
            txid           : arg3,
        }
    }

    public(friend) fun new_withdrawal_confirmation_message(arg0: address) : WithdrawalConfirmationMessage {
        WithdrawalConfirmationMessage{withdrawal_id: arg0}
    }

    public(friend) fun new_withdrawal_signed_message(arg0: address, arg1: vector<vector<u8>>, arg2: vector<vector<u8>>) : WithdrawalSignedMessage {
        WithdrawalSignedMessage{
            withdrawal_id       : arg0,
            signatures          : arg1,
            guardian_signatures : arg2,
        }
    }

    entry fun reallocate_presigs(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: &0x2::random::Random, arg3: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_unpaused(arg0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_not_reconfiguring(arg0);
        let v0 = 0x2::random::new_generator(arg2, arg3);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::reallocate_presigs_for_withdrawal_txn(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), arg1, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::allocate_presigs(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::withdrawal_txn_pending_count(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), arg1)), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee_set::epoch(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::committee_set(arg0)), 0x2::random::generate_bytes(&mut v0, 32));
    }

    entry fun request_withdrawal(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: &0x2::clock::Clock, arg2: 0x2::balance::Balance<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_unpaused(arg0);
        assert!(0x2::balance::value<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>(&arg2) >= 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config::bitcoin_withdrawal_minimum(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config(arg0)), 13906834668264620033);
        let v0 = 0x1::vector::length<u8>(&arg3);
        assert!(v0 == 20 || v0 == 32, 13906834685444620291);
        let v1 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::create_withdrawal(arg2, arg3, arg1, arg4);
        let v2 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::request_id(&v1);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::emit_withdrawal_requested(&v1);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue::insert_withdrawal(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::withdrawal_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), v1);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::index_user_request(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0), 0x2::tx_context::sender(arg4), 0x2::object::id_to_address(&v2), arg4);
    }

    // decompiled from Move bytecode v7
}

