module 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::pool_rewards {
    struct RewardRegistry has key {
        id: 0x2::object::UID,
        admin: address,
        total_batches: u64,
        total_sats_paid: u128,
        completed_rounds: u64,
    }

    struct RewardBatch has key {
        id: 0x2::object::UID,
        round_id: u64,
        payouts: 0x2::table::Table<address, u64>,
        miner_list: vector<address>,
        total_sats: u64,
        miner_count: u64,
        btc_tx_hash: 0x1::option::Option<vector<u8>>,
        signature: 0x1::option::Option<vector<u8>>,
        status: u8,
        created_at_ms: u64,
        signing_requested_at_ms: 0x1::option::Option<u64>,
        signed_at_ms: 0x1::option::Option<u64>,
        broadcast_at_ms: 0x1::option::Option<u64>,
        confirmed_at_ms: 0x1::option::Option<u64>,
    }

    struct RewardReceipt has store, key {
        id: 0x2::object::UID,
        batch_id: address,
        round_id: u64,
        miner: address,
        amount_sats: u64,
        btc_tx_hash: vector<u8>,
        issued_at_ms: u64,
    }

    struct RewardBatchCreated has copy, drop {
        batch_id: address,
        round_id: u64,
        miner_count: u64,
        total_sats: u64,
    }

    struct RewardSigningRequested has copy, drop {
        batch_id: address,
        round_id: u64,
        btc_tx_hash: vector<u8>,
        dwallet_id: address,
    }

    struct RewardBatchSigned has copy, drop {
        batch_id: address,
        round_id: u64,
        signature: vector<u8>,
    }

    struct RewardBatchBroadcast has copy, drop {
        batch_id: address,
        round_id: u64,
        btc_tx_hash: vector<u8>,
    }

    struct RewardBatchConfirmed has copy, drop {
        batch_id: address,
        round_id: u64,
        btc_block_height: u64,
    }

    struct RewardReceiptIssued has copy, drop {
        receipt_id: address,
        batch_id: address,
        miner: address,
        amount_sats: u64,
    }

    public entry fun create_reward_batch(arg0: &mut RewardRegistry, arg1: &0x2::clock::Clock, arg2: u64, arg3: vector<address>, arg4: vector<u64>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.admin, 1);
        assert!(0x1::vector::length<address>(&arg3) == 0x1::vector::length<u64>(&arg4), 7);
        let v0 = 0x1::vector::length<address>(&arg3);
        let v1 = 0x2::table::new<address, u64>(arg5);
        let v2 = 0;
        let v3 = 0x1::vector::empty<address>();
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<address>(&arg3, v4);
            let v6 = *0x1::vector::borrow<u64>(&arg4, v4);
            0x2::table::add<address, u64>(&mut v1, v5, v6);
            0x1::vector::push_back<address>(&mut v3, v5);
            v2 = v2 + v6;
            v4 = v4 + 1;
        };
        let v7 = RewardBatch{
            id                      : 0x2::object::new(arg5),
            round_id                : arg2,
            payouts                 : v1,
            miner_list              : v3,
            total_sats              : v2,
            miner_count             : (v0 as u64),
            btc_tx_hash             : 0x1::option::none<vector<u8>>(),
            signature               : 0x1::option::none<vector<u8>>(),
            status                  : 0,
            created_at_ms           : 0x2::clock::timestamp_ms(arg1),
            signing_requested_at_ms : 0x1::option::none<u64>(),
            signed_at_ms            : 0x1::option::none<u64>(),
            broadcast_at_ms         : 0x1::option::none<u64>(),
            confirmed_at_ms         : 0x1::option::none<u64>(),
        };
        arg0.total_batches = arg0.total_batches + 1;
        let v8 = RewardBatchCreated{
            batch_id    : 0x2::object::uid_to_address(&v7.id),
            round_id    : arg2,
            miner_count : (v0 as u64),
            total_sats  : v2,
        };
        0x2::event::emit<RewardBatchCreated>(v8);
        0x2::transfer::share_object<RewardBatch>(v7);
    }

    public fun get_batch_miner_count(arg0: &RewardBatch) : u64 {
        arg0.miner_count
    }

    public fun get_batch_round_id(arg0: &RewardBatch) : u64 {
        arg0.round_id
    }

    public fun get_batch_status(arg0: &RewardBatch) : u8 {
        arg0.status
    }

    public fun get_batch_total_sats(arg0: &RewardBatch) : u64 {
        arg0.total_sats
    }

    public fun get_btc_tx_hash(arg0: &RewardBatch) : 0x1::option::Option<vector<u8>> {
        arg0.btc_tx_hash
    }

    public fun get_miner_payout(arg0: &RewardBatch, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.payouts, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.payouts, arg1)
        } else {
            0
        }
    }

    public fun get_registry_stats(arg0: &RewardRegistry) : (u64, u128, u64) {
        (arg0.total_batches, arg0.total_sats_paid, arg0.completed_rounds)
    }

    public fun get_signature(arg0: &RewardBatch) : 0x1::option::Option<vector<u8>> {
        arg0.signature
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardRegistry{
            id               : 0x2::object::new(arg0),
            admin            : 0x2::tx_context::sender(arg0),
            total_batches    : 0,
            total_sats_paid  : 0,
            completed_rounds : 0,
        };
        0x2::transfer::share_object<RewardRegistry>(v0);
    }

    public fun is_signed(arg0: &RewardBatch) : bool {
        0x1::option::is_some<vector<u8>>(&arg0.signature)
    }

    public entry fun issue_receipt(arg0: &RewardBatch, arg1: &0x2::clock::Clock, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 4, 2);
        assert!(0x2::table::contains<address, u64>(&arg0.payouts, arg2), 4);
        let v0 = *0x2::table::borrow<address, u64>(&arg0.payouts, arg2);
        let v1 = RewardReceipt{
            id           : 0x2::object::new(arg3),
            batch_id     : 0x2::object::uid_to_address(&arg0.id),
            round_id     : arg0.round_id,
            miner        : arg2,
            amount_sats  : v0,
            btc_tx_hash  : *0x1::option::borrow<vector<u8>>(&arg0.btc_tx_hash),
            issued_at_ms : 0x2::clock::timestamp_ms(arg1),
        };
        let v2 = RewardReceiptIssued{
            receipt_id  : 0x2::object::uid_to_address(&v1.id),
            batch_id    : 0x2::object::uid_to_address(&arg0.id),
            miner       : arg2,
            amount_sats : v0,
        };
        0x2::event::emit<RewardReceiptIssued>(v2);
        0x2::transfer::transfer<RewardReceipt>(v1, arg2);
    }

    public entry fun mark_broadcast(arg0: &mut RewardRegistry, arg1: &mut RewardBatch, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.admin, 1);
        assert!(arg1.status == 2, 2);
        arg1.status = 3;
        arg1.broadcast_at_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
        let v0 = RewardBatchBroadcast{
            batch_id    : 0x2::object::uid_to_address(&arg1.id),
            round_id    : arg1.round_id,
            btc_tx_hash : *0x1::option::borrow<vector<u8>>(&arg1.btc_tx_hash),
        };
        0x2::event::emit<RewardBatchBroadcast>(v0);
    }

    public entry fun mark_confirmed(arg0: &mut RewardRegistry, arg1: &mut RewardBatch, arg2: &0x2::clock::Clock, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        assert!(arg1.status == 3, 2);
        arg1.status = 4;
        arg1.confirmed_at_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
        arg0.total_sats_paid = arg0.total_sats_paid + (arg1.total_sats as u128);
        arg0.completed_rounds = arg0.completed_rounds + 1;
        let v0 = RewardBatchConfirmed{
            batch_id         : 0x2::object::uid_to_address(&arg1.id),
            round_id         : arg1.round_id,
            btc_block_height : arg3,
        };
        0x2::event::emit<RewardBatchConfirmed>(v0);
    }

    public entry fun request_signing(arg0: &mut RewardBatch, arg1: &0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::dwallet_cap::PoolSigningCap, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 2);
        assert!(0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::dwallet_cap::is_active(arg1), 5);
        assert!(0x1::vector::length<u8>(&arg3) == 32, 6);
        arg0.btc_tx_hash = 0x1::option::some<vector<u8>>(arg3);
        arg0.status = 1;
        arg0.signing_requested_at_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
        let v0 = RewardSigningRequested{
            batch_id    : 0x2::object::uid_to_address(&arg0.id),
            round_id    : arg0.round_id,
            btc_tx_hash : arg3,
            dwallet_id  : 0xdf7cc2d80454cd56818e58e727b48beb2f8c441fcf6e4f46fd2282d24427a895::dwallet_cap::get_dwallet_id(arg1),
        };
        0x2::event::emit<RewardSigningRequested>(v0);
    }

    public fun status_broadcast() : u8 {
        3
    }

    public fun status_confirmed() : u8 {
        4
    }

    public fun status_failed() : u8 {
        5
    }

    public fun status_pending() : u8 {
        0
    }

    public fun status_signed() : u8 {
        2
    }

    public fun status_signing() : u8 {
        1
    }

    public entry fun submit_signature(arg0: &mut RewardRegistry, arg1: &mut RewardBatch, arg2: &0x2::clock::Clock, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg4) == arg0.admin, 1);
        assert!(arg1.status == 1, 2);
        let v0 = 0x1::vector::length<u8>(&arg3);
        assert!(v0 == 64 || v0 == 65, 6);
        arg1.signature = 0x1::option::some<vector<u8>>(arg3);
        arg1.status = 2;
        arg1.signed_at_ms = 0x1::option::some<u64>(0x2::clock::timestamp_ms(arg2));
        let v1 = RewardBatchSigned{
            batch_id  : 0x2::object::uid_to_address(&arg1.id),
            round_id  : arg1.round_id,
            signature : arg3,
        };
        0x2::event::emit<RewardBatchSigned>(v1);
    }

    // decompiled from Move bytecode v6
}

