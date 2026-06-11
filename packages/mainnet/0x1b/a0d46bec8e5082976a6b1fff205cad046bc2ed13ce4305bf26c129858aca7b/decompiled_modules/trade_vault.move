module 0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::trade_vault {
    struct TradeProposal has key {
        id: 0x2::object::UID,
        proposer: address,
        counterparty: address,
        offered_cards: vector<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>,
        requested_card_ids: vector<0x2::object::ID>,
        memo: vector<u8>,
        state: u8,
        created_at: u64,
    }

    struct TradeProposed has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        counterparty: address,
        offered_count: u64,
        requested_count: u64,
        created_at: u64,
    }

    struct TradeAccepted has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        counterparty: address,
        swapped_count: u64,
        accepted_at: u64,
    }

    struct TradeCancelled has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        counterparty: address,
        cancelled_by: address,
        cancelled_at: u64,
    }

    public fun accept(arg0: TradeProposal, arg1: vector<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == arg0.counterparty, 3);
        let v0 = 0x1::vector::length<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&arg1);
        assert!(0x1::vector::length<0x2::object::ID>(&arg0.requested_card_ids) == v0, 4);
        let v1 = arg0.requested_card_ids;
        let v2 = 0;
        while (v2 < v0) {
            let v3 = 0x2::object::id<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(0x1::vector::borrow<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&arg1, v2));
            let v4 = find_id(&v1, &v3);
            assert!(0x1::option::is_some<u64>(&v4), 5);
            0x1::vector::swap_remove<0x2::object::ID>(&mut v1, 0x1::option::extract<u64>(&mut v4));
            v2 = v2 + 1;
        };
        assert!(0x1::vector::is_empty<0x2::object::ID>(&v1), 5);
        0x1::vector::destroy_empty<0x2::object::ID>(v1);
        let v5 = arg0.proposer;
        let v6 = arg0.counterparty;
        while (!0x1::vector::is_empty<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&arg0.offered_cards)) {
            0x2::transfer::public_transfer<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(0x1::vector::pop_back<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&mut arg0.offered_cards), v6);
        };
        while (!0x1::vector::is_empty<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&arg1)) {
            0x2::transfer::public_transfer<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(0x1::vector::pop_back<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&mut arg1), v5);
        };
        let v7 = TradeAccepted{
            proposal_id   : 0x2::object::uid_to_inner(&arg0.id),
            proposer      : v5,
            counterparty  : v6,
            swapped_count : v0,
            accepted_at   : arg2,
        };
        0x2::event::emit<TradeAccepted>(v7);
        let TradeProposal {
            id                 : v8,
            proposer           : _,
            counterparty       : _,
            offered_cards      : v11,
            requested_card_ids : _,
            memo               : _,
            state              : _,
            created_at         : _,
        } = arg0;
        0x1::vector::destroy_empty<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(v11);
        0x1::vector::destroy_empty<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(arg1);
        0x2::object::delete(v8);
    }

    public fun cancel(arg0: TradeProposal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.proposer, 2);
        return_offered_cards_and_delete(arg0, v0, arg1, arg2);
    }

    public fun counterparty(arg0: &TradeProposal) : address {
        arg0.counterparty
    }

    public fun created_at(arg0: &TradeProposal) : u64 {
        arg0.created_at
    }

    public fun decline(arg0: TradeProposal, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 == arg0.counterparty, 3);
        return_offered_cards_and_delete(arg0, v0, arg1, arg2);
    }

    fun find_id(arg0: &vector<0x2::object::ID>, arg1: &0x2::object::ID) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<0x2::object::ID>(arg0)) {
            if (0x1::vector::borrow<0x2::object::ID>(arg0, v0) == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    public fun memo(arg0: &TradeProposal) : &vector<u8> {
        &arg0.memo
    }

    public fun offered_count(arg0: &TradeProposal) : u64 {
        0x1::vector::length<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&arg0.offered_cards)
    }

    public fun propose(arg0: vector<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>, arg1: address, arg2: vector<0x2::object::ID>, arg3: vector<u8>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&arg0);
        assert!(v0 > 0, 0);
        assert!(0x1::vector::length<0x2::object::ID>(&arg2) > 0, 1);
        let v1 = 0x1::vector::empty<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>();
        while (!0x1::vector::is_empty<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&arg0)) {
            0x1::vector::push_back<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&mut v1, 0x1::vector::pop_back<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&mut arg0));
        };
        0x1::vector::destroy_empty<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(arg0);
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = TradeProposal{
            id                 : 0x2::object::new(arg5),
            proposer           : v2,
            counterparty       : arg1,
            offered_cards      : v1,
            requested_card_ids : arg2,
            memo               : arg3,
            state              : 0,
            created_at         : arg4,
        };
        let v4 = TradeProposed{
            proposal_id     : 0x2::object::uid_to_inner(&v3.id),
            proposer        : v2,
            counterparty    : arg1,
            offered_count   : v0,
            requested_count : 0x1::vector::length<0x2::object::ID>(&v3.requested_card_ids),
            created_at      : arg4,
        };
        0x2::event::emit<TradeProposed>(v4);
        0x2::transfer::share_object<TradeProposal>(v3);
    }

    public fun proposer(arg0: &TradeProposal) : address {
        arg0.proposer
    }

    public fun requested_count(arg0: &TradeProposal) : u64 {
        0x1::vector::length<0x2::object::ID>(&arg0.requested_card_ids)
    }

    fun return_offered_cards_and_delete(arg0: TradeProposal, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.proposer;
        while (!0x1::vector::is_empty<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&arg0.offered_cards)) {
            0x2::transfer::public_transfer<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(0x1::vector::pop_back<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(&mut arg0.offered_cards), v0);
        };
        let v1 = TradeCancelled{
            proposal_id  : 0x2::object::uid_to_inner(&arg0.id),
            proposer     : v0,
            counterparty : arg0.counterparty,
            cancelled_by : arg1,
            cancelled_at : arg2,
        };
        0x2::event::emit<TradeCancelled>(v1);
        let TradeProposal {
            id                 : v2,
            proposer           : _,
            counterparty       : _,
            offered_cards      : v5,
            requested_card_ids : _,
            memo               : _,
            state              : _,
            created_at         : _,
        } = arg0;
        0x1::vector::destroy_empty<0x1ba0d46bec8e5082976a6b1fff205cad046bc2ed13ce4305bf26c129858aca7b::cards::Card>(v5);
        0x2::object::delete(v2);
    }

    // decompiled from Move bytecode v7
}

