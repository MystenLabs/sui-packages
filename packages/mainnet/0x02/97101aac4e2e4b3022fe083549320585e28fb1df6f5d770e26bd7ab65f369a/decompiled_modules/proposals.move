module 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::proposals {
    struct ProposalBoard has key {
        id: 0x2::object::UID,
        block_index_id: 0x2::object::ID,
        min_proposal_fee: u64,
        max_per_polygon: u64,
        max_per_proposer: u64,
        pending_ttl_epochs: u64,
        proposal_counter: u64,
        escrow: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct Proposal has drop, store {
        polygon_id: 0x2::object::ID,
        proposer: address,
        poi_name: vector<u8>,
        poi_coord_x: u64,
        poi_coord_y: u64,
        poi_icon: 0x1::option::Option<vector<u8>>,
        details_cid: 0x1::option::Option<0x1::string::String>,
        offer_amount: u64,
        status: u8,
        created_epoch: u64,
    }

    struct ProposalKey has copy, drop, store {
        proposal_id: u64,
    }

    struct PendingCountKey has copy, drop, store {
        polygon_id: 0x2::object::ID,
    }

    struct ProposerCountKey has copy, drop, store {
        polygon_id: 0x2::object::ID,
        proposer: address,
    }

    struct MinOfferKey has copy, drop, store {
        polygon_id: 0x2::object::ID,
    }

    struct PolygonProposalIdsKey has copy, drop, store {
        polygon_id: 0x2::object::ID,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: u64,
        polygon_id: 0x2::object::ID,
        proposer: address,
        offer_amount: u64,
        created_epoch: u64,
    }

    struct ProposalAccepted has copy, drop {
        proposal_id: u64,
        polygon_id: 0x2::object::ID,
        owner: address,
        offer_amount: u64,
    }

    struct ProposalRejected has copy, drop {
        proposal_id: u64,
        polygon_id: 0x2::object::ID,
        proposer: address,
        refund_amount: u64,
    }

    struct ProposalWithdrawn has copy, drop {
        proposal_id: u64,
        proposer: address,
        refund_amount: u64,
    }

    struct ProposalExpired has copy, drop {
        proposal_id: u64,
        proposer: address,
        refund_amount: u64,
    }

    entry fun accept_proposal(arg0: &mut ProposalBoard, arg1: &mut 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::Market, arg2: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = ProposalKey{proposal_id: arg3};
        let v1 = 0x2::dynamic_field::borrow<ProposalKey, Proposal>(&arg0.id, v0);
        assert!(v1.status == 0, 3409);
        let v2 = v1.polygon_id;
        let v3 = 0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::owner(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::get(arg2, v2));
        assert!(v3 == 0x2::tx_context::sender(arg4), 3401);
        let v4 = ProposalKey{proposal_id: arg3};
        let v5 = 0x2::dynamic_field::borrow_mut<ProposalKey, Proposal>(&mut arg0.id, v4);
        let v6 = v5.offer_amount;
        v5.status = 1;
        if (v6 > 0) {
            let (v7, v8) = 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::revenue::deposit_revenue(0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::market_uid_mut(arg1), 0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v6), v2, 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::level_rank_for_index_id(arg1, arg0.block_index_id), arg4);
            0x2::balance::join<0x2::sui::SUI>(0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::treasury_mut(arg1), v8);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v7, arg4), v3);
        };
        remove_from_polygon_ids(arg0, v2, arg3);
        decrement_pending_count(arg0, v2);
        decrement_proposer_count(arg0, v2, v5.proposer);
        let v9 = ProposalAccepted{
            proposal_id  : arg3,
            polygon_id   : v2,
            owner        : v3,
            offer_amount : v6,
        };
        0x2::event::emit<ProposalAccepted>(v9);
    }

    fun add_to_polygon_ids(arg0: &mut ProposalBoard, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = PolygonProposalIdsKey{polygon_id: arg1};
        if (0x2::dynamic_field::exists_<PolygonProposalIdsKey>(&arg0.id, v0)) {
            0x1::vector::push_back<u64>(0x2::dynamic_field::borrow_mut<PolygonProposalIdsKey, vector<u64>>(&mut arg0.id, v0), arg2);
        } else {
            let v1 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v1, arg2);
            0x2::dynamic_field::add<PolygonProposalIdsKey, vector<u64>>(&mut arg0.id, v0, v1);
        };
    }

    public fun board_escrow_value(arg0: &ProposalBoard) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.escrow)
    }

    public fun board_proposal_counter(arg0: &ProposalBoard) : u64 {
        arg0.proposal_counter
    }

    entry fun create_proposal_board(arg0: &0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::MarketAdminCap, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = ProposalBoard{
            id                 : 0x2::object::new(arg6),
            block_index_id     : arg1,
            min_proposal_fee   : arg2,
            max_per_polygon    : arg3,
            max_per_proposer   : arg4,
            pending_ttl_epochs : arg5,
            proposal_counter   : 0,
            escrow             : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<ProposalBoard>(v0);
    }

    fun decrement_pending_count(arg0: &mut ProposalBoard, arg1: 0x2::object::ID) {
        let v0 = PendingCountKey{polygon_id: arg1};
        if (!0x2::dynamic_field::exists_<PendingCountKey>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<PendingCountKey, u64>(&mut arg0.id, v0);
        let v2 = if (*v1 > 1) {
            *v1 = *v1 - 1;
            false
        } else {
            true
        };
        if (v2) {
            0x2::dynamic_field::remove<PendingCountKey, u64>(&mut arg0.id, v0);
        };
    }

    fun decrement_proposer_count(arg0: &mut ProposalBoard, arg1: 0x2::object::ID, arg2: address) {
        let v0 = ProposerCountKey{
            polygon_id : arg1,
            proposer   : arg2,
        };
        if (!0x2::dynamic_field::exists_<ProposerCountKey>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<ProposerCountKey, u64>(&mut arg0.id, v0);
        let v2 = if (*v1 > 1) {
            *v1 = *v1 - 1;
            false
        } else {
            true
        };
        if (v2) {
            0x2::dynamic_field::remove<ProposerCountKey, u64>(&mut arg0.id, v0);
        };
    }

    public fun get_polygon_proposal_ids(arg0: &ProposalBoard, arg1: 0x2::object::ID) : vector<u64> {
        let v0 = PolygonProposalIdsKey{polygon_id: arg1};
        if (0x2::dynamic_field::exists_<PolygonProposalIdsKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<PolygonProposalIdsKey, vector<u64>>(&arg0.id, v0)
        } else {
            vector[]
        }
    }

    public fun get_proposal(arg0: &ProposalBoard, arg1: u64) : &Proposal {
        let v0 = ProposalKey{proposal_id: arg1};
        0x2::dynamic_field::borrow<ProposalKey, Proposal>(&arg0.id, v0)
    }

    public fun proposal_created_epoch(arg0: &Proposal) : u64 {
        arg0.created_epoch
    }

    public fun proposal_details_cid(arg0: &Proposal) : 0x1::option::Option<0x1::string::String> {
        arg0.details_cid
    }

    public fun proposal_offer_amount(arg0: &Proposal) : u64 {
        arg0.offer_amount
    }

    public fun proposal_poi_coord_x(arg0: &Proposal) : u64 {
        arg0.poi_coord_x
    }

    public fun proposal_poi_coord_y(arg0: &Proposal) : u64 {
        arg0.poi_coord_y
    }

    public fun proposal_poi_icon(arg0: &Proposal) : 0x1::option::Option<vector<u8>> {
        arg0.poi_icon
    }

    public fun proposal_poi_name(arg0: &Proposal) : vector<u8> {
        arg0.poi_name
    }

    public fun proposal_polygon_id(arg0: &Proposal) : 0x2::object::ID {
        arg0.polygon_id
    }

    public fun proposal_proposer(arg0: &Proposal) : address {
        arg0.proposer
    }

    public fun proposal_status(arg0: &Proposal) : u8 {
        arg0.status
    }

    entry fun propose_poi(arg0: &mut ProposalBoard, arg1: &mut 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::Market, arg2: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg3: 0x2::object::ID, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: 0x1::option::Option<vector<u8>>, arg8: 0x1::option::Option<0x1::string::String>, arg9: 0x2::coin::Coin<0x2::sui::SUI>, arg10: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index>(arg2) == arg0.block_index_id, 3406);
        0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::get(arg2, arg3);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg9) >= arg0.min_proposal_fee, 3403);
        assert!(0x1::vector::length<u8>(&arg4) <= 48, 3404);
        if (0x1::option::is_some<vector<u8>>(&arg7)) {
            assert!(0x1::vector::length<u8>(0x1::option::borrow<vector<u8>>(&arg7)) <= 16, 3405);
        };
        let v0 = PendingCountKey{polygon_id: arg3};
        if (!0x2::dynamic_field::exists_<PendingCountKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<PendingCountKey, u64>(&mut arg0.id, v0, 1);
        } else {
            let v1 = 0x2::dynamic_field::borrow_mut<PendingCountKey, u64>(&mut arg0.id, v0);
            assert!(*v1 < arg0.max_per_polygon, 3407);
            *v1 = *v1 + 1;
        };
        let v2 = 0x2::tx_context::sender(arg10);
        let v3 = ProposerCountKey{
            polygon_id : arg3,
            proposer   : v2,
        };
        if (!0x2::dynamic_field::exists_<ProposerCountKey>(&arg0.id, v3)) {
            0x2::dynamic_field::add<ProposerCountKey, u64>(&mut arg0.id, v3, 1);
        } else {
            let v4 = 0x2::dynamic_field::borrow_mut<ProposerCountKey, u64>(&mut arg0.id, v3);
            assert!(*v4 < arg0.max_per_proposer, 3408);
            *v4 = *v4 + 1;
        };
        0x2::balance::join<0x2::sui::SUI>(0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::market::treasury_mut(arg1), 0x297101aac4e2e4b3022fe083549320585e28fb1df6f5d770e26bd7ab65f369a::revenue::collect_treasury_fee(0x2::coin::split<0x2::sui::SUI>(&mut arg9, arg0.min_proposal_fee, arg10)));
        let v5 = 0x2::coin::value<0x2::sui::SUI>(&arg9);
        let v6 = MinOfferKey{polygon_id: arg3};
        if (0x2::dynamic_field::exists_<MinOfferKey>(&arg0.id, v6)) {
            assert!(v5 >= *0x2::dynamic_field::borrow<MinOfferKey, u64>(&arg0.id, v6), 3411);
        };
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.escrow, 0x2::coin::into_balance<0x2::sui::SUI>(arg9));
        let v7 = arg0.proposal_counter;
        arg0.proposal_counter = arg0.proposal_counter + 1;
        let v8 = 0x2::tx_context::epoch(arg10);
        let v9 = Proposal{
            polygon_id    : arg3,
            proposer      : v2,
            poi_name      : arg4,
            poi_coord_x   : arg5,
            poi_coord_y   : arg6,
            poi_icon      : arg7,
            details_cid   : arg8,
            offer_amount  : v5,
            status        : 0,
            created_epoch : v8,
        };
        let v10 = ProposalKey{proposal_id: v7};
        0x2::dynamic_field::add<ProposalKey, Proposal>(&mut arg0.id, v10, v9);
        add_to_polygon_ids(arg0, arg3, v7);
        let v11 = ProposalCreated{
            proposal_id   : v7,
            polygon_id    : arg3,
            proposer      : v2,
            offer_amount  : v5,
            created_epoch : v8,
        };
        0x2::event::emit<ProposalCreated>(v11);
    }

    entry fun prune_pending(arg0: &mut ProposalBoard, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ProposalKey{proposal_id: arg1};
        let v1 = 0x2::dynamic_field::borrow<ProposalKey, Proposal>(&arg0.id, v0);
        assert!(v1.status == 0, 3409);
        assert!(0x2::tx_context::epoch(arg2) - v1.created_epoch > arg0.pending_ttl_epochs, 3410);
        let v2 = ProposalKey{proposal_id: arg1};
        let v3 = 0x2::dynamic_field::remove<ProposalKey, Proposal>(&mut arg0.id, v2);
        let v4 = v3.offer_amount;
        let v5 = v3.proposer;
        let v6 = v3.polygon_id;
        remove_from_polygon_ids(arg0, v6, arg1);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v4), arg2), v5);
        };
        decrement_pending_count(arg0, v6);
        decrement_proposer_count(arg0, v6, v5);
        let v7 = ProposalExpired{
            proposal_id   : arg1,
            proposer      : v5,
            refund_amount : v4,
        };
        0x2::event::emit<ProposalExpired>(v7);
    }

    entry fun reject_proposal(arg0: &mut ProposalBoard, arg1: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = ProposalKey{proposal_id: arg2};
        let v1 = 0x2::dynamic_field::borrow<ProposalKey, Proposal>(&arg0.id, v0);
        assert!(v1.status == 0, 3409);
        let v2 = v1.polygon_id;
        assert!(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::owner(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::get(arg1, v2)) == 0x2::tx_context::sender(arg3), 3401);
        let v3 = ProposalKey{proposal_id: arg2};
        let v4 = 0x2::dynamic_field::remove<ProposalKey, Proposal>(&mut arg0.id, v3);
        let v5 = v4.offer_amount;
        let v6 = v4.proposer;
        remove_from_polygon_ids(arg0, v2, arg2);
        if (v5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v5), arg3), v6);
        };
        decrement_pending_count(arg0, v2);
        decrement_proposer_count(arg0, v2, v6);
        let v7 = ProposalRejected{
            proposal_id   : arg2,
            polygon_id    : v2,
            proposer      : v6,
            refund_amount : v5,
        };
        0x2::event::emit<ProposalRejected>(v7);
    }

    fun remove_from_polygon_ids(arg0: &mut ProposalBoard, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = PolygonProposalIdsKey{polygon_id: arg1};
        if (!0x2::dynamic_field::exists_<PolygonProposalIdsKey>(&arg0.id, v0)) {
            return
        };
        let v1 = 0x2::dynamic_field::borrow_mut<PolygonProposalIdsKey, vector<u64>>(&mut arg0.id, v0);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v1)) {
            if (*0x1::vector::borrow<u64>(v1, v2) == arg2) {
                0x1::vector::swap_remove<u64>(v1, v2);
                break
            };
            v2 = v2 + 1;
        };
        if (0x1::vector::is_empty<u64>(v1)) {
            0x2::dynamic_field::remove<PolygonProposalIdsKey, vector<u64>>(&mut arg0.id, v0);
        };
    }

    entry fun set_min_offer(arg0: &mut ProposalBoard, arg1: &0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::Index, arg2: 0x2::object::ID, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        assert!(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::polygon::owner(0xb73acbeb7ba64de058d7035f2db26452158f8af6b9296d1caae0d5ee89f3d23b::index::get(arg1, arg2)) == 0x2::tx_context::sender(arg4), 3401);
        let v0 = MinOfferKey{polygon_id: arg2};
        if (arg3 > 0) {
            if (0x2::dynamic_field::exists_<MinOfferKey>(&arg0.id, v0)) {
                *0x2::dynamic_field::borrow_mut<MinOfferKey, u64>(&mut arg0.id, v0) = arg3;
            } else {
                0x2::dynamic_field::add<MinOfferKey, u64>(&mut arg0.id, v0, arg3);
            };
        } else if (0x2::dynamic_field::exists_<MinOfferKey>(&arg0.id, v0)) {
            0x2::dynamic_field::remove<MinOfferKey, u64>(&mut arg0.id, v0);
        };
    }

    entry fun withdraw_proposal(arg0: &mut ProposalBoard, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = ProposalKey{proposal_id: arg1};
        let v1 = 0x2::dynamic_field::borrow<ProposalKey, Proposal>(&arg0.id, v0);
        assert!(v1.status == 0, 3409);
        assert!(v1.proposer == 0x2::tx_context::sender(arg2), 3402);
        let v2 = ProposalKey{proposal_id: arg1};
        let v3 = 0x2::dynamic_field::remove<ProposalKey, Proposal>(&mut arg0.id, v2);
        let v4 = v3.offer_amount;
        let v5 = v3.proposer;
        let v6 = v3.polygon_id;
        remove_from_polygon_ids(arg0, v6, arg1);
        if (v4 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.escrow, v4), arg2), v5);
        };
        decrement_pending_count(arg0, v6);
        decrement_proposer_count(arg0, v6, v5);
        let v7 = ProposalWithdrawn{
            proposal_id   : arg1,
            proposer      : v5,
            refund_amount : v4,
        };
        0x2::event::emit<ProposalWithdrawn>(v7);
    }

    // decompiled from Move bytecode v7
}

