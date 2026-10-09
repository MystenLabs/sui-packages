module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::withdrawal_queue {
    struct WithdrawalRequest has store, key {
        id: 0x2::object::UID,
        sender: address,
        btc_amount: u64,
        bitcoin_address: vector<u8>,
        created_timestamp_ms: u64,
        approval_cert: 0x1::option::Option<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>,
        approved_timestamp_ms: 0x1::option::Option<u64>,
        withdrawal_txn_id: 0x1::option::Option<address>,
        sui_tx_digest: vector<u8>,
        btc: 0x2::balance::Balance<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>,
    }

    struct WithdrawalRequestQueue has store {
        requests: 0x2::object_bag::ObjectBag,
        processed: 0x2::object_bag::ObjectBag,
        withdrawal_txns: 0x2::object_bag::ObjectBag,
        confirmed_txns: 0x2::object_bag::ObjectBag,
    }

    struct WithdrawalTransaction has store, key {
        id: 0x2::object::UID,
        txid: address,
        request_ids: vector<address>,
        inputs: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>,
        withdrawal_outputs: vector<OutputUtxo>,
        change_outputs: vector<OutputUtxo>,
        created_timestamp_ms: u64,
        signed_timestamp_ms: 0x1::option::Option<u64>,
        confirmed_timestamp_ms: 0x1::option::Option<u64>,
        randomness: vector<u8>,
        signing: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::SigningBatch,
        guardian_signatures: 0x1::option::Option<vector<vector<u8>>>,
    }

    struct OutputUtxo has copy, drop, store {
        amount: u64,
        bitcoin_address: vector<u8>,
    }

    struct CommittedRequestInfo has copy, drop, store {
        btc_amount: u64,
        bitcoin_address: vector<u8>,
    }

    struct WithdrawalRequested has copy, drop {
        request_id: address,
        btc_amount: u64,
        bitcoin_address: vector<u8>,
        timestamp_ms: u64,
        requester_address: address,
        sui_tx_digest: vector<u8>,
    }

    struct WithdrawalApproved has copy, drop {
        request_id: address,
    }

    struct WithdrawalPickedForProcessing has copy, drop {
        withdrawal_txn_id: address,
        txid: address,
        request_ids: vector<address>,
        inputs: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>,
        withdrawal_outputs: vector<OutputUtxo>,
        change_outputs: vector<OutputUtxo>,
        timestamp_ms: u64,
        randomness: vector<u8>,
    }

    struct WithdrawalInputsSigned has copy, drop {
        withdrawal_txn_id: address,
        signed_count: u64,
        num_inputs: u64,
    }

    struct WithdrawalSigned has copy, drop {
        withdrawal_txn_id: address,
        request_ids: vector<address>,
        signatures: vector<vector<u8>>,
        guardian_signatures: vector<vector<u8>>,
    }

    struct WithdrawalPresigsReassigned has copy, drop {
        withdrawal_txn_id: address,
        epoch: u64,
    }

    struct WithdrawalConfirmed has copy, drop {
        withdrawal_txn_id: address,
        txid: address,
        change_utxo_ids: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>,
        request_ids: vector<address>,
        change_utxo_amounts: vector<u64>,
    }

    struct WithdrawalCancelled has copy, drop {
        request_id: address,
        requester_address: address,
        btc_amount: u64,
    }

    struct WithdrawalArchived has copy, drop {
        withdrawal_txn_id: address,
        request_ids: vector<address>,
    }

    public(friend) fun approve_withdrawal(arg0: &mut WithdrawalRequestQueue, arg1: address, arg2: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object_bag::borrow_mut<address, WithdrawalRequest>(&mut arg0.requests, arg1);
        assert!(!is_committed(v0), 13906835505784684567);
        assert!(0x1::option::is_none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(&v0.approval_cert) || 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::signature_epoch(0x1::option::borrow<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(&v0.approval_cert)) < 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::signature_epoch(&arg2), 13906835540144554009);
        v0.approval_cert = 0x1::option::some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(arg2);
        v0.approved_timestamp_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg3));
    }

    fun archive_request(arg0: &mut WithdrawalRequestQueue, arg1: address, arg2: address) {
        if (!0x2::object_bag::contains<address>(&arg0.requests, arg2)) {
            return
        };
        let v0 = 0x2::object_bag::remove<address, WithdrawalRequest>(&mut arg0.requests, arg2);
        assert!(v0.withdrawal_txn_id == 0x1::option::some<address>(arg1), 13906836944599384097);
        0x2::object_bag::add<address, WithdrawalRequest>(&mut arg0.processed, arg2, v0);
    }

    public(friend) fun archive_withdrawal_requests(arg0: &mut WithdrawalRequestQueue, arg1: address, arg2: &vector<address>) {
        if (!0x2::object_bag::contains<address>(&arg0.withdrawal_txns, arg1)) {
            return
        };
        assert!(0x1::option::is_some<u64>(&0x2::object_bag::borrow<address, WithdrawalTransaction>(&arg0.withdrawal_txns, arg1).confirmed_timestamp_ms), 13906837026203500573);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg2)) {
            archive_request(arg0, arg1, *0x1::vector::borrow<address>(arg2, v0));
            v0 = v0 + 1;
        };
    }

    public(friend) fun archive_withdrawal_txn(arg0: &mut WithdrawalRequestQueue, arg1: address) {
        if (!0x2::object_bag::contains<address>(&arg0.withdrawal_txns, arg1)) {
            return
        };
        let v0 = 0x2::object_bag::borrow<address, WithdrawalTransaction>(&arg0.withdrawal_txns, arg1);
        assert!(0x1::option::is_some<u64>(&v0.confirmed_timestamp_ms), 13906836837224939549);
        let v1 = v0.request_ids;
        0x1::vector::reverse<address>(&mut v1);
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(&v1)) {
            archive_request(arg0, arg1, 0x1::vector::pop_back<address>(&mut v1));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<address>(v1);
        let v3 = WithdrawalArchived{
            withdrawal_txn_id : arg1,
            request_ids       : v1,
        };
        0x2::event::emit<WithdrawalArchived>(v3);
        0x2::object_bag::add<address, WithdrawalTransaction>(&mut arg0.confirmed_txns, arg1, 0x2::object_bag::remove<address, WithdrawalTransaction>(&mut arg0.withdrawal_txns, arg1));
    }

    public(friend) fun borrow_request(arg0: &WithdrawalRequestQueue, arg1: address) : &WithdrawalRequest {
        0x2::object_bag::borrow<address, WithdrawalRequest>(&arg0.requests, arg1)
    }

    public(friend) fun borrow_withdrawal_txn(arg0: &WithdrawalRequestQueue, arg1: address) : &WithdrawalTransaction {
        0x2::object_bag::borrow<address, WithdrawalTransaction>(&arg0.withdrawal_txns, arg1)
    }

    public(friend) fun build_change_utxos(arg0: &WithdrawalTransaction) : vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo> {
        let v0 = 0x1::vector::empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<OutputUtxo>(&arg0.change_outputs)) {
            0x1::vector::push_back<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(&mut v0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::utxo(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::utxo_id(arg0.txid, (0x1::vector::length<OutputUtxo>(&arg0.withdrawal_outputs) as u32) + (v1 as u32)), 0x1::vector::borrow<OutputUtxo>(&arg0.change_outputs, v1).amount, 0x1::option::none<address>()));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun cancel_withdrawal(arg0: &mut WithdrawalRequestQueue, arg1: address) : 0x2::balance::Balance<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC> {
        let v0 = 0x2::object_bag::remove<address, WithdrawalRequest>(&mut arg0.requests, arg1);
        assert!(!is_committed(&v0), 13906835853677297691);
        let WithdrawalRequest {
            id                    : v1,
            sender                : _,
            btc_amount            : _,
            bitcoin_address       : _,
            created_timestamp_ms  : _,
            approval_cert         : _,
            approved_timestamp_ms : _,
            withdrawal_txn_id     : _,
            sui_tx_digest         : _,
            btc                   : v10,
        } = v0;
        0x2::object::delete(v1);
        v10
    }

    public(friend) fun change_utxo_ids(arg0: &WithdrawalTransaction) : vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId> {
        let v0 = 0x1::vector::empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<OutputUtxo>(&arg0.change_outputs)) {
            0x1::vector::push_back<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::UtxoId>(&mut v0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::utxo_id(arg0.txid, (0x1::vector::length<OutputUtxo>(&arg0.withdrawal_outputs) as u32) + (v1 as u32)));
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun commit_requests(arg0: &mut WithdrawalRequestQueue, arg1: &WithdrawalTransaction) : 0x2::balance::Balance<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC> {
        let v0 = 0x2::balance::zero<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>();
        let v1 = &arg1.request_ids;
        let v2 = 0;
        while (v2 < 0x1::vector::length<address>(v1)) {
            let v3 = 0x2::object_bag::borrow_mut<address, WithdrawalRequest>(&mut arg0.requests, *0x1::vector::borrow<address>(v1, v2));
            assert!(is_approved(v3), 13906835750596378625);
            assert!(!is_committed(v3), 13906835763481411587);
            0x2::balance::join<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>(&mut v0, 0x2::balance::withdraw_all<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>(&mut v3.btc));
            v3.withdrawal_txn_id = 0x1::option::some<address>(0x2::object::uid_to_address(&arg1.id));
            v2 = v2 + 1;
        };
        v0
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : WithdrawalRequestQueue {
        WithdrawalRequestQueue{
            requests        : 0x2::object_bag::new(arg0),
            processed       : 0x2::object_bag::new(arg0),
            withdrawal_txns : 0x2::object_bag::new(arg0),
            confirmed_txns  : 0x2::object_bag::new(arg0),
        }
    }

    public(friend) fun create_withdrawal(arg0: 0x2::balance::Balance<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : WithdrawalRequest {
        assert!(0x1::vector::length<u8>(&arg1) == 32 || 0x1::vector::length<u8>(&arg1) == 20, 13906835333984550911);
        WithdrawalRequest{
            id                    : 0x2::object::new(arg3),
            sender                : 0x2::tx_context::sender(arg3),
            btc_amount            : 0x2::balance::value<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc::BTC>(&arg0),
            bitcoin_address       : arg1,
            created_timestamp_ms  : 0x2::clock::timestamp_ms(arg2),
            approval_cert         : 0x1::option::none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(),
            approved_timestamp_ms : 0x1::option::none<u64>(),
            withdrawal_txn_id     : 0x1::option::none<address>(),
            sui_tx_digest         : *0x2::tx_context::digest(arg3),
            btc                   : arg0,
        }
    }

    public(friend) fun emit_withdrawal_approved(arg0: address) {
        let v0 = WithdrawalApproved{request_id: arg0};
        0x2::event::emit<WithdrawalApproved>(v0);
    }

    public(friend) fun emit_withdrawal_cancelled(arg0: &WithdrawalRequest) {
        let v0 = WithdrawalCancelled{
            request_id        : 0x2::object::uid_to_address(&arg0.id),
            requester_address : arg0.sender,
            btc_amount        : arg0.btc_amount,
        };
        0x2::event::emit<WithdrawalCancelled>(v0);
    }

    public(friend) fun emit_withdrawal_confirmed(arg0: &WithdrawalTransaction) {
        let v0 = &arg0.change_outputs;
        let v1 = vector[];
        let v2 = 0;
        while (v2 < 0x1::vector::length<OutputUtxo>(v0)) {
            0x1::vector::push_back<u64>(&mut v1, 0x1::vector::borrow<OutputUtxo>(v0, v2).amount);
            v2 = v2 + 1;
        };
        let v3 = WithdrawalConfirmed{
            withdrawal_txn_id   : 0x2::object::uid_to_address(&arg0.id),
            txid                : arg0.txid,
            change_utxo_ids     : change_utxo_ids(arg0),
            request_ids         : arg0.request_ids,
            change_utxo_amounts : v1,
        };
        0x2::event::emit<WithdrawalConfirmed>(v3);
    }

    public(friend) fun emit_withdrawal_picked_for_processing(arg0: &WithdrawalTransaction) {
        let v0 = WithdrawalPickedForProcessing{
            withdrawal_txn_id  : 0x2::object::uid_to_address(&arg0.id),
            txid               : arg0.txid,
            request_ids        : arg0.request_ids,
            inputs             : arg0.inputs,
            withdrawal_outputs : arg0.withdrawal_outputs,
            change_outputs     : arg0.change_outputs,
            timestamp_ms       : arg0.created_timestamp_ms,
            randomness         : arg0.randomness,
        };
        0x2::event::emit<WithdrawalPickedForProcessing>(v0);
    }

    public(friend) fun emit_withdrawal_requested(arg0: &WithdrawalRequest) {
        let v0 = WithdrawalRequested{
            request_id        : 0x2::object::uid_to_address(&arg0.id),
            btc_amount        : arg0.btc_amount,
            bitcoin_address   : arg0.bitcoin_address,
            timestamp_ms      : arg0.created_timestamp_ms,
            requester_address : arg0.sender,
            sui_tx_digest     : arg0.sui_tx_digest,
        };
        0x2::event::emit<WithdrawalRequested>(v0);
    }

    public(friend) fun emit_withdrawal_signed(arg0: &WithdrawalTransaction) {
        let v0 = WithdrawalSigned{
            withdrawal_txn_id   : 0x2::object::uid_to_address(&arg0.id),
            request_ids         : arg0.request_ids,
            signatures          : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::to_signatures(&arg0.signing),
            guardian_signatures : *0x1::option::borrow<vector<vector<u8>>>(&arg0.guardian_signatures),
        };
        0x2::event::emit<WithdrawalSigned>(v0);
    }

    public(friend) fun extract_request_infos(arg0: &WithdrawalRequestQueue, arg1: &vector<address>) : vector<CommittedRequestInfo> {
        let v0 = 0x1::vector::empty<CommittedRequestInfo>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg1)) {
            let v2 = 0x2::object_bag::borrow<address, WithdrawalRequest>(&arg0.requests, *0x1::vector::borrow<address>(arg1, v1));
            let v3 = CommittedRequestInfo{
                btc_amount      : v2.btc_amount,
                bitcoin_address : v2.bitcoin_address,
            };
            0x1::vector::push_back<CommittedRequestInfo>(&mut v0, v3);
            v1 = v1 + 1;
        };
        v0
    }

    public(friend) fun finalize_withdrawal_txn(arg0: &mut WithdrawalRequestQueue, arg1: address, arg2: vector<vector<u8>>, arg3: &0x2::clock::Clock) {
        let v0 = 0x2::object_bag::borrow_mut<address, WithdrawalTransaction>(&mut arg0.withdrawal_txns, arg1);
        assert!(!txn_fully_signed(v0), 13906836674015526931);
        assert!(0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::is_complete(&v0.signing), 13906836678310625301);
        v0.guardian_signatures = 0x1::option::some<vector<vector<u8>>>(arg2);
        v0.signed_timestamp_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg3));
        emit_withdrawal_signed(v0);
    }

    public(friend) fun finish_archive_withdrawal_txn(arg0: &mut WithdrawalRequestQueue, arg1: address) {
        if (!0x2::object_bag::contains<address>(&arg0.withdrawal_txns, arg1)) {
            return
        };
        let v0 = 0x2::object_bag::borrow<address, WithdrawalTransaction>(&arg0.withdrawal_txns, arg1);
        assert!(0x1::option::is_some<u64>(&v0.confirmed_timestamp_ms), 13906837116397813789);
        let v1 = v0.request_ids;
        let v2 = &v1;
        let v3 = 0;
        let v4;
        while (v3 < 0x1::vector::length<address>(v2)) {
            if (!0x2::object_bag::contains<address>(&arg0.processed, *0x1::vector::borrow<address>(v2, v3))) {
                v4 = true;
                /* label 11 */
                if (v4) {
                    return
                };
                let v5 = WithdrawalArchived{
                    withdrawal_txn_id : arg1,
                    request_ids       : v1,
                };
                0x2::event::emit<WithdrawalArchived>(v5);
                0x2::object_bag::add<address, WithdrawalTransaction>(&mut arg0.confirmed_txns, arg1, 0x2::object_bag::remove<address, WithdrawalTransaction>(&mut arg0.withdrawal_txns, arg1));
                return
            };
            v3 = v3 + 1;
        };
        v4 = false;
        /* goto 11 */
    }

    public(friend) fun insert_confirmed_txn(arg0: &mut WithdrawalRequestQueue, arg1: WithdrawalTransaction) {
        0x2::object_bag::add<address, WithdrawalTransaction>(&mut arg0.confirmed_txns, 0x2::object::uid_to_address(&arg1.id), arg1);
    }

    public(friend) fun insert_withdrawal(arg0: &mut WithdrawalRequestQueue, arg1: WithdrawalRequest) {
        0x2::object_bag::add<address, WithdrawalRequest>(&mut arg0.requests, 0x2::object::uid_to_address(&arg1.id), arg1);
    }

    public(friend) fun insert_withdrawal_txn(arg0: &mut WithdrawalRequestQueue, arg1: WithdrawalTransaction) {
        0x2::object_bag::add<address, WithdrawalTransaction>(&mut arg0.withdrawal_txns, 0x2::object::uid_to_address(&arg1.id), arg1);
    }

    public(friend) fun is_approved(arg0: &WithdrawalRequest) : bool {
        0x1::option::is_some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(&arg0.approval_cert)
    }

    public(friend) fun is_committed(arg0: &WithdrawalRequest) : bool {
        0x1::option::is_some<address>(&arg0.withdrawal_txn_id)
    }

    public(friend) fun is_request_processing(arg0: &WithdrawalRequestQueue, arg1: address) : bool {
        0x2::object_bag::contains<address>(&arg0.requests, arg1) && is_committed(0x2::object_bag::borrow<address, WithdrawalRequest>(&arg0.requests, arg1)) || 0x2::object_bag::contains<address>(&arg0.processed, arg1)
    }

    public(friend) fun mark_txn_confirmed(arg0: &mut WithdrawalRequestQueue, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::object_bag::borrow_mut<address, WithdrawalTransaction>(&mut arg0.withdrawal_txns, arg1);
        assert!(0x1::option::is_none<u64>(&v0.confirmed_timestamp_ms), 13906836755620691999);
        v0.confirmed_timestamp_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
        emit_withdrawal_confirmed(v0);
    }

    public(friend) fun new_withdrawal_txn(arg0: &mut 0x2::tx_context::TxContext, arg1: vector<address>, arg2: &vector<CommittedRequestInfo>, arg3: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>, arg4: vector<OutputUtxo>, arg5: address, arg6: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::Presig>, arg7: u64, arg8: &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::config::Config, arg9: &0x2::clock::Clock, arg10: vector<u8>) : WithdrawalTransaction {
        let v0 = 0;
        let v1 = &arg3;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(v1)) {
            v0 = v0 + 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::amount(0x1::vector::borrow<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(v1, v2));
            v2 = v2 + 1;
        };
        let v3 = 0;
        let v4 = &arg4;
        let v5 = 0;
        while (v5 < 0x1::vector::length<OutputUtxo>(v4)) {
            v3 = v3 + 0x1::vector::borrow<OutputUtxo>(v4, v5).amount;
            v5 = v5 + 1;
        };
        assert!(v0 >= v3, 13906836150029254671);
        let v6 = v0 - v3;
        let v7 = 0x1::vector::length<address>(&arg1);
        let v8 = 0x1::vector::length<OutputUtxo>(&arg4);
        assert!(v8 >= v7, 13906836184389124113);
        assert!(v8 <= 4294967295, 13906836197274026001);
        assert!(v6 % v7 == 0, 13906836210158665741);
        let v9 = v6 / v7;
        assert!(v9 <= 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config::worst_case_network_fee(arg8), 13906836218748469259);
        let v10 = 0;
        while (v10 < v7) {
            let v11 = 0x1::vector::borrow<CommittedRequestInfo>(arg2, v10);
            let v12 = 0x1::vector::borrow<OutputUtxo>(&arg4, v10);
            assert!(v11.btc_amount >= v9 + 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc_config::dust_relay_min_value(), 13906836270287683589);
            assert!(v12.amount == v11.btc_amount - v9, 13906836283172716551);
            assert!(v12.bitcoin_address == v11.bitcoin_address, 13906836287467814921);
            v10 = v10 + 1;
        };
        let v13 = 0x1::vector::empty<OutputUtxo>();
        let v14 = 0;
        while (v14 < v8 - v7) {
            0x1::vector::push_back<OutputUtxo>(&mut v13, 0x1::vector::pop_back<OutputUtxo>(&mut arg4));
            v14 = v14 + 1;
        };
        0x1::vector::reverse<OutputUtxo>(&mut v13);
        WithdrawalTransaction{
            id                     : 0x2::object::new(arg0),
            txid                   : arg5,
            request_ids            : arg1,
            inputs                 : arg3,
            withdrawal_outputs     : arg4,
            change_outputs         : v13,
            created_timestamp_ms   : 0x2::clock::timestamp_ms(arg9),
            signed_timestamp_ms    : 0x1::option::none<u64>(),
            confirmed_timestamp_ms : 0x1::option::none<u64>(),
            randomness             : arg10,
            signing                : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::new(0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(&arg3), arg6, arg7),
            guardian_signatures    : 0x1::option::none<vector<vector<u8>>>(),
        }
    }

    public fun output_utxo(arg0: u64, arg1: vector<u8>) : OutputUtxo {
        OutputUtxo{
            amount          : arg0,
            bitcoin_address : arg1,
        }
    }

    public(friend) fun reallocate_presigs_for_withdrawal_txn(arg0: &mut WithdrawalRequestQueue, arg1: address, arg2: vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::Presig>, arg3: u64, arg4: vector<u8>) {
        let v0 = 0x2::object_bag::borrow_mut<address, WithdrawalTransaction>(&mut arg0.withdrawal_txns, arg1);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::reallocate(&mut v0.signing, arg2, arg3);
        if (!0x1::vector::is_empty<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::Presig>(&arg2)) {
            v0.randomness = arg4;
        };
        let v1 = WithdrawalPresigsReassigned{
            withdrawal_txn_id : arg1,
            epoch             : arg3,
        };
        0x2::event::emit<WithdrawalPresigsReassigned>(v1);
    }

    public(friend) fun record_input_signatures(arg0: &mut WithdrawalRequestQueue, arg1: address, arg2: vector<u64>, arg3: vector<vector<u8>>) {
        let v0 = 0x2::object_bag::borrow_mut<address, WithdrawalTransaction>(&mut arg0.withdrawal_txns, arg1);
        assert!(!txn_fully_signed(v0), 13906836592411148307);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::record(&mut v0.signing, arg2, arg3);
        let v1 = WithdrawalInputsSigned{
            withdrawal_txn_id : arg1,
            signed_count      : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::signed_count(&v0.signing),
            num_inputs        : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::num_inputs(&v0.signing),
        };
        0x2::event::emit<WithdrawalInputsSigned>(v1);
    }

    public(friend) fun remove_withdrawal_txn(arg0: &mut WithdrawalRequestQueue, arg1: address) : WithdrawalTransaction {
        0x2::object_bag::remove<address, WithdrawalTransaction>(&mut arg0.withdrawal_txns, arg1)
    }

    public(friend) fun request_approval_cert(arg0: &WithdrawalRequest) : 0x1::option::Option<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature> {
        arg0.approval_cert
    }

    public(friend) fun request_approved_timestamp_ms(arg0: &WithdrawalRequest) : 0x1::option::Option<u64> {
        arg0.approved_timestamp_ms
    }

    public(friend) fun request_bitcoin_address(arg0: &WithdrawalRequest) : &vector<u8> {
        &arg0.bitcoin_address
    }

    public(friend) fun request_btc_amount(arg0: &WithdrawalRequest) : u64 {
        arg0.btc_amount
    }

    public(friend) fun request_created_timestamp_ms(arg0: &WithdrawalRequest) : u64 {
        arg0.created_timestamp_ms
    }

    public(friend) fun request_id(arg0: &WithdrawalRequest) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun request_sender(arg0: &WithdrawalRequest) : address {
        arg0.sender
    }

    public(friend) fun request_withdrawal_txn_id(arg0: &WithdrawalRequest) : 0x1::option::Option<address> {
        arg0.withdrawal_txn_id
    }

    public(friend) fun txid(arg0: &WithdrawalTransaction) : address {
        arg0.txid
    }

    fun txn_fully_signed(arg0: &WithdrawalTransaction) : bool {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::is_complete(&arg0.signing) && 0x1::option::is_some<vector<vector<u8>>>(&arg0.guardian_signatures)
    }

    public(friend) fun withdrawal_txn_id(arg0: &WithdrawalTransaction) : address {
        0x2::object::uid_to_address(&arg0.id)
    }

    public(friend) fun withdrawal_txn_inputs(arg0: &WithdrawalTransaction) : &vector<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo> {
        &arg0.inputs
    }

    public(friend) fun withdrawal_txn_is_fully_signed(arg0: &WithdrawalRequestQueue, arg1: address) : bool {
        txn_fully_signed(0x2::object_bag::borrow<address, WithdrawalTransaction>(&arg0.withdrawal_txns, arg1))
    }

    public(friend) fun withdrawal_txn_mpc_signatures(arg0: &WithdrawalRequestQueue, arg1: address) : vector<vector<u8>> {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::to_signatures(&0x2::object_bag::borrow<address, WithdrawalTransaction>(&arg0.withdrawal_txns, arg1).signing)
    }

    public(friend) fun withdrawal_txn_num_inputs(arg0: &WithdrawalRequestQueue, arg1: address) : u64 {
        0x1::vector::length<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo>(&0x2::object_bag::borrow<address, WithdrawalTransaction>(&arg0.withdrawal_txns, arg1).inputs)
    }

    public(friend) fun withdrawal_txn_pending_count(arg0: &WithdrawalRequestQueue, arg1: address) : u64 {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::pending_count(&0x2::object_bag::borrow<address, WithdrawalTransaction>(&arg0.withdrawal_txns, arg1).signing)
    }

    public(friend) fun withdrawal_txn_request_ids(arg0: &WithdrawalTransaction) : &vector<address> {
        &arg0.request_ids
    }

    public(friend) fun withdrawal_txn_signing_epoch(arg0: &WithdrawalRequestQueue, arg1: address) : u64 {
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::mpc_signing::epoch(&0x2::object_bag::borrow<address, WithdrawalTransaction>(&arg0.withdrawal_txns, arg1).signing)
    }

    // decompiled from Move bytecode v7
}

