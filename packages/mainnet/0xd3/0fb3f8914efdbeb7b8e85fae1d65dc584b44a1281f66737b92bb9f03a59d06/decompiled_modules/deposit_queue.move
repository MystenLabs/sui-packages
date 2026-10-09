module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::deposit_queue {
    struct DepositRequest has store, key {
        id: 0x2::object::UID,
        sender: address,
        created_timestamp_ms: u64,
        sui_tx_digest: vector<u8>,
        utxo: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo,
        approval_cert: 0x1::option::Option<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>,
        approved_timestamp_ms: 0x1::option::Option<u64>,
        confirmed_timestamp_ms: 0x1::option::Option<u64>,
    }

    struct DepositRequestQueue has store {
        requests: 0x2::object_bag::ObjectBag,
        processed: 0x2::object_bag::ObjectBag,
    }

    public(friend) fun contains(arg0: &DepositRequestQueue, arg1: address) : bool {
        0x2::object_bag::contains<address>(&arg0.requests, arg1)
    }

    public(friend) fun approval_cert(arg0: &DepositRequest) : 0x1::option::Option<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature> {
        arg0.approval_cert
    }

    public(friend) fun approve(arg0: &mut DepositRequest, arg1: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature, arg2: &0x2::clock::Clock) {
        arg0.approval_cert = 0x1::option::some<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(arg1);
        arg0.approved_timestamp_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
    }

    public(friend) fun approved_timestamp_ms(arg0: &DepositRequest) : 0x1::option::Option<u64> {
        arg0.approved_timestamp_ms
    }

    public(friend) fun borrow_request(arg0: &DepositRequestQueue, arg1: address) : &DepositRequest {
        0x2::object_bag::borrow<address, DepositRequest>(&arg0.requests, arg1)
    }

    public(friend) fun borrow_request_mut(arg0: &mut DepositRequestQueue, arg1: address) : &mut DepositRequest {
        0x2::object_bag::borrow_mut<address, DepositRequest>(&mut arg0.requests, arg1)
    }

    public(friend) fun confirm(arg0: &mut DepositRequest, arg1: &0x2::clock::Clock) {
        arg0.confirmed_timestamp_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg1));
    }

    public(friend) fun confirmed_timestamp_ms(arg0: &DepositRequest) : 0x1::option::Option<u64> {
        arg0.confirmed_timestamp_ms
    }

    public(friend) fun create(arg0: &mut 0x2::tx_context::TxContext) : DepositRequestQueue {
        DepositRequestQueue{
            requests  : 0x2::object_bag::new(arg0),
            processed : 0x2::object_bag::new(arg0),
        }
    }

    public(friend) fun create_deposit(arg0: 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : DepositRequest {
        DepositRequest{
            id                     : 0x2::object::new(arg2),
            sender                 : 0x2::tx_context::sender(arg2),
            created_timestamp_ms   : 0x2::clock::timestamp_ms(arg1),
            sui_tx_digest          : *0x2::tx_context::digest(arg2),
            utxo                   : arg0,
            approval_cert          : 0x1::option::none<0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::committee::CommitteeSignature>(),
            approved_timestamp_ms  : 0x1::option::none<u64>(),
            confirmed_timestamp_ms : 0x1::option::none<u64>(),
        }
    }

    public(friend) fun utxo(arg0: &DepositRequest) : 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo {
        arg0.utxo
    }

    public(friend) fun delete_expired(arg0: &mut DepositRequestQueue, arg1: address, arg2: &0x2::clock::Clock) {
        assert!(!0x2::object_bag::contains<address>(&arg0.processed, arg1), 13906834754164162564);
        let v0 = 0x2::object_bag::remove<address, DepositRequest>(&mut arg0.requests, arg1);
        assert!(is_expired(&v0, arg2), 13835058643692748802);
        let DepositRequest {
            id                     : v1,
            sender                 : _,
            created_timestamp_ms   : _,
            sui_tx_digest          : _,
            utxo                   : v5,
            approval_cert          : _,
            approved_timestamp_ms  : _,
            confirmed_timestamp_ms : _,
        } = v0;
        0x2::object::delete(v1);
        0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::delete(v5);
    }

    public(friend) fun insert_deposit(arg0: &mut DepositRequestQueue, arg1: DepositRequest) {
        0x2::object_bag::add<address, DepositRequest>(&mut arg0.requests, 0x2::object::uid_to_address(&arg1.id), arg1);
    }

    public(friend) fun insert_processed(arg0: &mut DepositRequestQueue, arg1: DepositRequest) : (address, 0x1::option::Option<address>) {
        let v0 = 0x2::object::uid_to_address(&arg1.id);
        0x2::object_bag::add<address, DepositRequest>(&mut arg0.processed, v0, arg1);
        (v0, 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::derivation_path(&arg1.utxo))
    }

    fun is_expired(arg0: &DepositRequest, arg1: &0x2::clock::Clock) : bool {
        0x2::clock::timestamp_ms(arg1) > arg0.created_timestamp_ms + 86400000
    }

    public(friend) fun remove_request(arg0: &mut DepositRequestQueue, arg1: address) : DepositRequest {
        0x2::object_bag::remove<address, DepositRequest>(&mut arg0.requests, arg1)
    }

    public(friend) fun request_created_timestamp_ms(arg0: &DepositRequest) : u64 {
        arg0.created_timestamp_ms
    }

    public(friend) fun request_id(arg0: &DepositRequest) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public(friend) fun request_sender(arg0: &DepositRequest) : address {
        arg0.sender
    }

    public(friend) fun request_sui_tx_digest(arg0: &DepositRequest) : vector<u8> {
        arg0.sui_tx_digest
    }

    public(friend) fun request_utxo(arg0: &DepositRequest) : &0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::utxo::Utxo {
        &arg0.utxo
    }

    // decompiled from Move bytecode v7
}

