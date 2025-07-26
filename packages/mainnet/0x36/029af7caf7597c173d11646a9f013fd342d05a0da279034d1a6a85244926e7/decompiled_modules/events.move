module 0xf501bc5006be9be7e368a604664c02b0d64c8e98fc80619c1af2a10a4faf0daf::events {
    struct CommitAllocationSet has copy, drop {
        user: address,
        admin: address,
        tier1_allocation: u64,
        tier2_allocation: u64,
        tier3_allocation: u64,
        timestamp: u64,
    }

    struct IsPausedUpdated has copy, drop {
        admin: address,
        is_paused: bool,
        timestamp: u64,
    }

    struct TotalCapUpdated has copy, drop {
        admin: address,
        total_cap: u64,
        timestamp: u64,
    }

    struct PhaseUpdated has copy, drop {
        admin: address,
        phase: u8,
        timestamp: u64,
    }

    struct MigrationEvent has copy, drop {
        admin: address,
        old_version: u64,
        new_version: u64,
        timestamp: u64,
    }

    struct InviterRelationshipEstablished has copy, drop {
        user: address,
        inviter: address,
        inviter_code: vector<u8>,
        timestamp: u64,
    }

    struct CommitMade has copy, drop {
        user: address,
        tier: u8,
        quantity: u64,
        amount: u64,
        commit_id: address,
        timestamp: u64,
    }

    struct PrivateRefund has copy, drop {
        user: address,
        tier: u8,
        quantity: u64,
        amount: u64,
        commit_id: address,
        timestamp: u64,
    }

    struct PrivatePurchase has copy, drop {
        user: address,
        tier: u8,
        quantity: u64,
        amount: u64,
        commit_id: address,
        timestamp: u64,
    }

    struct PublicPurchase has copy, drop {
        user: address,
        quantity: u64,
        amount: u64,
        timestamp: u64,
    }

    struct DeedBurned has copy, drop {
        deed_id: address,
        tier: u8,
        owner: address,
        minted_at: u64,
        timestamp: u64,
    }

    struct RevenueWithdrawal has copy, drop {
        admin: address,
        amount: u64,
        timestamp: u64,
    }

    struct InviteCodeRegistered has copy, drop {
        user: address,
        invite_code: vector<u8>,
        timestamp: u64,
    }

    struct InviterReward has copy, drop {
        inviter: address,
        buyer: address,
        amount: u64,
        tier: u8,
        quantity: u64,
        timestamp: u64,
    }

    struct BuyerDiscount has copy, drop {
        buyer: address,
        amount: u64,
        timestamp: u64,
    }

    struct AdminMint has copy, drop {
        admin: address,
        addr: address,
        quantity: u64,
        timestamp: u64,
    }

    struct Minted has copy, drop {
        user: address,
        tier: u8,
        timestamp: u64,
    }

    struct OperatorUpdated has copy, drop {
        admin: address,
        operator: address,
        timestamp: u64,
    }

    public fun emit_admin_mint(arg0: address, arg1: address, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = AdminMint{
            admin     : arg0,
            addr      : arg1,
            quantity  : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<AdminMint>(v0);
    }

    public fun emit_buyer_discount(arg0: address, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = BuyerDiscount{
            buyer     : arg0,
            amount    : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BuyerDiscount>(v0);
    }

    public fun emit_commit_allocation_set(arg0: address, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = CommitAllocationSet{
            user             : arg0,
            admin            : arg1,
            tier1_allocation : arg2,
            tier2_allocation : arg3,
            tier3_allocation : arg4,
            timestamp        : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CommitAllocationSet>(v0);
    }

    public fun emit_commit_made(arg0: address, arg1: u8, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock) {
        let v0 = CommitMade{
            user      : arg0,
            tier      : arg1,
            quantity  : arg2,
            amount    : arg3,
            commit_id : arg4,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<CommitMade>(v0);
    }

    public fun emit_deed_burned(arg0: address, arg1: u8, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = DeedBurned{
            deed_id   : arg0,
            tier      : arg1,
            owner     : 0x2::tx_context::sender(arg4),
            minted_at : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<DeedBurned>(v0);
    }

    public fun emit_invite_code_registered(arg0: address, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        let v0 = InviteCodeRegistered{
            user        : arg0,
            invite_code : arg1,
            timestamp   : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<InviteCodeRegistered>(v0);
    }

    public fun emit_inviter_relationship_established(arg0: address, arg1: address, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        let v0 = InviterRelationshipEstablished{
            user         : arg0,
            inviter      : arg1,
            inviter_code : arg2,
            timestamp    : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<InviterRelationshipEstablished>(v0);
    }

    public fun emit_inviter_reward(arg0: address, arg1: address, arg2: u64, arg3: u8, arg4: u64, arg5: &0x2::clock::Clock) {
        let v0 = InviterReward{
            inviter   : arg0,
            buyer     : arg1,
            amount    : arg2,
            tier      : arg3,
            quantity  : arg4,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<InviterReward>(v0);
    }

    public fun emit_is_paused_updated(arg0: address, arg1: bool, arg2: &0x2::clock::Clock) {
        let v0 = IsPausedUpdated{
            admin     : arg0,
            is_paused : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<IsPausedUpdated>(v0);
    }

    public fun emit_migration_event(arg0: address, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = MigrationEvent{
            admin       : arg0,
            old_version : arg1,
            new_version : arg2,
            timestamp   : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<MigrationEvent>(v0);
    }

    public fun emit_minted(arg0: address, arg1: u8, arg2: &0x2::clock::Clock) {
        let v0 = Minted{
            user      : arg0,
            tier      : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<Minted>(v0);
    }

    public fun emit_operator_updated(arg0: address, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = OperatorUpdated{
            admin     : arg0,
            operator  : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<OperatorUpdated>(v0);
    }

    public fun emit_phase_updated(arg0: address, arg1: u8, arg2: &0x2::clock::Clock) {
        let v0 = PhaseUpdated{
            admin     : arg0,
            phase     : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<PhaseUpdated>(v0);
    }

    public fun emit_private_purchase(arg0: address, arg1: u8, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock) {
        let v0 = PrivatePurchase{
            user      : arg0,
            tier      : arg1,
            quantity  : arg2,
            amount    : arg3,
            commit_id : arg4,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<PrivatePurchase>(v0);
    }

    public fun emit_private_refund(arg0: address, arg1: u8, arg2: u64, arg3: u64, arg4: address, arg5: &0x2::clock::Clock) {
        let v0 = PrivateRefund{
            user      : arg0,
            tier      : arg1,
            quantity  : arg2,
            amount    : arg3,
            commit_id : arg4,
            timestamp : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<PrivateRefund>(v0);
    }

    public fun emit_public_purchase(arg0: address, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        let v0 = PublicPurchase{
            user      : arg0,
            quantity  : arg1,
            amount    : arg2,
            timestamp : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<PublicPurchase>(v0);
    }

    public fun emit_revenue_withdrawal(arg0: address, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = RevenueWithdrawal{
            admin     : arg0,
            amount    : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<RevenueWithdrawal>(v0);
    }

    public fun emit_total_cap_updated(arg0: address, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = TotalCapUpdated{
            admin     : arg0,
            total_cap : arg1,
            timestamp : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<TotalCapUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

