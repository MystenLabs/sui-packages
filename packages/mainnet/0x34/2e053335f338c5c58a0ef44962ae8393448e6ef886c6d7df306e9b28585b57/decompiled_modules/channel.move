module 0x342e053335f338c5c58a0ef44962ae8393448e6ef886c6d7df306e9b28585b57::channel {
    struct Channel has store, key {
        id: 0x2::object::UID,
        terms_hash: vector<u8>,
        recipient_addrs: vector<address>,
        cooperative_close_threshold: u64,
        claim_grace_ms: u64,
        maximum_reservation_microusd: u64,
        settlement_deadline_ms: u64,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
        deposit_microusd: u64,
        last_sequence: u64,
        last_cumulative_microusd: u64,
        last_reservation_microusd: u64,
        last_accepted_tokens: u64,
        last_accepted_blocks: u64,
        last_block_commit_hash: vector<u8>,
        paid_out_microusd: u64,
        closed_at_ms: u64,
    }

    struct VoucherAccepted has copy, drop {
        channel: 0x2::object::ID,
        sequence: u64,
        cumulative_microusd: u64,
        paid_delta_microusd: u64,
    }

    public fun accepted_cumulative(arg0: &VoucherAccepted) : u64 {
        arg0.cumulative_microusd
    }

    public fun accepted_paid_delta(arg0: &VoucherAccepted) : u64 {
        arg0.paid_delta_microusd
    }

    public fun accepted_sequence(arg0: &VoucherAccepted) : u64 {
        arg0.sequence
    }

    public fun closed_at_ms(arg0: &Channel) : u64 {
        arg0.closed_at_ms
    }

    fun contains_recipient(arg0: &Channel, arg1: address) : bool {
        0x1::vector::contains<address>(&arg0.recipient_addrs, &arg1)
    }

    public fun cooperative_close(arg0: &mut Channel, arg1: u64, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.closed_at_ms == 0, 1);
        assert!(arg1 >= arg0.cooperative_close_threshold, 14);
        assert!(contains_recipient(arg0, arg3), 14);
        arg0.closed_at_ms = arg2;
        sweep(arg0, arg3, arg4);
    }

    public fun deposit_microusd(arg0: &Channel) : u64 {
        arg0.deposit_microusd
    }

    fun initial_terms_hash(arg0: &vector<address>, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = b"sensui-channel-terms-v1";
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg0)) {
            let v2 = *0x1::vector::borrow<address>(arg0, v1);
            0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&v2));
            v1 = v1 + 1;
        };
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg4));
        v0
    }

    public fun last_accepted_blocks(arg0: &Channel) : u64 {
        arg0.last_accepted_blocks
    }

    public fun last_accepted_tokens(arg0: &Channel) : u64 {
        arg0.last_accepted_tokens
    }

    public fun last_cumulative_microusd(arg0: &Channel) : u64 {
        arg0.last_cumulative_microusd
    }

    public fun last_reservation_microusd(arg0: &Channel) : u64 {
        arg0.last_reservation_microusd
    }

    public fun last_sequence(arg0: &Channel) : u64 {
        arg0.last_sequence
    }

    public fun open(arg0: vector<address>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg0) > 0, 16);
        let v0 = Channel{
            id                           : 0x2::object::new(arg6),
            terms_hash                   : initial_terms_hash(&arg0, arg1, arg2, arg3, arg4),
            recipient_addrs              : arg0,
            cooperative_close_threshold  : arg1,
            claim_grace_ms               : arg2,
            maximum_reservation_microusd : arg3,
            settlement_deadline_ms       : arg4,
            escrow                       : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
            deposit_microusd             : 0x2::coin::value<0x2::sui::SUI>(&mut arg5),
            last_sequence                : 0,
            last_cumulative_microusd     : 0,
            last_reservation_microusd    : 0,
            last_accepted_tokens         : 0,
            last_accepted_blocks         : 0,
            last_block_commit_hash       : b"",
            paid_out_microusd            : 0,
            closed_at_ms                 : 0,
        };
        0x2::transfer::public_transfer<Channel>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun paid_out_microusd(arg0: &Channel) : u64 {
        arg0.paid_out_microusd
    }

    public fun recipient_count(arg0: &Channel) : u64 {
        0x1::vector::length<address>(&arg0.recipient_addrs)
    }

    public fun refund_after_deadline(arg0: &mut Channel, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg0.closed_at_ms > 0) {
            arg0.closed_at_ms + arg0.claim_grace_ms
        } else {
            arg0.settlement_deadline_ms
        };
        assert!(arg1 >= v0, 13);
        sweep(arg0, arg2, arg3);
    }

    public fun submit_voucher(arg0: &mut Channel, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: vector<u8>, arg8: bool, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) : VoucherAccepted {
        assert!(arg0.closed_at_ms == 0, 1);
        if (arg0.closed_at_ms > 0) {
            assert!(arg9 < arg0.closed_at_ms + arg0.claim_grace_ms, 9);
        };
        assert!(arg8, 11);
        assert!(0x1::vector::length<u8>(&arg7) > 0, 12);
        if (arg1 == arg0.last_sequence) {
            assert!(arg2 == arg0.last_cumulative_microusd, 3);
        } else {
            assert!(arg1 > arg0.last_sequence, 2);
            assert!(arg2 > arg0.last_cumulative_microusd, 3);
        };
        assert!(arg3 >= arg0.last_reservation_microusd, 4);
        assert!(arg3 <= arg0.maximum_reservation_microusd, 5);
        assert!(arg4 >= arg0.last_accepted_tokens, 6);
        assert!(arg5 >= arg0.last_accepted_blocks, 7);
        if (arg1 > arg0.last_sequence) {
            assert!(arg6 != arg0.last_block_commit_hash || 0x1::vector::length<u8>(&arg0.last_block_commit_hash) == 0, 8);
        };
        assert!(arg2 <= arg0.deposit_microusd, 15);
        let v0 = arg2 - arg0.last_cumulative_microusd;
        arg0.last_sequence = arg1;
        arg0.last_cumulative_microusd = arg2;
        arg0.last_reservation_microusd = arg3;
        arg0.last_accepted_tokens = arg4;
        arg0.last_accepted_blocks = arg5;
        arg0.last_block_commit_hash = arg6;
        arg0.paid_out_microusd = arg0.paid_out_microusd + v0;
        VoucherAccepted{
            channel             : 0x2::object::id<Channel>(arg0),
            sequence            : arg1,
            cumulative_microusd : arg2,
            paid_delta_microusd : v0,
        }
    }

    fun sweep(arg0: &mut Channel, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.escrow);
        if (v0 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v0), arg2), arg1);
        };
        arg0.deposit_microusd = 0;
    }

    public fun terms_hash(arg0: &Channel) : vector<u8> {
        arg0.terms_hash
    }

    public fun voucher_domain_binding(arg0: &Channel, arg1: &vector<u8>, arg2: &vector<u8>, arg3: &vector<u8>, arg4: &vector<u8>) : vector<u8> {
        let v0 = terms_hash(arg0);
        let v1 = 0x2::object::id<Channel>(arg0);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<0x2::object::ID>(&v1));
        0x1::vector::append<u8>(&mut v0, *arg1);
        0x1::vector::append<u8>(&mut v0, *arg2);
        0x1::vector::append<u8>(&mut v0, *arg3);
        0x1::vector::append<u8>(&mut v0, *arg4);
        v0
    }

    // decompiled from Move bytecode v7
}

