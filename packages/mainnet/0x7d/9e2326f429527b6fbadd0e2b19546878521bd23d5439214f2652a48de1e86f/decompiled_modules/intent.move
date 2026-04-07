module 0x7d9e2326f429527b6fbadd0e2b19546878521bd23d5439214f2652a48de1e86f::intent {
    struct USDC has drop {
        dummy_field: bool,
    }

    struct DIDState has store, key {
        id: 0x2::object::UID,
        owner: address,
        open_intents: u64,
        total_settled: u64,
    }

    struct Intent has key {
        id: 0x2::object::UID,
        intent_hash: vector<u8>,
        buyer: address,
        escrow: 0x2::coin::Coin<USDC>,
        bid_amount: u64,
        provider: address,
        evaluator: vector<u8>,
        expires_at: u64,
        state: u8,
        rules_hash: vector<u8>,
        audit_hash: vector<u8>,
    }

    struct IntentPublished has copy, drop {
        intent_id: 0x2::object::ID,
        buyer: address,
        escrow: u64,
        expires_at: u64,
    }

    struct BidAccepted has copy, drop {
        intent_id: 0x2::object::ID,
        provider: address,
        bid_amount: u64,
    }

    struct IntentFulfilled has copy, drop {
        intent_id: 0x2::object::ID,
        fulfilled_at: u64,
    }

    struct IntentExpired has copy, drop {
        intent_id: 0x2::object::ID,
        refunded: u64,
    }

    struct IntentCancelled has copy, drop {
        intent_id: 0x2::object::ID,
        refunded: u64,
        burned: u64,
    }

    struct BidAcceptedWithBond has copy, drop {
        intent_id: 0x2::object::ID,
        buyer: address,
        provider: address,
        bid_amount: u64,
        fulfil_by: u64,
        category: vector<u8>,
    }

    public entry fun accept_bid(arg0: &mut Intent, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0 || arg0.state == 1, 6);
        assert!(0x2::tx_context::sender(arg3) == arg0.buyer, 12);
        assert!(arg2 > 0, 17);
        assert!(arg2 <= 0x2::coin::value<USDC>(&arg0.escrow), 16);
        arg0.provider = arg1;
        arg0.bid_amount = arg2;
        arg0.state = 2;
        let v0 = BidAccepted{
            intent_id  : 0x2::object::id<Intent>(arg0),
            provider   : arg1,
            bid_amount : arg2,
        };
        0x2::event::emit<BidAccepted>(v0);
    }

    public entry fun accept_bid_with_bond(arg0: &mut Intent, arg1: &mut DIDState, arg2: address, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0 || arg0.state == 1, 6);
        assert!(0x2::tx_context::sender(arg6) == arg0.buyer, 12);
        assert!(arg3 > 0, 17);
        assert!(arg3 <= 0x2::coin::value<USDC>(&arg0.escrow), 16);
        arg0.provider = arg2;
        arg0.bid_amount = arg3;
        arg0.state = 2;
        decrement_open(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::split<USDC>(&mut arg0.escrow, arg3, arg6), arg0.buyer);
        let v0 = BidAcceptedWithBond{
            intent_id  : 0x2::object::id<Intent>(arg0),
            buyer      : arg0.buyer,
            provider   : arg2,
            bid_amount : arg3,
            fulfil_by  : 0x2::clock::timestamp_ms(arg5) + 259200000,
            category   : arg4,
        };
        0x2::event::emit<BidAcceptedWithBond>(v0);
        let v1 = BidAccepted{
            intent_id  : 0x2::object::id<Intent>(arg0),
            provider   : arg2,
            bid_amount : arg3,
        };
        0x2::event::emit<BidAccepted>(v1);
    }

    public fun audit_hash_ref(arg0: &Intent) : &vector<u8> {
        &arg0.audit_hash
    }

    public fun bid_amount(arg0: &Intent) : u64 {
        arg0.bid_amount
    }

    public fun buyer(arg0: &Intent) : address {
        arg0.buyer
    }

    public entry fun cancel_intent(arg0: &mut Intent, arg1: address, arg2: &mut DIDState, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 0, 6);
        assert!(0x2::tx_context::sender(arg3) == arg0.buyer, 11);
        arg0.state = 6;
        let v0 = 0x2::coin::value<USDC>(&arg0.escrow);
        let v1 = v0 * 1000 / 10000;
        let v2 = v0 - v1;
        if (arg2.open_intents > 0) {
            arg2.open_intents = arg2.open_intents - 1;
        };
        let v3 = IntentCancelled{
            intent_id : 0x2::object::id<Intent>(arg0),
            refunded  : v2,
            burned    : v1,
        };
        0x2::event::emit<IntentCancelled>(v3);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::split<USDC>(&mut arg0.escrow, v1, arg3), arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::split<USDC>(&mut arg0.escrow, v2, arg3), arg0.buyer);
    }

    public fun create_did_state(arg0: &mut 0x2::tx_context::TxContext) : DIDState {
        DIDState{
            id            : 0x2::object::new(arg0),
            owner         : 0x2::tx_context::sender(arg0),
            open_intents  : 0,
            total_settled : 0,
        }
    }

    public fun decrement_open(arg0: &mut DIDState) {
        if (arg0.open_intents > 0) {
            arg0.open_intents = arg0.open_intents - 1;
        };
    }

    public fun escrow_value(arg0: &Intent) : u64 {
        0x2::coin::value<USDC>(&arg0.escrow)
    }

    public fun evaluator(arg0: &Intent) : vector<u8> {
        arg0.evaluator
    }

    public entry fun expire(arg0: &mut Intent, arg1: &mut DIDState, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg0.expires_at, 8);
        assert!(arg0.state != 4, 9);
        arg0.state = 5;
        let v0 = 0x2::coin::value<USDC>(&arg0.escrow);
        if (arg1.open_intents > 0) {
            arg1.open_intents = arg1.open_intents - 1;
        };
        let v1 = IntentExpired{
            intent_id : 0x2::object::id<Intent>(arg0),
            refunded  : v0,
        };
        0x2::event::emit<IntentExpired>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<USDC>>(0x2::coin::split<USDC>(&mut arg0.escrow, v0, arg3), arg0.buyer);
    }

    public fun expires_at(arg0: &Intent) : u64 {
        arg0.expires_at
    }

    public fun increment_settled(arg0: &mut DIDState) {
        arg0.total_settled = arg0.total_settled + 1;
    }

    public entry fun init_did_state(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = create_did_state(arg0);
        0x2::transfer::transfer<DIDState>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun mark_fulfilled(arg0: &mut Intent, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.state == 2, 6);
        assert!(0x2::tx_context::sender(arg2) == arg0.provider, 10);
        arg0.state = 3;
        let v0 = IntentFulfilled{
            intent_id    : 0x2::object::id<Intent>(arg0),
            fulfilled_at : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<IntentFulfilled>(v0);
    }

    public fun open_intents(arg0: &DIDState) : u64 {
        arg0.open_intents
    }

    public fun provider(arg0: &Intent) : address {
        arg0.provider
    }

    public entry fun publish_intent(arg0: 0x2::coin::Coin<USDC>, arg1: vector<u8>, arg2: vector<u8>, arg3: vector<u8>, arg4: u64, arg5: &mut DIDState, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<USDC>(&arg0);
        assert!(v0 >= 1000000, 1);
        assert!(arg4 >= 3600000, 2);
        assert!(arg5.open_intents < 50, 3);
        if (arg5.total_settled == 0) {
            assert!(arg5.open_intents < 5, 4);
            assert!(v0 <= 100000000, 5);
        };
        let v1 = 0x2::clock::timestamp_ms(arg6) + arg4;
        let v2 = Intent{
            id          : 0x2::object::new(arg7),
            intent_hash : arg1,
            buyer       : 0x2::tx_context::sender(arg7),
            escrow      : arg0,
            bid_amount  : 0,
            provider    : @0x0,
            evaluator   : arg3,
            expires_at  : v1,
            state       : 0,
            rules_hash  : arg2,
            audit_hash  : 0x1::vector::empty<u8>(),
        };
        arg5.open_intents = arg5.open_intents + 1;
        let v3 = IntentPublished{
            intent_id  : 0x2::object::id<Intent>(&v2),
            buyer      : 0x2::tx_context::sender(arg7),
            escrow     : v0,
            expires_at : v1,
        };
        0x2::event::emit<IntentPublished>(v3);
        0x2::transfer::share_object<Intent>(v2);
    }

    public fun settle_escrow(arg0: &mut Intent, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<USDC>, 0x2::coin::Coin<USDC>, address, address) {
        arg0.state = 4;
        arg0.audit_hash = arg1;
        let v0 = arg0.bid_amount;
        assert!(v0 <= 0x2::coin::value<USDC>(&arg0.escrow), 14);
        (0x2::coin::split<USDC>(&mut arg0.escrow, v0, arg2), 0x2::coin::split<USDC>(&mut arg0.escrow, 0x2::coin::value<USDC>(&arg0.escrow), arg2), arg0.provider, arg0.buyer)
    }

    public fun state(arg0: &Intent) : u8 {
        arg0.state
    }

    public fun state_accepted() : u8 {
        2
    }

    public fun state_bidding() : u8 {
        1
    }

    public fun state_cancelled() : u8 {
        6
    }

    public fun state_expired() : u8 {
        5
    }

    public fun state_fulfilled() : u8 {
        3
    }

    public fun state_open() : u8 {
        0
    }

    public fun state_settled() : u8 {
        4
    }

    public fun total_settled(arg0: &DIDState) : u64 {
        arg0.total_settled
    }

    // decompiled from Move bytecode v6
}

