module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit {
    struct DepositConfirmationMessage has copy, drop, store {
        request_id: address,
        utxo: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo,
    }

    struct DepositRequested has copy, drop {
        request_id: address,
        utxo_id: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId,
        amount: u64,
        derivation_path: 0x1::option::Option<address>,
        timestamp_ms: u64,
        requester_address: address,
        sui_tx_digest: vector<u8>,
    }

    struct DepositApproved has copy, drop {
        request_id: address,
        utxo: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo,
        cert: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature,
        approval_timestamp_ms: u64,
    }

    struct DepositConfirmed has copy, drop {
        request_id: address,
        utxo: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo,
    }

    struct ExpiredDepositDeleted has copy, drop {
        request_id: address,
    }

    entry fun deposit(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_unpaused(arg0);
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::amount(&arg1) >= 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config::bitcoin_deposit_minimum(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config(arg0)), 13906834590955208705);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::assert_not_spent_or_active(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::utxo_pool(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::id(&arg1));
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::create_deposit(arg1, arg2, arg3);
        let v1 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::request_id(&v0);
        let v2 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::request_utxo(&v0);
        let v3 = DepositRequested{
            request_id        : 0x2::object::id_to_address(&v1),
            utxo_id           : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::id(v2),
            amount            : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::amount(v2),
            derivation_path   : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::derivation_path(v2),
            timestamp_ms      : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::request_created_timestamp_ms(&v0),
            requester_address : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::request_sender(&v0),
            sui_tx_digest     : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::request_sui_tx_digest(&v0),
        };
        0x2::event::emit<DepositRequested>(v3);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::insert_deposit(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::deposit_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), v0);
    }

    entry fun approve_deposit(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_unpaused(arg0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_not_reconfiguring(arg0);
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::borrow_request(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::deposit_queue(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), arg1);
        let v1 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::utxo(v0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::assert_not_spent_or_active(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::utxo_pool(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::id(&v1));
        let v2 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::approval_cert(v0);
        assert!(0x1::option::is_none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(&v2) || 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::signature_epoch(0x1::option::borrow<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(&v2)) != 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::epoch(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::current_committee(arg0)), 13906834870128345093);
        let v3 = DepositConfirmationMessage{
            request_id : arg1,
            utxo       : v1,
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::verify<DepositConfirmationMessage>(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::intent::deposit_confirmation(), v3, arg2);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::approve(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::borrow_request_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::deposit_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), arg1), arg2, arg3);
        let v4 = DepositApproved{
            request_id            : arg1,
            utxo                  : v1,
            cert                  : arg2,
            approval_timestamp_ms : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DepositApproved>(v4);
    }

    entry fun confirm_deposit(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_unpaused(arg0);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::assert_not_reconfiguring(arg0);
        let v0 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::utxo(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::borrow_request(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::deposit_queue(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), arg1));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::assert_not_spent_or_active(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::utxo_pool(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin(arg0)), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::id(&v0));
        let v1 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::remove_request(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::deposit_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), arg1);
        let v2 = DepositConfirmationMessage{
            request_id : arg1,
            utxo       : v0,
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::verify<DepositConfirmationMessage>(arg0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::intent::deposit_confirmation(), v2, 0x1::option::destroy_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::approval_cert(&v1)));
        assert!(0x1::option::destroy_some<u64>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::approved_timestamp_ms(&v1)) + 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config::bitcoin_deposit_time_delay_ms(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::config(arg0)) <= 0x2::clock::timestamp_ms(arg2), 13906835179365859331);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::confirm(&mut v1, arg2);
        let v3 = DepositConfirmed{
            request_id : arg1,
            utxo       : v0,
        };
        0x2::event::emit<DepositConfirmed>(v3);
        let v4 = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::derivation_path(&v0);
        if (0x1::option::is_some<address>(&v4)) {
            0x2::balance::send_funds<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::treasury::mint_balance<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::treasury_mut(arg0), 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::amount(&v0)), 0x1::option::destroy_some<address>(v4));
        };
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo_pool::insert_active(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::utxo_pool_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), v0);
        let (v5, v6) = 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::insert_processed(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::deposit_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), v1);
        let v7 = v6;
        if (0x1::option::is_some<address>(&v7)) {
            0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::index_user_request(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0), 0x1::option::destroy_some<address>(v7), v5, arg3);
        } else {
            0x1::option::destroy_none<address>(v7);
        };
    }

    entry fun delete_expired_deposit(arg0: &mut 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::Hashi, arg1: address, arg2: &0x2::clock::Clock) {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::versioning::assert_version_enabled(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::versioning(arg0));
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue::delete_expired(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::bitcoin_state::deposit_queue_mut(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::hashi::bitcoin_mut(arg0)), arg1, arg2);
        let v0 = ExpiredDepositDeleted{request_id: arg1};
        0x2::event::emit<ExpiredDepositDeleted>(v0);
    }

    // decompiled from Move bytecode v7
}

