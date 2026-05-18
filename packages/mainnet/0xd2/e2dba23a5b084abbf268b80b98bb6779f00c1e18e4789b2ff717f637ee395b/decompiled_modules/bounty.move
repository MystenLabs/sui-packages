module 0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::bounty {
    struct Bounty has key {
        id: 0x2::object::UID,
        room: 0x2::object::ID,
        poster: address,
        amount: u64,
        locked: 0x2::balance::Balance<0x2::sui::SUI>,
        title: 0x1::string::String,
        brief_cid: 0x1::string::String,
        status: u8,
        claimer: 0x1::option::Option<address>,
        submission_cid: 0x1::option::Option<0x1::string::String>,
        claim_window_ms: u64,
        review_window_ms: u64,
        claim_deadline_ms: u64,
        review_deadline_ms: u64,
        created_at_ms: u64,
    }

    struct BountyPosted has copy, drop {
        bounty: 0x2::object::ID,
        room: 0x2::object::ID,
        poster: address,
        amount: u64,
        title: 0x1::string::String,
        brief_cid: 0x1::string::String,
        claim_window_ms: u64,
        review_window_ms: u64,
        timestamp_ms: u64,
    }

    struct BountyClaimed has copy, drop {
        bounty: 0x2::object::ID,
        claimer: address,
        claim_deadline_ms: u64,
        timestamp_ms: u64,
    }

    struct BountyReopened has copy, drop {
        bounty: 0x2::object::ID,
        prior_claimer: address,
        timestamp_ms: u64,
    }

    struct BountySubmitted has copy, drop {
        bounty: 0x2::object::ID,
        claimer: address,
        submission_cid: 0x1::string::String,
        review_deadline_ms: u64,
        timestamp_ms: u64,
    }

    struct BountyReleased has copy, drop {
        bounty: 0x2::object::ID,
        claimer: address,
        amount: u64,
        fee: u64,
        auto_released: bool,
        timestamp_ms: u64,
    }

    struct BountyCancelled has copy, drop {
        bounty: 0x2::object::ID,
        poster: address,
        amount: u64,
        timestamp_ms: u64,
    }

    struct BountyDisputed has copy, drop {
        bounty: 0x2::object::ID,
        raised_by: address,
        reason_cid: 0x1::string::String,
        timestamp_ms: u64,
    }

    struct DisputeResolved has copy, drop {
        bounty: 0x2::object::ID,
        to_claimer: u64,
        to_poster: u64,
        fee: u64,
        verdict_cid: 0x1::string::String,
        timestamp_ms: u64,
    }

    public fun amount(arg0: &Bounty) : u64 {
        arg0.amount
    }

    public fun brief_cid(arg0: &Bounty) : &0x1::string::String {
        &arg0.brief_cid
    }

    public fun cancel_bounty(arg0: &mut Bounty, arg1: &mut 0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Room, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        assert!(arg0.room == 0x2::object::id<0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Room>(arg1), 10);
        assert!(0x2::tx_context::sender(arg3) == arg0.poster, 0);
        refund_to_poster(arg0, arg2, arg3);
        0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::dec_active_bounties(arg1);
    }

    public fun claim_after_review_timeout(arg0: &mut Bounty, arg1: &mut 0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Room, arg2: &0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 1);
        assert!(arg0.room == 0x2::object::id<0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Room>(arg1), 10);
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x1::option::contains<address>(&arg0.claimer, &v0), 0);
        assert!(0x2::clock::timestamp_ms(arg3) >= arg0.review_deadline_ms, 8);
        payout_to_claimer(arg0, arg2, true, arg3, arg4);
        0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::dec_active_bounties(arg1);
    }

    public fun claim_bounty(arg0: &mut Bounty, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 0, 1);
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(v0 != arg0.poster, 7);
        let v1 = 0x2::clock::timestamp_ms(arg1);
        arg0.claimer = 0x1::option::some<address>(v0);
        arg0.claim_deadline_ms = v1 + arg0.claim_window_ms;
        arg0.status = 1;
        let v2 = BountyClaimed{
            bounty            : 0x2::object::uid_to_inner(&arg0.id),
            claimer           : v0,
            claim_deadline_ms : arg0.claim_deadline_ms,
            timestamp_ms      : v1,
        };
        0x2::event::emit<BountyClaimed>(v2);
    }

    public fun claim_deadline_ms(arg0: &Bounty) : u64 {
        arg0.claim_deadline_ms
    }

    public fun claimer(arg0: &Bounty) : &0x1::option::Option<address> {
        &arg0.claimer
    }

    fun compute_fee(arg0: u64, arg1: &0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Config) : u64 {
        arg0 * 0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::bounty_fee_bps(arg1) / 10000
    }

    public fun dispute_bounty(arg0: &mut Bounty, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(v0 == arg0.poster || 0x1::option::contains<address>(&arg0.claimer, &v0), 0);
        assert!(arg0.status == 1 || arg0.status == 2, 1);
        assert!(0x1::vector::length<u8>(&arg1) <= 96, 6);
        arg0.status = 5;
        let v1 = BountyDisputed{
            bounty       : 0x2::object::uid_to_inner(&arg0.id),
            raised_by    : v0,
            reason_cid   : 0x1::string::utf8(arg1),
            timestamp_ms : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<BountyDisputed>(v1);
    }

    public fun locked_value(arg0: &Bounty) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.locked)
    }

    fun payout_to_claimer(arg0: &mut Bounty, arg1: &0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Config, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = *0x1::option::borrow<address>(&arg0.claimer);
        let v1 = arg0.amount;
        let v2 = compute_fee(v1, arg1);
        let v3 = 0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.locked);
        if (v2 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v3, v2), arg4), 0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::treasury(arg1));
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v3, arg4), v0);
        arg0.status = 3;
        let v4 = BountyReleased{
            bounty        : 0x2::object::uid_to_inner(&arg0.id),
            claimer       : v0,
            amount        : v1 - v2,
            fee           : v2,
            auto_released : arg2,
            timestamp_ms  : 0x2::clock::timestamp_ms(arg3),
        };
        0x2::event::emit<BountyReleased>(v4);
    }

    public fun post_bounty(arg0: &mut 0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Room, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>, arg5: u64, arg6: u64, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::is_open(arg0), 11);
        assert!(arg2 > 0, 2);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg1) >= arg2, 4);
        assert!(0x1::vector::length<u8>(&arg3) <= 96, 5);
        assert!(0x1::vector::length<u8>(&arg4) <= 96, 6);
        assert!(arg5 >= 60000 && arg5 <= 7776000000, 3);
        assert!(arg6 >= 60000 && arg6 <= 7776000000, 3);
        let v0 = 0x2::tx_context::sender(arg8);
        let v1 = 0x2::balance::zero<0x2::sui::SUI>();
        0x2::balance::join<0x2::sui::SUI>(&mut v1, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg2, arg8)));
        refund_remainder(arg1, v0);
        let v2 = 0x2::clock::timestamp_ms(arg7);
        let v3 = 0x1::string::utf8(arg3);
        let v4 = 0x1::string::utf8(arg4);
        let v5 = 0x2::object::id<0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Room>(arg0);
        let v6 = Bounty{
            id                 : 0x2::object::new(arg8),
            room               : v5,
            poster             : v0,
            amount             : arg2,
            locked             : v1,
            title              : v3,
            brief_cid          : v4,
            status             : 0,
            claimer            : 0x1::option::none<address>(),
            submission_cid     : 0x1::option::none<0x1::string::String>(),
            claim_window_ms    : arg5,
            review_window_ms   : arg6,
            claim_deadline_ms  : 0,
            review_deadline_ms : 0,
            created_at_ms      : v2,
        };
        let v7 = BountyPosted{
            bounty           : 0x2::object::uid_to_inner(&v6.id),
            room             : v5,
            poster           : v0,
            amount           : arg2,
            title            : v3,
            brief_cid        : v4,
            claim_window_ms  : arg5,
            review_window_ms : arg6,
            timestamp_ms     : v2,
        };
        0x2::event::emit<BountyPosted>(v7);
        0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::inc_active_bounties(arg0);
        0x2::transfer::share_object<Bounty>(v6);
    }

    public fun poster(arg0: &Bounty) : address {
        arg0.poster
    }

    fun refund_remainder(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: address) {
        if (0x2::coin::value<0x2::sui::SUI>(&arg0) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, arg1);
        };
    }

    fun refund_to_poster(arg0: &mut Bounty, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.locked), arg2), arg0.poster);
        arg0.status = 4;
        let v0 = BountyCancelled{
            bounty       : 0x2::object::uid_to_inner(&arg0.id),
            poster       : arg0.poster,
            amount       : arg0.amount,
            timestamp_ms : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<BountyCancelled>(v0);
    }

    public fun release_bounty(arg0: &mut Bounty, arg1: &mut 0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Room, arg2: &0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Config, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.status == 2, 1);
        assert!(arg0.room == 0x2::object::id<0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Room>(arg1), 10);
        assert!(0x2::tx_context::sender(arg4) == arg0.poster, 0);
        payout_to_claimer(arg0, arg2, false, arg3, arg4);
        0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::dec_active_bounties(arg1);
    }

    public fun reopen_expired(arg0: &mut Bounty, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.claim_deadline_ms, 8);
        arg0.claimer = 0x1::option::none<address>();
        arg0.claim_deadline_ms = 0;
        arg0.status = 0;
        let v1 = BountyReopened{
            bounty        : 0x2::object::uid_to_inner(&arg0.id),
            prior_claimer : *0x1::option::borrow<address>(&arg0.claimer),
            timestamp_ms  : v0,
        };
        0x2::event::emit<BountyReopened>(v1);
    }

    public fun resolve_dispute(arg0: &0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::AdminCap, arg1: &mut Bounty, arg2: &mut 0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Room, arg3: &0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Config, arg4: u64, arg5: u64, arg6: vector<u8>, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.status == 5, 1);
        assert!(arg1.room == 0x2::object::id<0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::Room>(arg2), 10);
        assert!(arg4 + arg5 == arg1.amount, 12);
        assert!(0x1::vector::length<u8>(&arg6) <= 96, 6);
        let v0 = compute_fee(arg4, arg3);
        if (arg4 > 0) {
            let v1 = 0x2::balance::split<0x2::sui::SUI>(&mut arg1.locked, arg4);
            if (v0 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut v1, v0), arg8), 0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::treasury(arg3));
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v1, arg8), *0x1::option::borrow<address>(&arg1.claimer));
        };
        if (arg5 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.locked, arg5), arg8), arg1.poster);
        };
        arg1.status = 3;
        let v2 = DisputeResolved{
            bounty       : 0x2::object::uid_to_inner(&arg1.id),
            to_claimer   : arg4,
            to_poster    : arg5,
            fee          : v0,
            verdict_cid  : 0x1::string::utf8(arg6),
            timestamp_ms : 0x2::clock::timestamp_ms(arg7),
        };
        0x2::event::emit<DisputeResolved>(v2);
        0xd2e2dba23a5b084abbf268b80b98bb6779f00c1e18e4789b2ff717f637ee395b::ephemeral_chat::dec_active_bounties(arg2);
    }

    public fun review_deadline_ms(arg0: &Bounty) : u64 {
        arg0.review_deadline_ms
    }

    public fun room_of(arg0: &Bounty) : 0x2::object::ID {
        arg0.room
    }

    public fun status(arg0: &Bounty) : u8 {
        arg0.status
    }

    public fun submission_cid(arg0: &Bounty) : &0x1::option::Option<0x1::string::String> {
        &arg0.submission_cid
    }

    public fun submit_work(arg0: &mut Bounty, arg1: vector<u8>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 1);
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x1::option::contains<address>(&arg0.claimer, &v0), 0);
        assert!(0x1::vector::length<u8>(&arg1) <= 96, 6);
        let v1 = 0x2::clock::timestamp_ms(arg2);
        assert!(v1 < arg0.claim_deadline_ms, 9);
        let v2 = 0x1::string::utf8(arg1);
        arg0.submission_cid = 0x1::option::some<0x1::string::String>(v2);
        arg0.review_deadline_ms = v1 + arg0.review_window_ms;
        arg0.status = 2;
        let v3 = BountySubmitted{
            bounty             : 0x2::object::uid_to_inner(&arg0.id),
            claimer            : v0,
            submission_cid     : v2,
            review_deadline_ms : arg0.review_deadline_ms,
            timestamp_ms       : v1,
        };
        0x2::event::emit<BountySubmitted>(v3);
    }

    public fun title(arg0: &Bounty) : &0x1::string::String {
        &arg0.title
    }

    // decompiled from Move bytecode v7
}

