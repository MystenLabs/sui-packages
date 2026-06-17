module 0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::timelock {
    struct TimelockScheduled has copy, drop {
        action_id: 0x2::object::ID,
        action_kind: u8,
        target_id: 0x2::object::ID,
        payload_hash: vector<u8>,
        execute_after_ms: u64,
    }

    struct TimelockExecuted has copy, drop {
        action_id: 0x2::object::ID,
        action_kind: u8,
        target_id: 0x2::object::ID,
        payload_hash: vector<u8>,
    }

    struct TimelockCancelled has copy, drop {
        action_id: 0x2::object::ID,
        action_kind: u8,
        target_id: 0x2::object::ID,
        payload_hash: vector<u8>,
    }

    struct TimelockReceipt has store, key {
        id: 0x2::object::UID,
        action_kind: u8,
        target_id: 0x2::object::ID,
        payload_hash: vector<u8>,
        execute_after_ms: u64,
    }

    public fun action_create_market() : u8 {
        0
    }

    public fun action_finalize_paused_yt() : u8 {
        15
    }

    public fun action_otc_freeze_listing() : u8 {
        19
    }

    public fun action_otc_issue_pause_cap() : u8 {
        20
    }

    public fun action_otc_set_fee_bps() : u8 {
        16
    }

    public fun action_otc_set_fee_recipient() : u8 {
        17
    }

    public fun action_otc_unpause() : u8 {
        18
    }

    public fun action_register_pt_vault() : u8 {
        1
    }

    public fun action_register_yt_vault() : u8 {
        2
    }

    public fun action_set_adapter_watermark() : u8 {
        7
    }

    public fun action_set_watermark_thresholds() : u8 {
        3
    }

    public fun action_treasury_withdraw() : u8 {
        9
    }

    public fun action_unpause_after_watermark() : u8 {
        4
    }

    public fun action_unpause_escrow() : u8 {
        6
    }

    public fun action_unpause_hard_cap() : u8 {
        8
    }

    public fun action_unpause_market() : u8 {
        5
    }

    public fun action_unpause_pt_vault() : u8 {
        12
    }

    public fun action_unpause_yt_vault() : u8 {
        13
    }

    public fun action_withdraw_forfeited_sy() : u8 {
        11
    }

    public fun action_withdraw_unallocated_yield() : u8 {
        14
    }

    public(friend) fun append_bcs<T0>(arg0: &mut vector<u8>, arg1: &T0) {
        0x1::vector::append<u8>(arg0, 0x2::bcs::to_bytes<T0>(arg1));
    }

    public fun cancel_action(arg0: TimelockReceipt, arg1: &0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::caps::MarketAdminCap) {
        let TimelockReceipt {
            id               : v0,
            action_kind      : v1,
            target_id        : v2,
            payload_hash     : v3,
            execute_after_ms : _,
        } = arg0;
        let v5 = v0;
        0x2::object::delete(v5);
        let v6 = TimelockCancelled{
            action_id    : 0x2::object::uid_to_inner(&v5),
            action_kind  : v1,
            target_id    : v2,
            payload_hash : v3,
        };
        0x2::event::emit<TimelockCancelled>(v6);
    }

    public fun consume_receipt(arg0: TimelockReceipt, arg1: u8, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock) : 0x2::object::ID {
        consume_receipt_with_payload(arg0, arg1, arg2, no_payload_hash(), arg3)
    }

    public fun consume_receipt_with_payload(arg0: TimelockReceipt, arg1: u8, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &0x2::clock::Clock) : 0x2::object::ID {
        let TimelockReceipt {
            id               : v0,
            action_kind      : v1,
            target_id        : v2,
            payload_hash     : v3,
            execute_after_ms : v4,
        } = arg0;
        let v5 = v0;
        let v6 = 0x2::object::uid_to_inner(&v5);
        assert!(v1 == arg1, 17);
        assert!(v2 == arg2, 18);
        assert!(v3 == arg3, 19);
        assert!(0x2::clock::timestamp_ms(arg4) >= v4, 16);
        0x2::object::delete(v5);
        let v7 = TimelockExecuted{
            action_id    : v6,
            action_kind  : v1,
            target_id    : v2,
            payload_hash : v3,
        };
        0x2::event::emit<TimelockExecuted>(v7);
        v6
    }

    public fun hash_payload(arg0: vector<u8>) : vector<u8> {
        0x1::hash::sha2_256(arg0)
    }

    public fun is_known_action(arg0: u8) : bool {
        if (arg0 == 0) {
            true
        } else if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else if (arg0 == 7) {
            true
        } else if (arg0 == 8) {
            true
        } else if (arg0 == 9) {
            true
        } else if (arg0 == 11) {
            true
        } else if (arg0 == 12) {
            true
        } else if (arg0 == 13) {
            true
        } else if (arg0 == 14) {
            true
        } else if (arg0 == 15) {
            true
        } else if (arg0 == 16) {
            true
        } else if (arg0 == 17) {
            true
        } else if (arg0 == 18) {
            true
        } else if (arg0 == 19) {
            true
        } else {
            arg0 == 20
        }
    }

    public fun no_payload_hash() : vector<u8> {
        hash_payload(0x1::vector::empty<u8>())
    }

    public fun receipt_action_id(arg0: &TimelockReceipt) : 0x2::object::ID {
        0x2::object::id<TimelockReceipt>(arg0)
    }

    public fun receipt_action_kind(arg0: &TimelockReceipt) : u8 {
        arg0.action_kind
    }

    public fun receipt_execute_after_ms(arg0: &TimelockReceipt) : u64 {
        arg0.execute_after_ms
    }

    public fun receipt_payload_hash(arg0: &TimelockReceipt) : vector<u8> {
        arg0.payload_hash
    }

    public fun receipt_target_id(arg0: &TimelockReceipt) : 0x2::object::ID {
        arg0.target_id
    }

    public fun schedule_action(arg0: &0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::caps::MarketAdminCap, arg1: u8, arg2: 0x2::object::ID, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : TimelockReceipt {
        schedule_action_with_payload(arg0, arg1, arg2, no_payload_hash(), arg3, arg4)
    }

    public fun schedule_action_with_payload(arg0: &0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::caps::MarketAdminCap, arg1: u8, arg2: 0x2::object::ID, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : TimelockReceipt {
        assert!(is_known_action(arg1), 20);
        let v0 = 0x2::object::new(arg5);
        let v1 = 0x2::clock::timestamp_ms(arg4) + 172800000;
        let v2 = TimelockScheduled{
            action_id        : 0x2::object::uid_to_inner(&v0),
            action_kind      : arg1,
            target_id        : arg2,
            payload_hash     : arg3,
            execute_after_ms : v1,
        };
        0x2::event::emit<TimelockScheduled>(v2);
        TimelockReceipt{
            id               : v0,
            action_kind      : arg1,
            target_id        : arg2,
            payload_hash     : arg3,
            execute_after_ms : v1,
        }
    }

    public fun timelock_delay_ms() : u64 {
        172800000
    }

    public fun transfer_receipt(arg0: TimelockReceipt, arg1: address, arg2: &0x604cdfc00224276b5797b53af8c3aa6c8a9895481b1019784fa98ea786a0ad32::caps::MarketAdminCap) {
        0x2::transfer::public_transfer<TimelockReceipt>(arg0, arg1);
    }

    // decompiled from Move bytecode v7
}

