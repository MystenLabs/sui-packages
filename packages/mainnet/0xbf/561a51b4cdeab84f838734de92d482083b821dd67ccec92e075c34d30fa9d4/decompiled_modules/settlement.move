module 0xbf561a51b4cdeab84f838734de92d482083b821dd67ccec92e075c34d30fa9d4::settlement {
    struct AgentEscrow has key {
        id: 0x2::object::UID,
        session_id: vector<u8>,
        initiator: address,
        responder: address,
        locked_funds: 0x2::coin::Coin<0x2::sui::SUI>,
        commitment_hash: vector<u8>,
        deadline_ms: u64,
        treasury: address,
    }

    struct AgentReputation has key {
        id: 0x2::object::UID,
        agent: address,
        successful_settlements: u64,
        failed_settlements: u64,
        total_compute_units: u64,
        eigentrust_score: u64,
        stake: 0x2::coin::Coin<0x2::sui::SUI>,
    }

    struct EscrowCreated has copy, drop {
        escrow_id: 0x2::object::ID,
        session_id: vector<u8>,
        initiator: address,
        responder: address,
        amount_pico: u64,
        deadline_ms: u64,
    }

    struct EscrowSettled has copy, drop {
        escrow_id: 0x2::object::ID,
        session_id: vector<u8>,
        responder: address,
        compute_units: u64,
        responder_payment: u64,
        protocol_fee: u64,
        initiator_refund: u64,
        new_eigentrust: u64,
    }

    struct EscrowReclaimed has copy, drop {
        escrow_id: 0x2::object::ID,
        session_id: vector<u8>,
        initiator: address,
        refund_amount: u64,
        new_eigentrust: u64,
    }

    public fun create_escrow(arg0: vector<u8>, arg1: address, arg2: vector<u8>, arg3: u64, arg4: address, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        assert!(arg3 > 0x2::clock::timestamp_ms(arg6), 1001);
        assert!(0x1::vector::length<u8>(&arg2) == 32, 1005);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) > 0, 1006);
        let v0 = AgentEscrow{
            id              : 0x2::object::new(arg7),
            session_id      : arg0,
            initiator       : 0x2::tx_context::sender(arg7),
            responder       : arg1,
            locked_funds    : arg5,
            commitment_hash : arg2,
            deadline_ms     : arg3,
            treasury        : arg4,
        };
        let v1 = 0x2::object::id<AgentEscrow>(&v0);
        let v2 = EscrowCreated{
            escrow_id   : v1,
            session_id  : v0.session_id,
            initiator   : v0.initiator,
            responder   : arg1,
            amount_pico : 0x2::coin::value<0x2::sui::SUI>(&v0.locked_funds),
            deadline_ms : arg3,
        };
        0x2::event::emit<EscrowCreated>(v2);
        0x2::transfer::share_object<AgentEscrow>(v0);
        v1
    }

    public fun eigentrust_score(arg0: &AgentReputation) : u64 {
        arg0.eigentrust_score
    }

    public fun reclaim_expired_escrow(arg0: AgentEscrow, arg1: &mut AgentReputation, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.initiator, 1003);
        assert!(0x2::clock::timestamp_ms(arg2) > arg0.deadline_ms, 1004);
        let AgentEscrow {
            id              : v0,
            session_id      : v1,
            initiator       : v2,
            responder       : _,
            locked_funds    : v4,
            commitment_hash : _,
            deadline_ms     : _,
            treasury        : _,
        } = arg0;
        let v8 = v4;
        let v9 = v0;
        0x2::object::delete(v9);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v8, v2);
        arg1.failed_settlements = arg1.failed_settlements + 1;
        arg1.eigentrust_score = arg1.eigentrust_score * 9 / 10;
        let v10 = EscrowReclaimed{
            escrow_id      : 0x2::object::uid_to_inner(&v9),
            session_id     : v1,
            initiator      : v2,
            refund_amount  : 0x2::coin::value<0x2::sui::SUI>(&v8),
            new_eigentrust : arg1.eigentrust_score,
        };
        0x2::event::emit<EscrowReclaimed>(v10);
    }

    public entry fun register_agent(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AgentReputation{
            id                     : 0x2::object::new(arg0),
            agent                  : 0x2::tx_context::sender(arg0),
            successful_settlements : 0,
            failed_settlements     : 0,
            total_compute_units    : 0,
            eigentrust_score       : 1000,
            stake                  : 0x2::coin::zero<0x2::sui::SUI>(arg0),
        };
        0x2::transfer::share_object<AgentReputation>(v0);
    }

    public fun settle_escrow(arg0: AgentEscrow, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: &mut AgentReputation, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg6) == arg0.responder, 1003);
        assert!(0x2::clock::timestamp_ms(arg5) <= arg0.deadline_ms, 1001);
        assert!(0x1::hash::sha2_256(arg1) == arg0.commitment_hash, 1002);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg0.locked_funds);
        let v1 = arg2 * arg3;
        let v2 = if (v1 > v0) {
            v0
        } else {
            v1
        };
        let v3 = v2 * 30 / 10000;
        let v4 = v2 - v3;
        let v5 = v0 - v2;
        let AgentEscrow {
            id              : v6,
            session_id      : v7,
            initiator       : v8,
            responder       : v9,
            locked_funds    : v10,
            commitment_hash : _,
            deadline_ms     : _,
            treasury        : v13,
        } = arg0;
        let v14 = v6;
        0x2::object::delete(v14);
        let v15 = v10;
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v15, v4, arg6), v9);
        if (v3 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(&mut v15, v3, arg6), v13);
        };
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v15, v8);
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v15);
        };
        arg4.successful_settlements = arg4.successful_settlements + 1;
        arg4.total_compute_units = arg4.total_compute_units + arg2;
        let v16 = arg4.eigentrust_score * 9 / 10 + 100000;
        let v17 = if (v16 > 1000000) {
            1000000
        } else {
            v16
        };
        arg4.eigentrust_score = v17;
        let v18 = EscrowSettled{
            escrow_id         : 0x2::object::uid_to_inner(&v14),
            session_id        : v7,
            responder         : v9,
            compute_units     : arg2,
            responder_payment : v4,
            protocol_fee      : v3,
            initiator_refund  : v5,
            new_eigentrust    : arg4.eigentrust_score,
        };
        0x2::event::emit<EscrowSettled>(v18);
    }

    public fun success_rate_bps(arg0: &AgentReputation) : u64 {
        let v0 = arg0.successful_settlements + arg0.failed_settlements;
        if (v0 == 0) {
            0
        } else {
            arg0.successful_settlements * 10000 / v0
        }
    }

    // decompiled from Move bytecode v7
}

