module 0x48db008a3c9e638dd17d20702632d9909c3c075e44eb339f890fb29503ec3050::events {
    struct PackForked has copy, drop {
        pack_id: 0x2::object::ID,
        parent_id: 0x2::object::ID,
        root_id: 0x2::object::ID,
        creator: address,
        fork_depth: u16,
        content_hash: vector<u8>,
    }

    struct MemoryVersioned has copy, drop {
        pack_id: 0x2::object::ID,
        old_version: u32,
        new_version: u32,
        content_hash: vector<u8>,
        ts_ms: u64,
    }

    struct PackPriceUpdated has copy, drop {
        pack_id: 0x2::object::ID,
        old_price_mist: u64,
        new_price_mist: u64,
    }

    struct PackUnlisted has copy, drop {
        pack_id: 0x2::object::ID,
        seller: address,
    }

    struct PackListedV2 has copy, drop {
        pack_id: 0x2::object::ID,
        seller: address,
        price_mist: u64,
        ts_ms: u64,
    }

    struct PackSoldV2 has copy, drop {
        pack_id: 0x2::object::ID,
        buyer: address,
        seller: address,
        price_mist: u64,
        fee_mist: u64,
        royalty_mist: u64,
        lineage_mist: u64,
    }

    struct LineageRoyaltyPaid has copy, drop {
        pack_id: 0x2::object::ID,
        recipient: address,
        amount_mist: u64,
        depth: u16,
    }

    struct FulfillmentReviewed has copy, drop {
        bounty_id: 0x2::object::ID,
        submission_id: 0x2::object::ID,
        accepted: bool,
    }

    struct BountyPostedV2 has copy, drop {
        bounty_id: 0x2::object::ID,
        poster: address,
        amount_mist: u64,
        deadline_ms: u64,
        description_hash: vector<u8>,
        min_score: u8,
    }

    struct FulfillmentSubmittedV2 has copy, drop {
        bounty_id: 0x2::object::ID,
        submission_id: 0x2::object::ID,
        claimer: address,
        walrus_blob_id: 0x2::object::ID,
    }

    struct BountyPaidV2 has copy, drop {
        bounty_id: 0x2::object::ID,
        claimer: address,
        amount_mist: u64,
    }

    struct BountyCancelledV2 has copy, drop {
        bounty_id: 0x2::object::ID,
        poster: address,
        refund_mist: u64,
    }

    struct ConfigUpdated has copy, drop {
        field: vector<u8>,
        old_value: u64,
        new_value: u64,
    }

    public(friend) fun emit_bounty_cancelled_v2(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = BountyCancelledV2{
            bounty_id   : arg0,
            poster      : arg1,
            refund_mist : arg2,
        };
        0x2::event::emit<BountyCancelledV2>(v0);
    }

    public(friend) fun emit_bounty_paid_v2(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = BountyPaidV2{
            bounty_id   : arg0,
            claimer     : arg1,
            amount_mist : arg2,
        };
        0x2::event::emit<BountyPaidV2>(v0);
    }

    public(friend) fun emit_bounty_posted_v2(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: u8) {
        let v0 = BountyPostedV2{
            bounty_id        : arg0,
            poster           : arg1,
            amount_mist      : arg2,
            deadline_ms      : arg3,
            description_hash : arg4,
            min_score        : arg5,
        };
        0x2::event::emit<BountyPostedV2>(v0);
    }

    public(friend) fun emit_config_updated(arg0: vector<u8>, arg1: u64, arg2: u64) {
        let v0 = ConfigUpdated{
            field     : arg0,
            old_value : arg1,
            new_value : arg2,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public(friend) fun emit_fulfillment_reviewed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool) {
        let v0 = FulfillmentReviewed{
            bounty_id     : arg0,
            submission_id : arg1,
            accepted      : arg2,
        };
        0x2::event::emit<FulfillmentReviewed>(v0);
    }

    public(friend) fun emit_fulfillment_submitted_v2(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x2::object::ID) {
        let v0 = FulfillmentSubmittedV2{
            bounty_id      : arg0,
            submission_id  : arg1,
            claimer        : arg2,
            walrus_blob_id : arg3,
        };
        0x2::event::emit<FulfillmentSubmittedV2>(v0);
    }

    public(friend) fun emit_lineage_royalty_paid(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u16) {
        let v0 = LineageRoyaltyPaid{
            pack_id     : arg0,
            recipient   : arg1,
            amount_mist : arg2,
            depth       : arg3,
        };
        0x2::event::emit<LineageRoyaltyPaid>(v0);
    }

    public(friend) fun emit_memory_versioned(arg0: 0x2::object::ID, arg1: u32, arg2: u32, arg3: vector<u8>, arg4: u64) {
        let v0 = MemoryVersioned{
            pack_id      : arg0,
            old_version  : arg1,
            new_version  : arg2,
            content_hash : arg3,
            ts_ms        : arg4,
        };
        0x2::event::emit<MemoryVersioned>(v0);
    }

    public(friend) fun emit_pack_forked(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: address, arg4: u16, arg5: vector<u8>) {
        let v0 = PackForked{
            pack_id      : arg0,
            parent_id    : arg1,
            root_id      : arg2,
            creator      : arg3,
            fork_depth   : arg4,
            content_hash : arg5,
        };
        0x2::event::emit<PackForked>(v0);
    }

    public(friend) fun emit_pack_listed_v2(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = PackListedV2{
            pack_id    : arg0,
            seller     : arg1,
            price_mist : arg2,
            ts_ms      : arg3,
        };
        0x2::event::emit<PackListedV2>(v0);
    }

    public(friend) fun emit_pack_price_updated(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = PackPriceUpdated{
            pack_id        : arg0,
            old_price_mist : arg1,
            new_price_mist : arg2,
        };
        0x2::event::emit<PackPriceUpdated>(v0);
    }

    public(friend) fun emit_pack_sold_v2(arg0: 0x2::object::ID, arg1: address, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = PackSoldV2{
            pack_id      : arg0,
            buyer        : arg1,
            seller       : arg2,
            price_mist   : arg3,
            fee_mist     : arg4,
            royalty_mist : arg5,
            lineage_mist : arg6,
        };
        0x2::event::emit<PackSoldV2>(v0);
    }

    public(friend) fun emit_pack_unlisted(arg0: 0x2::object::ID, arg1: address) {
        let v0 = PackUnlisted{
            pack_id : arg0,
            seller  : arg1,
        };
        0x2::event::emit<PackUnlisted>(v0);
    }

    // decompiled from Move bytecode v7
}

